/**
 * Author : ez
 * Description : Configuration wrapper.
 * Date : 2016/10/20
 */

package ez.hbase;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.conf.Configuration;

import java.util.Map;
import java.util.Map.Entry;

public class HbaseConf {
	private final Configuration conf;

	public HbaseConf () {
		conf = HBaseConfiguration.create ();
	}

	public HbaseConf (Map <String, String> props) {
		this ();
		for (Entry <String, String> e: props.entrySet ())
			conf.set (e.getKey (), e.getValue ());
	}

	public Configuration getConf () {
		return this.conf;
	}

	// public Class <? extends HBaseConfiguration> getObjectType () {
	// 	return HBaseConfiguration.class;
	// }

}
