package dt.ez.util.hbase

import org.apache.hadoop.conf.Configuration
import org.apache.hadoop.hbase.client.{Connection, ConnectionFactory}
import org.apache.hadoop.hbase.util.Bytes
import org.apache.hadoop.hbase.{HColumnDescriptor, HTableDescriptor, TableName}

/*
 * These Hbase Utilities support:
 * 
 * create table
 * check table existing
 * disable table
 * delete table
 * truncate table 
 */
class HbaseUtils (conf: Configuration) {
  
  implicit def string2Bytes (s: String): Array [Byte] = Bytes.toBytes (s)
  implicit def array2Bytes (a: Array [String]): Array[Array[Byte]] = a map Bytes.toBytes
  implicit def bytes2String (s: Array [Byte]): String = Bytes.toString (s)
  
  val admin = ConnectionFactory.createConnection(conf).getAdmin ()

    /**
     * Creates a table (if it doesn't exist already) with one or more column families
     * and made of one or more regions
     *
     * @param tableName name of table
     * @param families set of column families
     * @param splitKeys ordered list of keys that defines region splits
     */
    def createTable(tableName: String, families: Set [String], splitKeys: Seq [String]): Unit = {
      val table = TableName.valueOf (tableName)
      if (!admin.isTableAvailable (table)) {
        val tableDescriptor = new HTableDescriptor(table)
        families foreach { f => tableDescriptor.addFamily (new HColumnDescriptor (f)) }
        if (splitKeys.isEmpty)
          admin.createTable (tableDescriptor)
        else {
          val splitKeysBytes = splitKeys.map (Bytes.toBytes).toArray
          admin.createTable (tableDescriptor, splitKeysBytes)
        }
      }
    }

    /**
      * Creates a table (if it doesn't exist already) with one or more column families
      * and made of one or more regions
      *
      * @param tableName name of table
      * @param families set of column families
      */
    def createTable(tableName: String, families: Set [String]): Unit =
      createTable (tableName, families, Seq.empty)
      
    
    /**
     * Checks if table exists, and requires that it contains the desired column family
     *
     * @param tableName name of the table
     * @param family name of the column family
     *
     * @return true if table exists, false otherwise
     */
    def tableExists (tableName: String/*, family: String*/): Boolean = {
      val table = TableName.valueOf (tableName)
      admin.tableExists (table)
    }
      
    
    /**
      * Disables a table
      *
      * @param tableName name of table
      */
    def disableTable(tableName: String) = {
      val table = TableName.valueOf(tableName)
      if (admin.tableExists (table))
        admin.disableTable (table)
    }

    /**
      * Deletes a table
      *
      * @param tableName name of table
      */
    def deleteTable(tableName: String) = {
      val table = TableName.valueOf(tableName)
      if (admin.tableExists(table))
        admin.deleteTable (table)
    }

    /**
      * Truncates a table
      *
      * @param tableName name of table
      * @param preserveSplits true if region splits should be preserved
      */
    def truncateTable(tableName: String, preserveSplits: Boolean) = {
      val table = TableName.valueOf(tableName)
      if (admin.tableExists(table))
        admin.truncateTable(table, preserveSplits)
    }
    
}
