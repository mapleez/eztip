/*
	author : ez
	date : 2015/4/13
	describe : a class to support writing log string into logfile
*/
namespace libezsharp {

    using System;
    using System.Collections;
    using System.Collections.Generic;

    using System.IO;

    public class log {

		// support dynamically file path changing
        public String filepath {
            get { return this._logfile; }
            set {
                if (this._writer != null && close_file ())
                    this._writer = new StreamWriter (this._logfile = value, true); // support appending writing
                else
                    open_file (this._logfile = value);
            }
        }

        public log (String __log_file) {
            this.open_file (this._logfile = __log_file);
        }

        public bool writeln_log (String __str) {
            if (this._writer == null && !this.open_file (this._logfile))
                return false;
            this._writer.WriteLine (__str);
            this._writer.Flush ();
            return true;
            /*
            if (this._fs == null && ! this.open_file (this._logfile))
                return false; // error in close file
            writer = new StreamWriter (this._fs);
            writer.WriteLine (__str);
            return true;
            */
        }

        public static void del_log_file (String __file) {
            if (File.Exists (__file))
                File.Delete (__file);
        }

        private bool open_file (String __log_file) {
            try {
                this._writer = new StreamWriter (__log_file, true);
                return true;
            }
            catch (Exception ex) {
				// show exception message to Console
                Console.WriteLine ("libezsharp.log.open_file [" + DateTime.Now.ToString () + "] : " + ex.Message);
                return false;
            }
        }

		// always return true
        public bool close_file () {
            this._writer.Dispose ();
            return true;
        }

        private StreamWriter _writer;
        private String _logfile;
    }

}
