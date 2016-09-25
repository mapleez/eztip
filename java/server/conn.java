/*
 * Author : ez
 * Describe : channel for client to connect.
 * Date : 2016/7/2
 */

import java.net.ServerSocket;
import java.net.InetAddress;
import java.net.Socket;
import java.net.InetSocketAddress;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.ArrayList;

public class conn {
	private ServerSocket _core;
	private List<user> _usrs;
	private boolean _run;
	private static int current_id;

	public conn () {
		InetAddress addr = new InetSocketAddress (
				config.bind_ip, config.port).getAddress ();
		try {
			this._core = new ServerSocket (
					config.port, config.backlog, addr);
			this._core.setSoTimeout (config.so_timeo);
		} catch (IOException ioex) {
			ezutils.printlog (ioex.getMessage ());
		} catch (Exception ex) {
			ezutils.printlog (ex.getMessage ());
		}
		_usrs = new ArrayList <user> ();
		_run = true;
		conn.current_id = 1;
	} 

	public void service () {
		Socket cli_sock = null;
		user usr = null;
		ezutils.printlog ("Start Server Service.");
		ezutils.printlog (
			"Start Server Service, port=" + config.port +
			", bind_ip=" + config.bind_ip);
		while (_run) {
			user usr = null;
			try {
				// OutputStream out = null;
				int srv_port, cli_port;
				boolean temp = false;
				usr = new user ();
				cli_sock = _core.accept ();
				usr = new user (conn.current_id ++, 
					Integer.toString (conn.current_id));
				if (! usr.load_channel (cli_sock)) {
					current_id --;
					continue;
				}
				// --- display ---
				srv_port = cli_sock.getLocalPort ();
				cli_port = cli_sock.getPort ();
				ezutils.printlog ("sport = " + srv_port + 
						", cport = " + cli_port);
				// --- display ---
				boolean connected = true;

				while (connected) {
					if (! usr.write ("Hello!")) {
						connected = false;
					} else {
						ezutils.println ("wroten!");
					}
					Thread.sleep (1000);
				}
				usr.close ();
			} catch (IOException ioex) {
				ezutils.printlog ("Accept IOException : " + ioex.getMessage ());
			} catch (Exception ex) {
				ezutils.printlog ("Accept OtherException : " + ex.getMessage ());
				temp = usr.load_channel (cli_sock);
				if (! temp) 
					continue;
				// ezutils.printlog ("sport = " + srv_port + 
				// 		", cport = " + cli_port);
				boolean connected = true;

				while (connected) {
					int wt_status = usr.write ("Hello world!");
					if (wt_status == -1) {
						usr.disconnect ();
						connected = false;
					}
				}

			} catch (IOException ioex) {
				ezutils.printlog ("write () IOException : " + ioex.getMessage ());
				// usr.disconnect ();
			} catch (Exception ex) {
				ezutils.printlog ("OtherException : " + ex.getMessage ());
				// usr.disconnect ();
			}
		} // while
	}

	public void stop () {
		this._run = false;
		try {
			this._core.close ();
		} catch (IOException ioex) {
			ezutils.printlog (ioex.getMessage ());
		}
	}

	private byte [] _testing_string (String _str) {
		return _str.getBytes ();
	}

	private boolean _remote_status (Socket _cli_sock) {
		try {
			_cli_sock.sendUrgentData (0x32);
			return true;
		} catch (IOException ex) {
			ezutils.printlog ("IOException _remote_status () :" + 
					ex.getMessage ());
			return false;
		}
	}

}

