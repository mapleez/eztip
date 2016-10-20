/**
 * Author : ez
 * Description : HTable utils.
 * Date : 2016/10/20
 */
package ez.hbase;

import org.apache.hadoop.conf.Configuration;

import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.HBaseAdmin;

import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;

import java.util.List;
import java.util.ArrayList;

public class HbaseTable {

	private String tbName;
	private int maxVersion;
	private final Configuration conf;
	private final List <HColumnDescriptor> cfDesc;
	private final HBaseAdmin admin;

	public HbaseTable (Configuration conf) throws Exception {
		cfDesc = new ArrayList <HColumnDescriptor> ();
		this.conf = conf;
		admin = new HBaseAdmin (this.conf); // will throws
	}

	/* It must be called at least one times. */
	public HbaseTable setName (String tbName) {
		this.tbName = tbName;
		this.maxVersion = 1; // default
		return this;
	}

	/* Set max version. */
	public HbaseTable setMaxVer (int maxVersion) {
		this.maxVersion = maxVersion;
		return this;
	}

	/* Add column families. */
	public HbaseTable setColumnFamilies (String ... cfs) {
		for (String s: cfs) {
			HColumnDescriptor cfd = new HColumnDescriptor (s);
			cfd.setMaxVersions (maxVersion);
			cfDesc.add (cfd);
		}
		return this;
	}

	// public HbaseTable setColumnFamilies (String ... cfs) {
	// 	for (String s: cfs) {
	// 		HColumnDescriptor cfDesc = new HColumnDescriptor (s);
	// 		cfDesc.setMaxVersions (maxVersions);
	// 		cfDesc.add (cfDesc);
	// 	}
	// 	return this;
	// }

	/* Get a HTable object from a existing table. */
	private HTable get () throws Exception {
			return new HTable (conf, tbName);
	}

	/* Create a table that is not existing. */
	private HTable createTable () throws Exception {
			HTableDescriptor tdesc = 
				new HTableDescriptor (this.tbName);
			for (HColumnDescriptor d: cfDesc)
				tdesc.addFamily (d);
			admin.createTable (tdesc);
			return new HTable (conf, tbName);
	}

	/* If the table (tbName) is exists, then get HTable,
	 * Otherwise create it and return HTable;
	 */
	public HTable createOrGet () throws Exception {
		if (admin.tableExists (tbName))
			return this.get ();
		else 
			return this.createTable ();
	}

	public HTable deleteOrCreate () throws Exception {
		if (admin.tableExists (tbName)) {
			admin.disableTable (tbName);
			admin.deleteTable (tbName);
		}
		return createTable ();
	}

	/* Close HBaseAdmin */
	public void close () throws Exception {
		admin.close ();
	}

}


