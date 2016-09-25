package ez;

import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;


public class sparksql {

	static SparkSession spark;

	public static void init () {
		spark = SparkSession
			.builder ()
			.appName ("Java Spark SQL Example")
			.getOrCreate ();
			// .Config ("")
	}

	public static void main (String [] args) {
		init ();
		createDataFrames ();
	}

	public static Dataset <Row> createDataFrames () {
		Dataset <Row> df = spark.read ().json ("/ez/people.json");
		return df;
	}

	public static void registTempView (String viewName, Dataset <Row> df) {
		if (null == df || null == viewName || 0 < viewName.length ()) return;
		df.createOrReplaceTempView (viewName);
	}

	public static void registTempTable (String tableName, Dataset <Row> df) {
		if (null == df || null == tableName || 0 < tableName.length ()) return;
		df.registerTempTable (tableName);
	}

	public static Dataset <Row> sql (String _sql) {
		if (null == spark || null == _sql) return null;
		Dataset <Row> sqldf = spark.sql (_sql);
		return sqldf;
	}

	public static Dataset <Row> select (String col, Dataset <Row> df) {
		if (null != df && 
				null != col && 
				0 < col.length ()) {
			df.select (col);
		} else {
			System.out.println ("Error select () dataframe.");
		}
		return df;
	}

	public static Dataset <Row> filter (String col, Dataset <Row> df) {
		if (null != df && 
				null != col && 
				0 < col.length ()) {
			df.filter (col);
		} else {
			System.out.println ("Error filter () dataframe.");
		}
		return df;
	}

	public static Dataset <Row> groupBy (String col, Dataset <Row> df) {
		if (null != df && 
				null != col && 
				0 < col.length ()) {
			df.groupBy (col);
		} else {
			System.out.println ("Error groupBy () dataframe.");
		}
		return df;
	}
 
}

