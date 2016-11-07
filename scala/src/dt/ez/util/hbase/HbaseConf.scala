package dt.ez.util.hbase

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.conf.Configuration

/**
 * Wrapper for HBaseConfiguration
 */
class HbaseConf (defaults: Configuration) extends Serializable {
  def get = HBaseConfiguration.create (defaults)
}

/**
 * Factories to generate HBaseConfig instances.
 *
 * We can generate an HBaseConfig
 * - from an existing HBaseConfiguration
 * - from a sequence of String key/value pairs
 * - from an existing object with a `rootdir` and `quorum` members
 *
 * The two latter cases are provided for simplicity
 * (ideally a client should not have to deal with the native
 * HBase API).
 *
 * The last constructor contains the minimum information to
 * be able to read and write to the HBase cluster. It can be used
 * in tandem with a case class containing job configuration.
 */
object HbaseConf {
  def apply (conf: Configuration): HbaseConf = new HbaseConf (conf)

  def xp = "feafeaw"
  
  def apply (options: (String, String)*): HbaseConf = {
    val conf = HBaseConfiguration.create

    for ((key, value) <- options) { conf.set(key, value) }

    apply(conf)
  }

  def apply (conf: { def rootdir: String; def quorum: String }): HbaseConf = apply (
    "hbase.rootdir" -> conf.rootdir,
    "hbase.zookeeper.quorum" -> conf.quorum)
}

