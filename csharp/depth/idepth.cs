/*
	AUTHOR : ez
	DATE : 2014/10/23
	DESCIRBE : 底层通信接口
	
	WORKINGGROUP Dre@mtech
*/
namespace libezsharp.depth {

    using System;

    interface idepth : IDisposable {

        String Addr {
            get;
            set;
        }

        String Parameters {
            get;
            set;
        }

        bool open_channel ();
        bool close_channel ();

		// synchronous
        int send (byte [] _frm, int _len, int _off);
		int recv (byte [] _frm, int _len, int _off);

		// asynchronous
		IAsyncResult sendasync (
				byte [] _frm, int _len, 
				int _off, 
				AsyncCallback __callback);

		IAsyncResult recvasync (
				byte [] _frm, int _len, 
				int _off, 
				AsyncCallback __callback);

    }
}
