package main

// import "fmt"
import "bufio"
import (. "os")

func main () {

  // var buffer [] byte = make ([] byte, 0x400)
  for {
    // fmt.Scanf ("%s", str)
    var bufReader = bufio.NewReader (Stdin)
    buffer, isprefix, err := bufReader.ReadLine ()
    if !isprefix && err == nil {
      println (string (buffer))
      println ("------------")
    }

  }

}

