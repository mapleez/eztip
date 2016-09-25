/*
 * Author : ez
 * Describe : My tools 
 * Date : 2016/7/2
 */
import java.util.Date;
import java.text.SimpleDateFormat;

public class ezutils {
	private static int num = 1;

	private static String _current () {
		return new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").
			format (new Date ());
	}

	public static void println (String _str) {
		System.out.println (_str);
	}

	public static void printlog (String _str) {
		String log = "[" + (num ++) + "] " + 
			 _current () + " " + _str;
		println (log);
	}

	public static void reset_num () {
		num = 1;
	}

	public static int get_num () {
		return num;
	}
}

