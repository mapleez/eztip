package ez;

import org.apache.spark.api.java.JavaRDD;

public class Main {

	private static MySpark spark;

	public static void main ( String[] args ) {
		System.out.println ( "Start Spark testing" );
		spark.config ("myfirst_spark", "yarn");
		JavaRDD <String> input = spark.createRDD ("data.dat");
		int len = spark.calculate (input);
		System.out.println ("The total length : " + len);
	}


}
