package ezsrv

import "net"
import "bufio"
import (. "os")
// import "encoding/binary"
// import "bytes"

type Iezproto interface {

  // server 
  Start_server_loop (*Ezserver)
  End_server_loop (*Ezserver)
  Shutdown_server (*Ezserver)

  // client
  Start_client_loop (*Ezclient)
  End_client_loop (*Ezclient)
  _connect (*Ezclient)
  _regist (*Ezclient) int
  _send_msg (string, *Ezclient, *Ezclient) int
  Broadcast (string, *Ezclient) int
  Receive_parsing (*Ezclient, int)
  Shutdown (*Ezclient) int

}

// protocol for server endpoint
type Iezproto_server interface {
  Start_server_loop (*Ezserver)
  End_server_loop (*Ezserver)
  Shutdown_server (*Ezserver)
}

// protocol for client endpoint
type Iezproto_client interface {
	Start_client_loop (*Ezclient)
  End_client_loop (*Ezclient)
  _connect (*Ezclient)
  _regist (*Ezclient) int
  _send_msg (string, *Ezclient, *Ezclient) int
  Broadcast (string, *Ezclient) int
  Receive_parsing (*Ezclient, int)
  Shutdown (*Ezclient) int
}

// implement a special protocol function set.
type Ezchatproto struct {}

// sizeof (frame_header) == 0x6 bytes
type frame_header struct {

  transflag uint16
  typeflag uint8
  dstid uint8
  srcid uint8
  length uint8

  // The body is data domain
}

func (this *frame_header) _tobytes (_data []byte) ([]byte, int) {
	// max data length = 0xff
/*len (_data) != int (this.length) ||*/
  if  len (_data) > 0xff {
    return nil, 0
  }

  var res = make ([]byte, len (_data) + 6)

  // little-endian
  res [0] = byte ( this.transflag & 0x00ff)
  res [1] = byte ((this.transflag & 0xff00) >> 8)

  res [2] = this.typeflag
  res [3] = this.dstid
  res [4] = this.srcid
  res [5] = this.length

  // res [6:] = _data [0:]
  for i, v := range _data {
    res [i + 6] = v
  }

  return res, (len (_data) + 6)
}

const (
    Registing = iota + 1
    Sending
    Broadcasting
    Cln_closing
    Srv_closing
)

// ----------- for client -------------------
func (Ezchatproto) Start_client_loop (_cln *Ezclient) {
  var stdinRead = bufio.NewReader (Stdin)

  // connect and regist
  print ("Start connecting server...")
  _cln._proto._connect (_cln)
  if _cln._sock == nil {
    print ("Error in connecting server, will now stop.\n")
    return
  }
  print ("Done !\n")

  // regist
  if _cln._proto._regist (_cln) <= 0 {
    println ("Error in registing to server.")
    return
  }

  for {
     print ("send >")
     inbuff, isprefix, err := stdinRead.ReadLine ()

     if isprefix || err != nil {
       println ("<error occured or your input is too long :(>")
       continue
     } else {
       println (string (inbuff))
     }

  }

}

func (Ezchatproto) End_client_loop (*Ezclient) {
}

func (Ezchatproto) _connect (_cln *Ezclient) {
  addr, _ := net.ResolveTCPAddr ("tcp", _cln._remote_addr)
  conn, err := net.DialTCP ("tcp4", nil, addr)
  if err != nil {
    _cln._sock = nil
    return
  }
  _cln._sock = conn
}


func (Ezchatproto) _send_msg (_str string, _cln, _dst *Ezclient) int {

  var framehdr frame_header
  var data = []byte (_str)
  var frame []byte
  var frame_len int

  // we only send a header
  _cln._trans ++
  framehdr.transflag = uint16 (_cln._trans)
  framehdr.typeflag  = byte (Sending)
  framehdr.dstid  = byte (_dst._num)
  framehdr.srcid  = byte (_cln._num)
  framehdr.length = uint8 (len (data))

  frame, frame_len = framehdr._tobytes (data)
  if frame_len != len (data) + 6 {
		return 0
  }

  writelen, _ := _cln._sock.Write (frame [0:frame_len])

  if writelen != frame_len {
    return 0
  }

  return writelen
}

func (Ezchatproto) _regist (_cln *Ezclient) int {

  var frame frame_header

  // we only send a header
  _cln._trans ++
  frame.transflag = uint16 (_cln._trans)
  frame.typeflag = byte (Registing)
  frame.dstid = 0 // to server, id = 0
  frame.srcid = byte (_cln._num)
  frame.length = 0
  _cln._wbuff, _ = frame._tobytes (make ([]byte, 0))

  writelen, err := _cln._sock.Write (_cln._wbuff [0:6])
  if writelen != 0x06 || err != nil {
    _cln._num = -1
  }

  readlen, _ := _cln._sock.Read (_cln._rbuff [0:])

  // parsing num
  _cln._proto.Receive_parsing (_cln, readlen)
  return _cln._num

}

func (Ezchatproto) Receive_parsing (_cln *Ezclient, _len int) {
  // TODO
}

func (Ezchatproto) Shutdown (*Ezclient) int {
  return -1
}


func (Ezchatproto) Broadcast (_str string, _cln *Ezclient) int {

  var frame frame_header
  var body []byte = []byte (_str)

  // we only support ASCII string at this version
  var tmp = len (body)

  // we send a header and string
  _cln._trans ++
  frame.transflag = uint16 (_cln._trans)
  frame.typeflag = byte (Broadcasting)
  frame.dstid = 0
  frame.srcid = byte (_cln._num)
  frame.length = uint8 (tmp) // len (_str)

  _cln._wbuff, _ = frame._tobytes (body)

  writelen, _ := _cln._sock.Write (_cln._wbuff [0:(tmp+6)])
  if writelen != 0x06 + tmp {
    return 0
  }

  return 0x06 + tmp
}


// ----------- for server -------------------
func (*Ezchatproto) Listener (_bind_addr string, _server* Ezserver) *net.TCPListener {
	bindaddr, ok := net.ResolveTCPAddr ("tcp", ":5959")
	if ok != nil {
		println ("Error resolv TCPAddr from address.", ok.Error ())
		return nil
	}

	tcplistener, err := net.ListenTCP ("tcp", bindaddr)
	if err != nil {
		println ("Error in listening local address at port 5959.")
		return nil
	}

	println ("Start Listening...")
	return tcplistener
}

func (*Ezchatproto) Start_server_loop (_server *Ezserver) {
}

func (*Ezchatproto) End_server_loop (_server *Ezserver) {
}

func (*Ezchatproto) Shutdown_server (_server *Ezserver) {
}
