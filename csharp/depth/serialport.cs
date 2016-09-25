/*
	AUTHOR : ez
	DATE : 2014/12/29
	DESCRIBE : 用于serial port 通信的套接字, 提供异步通信

*/

namespace ModbusScadaEngine.Depth {

	using System;
	using System.IO.Ports;
	using System.IO;
	using System.Text;
	using System.Collections;
	using System.Collections.Generic;
	using System.Threading;
    using ModbusScadaEngine.Entity;
	
	using ModbusScadaEngine.Buffer;
    using lib_ez;

	public class serialport : IDepth {
		
		private String port;   // port number
		private String parames;  // parameters
		private SerialPort sp;
		// private ManualResetEvent rcv_lock;
		// private ManualResetEvent snd_lock;
		
		public String Addr {
            get { return this.port; }
            set { this.port = value; }
        }
		
        public String Parameters {
            get { return this.parames; }
            set { this.parames = value; }
        }

        public KindOfProtocol KindOf {
            get { return KindOfProtocol.PF_S_PORT; }
        }
		
		public serialport (String _port, String _parames) {
			this.port = _port;
			this.parames = _parames;
			this.sp = new SerialPort (_port);
			this.parse_params (_parames); // init serial port
		}
		
		public serialport (Machine _mch) {
			this.port = _mch.ProtoAddr;
			this.parames = _mch.Parames;
            this.sp = new SerialPort (this.port);
			this.parse_params (this.parames);
		}
		
        // methods 
		// open
        public bool open () {
			try {
				this.sp.Open ();
				return sp.IsOpen;
			} catch {
				return false;
			}
			/*
			// IPEndPoint __client = new IPEndPoint (IPAddress.Parse (this.addr), 
												  int.Parse (this.parames));
			try {
				this.sock.Connect (__client);
				return this.sock.Connected;
			} catch {
				// TODO!
				return false;
			}
			*/
		}
		
		// close channel
        public bool close () {
			try {
				this.sp.Close ();
				return true;
			} catch {
				return false;
			}
		}

		
		// synchronous send ()
		public bool sends (mbs_frm _frm) {
			try {
				this.sp.Write (_frm.Req, 0, _frm.Req.Length);
				return true;
			} catch {
				return false;
			}
		}
		
		// synchronous rcv ()
		public bool rcvs (mbs_frm _frm) {
			try {
				int __read_len = this.sp.Read (_frm.Res, 0, _frm.Res.Length);
				_frm.ResponseLength = __read_len;
				return true;
			} catch {
				return false;
			}
		}
		
		// 异步发送数据帧
        public bool send (mbs_frm _frm) {
			// try {
				// this.sock.BeginSend (_frm.Req, 0, _frm.Req.Length, 0, new AsyncCallback (this.snd_callback), _frm);
				// this.snd_lock.WaitOne (Config.SND_TIMEOUT);
				// return true;
			// } catch {
				// // TODO
				// return false;
			// }
            return false;
		}
		

		
		// 异步发送回调函数
		private void snd_callback (IAsyncResult _ar) {
			// try {
				// mbs_frm __frm = (mbs_frm) _ar.AsyncState;
				// int __sent_len = this.sock.EndSend (_ar);
				// this.snd_lock.Set ();
			// } catch {
				// // TODO
			// }
		}
		
		// 异步接收函数
		public bool rcv (mbs_frm _frm) {
			// try {
				// this.sock.BeginReceive (_frm.Res, 0, _frm.Res.Length, 0, new AsyncCallback (this.rcv_callback), _frm);
				// this.rcv_lock.WaitOne (Config.RCV_TIMEOUT);
				// return true;
			// } catch {
				// // TODO
				// return false;
			// }
            return false;
		}
		
		// 异步接收回调函数
		private void rcv_callback (IAsyncResult _ar) {
			// try {
				// mbs_frm __frm = (mbs_frm) _ar.AsyncState;
				// int __rcv_len = this.sock.EndReceive (_ar);
                // // Console.Write("rcv");// 测试用
				// this.rcv_lock.Set ();
				// // 将帧句柄赋给指定的mbs_frm, 在buffer.rcvbuf 中
				// if (__frm.Req[0] != __frm.Res[0] || __frm.Req[1] != __frm.Res[1]) {
					// mbs_frm __item;
					// if (buffer.rcvbuf.Array.TryGetValue (memhelper.b2tos (__frm.Res[0], __frm.Res[1]), out __item)) {
						// __item.Res = __frm.Res;
                        // __item.ResponseLength = __rcv_len;
						// // __frm.Res = null;
					// }
				// }
				// else {
                    // __frm.ResponseLength = __rcv_len;
					// // __frm.Res = __frm.Res;
				// }
			// } catch {
				// // TODO
			// }
		}

		public string[] parse_params (String _params) {
			String[] __params = this.parames.Split ('#');
			if (__params.Length >= 3) {
				this.sp.BaudRate = int.Parse (__params[0]);   // BaudRate;
				this.sp.DataBits = int.Parse (__params[1]);   // DataBits;
				/*
					StopBits.None = 0x00
					StopBits.One
					StopBits.OnePointFive
					StopBits.Two
				*/
				this.sp.StopBits = (StopBits) int.Parse (__params[2]);			  // stopbytes
				/*
					Parity.Even = 0x00
					Parity.Mark = 0x01
					Parity.None
					Parity.Odd
					Parity.Space
				*/
				this.sp.Parity = (Parity) int.Parse (__params[3]);        // parity
			}
            return __params;
		}
		
		// dispose
        public void Dispose() { 
            // TODO
            this.sp.Dispose ();
        }
		
	}

}
