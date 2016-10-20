/**
 * Author : ez
 * Description : Simple function utils.
 * Date : 2016/10/20
 */
package ez.hbase;

import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Result;

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

	private static String bytes2Str (byte [] b) {
		return Bytes.toString (b);
	}

	private static void dispRow (Result r, List <String> fams,
		 List <String> cols) {
		/* For iterate. */
		String key = bytes2Str (r.getRow ());
		String row = key + " ->\n";
		for (String f: fams) {
			for (String c: cols) {
				row += "\t" + f + ":" + c + "=" + 
					bytes2Str (r.getValue (str2Bytes (f), str2Bytes (c))) 
					+ "\n";
			}
		}
		System.out.println (row);
	}

	private static void dispRow (Result r, 
		 String fam, List <String> cols) {
		String key = bytes2Str (r.getRow ());
		String row = key + " ->\n";
		for (String c: cols) {
			row += "\t" + fam + ":" + c + "=" + 
				bytes2Str (r.getValue (str2Bytes (fam), str2Bytes (c))) 
				+ "\n";
		}
		System.out.println (row);
	}

	public static void display (ResultScanner scan, 
		String family, List <String> column) {
		for (Result r: scan) {
			dispRow (r, family, column);
		}
	}

	public static void display (ResultScanner scan, 
		 List <String> families, List <String> columns) {
		for (String f: families) {
			display (scan, f, columns);
		}
	}

	public static void display (ResultScanner scan,
		 String fam, String col) {
		List <String> list = new ArrayList <String> ();
		list.add (col);
		display (scan, fam, col);
	}

}
