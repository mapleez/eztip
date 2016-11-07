package dt.ez.util.hbase

import org.apache.hadoop.conf.Configuration
import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.{Connection, ConnectionFactory, Put}
import org.apache.hadoop.hbase.TableName

import org.apache.hadoop.hbase.util.Bytes

import org.apache.hadoop.hbase.io.ImmutableBytesWritable
import java.util.List
import java.util.ArrayList


class HbaseWriter (conf: Configuration) extends Tools {
  
  implicit def tbName2TableName (tb: String) = TableName.valueOf (tb)
  implicit def TableName2tbName (tb: TableName) = tb.toString
  
  val conn = ConnectionFactory.createConnection (conf)
  
  /* The format: (key, (cf => (col => V))) */
  def writeMultiple [A] (tb: String, datas: Map [String, Map [String, Map [String, A]]], put: PutAddr [A]): Unit = {
    var puts: List [Put] = new ArrayList [Put]
    for {
      (rowkey, content) <- datas
      (cf, kv) <- content
      (k, v) <- kv
    } {
      val p = new Put (rowkey)
      puts.add (put (p, cf, k, v))
    }
    val htb = conn.getTable (tb)
    htb put (puts)
    htb close ()
  }
  
  def writeOne [A] (tb: String, key: String, data: Map [String, Map [String, A]], put: PutAddr [A]): Unit = {
    var puts: List [Put] = new ArrayList [Put]
    for {
      (cf, kv) <- data
      (k, v) <- kv // col -> value
    } {
      puts.add (put (new Put (key), cf, k, v))
    }
    val htb = conn.getTable (tb)
    htb put (puts)
    htb close ()
  }
  
  def close (): Unit = conn.close ()
  
}

