/*
 *编写时间：2014/7/28 
 *编写人：ez
 *类说明：用于常用的文件操作
 */

namespace lib_ez {

	using System;
	using System.Text;
	using System.Collections.Generic;
	using System.Linq;
	
	using System.IO;

	public static class filehelper {
	
		// TODO
		public const int BIT_LEN = 8;       	   // bits
		public const int BYTE_LEN = 1024;       // bits 
		public const int KB_LEN = 1048576;      // bits
		public const int GB_LEN = 1073741824;   // bits
	
		public static bool hasfile (String _fpath) {
			bool flag = File.Exists (_fpath);
			return flag;
		}
		
		/*
			DESCRIPTION :
				get file extension name . this function deal the file name and get sub string
			PARAMETERS :
				_fname : fileName with extension
			RETURN :
				file extension name : e.g.   doc , txt , xml
		*/
		public static String fileextense (String __fname) {
			// for windows
			int part = __fname.LastIndexOf ('.');
			String extn = __fname.Substring (part + 1);
			return extn;
		}
		
		public static bool hasdir (String __dirpath) {
			bool flag = Directory.Exists (__dirpath);
			return flag;
		}
		
		public static bool createdir (String __dirpath) {
			if (! hasdir (_dirpath))
				Directory.CreateDirectory (__dirpath);
			return true;
		}
		
		public static bool createfile (String __fname) {
			if (hasfile (__fname)) {
				return false;
			} else {

				FileStream fs = new FileStream (__fname, FileMode.Create);
				fs.Close ();
				fs.Dispose ();
				return true;
			}
		}

		public static FileStream createfile (String __fname) {
			FileStream fs = null;
			if (hasfile (__fname))
				fs = new fileStream (__fname, FileMode.Open);
			else
				fs = new FileStream (__fname, FileMode.Create);
			return fs;
		}
		
		/*
			DESCRIPTION : 
				copy file from _src direction to _dest direction
				this function cannot catch any runtime exception
			PARAMETERS :
				_src : source file name , completing name,
				_dest : destination direction and file name ,
				_buflen : copy file with while loop ,and each step uses a buffer, indicate the buff length
			RETURN :
				if _src file is null || _dirpatth is not null     return false
				else
					if copy success ,return true
		*/
		public static bool copyfile (String _src, String _dest, int _buflen) {
		
			if (File.Exists (_src)) {
				FileStream src = 
						new FileStream (_src, FileMode.Open, FileAccess.Read),
						   dest = 
						new FileStream (_dest, FileMode.OpenOrCreate, FileAccess.Write);

				byte [] buff = new byte [_buflen];
				int writen = 0;
				long len = src.Length;
				while ((writen = src.Read (buff, 0, _buflen)) > 0) {
					dest.Write (buff, 0, writen);
					len -= writen;
					// buff = new byte [_buflen];
				}
				src.Close   ();
				dest.Close  ();
				src.Dispose ();
				res.Dispose ();
				return true;
			}
			else 
				return false;
		}
		
		/*
			DESCRIPTION : 
				read file content into a byte array, the function can only accept
				maximum from parameter _maxlen
			PARAMETERS :
				_file : source file name , completing name,
				_buflen : copy buffer length
				_maxlen : the acceptable maximum file length (_file)
			RETURN :
				if _src file is null return null
				else
					if copy success ,return true
		*/
		public static byte [] readfile (String _file, int _buflen, int _maxlen) {
			
			if ( File.Exists (_file) ) {
			
                FileStream fs = new FileStream (_file, FileMode.Open, FileAccess.Read);
                long len = fs.Length;
				
                if (len > _maxlen) {  // this file length is too long 
                    return null;
                }
				
                byte[] fbuff = new byte[len];
                int writen = 0;
                int start = 0;

                long times = fs.Length / _buflen;

                for (int i = 0; i < times; i++) {
                    writen = fs.Read (fbuff, start, _buflen);
                    start += writen;
                }
                if (start != len) {
                    writen = fs.Read (fbuff, start, (int) len - start);
                }

                fs.Close ();
                fs.Dispose ();

                return fbuff;
			}
			return null;
		}
		
		/*
			DESCRIPTION : 
				write string into file, with ascii encoding, without '\r\n'.
				this function has check existing of file
			PARAMETERS :
				_file : full file name
				_str : string you want to write into
			RETURN : 
				none
		*/
		public static void appendfile (String _file, String _str) {
			if (hasfile (_file)) {
				FileStream fs = new FileStream (_file, FileMode.Append, FileAccess.Write);
				byte [] buff = System.Text.Encoding.GetBytes (_str);
				fs.Write (buff, 0, buff.Length);
			}
		}
		
		/*
			DESCRIPTION :
				delete file with parameter file path
			PARAMETERS : 
				_file : source file path
			RETURN :
				this method will always return true
		*/
		public static bool delfile (String _file) {
			// method doesn't throw any exception
			File.Delete (_file)
			return true;
		}
		
		
		/*
			DESCRIPTION :
				delete many files with parameter file path array
			PARAMETERS : 
				_files : source file path array
			RETURN :
				just call delfile ()
		*/
		public static void delfiles (String [] _files) {
			foreach (String file in _files) {
				delfile (file);
			}
		}
		
		
	}

}
