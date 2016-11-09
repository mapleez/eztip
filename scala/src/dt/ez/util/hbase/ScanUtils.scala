/** 
 * Author : ez
 * Date : 2016/11/7
 * Description : Wrap HBase scanner.
 */

package dt.ez.util.hbase

import org.apache.hadoop.hbase.client.Scan
import org.apache.hadoop.hbase.filter.{Filter, FilterList, PageFilter, RowFilter}
import org.apache.hadoop.hbase.filter.{CompareFilter, BinaryPrefixComparator, BinaryComparator}
import org.apache.hadoop.hbase.filter.CompareFilter.CompareOp

class ScanUtils extends Tools {
  
  val scan = new Scan ()
  
  /** If you use a FilterList instance. Then you'd
   * better ensure the instance has at list one 
   * filter underlying. Or an unknown result will 
   * occurred while scan data after invoking scan.setFilter.
   * 
   * So I use a List to store filters and invoking setFilter
   * in method get().
   */
  val filters = List [Filter] ()
  
  def limit (num: Long) : ScanUtils = {
    scan.setCaching (1)
    filters :+ new PageFilter (num)
    this
  }
  
  def reverse (rev: Boolean = false) : ScanUtils = {
    scan.setReversed (rev)
    this
  }
  
  def keySmallerThan (key: String, equal: Boolean = true) : ScanUtils = {
    val cmp = if (equal) CompareOp.LESS_OR_EQUAL else CompareOp.LESS
    val rowkeyFilter = new RowFilter (cmp, new BinaryComparator (key.getBytes))
    filters :+ rowkeyFilter
    this
  }
  
  def keyBiggerThan (key: String, equal: Boolean = true) : ScanUtils = {
    val cmp = if (equal) CompareOp.LESS_OR_EQUAL else CompareOp.LESS
    val rowkeyFilter = new RowFilter (cmp, new BinaryComparator (key))
    filters :+ rowkeyFilter
    this
  }
  
  /* This function sets starting and ending rowkey on scanner. */
  def keyRange (start: String, stop: String) : ScanUtils = {
    this.scan.setStartRow (start)
    this.scan.setStopRow (stop)
    this
  }
  
  def startWith (start: String) : ScanUtils = {
    this.scan.setStartRow (start)
    this
  }
  
  def stopWith (stop: String) : ScanUtils = {
    this.scan.setStopRow (stop)
    this
  }
  
  /* This function sets starting and ending rowkey with filter. */
  private def keyRange (start: String, end: String, eqSta: Boolean = true, eqEnd: Boolean = true) : ScanUtils = {
    val cmpSta = if (eqSta) CompareOp.GREATER_OR_EQUAL else CompareOp.GREATER
    val cmpEnd = if (eqEnd) CompareOp.LESS_OR_EQUAL else CompareOp.LESS
    /* Set Start key, end key. */
    filters :+ new RowFilter (cmpSta, new BinaryComparator (start))
    filters :+ new RowFilter (cmpEnd, new BinaryComparator (end))
    this
  }
  
  def get : Scan = {
    if (! filters.isEmpty) {
      val filterList = new FilterList ()
      filters.foreach { filterList.addFilter (_) }
      this.scan.setFilter (filterList)
    }
    this.scan
  }
  
}

