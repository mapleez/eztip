/*

AUTHOR : ez
CREATE DATE : 2015/10/26
DESCRIBE : support functions to parse 
	config file. The format of config 
	file meight look like them below:
		key = value
	We ignore the line started with '#'.
	It will be translated to comments;
NOTE : This interface may not support
	parallel .

*/
namespace libezsharp {

	using System;
	using System.Collections;
	using System.Text;

	public class config_entity {

		private String _val;
		private String _key;

	}

	public static class txtconfig {

		// TODO...
		public static config_entity [] 
			parse_config (String __conf_filename) {
		}

		// TODO...
		public static Dictionary <String, int>
			parse_config (String _conf_filename) {
			Dictionary <String, int> res = 
				new Dictionary <String, int> ();
			byte [] buff = new byte [256];
			int read_len = 0;
			if (! filehelper.hasfile 
					(__conf_filename))
			{
				// TODO...
				return null;
			}
			FileStream fs = new FileStream (
					__conf_filename,
					FileMode.Open,
					FileAccess.Read
					);
			while (0 <
					(read_len = 
					fs.Read (buff, 0, 256)))
			{
				if (buff [0] == (byte) '#')
			}
		}

		// public static void
		// 	parse_config (String _conf_filename) {
		// }

	}
}
