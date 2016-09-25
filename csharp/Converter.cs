/*
 *编写时间：2014/7/28 
 *编写人：ez
 *类说明：本类封装了静态的通用数据类型转化方法
 */

namespace lib_ez.Converter {

	using System;
	using System.Text;
	using System.Collections;
	using System.Collections.Generic;
	
	public static class CommonConvert {
		
		/*
			many kinds of byte.ToString ();
			with different format string as parameter
		*/
		public static void bytetostr () {
			
			byte num = 213;  // for example
			
			String display = String.Empty;
			
			display = num.ToString ("C3");   // ￥213.000
			display = num.ToString ("D4");   // 0213   (4 Decimal)
			display = num.ToString ("e1");   // 2.1e+002
			display = num.ToString ("E2");   // 2.13E+002
			display = num.ToString ("F1");   // 213.0  (float with 1 )
			display = num.ToString ("G");    // 213   (???)
			display = num.ToString ("N1");   // 213.0  
			display = num.ToString ("P0");   // 21,300%
			display = num.ToString ("X4");   // 00D5    (HEX MODE with 4)
			display = num.ToString ("0000.0000");  // 0213.0000
			display = num.ToString ("x");    // d5   (hex mode)
			display = num.ToString ("x2");   // d5   (hex mode with 2)
			display = num.ToString ("x6");   // 0000d5 (hex mode with 6)
			
			return ;
			
		}
		
	}

}
