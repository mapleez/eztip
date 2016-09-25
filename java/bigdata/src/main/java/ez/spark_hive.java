package ez;

import java.io.IOException;

// import org.apache.spark.sql.hive.HiveContext;
// import org.apache.spark.SparkContext;

import org.apache.hadoop.conf.Configuration;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Result;


public class spark_hive {

	private static void test ()
		throws IOException, Exception  {
		String tbName = "spark_testing", 
			getrow = "row1",
			col_fam = "cf",
			col1 = "c1";
		// String col2 = "";

		// SparkConf sparkconf = new SparkConf ();
		// SparkContext sparkctx = new SparkContext (sparkconf);
		// HiveContext hivectx = new HiveContext (sparkctx);
		Configuration hbaseconf = HBaseConfiguration.create ();

		HTable table = new HTable (hbaseconf, tbName);
		Get g = new Get (Bytes.toBytes (getrow));
		Result res = table.get (g);

		byte [] id = res.getValue (Bytes.toBytes (col_fam), Bytes.toBytes (col1));
		byte [] val = res.getValue (Bytes.toBytes (col_fam), Bytes.toBytes (col1));
		String id_s = Bytes.toString (id);
		String val_s = Bytes.toString (val);

		System.out.println ("id: " + id_s + " val: " + val_s);

		// hivectx.sql ("");
	}

	public static void main (String [] args) {
		try {
			test ();
		} catch (Exception ex) {
			System.out.println (ex.getMessage ());
		}
	}

}
