/*
 * Author : ez
 * Describe : The main process, initialize and start service.
 * Date : 2016/7/2
 */
public class server {
	public static void main (String [] args) {
		conn srv = new conn ();
		srv.service ();
	}
}
