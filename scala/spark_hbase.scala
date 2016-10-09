import org.apache.spark._
import org.apache.spark.sql.SparkSession
import org.apache.spark.rdd.NewHadoopRDD
import org.apache.hadoop.hbase.util.Bytes
import org.apache.hadoop.hbase.{HBaseConfiguration, HTableDescriptor}
import org.apache.hadoop.hbase.TableName
// import org.apache.hadoop.hbase.client._
import org.apache.hadoop.hbase.mapreduce.TableInputFormat
import org.apache.hadoop.hbase.io.ImmutableBytesWritable
//import org.apache.hadoop.hbase.mapreduce.

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.{Connection,ConnectionFactory,HBaseAdmin,HTable,Put,Get}
import org.apache.hadoop.hbase.util.Bytes
import org.apache.hadoop.fs.Path

object testing {
  
  private val jars = Array (
    "/ezpriv/deploy/spark-2.0.0-bin-hadoop2.7/jars/zookeeper-3.4.6.jar",
    "/ezpriv/deploy/hbase-1.2.2/lib/hbase-common-1.2.2.jar",
    "/ezpriv/deploy/hbase-1.2.2/lib/hbase-client-1.2.2.jar",
    "/ezpriv/deploy/hbase-1.2.2/lib/hbase-server-1.2.2.jar",
    "/ezpriv/deploy/hbase-1.2.2/lib/hbase-protocol-1.2.2.jar",
    "/ezpriv/deploy/hbase-1.2.2/lib/htrace-core-3.1.0-incubating.jar"
  )
  
  
  // local distributed environment
  private val sparkmaster = "spark://localhost:7077"
  private val zookeeperHost = "localhost"
  private val zookeeperPort = "2181"
  private val tableName = "ezspark"
  private val columnF = "cf"
  private val row_example = "1"
  private val cols = Array ("id", "val")
  
  
  // remote spark 
  // private val sparkmaster = "spark://master1:7077"
  // private val tableName = "eztable" 
	private val getrow = "0929-16-0"
	// private val columnF = "columnf"
	// private val cols = Array ("common")
	// private val zookeeperHost = "master1"
  
  
  def test_hbase (args : Array [String]): Unit = {
    
    val hbase_conf = HBaseConfiguration.create ()
//    hbase_conf.set ("hbase.zookeeper.quorum", zookeeperHost)
//    hbase_conf.set ("hbase.zookeeper.property.clientPort", zookeeperPort)
    // hbase_conf.addResource (new Path ("/home/hadoop/scalaide/Scalatesting/src/hbase-site.xml"))    
    hbase_conf.set (TableInputFormat.INPUT_TABLE, tableName)
    
    val hbaseAdmin = new HBaseAdmin (hbase_conf)
    
//    if (hbaseAdmin.tableExists (TableName.valueOf (tableName))) {
//      println ("Table " + tableName + " exists!")
//    }
//    
//    val table = new HTable (hbase_conf, tableName)
//    
//    val theget = new Get (Bytes.toBytes (row_example))
//    val result = table.get (theget)
//    var value = result.value ()
//    println (Bytes.toString (value))
    
//    value = result.value ()
//    println (Bytes.toString (value))
    
//    val listtable = admin.listTables ()
//    listtable.foreach (println)
    
//    val table = new HTable (hbase_conf, "eztable")
  }
  
     
  def test_spark (args : Array [String]): Unit = {
    // init spark configuration
    val spark = SparkSession
      .builder
      .appName ("ezspark")
      .master ("local")
      // .master (sparkmaster)
      .getOrCreate ()
    
//    val spark_conf = new SparkConf ()
//      .setMaster ("local")
//      .setAppName ("feafeawf")

    val sc = spark.sparkContext // new SparkContext (sparkConf)
    // val sc = new SparkContext (spark_conf)
    // jars.foreach (e => sc.addJar (e))
    sc.setLogLevel ("DEBUG")
    
    // sc.addJar()
    // val sc = new SparkContext (args(0), "HBaseTest",
    //  System.getenv ("SPARK_HOME"), SparkContext.jarOfClass (this.getClass))

    val hbase_conf = HBaseConfiguration.create ()
//    hbase_conf.addResource ("/home/hadoop/scalaide/Scalatesting/src/hbase-site.xml")
    hbase_conf.set (TableInputFormat.INPUT_TABLE, tableName)
//    hbase_conf.set ("hbase.zookeeper.quorum", zookeeperHost)
//    hbase_conf.set ("hbase.zookeeper.property.clientPort", zookeeperPort)
    
    val hBaseRDD = sc.newAPIHadoopRDD(hbase_conf, 
      classOf [org.apache.hadoop.hbase.mapreduce.TableInputFormat],
      classOf [org.apache.hadoop.hbase.io.ImmutableBytesWritable],
      classOf [org.apache.hadoop.hbase.client.Result])
    
    // hBaseRDD.foreach (println)
//    val count = hBaseRDD.count()
//    println ("hbase rdd count = " + count)
      
     import spark.implicits._
     
     val table = hBaseRDD.map (r => (
        Bytes.toString (r._2.getValue (Bytes.toBytes (columnF), Bytes.toBytes (cols (0))))
        , Bytes.toString (r._2.getValue (Bytes.toBytes (columnF), Bytes.toBytes (cols (1))))
     )).toDF ("id", "value")// .toDF ("id", "value")
     
//     println (hBaseRDD.count ())
    // val count = hBaseRDD.count ()
    // println (count)

    table.registerTempTable ("table")
    // table.select (columnF).show ()
    
    val d = spark.sql ("select * from table")
    d.show ()
    // d.map (attr => "id: " + attr (0) + " value: " + attr (1)).show ()
    
     
     
    System.exit (0)
  }
  
  def main (args : Array [String]) {    
    test_spark (args)
//    test_hbase (args)
  }
}
