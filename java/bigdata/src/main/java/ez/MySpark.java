package ez;

import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.Function2;


public class MySpark {
	private static SparkConf conf;
	private static JavaSparkContext sc;

	public static void config (String app, String master) {
 		conf = new SparkConf ()
			.setAppName (app);
			// .setMaster (master);
		sc = new JavaSparkContext (conf);
	}

	// create from local filesystem
	public static JavaRDD <String> createRDD (String fname) {
		JavaRDD <String> distFile = sc.textFile (fname);
		return distFile;
	}

	public static int calculate (JavaRDD <String> input) {
		// JavaRDD <Integer> len = input.map (s -> s.length ());
		// int total = len.reduce ((a, b) -> a + b);
		JavaRDD <Integer> len = input.map (new Function <String, Integer> () {
			public Integer call (String s) {
				return s.length ();
			}
		});

		int total = len.reduce (new Function2 <Integer, Integer, Integer> () {
			public Integer call (Integer a, Integer b) {
				return a + b;
			}
		}) ;
		return total;
	}

	public static void main (String [] args) {
		int result = 0;
		String filename = null;

		// input file name
		if (null != args [0] && args [0].length () <= 0) {
			System.out.println ("Error, please input filename.");
			return;
		}

		filename = args [0];

		config ("ezspark", "spark://localhost:7077");
		JavaRDD <String> input = createRDD (filename);
		result = calculate (input);
		System.out.println ("TotalLength = " + result);
	}

}


