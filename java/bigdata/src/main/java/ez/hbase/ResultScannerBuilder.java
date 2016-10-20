/**
 * Author : ez
 * Description : ResultScanner utils.
 * Date : 2016/10/20
 */
package ez.hbase;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.filter.Filter;
// import org.apache.hadoop.io.Writable;
// import com.google.common.collect.Lists;


public class ResultScannerBuilder {

	private final List <byte []> familyNames;
	private final HTable table;
	
	private byte [] startRow;
	private byte [] stopRow;
	
	private Filter filter;
	
	public ResultScannerBuilder (HTable table) {
		this.table = table;
		familyNames = new ArrayList <byte []> ();
	}

  public ResultScannerBuilder addCf (String ... cfs) {
    return addCf (SimpleHbaseUtils.arr2Bytes (cfs));
  }

  public ResultScannerBuilder addCf (List <byte []> cfs) {
    familyNames.addAll (cfs);
    return this;
  }

  public ResultScanner build () throws IOException {
		Scan scan = new Scan ();
		for (byte [] fam : familyNames)
			scan.addFamily (fam);
		
		if (startRow != null)
			scan.setStartRow (startRow);
		if (stopRow != null)
			scan.setStopRow (stopRow);
		
		if (filter != null)
			scan.setFilter (filter);
		return table.getScanner (scan);
  }

  // public ResultScannerBuilder startAt (Writable startRowKey) {
  //     return startAt (HBaseUtils.forWritable (startRowKey));
  // }

	public ResultScannerBuilder startAt (byte [] startRow) {
		this.startRow = startRow;
		return this;
	}

  // public ResultScannerBuilder stopAt(Writable stopRow) {
  //     return stopAt(HBaseUtils.forWritable(stopRow));
  // }

	public ResultScannerBuilder stopAt (byte [] stopRow) {
		this.stopRow = stopRow;
		return this;
	}

	public ResultScannerBuilder filter (Filter filter) {
		this.filter = filter;
		return this;
	}

}
