/*
 *编写时间：2014/7/28 
 *编写人：ez
 *类说明：本类封装了静态的加密算法
 */

namespace lib_ez.Encription {

	using System;
	using System.Text;
	using System.Collections;
	using System.Collections.Generic;
	
	using System.Security.Cryptography;
	
	public class Encription {
		
		
		/*
			DESCRIPTION :
				MD5 Hash Encryption (return approximately 32-length string )
			PARAMETERS :
				_str : the string you want to Encrypt;
			RETURN : Encrypted string
		*/
		public static String Md4Encription (String _str) {
			MD5 md5 = new MD5CryptoServiceProvider ();
			
			byte [] fromData = Encoding.Unicode.GetBytes (_str);
			byte [] targetData = md5.ComputeHash (fromData);
			string res = null;
			
			for (int i =0; i < targetData.Length; i++) {
				res += targetData[i].ToString ("x");  // convert to hex 
			}
			
			return res;
		}
		
		
	}

}
