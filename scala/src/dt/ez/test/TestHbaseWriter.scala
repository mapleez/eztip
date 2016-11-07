package dt.ez.test

import dt.ez.util.hbase.HbaseConf
import dt.ez.util.hbase.HbaseWriter
import dt.ez.util.hbase.Tools


object TestHbaseWriter extends App with Tools {
  
  val hbaseConnAddr = ("hbase.zookeeper.quorum", "master1,master2,slave1,slave2,slave3,slave4,slave5")
  val conf = HbaseConf (hbaseConnAddr)
  
  val wtr = new HbaseWriter (conf.get) 
  val data = Map ( "columnf" -> Map ( "col1" -> "data1", "col2" -> "data2" ))
  
  wtr.writeOne [String] ("eztable", "rowkey1_test", data, (p, cf, col, v) => {
    p.addColumn (cf, col, v)
  })
  
  wtr.close
}
