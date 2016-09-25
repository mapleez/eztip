/*
 * Author : ez
 * Describe : User model
 * Date : 2016/7/2
 */

import java.net.Socket;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.IOException;

public class user {

	private int _id;
	private String _name;
	private Socket _sock;

	private OutputStream _out;
	private InputStream _in;

	public user () {}

	public user (int id, String nm) {
		this._id = id;
		this._name = nm;
	}

	public boolean load_channel (Socket _s) {
		if (_s.isConnected ()) {
			this._sock = _s;
			try {
				this._out = _s.getOutputStream ();
				this._in = _s.getInputStream ();
				_sock = _s;
			} catch (IOException ex) {
				ezutils.println ("load_channel error.");
				return false;
			}
			return true;
		}
		return false;
	}

	public void disconnect () {
		try {
			ezutils.println ("disconnect.");
			this._sock.close ();
		} catch (Exception ex) {
			ezutils.println ("close error.");
		}
	}

	public int read (byte [] _buff) {
		int rd_len = 0;
		try {
			rd_len = this._in.read (_buff);
		} catch (IOException ioex) {
			ezutils.println ("read error.");
		}
		return rd_len;
	}

	public boolean write (String _str) {
		try {
			this._out.write (_str.getBytes ());
			return true;
		} catch (IOException ex) {
			ezutils.println ("Write IOException:" + 
					ex.getMessage ());
			return false;
		}
	}

	public void close () {
		try {
			this._sock.close ();
			ezutils.println ("close client socket.");
		} catch (IOException ioex) {
			ezutils.println ("close client socket error : " + 
					ioex.getMessage ());
		}
	}

	public int get_id () {
		return this._id;
	}

	public String get_name () {
		return this._name;
	}

	public void set_name (String nm) {
		this._name = nm;
	}
}
