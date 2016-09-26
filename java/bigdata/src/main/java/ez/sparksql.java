package ez;

import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;

import java.io.IOException;
import org.apache.hadoop.conf.Configuration;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.mapreduce.TableInputFormat;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;

import org.apache.spark.sql.SQLContext;
import org.apache.spark.SparkContext;
import org.apache.spark.SparkConf;


public class sparksql {

	static SparkSession spark;

	static String sparkMaster;
	static String sparkAppName;
	static String	tbName;
	static String	getrow;
	static String	col_fam;
	static String	col1;

	static {
		tbName = "hive_test", 
		getrow = "r1",
		col_fam = "cf",
		col1 = "c1";
		sparkMaster = "spark://localhost:7077";
		sparkAppName = "ezspark"
	}

	public static void init () {
		spark = SparkSession
			.builder ()
			.appName ("Java Spark SQL Example")
			.getOrCreate ();
			// .Config ("")
	}

	public static void test_hbase () {
		SparkConf sparkconf = new SparkConf ()
			.setMaster (sparkMaster)
			.setAppName (sparkAppName);
		HBaseConfiguration hbaseconf = HBaseConfiguration.create ();
		hbaseconf.set (TableInputFormat.INPUT_TABLE, tbName);
		SparkContext sc = new SparkContext (sparkconf);
		sc.newAPIHadoopRDD (hbaseconf, TableInputFormat.class, 
			ImmutableBytesWritable.class, Result.class);
	}

	public static void main (String [] args) {
		// init ();
		// createDataFrames ();
		test_hbase ();
	}

	public static Dataset <Row> createDataFrames () {
		Dataset <Row> df = spark.read ().json ("/ez/people.json");
		return df;
	}

	public static void registTempView (String viewName, Dataset <Row> df) {
		if (null == df || null == viewName || 0 < viewName.length ()) return;
		df.createOrReplaceTempView (viewName);
	}

	public static void registTempTable (String tableName, Dataset <Row> df) {
		if (null == df || null == tableName || 0 < tableName.length ()) return;
		df.registerTempTable (tableName);
	}

	public static Dataset <Row> sql (String _sql) {
		if (null == spark || null == _sql) return null;
		Dataset <Row> sqldf = spark.sql (_sql);
		return sqldf;
	}

	public static Dataset <Row> select (String col, Dataset <Row> df) {
		if (null != df && 
				null != col && 
				0 < col.length ()) {
			df.select (col);
		} else {
			System.out.println ("Error select () dataframe.");
		}
		return df;
	}

	public static Dataset <Row> filter (String col, Dataset <Row> df) {
		if (null != df && 
				null != col && 
				0 < col.length ()) {
			df.filter (col);
		} else {
			System.out.println ("Error filter () dataframe.");
		}
		return df;
	}

	public static Dataset <Row> groupBy (String col, Dataset <Row> df) {
		if (null != df && 
				null != col && 
				0 < col.length ()) {
			df.groupBy (col);
		} else {
			System.out.println ("Error groupBy () dataframe.");
		}
		return df;
	}
 
}

