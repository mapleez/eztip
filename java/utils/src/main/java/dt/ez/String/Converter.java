/*
 * Author : ez
 * Describe : String utilities for Converting.
 * Date : 2016/10/19
 */
package dt.ez.String;

public class Converter {

	public static int hex2i (char c) {
		if (c >= '0' && c <= '9')
			return c - '0';
		else if (c >= 'A' && c <= 'F')
			return c - 'A' + 10;
		else if (c >= 'a' && c <= 'f')
			return c - 'a' + 10;
		else
			return (-1);
	}

}
