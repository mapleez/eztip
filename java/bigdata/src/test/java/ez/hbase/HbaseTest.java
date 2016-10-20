/**
 * Author : ez
 * Description : Test Hbase Utils.
 * Date : 2016/10/20
 */
package ez.hbase;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.util.Bytes;

import java.util.List;
import java.util.ArrayList;

/**
 * Unit test for simple App.
 */
public class HbaseTest 
    extends TestCase {
	/**
	 * Create the test case
	 *
	 * @param testName name of the test case
	 */
	public HbaseTest (String testName) {
	  super (testName);
	}
	
	/**
	 * @return the suite of tests being tested
	 */
	public static Test suite () {
	  return new TestSuite (HbaseTest.class);
	}
	
	/**
	 * Rigourous Test :-)
	 */
	public void testHbaseUtil () {
		try {
		  // configuration.
			HbaseConf conf = new HbaseConf ();
			conf.addProperty ("hbase.zookeeper.quorum", "master1")
			.addProperty ("hbase.zookeeper.property.clientPort", "2181");

			// hbase table.
			HbaseTable tb = new HbaseTable (conf.getConf ())
				.setName ("eztable")
				.setColumnFamilies ("columnf");

			// scanner builder.
			ResultScannerBuilder scan = 
				new ResultScannerBuilder (tb.createOrGet ());

			// scanner.
			ResultScanner scanner = scan.build ();
			List <String> column = new ArrayList <String> ();
			column.add ("common");
			column.add ("value");

			/* For display. */
			SimpleHbaseUtils.display (scanner, "columnf", column);

			tb.close ();
		} catch (Exception ex) {
			ex.printStackTrace ();
		}

	}
}


