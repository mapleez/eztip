package dt.ez.util.hbase

import org.apache.hadoop.hbase.util.Bytes
import org.apache.hadoop.hbase.client.Put

trait Tools {
  
  type PutAddr[A] = (Put, Array[Byte], Array[Byte], A) => Put

  // PutAddr
  def pa[A](put: Put, cf: Array[Byte], q: Array[Byte], v: A)(implicit writer: Writes[A]) = put.addColumn(cf, q, writer.write(v))
  def pa[A](put: Put, cf: Array[Byte], q: Array[Byte], v: (A, Long))(implicit writer: Writes[A]) = put.addColumn(cf, q, v._2, writer.write(v._1))
  
  implicit def str2Bytes (s: String): Array[Byte] = Bytes.toBytes (s)
  implicit def bytes2Str (s: Array [Byte]): String = Bytes.toString (s)
  implicit def array2Bytes (a: Array [String]): Array[Array[Byte]] = a map Bytes.toBytes
}
