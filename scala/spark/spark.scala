import org.apache.spark.sql.SparkSession

var spark = SparkSession
	.builder ()
	.appName ("ezspark")
	getOrCreate ()

import spark.implicits._
