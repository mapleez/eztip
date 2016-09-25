package main

import "fmt"
// import "os"
import "net"
import "strings"

func _handle_client (_conn net.TCPConn) {
  for {
    var rbuff = make ([]byte, 1024)
    var wbuff []byte// = make ([] byte, 1024)

    readlen, _ := _conn.Read (rbuff [0:])
    if readlen > 0 {

      var readstr string = string (rbuff [0:])
      var readstr_trim = strings.TrimSpace (readstr)
      if readstr_trim == "quit" || readstr_trim == "q" {

        //err := _conn.CloseRead ()
        // var connTcp net.TCPConn := _conn
        err := _conn.CloseRead ()
        if err != nil {
          println ("shutdown reading side error :(")
        }
        break
      }

      readstr = "server recived string: " + readstr
      print (readstr)

      wbuff = []byte (readstr)
      writelen, _ := _conn.Write (wbuff[0:])
      fmt.Printf ("... Replyed %d bytes !\n", writelen)

    }

  }
}

func main () {
  bindaddr, ok := net.ResolveTCPAddr ("tcp", ":5959")
  if ok != nil {
    println ("Error resolv TCPAddr from addr:port string.")
  }
  tcpln, err := net.ListenTCP ("tcp", bindaddr)
  if err != nil {
    // error ...
  }

  for {
    tcpconn, err := tcpln.AcceptTCP ()
    if err != nil {
      // error ...
      println ("Error occured!")
    }

    go _handle_client (*tcpconn)
  }
}
