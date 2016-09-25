package socket

import "net"

// type server struct {
//   _conn Conn
//   _clients [] Conn
// }

func Testclient (_addr string) {
  var rbuff [0x400] byte
  conn, err := net.Dial ("tcp", _addr)
  if err != nil {
    println ("error in connect " + _addr)
    return
  }

  println ("wow !")

  writelen, _ := conn.Write (make ([] byte, 10))

  if (writelen > 0) {
    println ("write successful !")
  } else {
    println ("fuck !")
    return
  }

  readlen, _ := conn.Read (rbuff [0:])
  if (readlen > 0) {
    println (string (rbuff [0:]))
  } else {
    println ("fuck !")
    return
  }

}


