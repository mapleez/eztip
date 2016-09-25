/*
	Author : ez
	Date : 2015/6/21
	Describe : send a http request and get response
	
*/
namespace http {
	
    using System;
    using System.Data;
    using System.Collections;
    using System.Text;
    using System.Net;
    using System.IO;

    public class http_pro {
		
        public static void Main (String[] args) {

            string page_url = "http://www.baidu.com";
			string content = "content";
			
            try {
				
                for (int i = 0; i < 100; i++) {
					
                    HttpWebRequest request = (HttpWebRequest) HttpWebRequest.Create (page_url);
                    request.Method = "GET";
                    request.ContentLength = content.Length;
                    request.ContentType = "applicatioin/x-www-form-urlencoded";
                    request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
                    request.Referer = "http://baidu.com";
                    request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0";

                    Stream stream = request.GetRequestStream ();
                    byte[] content = Encoding.ASCII.GetBytes (content);
                    stream.Write (content, 0, content.Length);
                    stream.Close ();
                    HttpWebResponse response = (HttpWebResponse) request.GetResponse ();
                    response.Close ();
                }
            } catch (Exception ex)
				Console.WriteLine (ex.Message);

        }

    }

}