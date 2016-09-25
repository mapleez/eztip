package main

import "net"
// import "fmt"
import (. "os")
import "bufio"
// import "os"

// type server struct {
//   _conn Conn
//   _clients [] Conn
// }

func main () {
  var rbuff [0x400] byte
  var stdinReader = bufio.NewReader (Stdin)

  conn, err := net.Dial ("tcp", "127.0.0.1:5959")
  if err != nil {
    println ("Error in connecting.")
    return
  }
  println ("Connect successed!")

  // start loop
  for {

    // waiting for sending
    print ("send >")
    buffer, isprefix, err := stdinReader.ReadLine ()

    if isprefix || err != nil {
      println ("<error occured or your input is too long :(>")
      continue
    }

    // print (string (buffer))
    writelen, _ := conn.Write (buffer)

    if writelen == len (buffer) {
      print ("...Done !\n")
    } else {
      print ("...Error !\n")
    }

    print ("read <")
    // read somethine
    readlen, _ := conn.Read (rbuff [0:])
    if (readlen > 0) {
      println (string (rbuff [0:]))
    } else {
      println ("fuck !")
    }

  }

  /*
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
  */

}


