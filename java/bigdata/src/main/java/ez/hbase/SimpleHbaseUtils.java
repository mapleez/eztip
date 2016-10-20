/**
 * Author : ez
 * Description : Simple function utils.
 * Date : 2016/10/20
 */
package ez.hbase;

import java.util.ArrayList;
import java.util.List;

// import org.apache.hadoop.conf.Configuration;

// import org.apache.hadoop.hbase.HBaseConfiguration;
// import org.apache.hadoop.hbase.HColumnDescriptor;
// import org.apache.hadoop.hbase.HTableDescriptor;
// import org.apache.hadoop.hbase.TableName;
// import org.apache.hadoop.hbase.client.Admin;
// import org.apache.hadoop.hbase.client.Connection;

import org.apache.hadoop.hbase.util.Bytes;

/* Hbase utilities function. */
public class SimpleHbaseUtils {

	public static byte [] str2Bytes (String s) {
		return Bytes.toBytes (s);
	}

	public static List <byte []> arr2Bytes (String ... arr) {
		List <byte []> buf = new ArrayList <byte []> (arr.length);
		for (String s: arr)
			buf.add (str2Bytes (s));
		return buf;
	}

}
