/*
	AUTHOR : ez
	CREATE DATE : 2014/12/16
	DESCRIBE : A socket for tcp protocal.

*/

namespace libezsharp.depth {

	using System;
	using System.Net;
	using System.Net.Sockets;
	using System.Collections;

	public class tcp : Socket, idepth {
		
		private String _addr;
		private int _port;

		public String Addr {
            get { return this._addr; }
            set { this._addr = value; }
        }
		
        public int Parameters {
            get { return this._port; }
            set { this._port = value; }
        }

		
		public tcp (String __ip, int __port) 
			: base (AddressFamily.InterNetwork, 
					SocketType.Stream, 
					ProtocolType.Tcp)
		{
			this._addr = __ip;
			this._port = __port; 
			// default sychonorious timeout
			base.SendTimeout = 500;
			base.ReceiveTimeout = 1000;
		}
		
        public bool open_channel () {
			Connect (this._addr, this._port);
			return Connected;
		}
		
        public void close_side (
			SocketShutdown __flag) {
			Shutdown (__flag);
		}

		public bool close_channel () {
			Close ();
			return ! Connected;
		}

		
		// synchronous send ()
		public int send (
				byte [] __frm, 
				int __len, 
				int __off) {
			return Send (__frm, __off, 
					__len, SocketFlags.None);
		}
		
		// synchronous rcv ()
		public int recv (
				byte [] __frm, 
				int __len, 
				int __off) {
			return Receive (__frm, __off, 
					__len, SocketFlags.None);
		}
		
		// asynchronous send ()
        public IAsyncResult send (
				byte [] __frm, 
				int __len, 
				int __off, 
				AsyncCallback __callback) {
			return 
				BeginSend (__frm, __off, __len,
					SocketFlags.None,
					__callback,
					this);
		}
		
		// asynchronous received callback()
		private void _snd_callback (
				IAsyncResult __ar) {
		}
		
		// asynchronous received ()
		public IAsyncResult recv (
				byte [] __frm, 
				int __len, 
				int __off,
				AsyncCallback __callback) {
			return 
				BeginReceive (__frm, __off, __len,
					SocketFlags.None,
					__callback,
					this);
		}
		
		// asynchronous received callback
		private void _rcv_callback (
				IAsyncResult __ar) {
		}

	}

}
