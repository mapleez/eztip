package main

import "strings"
import "strconv"

func main () {
  var _strings [] string = [] string {":fdasf", "fdnvzkjnarf", "onckaf"}
  // testing Join ()
  var _str = strings.Join (_strings, "++")
  println (_str)

  { // testing string operator
    var _str = "stdio"
    println (_str + string (7832))
    println (_str + strconv.Itoa (7832))
  }

  { // testing strings.Contains ()
    if (strings.Contains (_str, "a")) {
      println ("strings contains str", "a")
    } else {
      println ("Cannot find Contains.")
    }
  }

  { // testing strings.Index ()
    var index  int = 0
    println (`start find the index of first "a" string`)
    index = strings.Index (_str, "a")
    if index == -1 {
      println (`sorry , the ascii "a" cannot be find.`)
    } else {
      println ("index : ", index)
    }
  }

  { // testing strings.Repeat ()
    println ("start testing string.Repeat () function.")
    var res string = strings.Repeat ("abcde\n", 10)
    print (res)
  }

  { // start testing strconv.
    println ("start testing strconv.")
    var buffer []byte = make ([]byte, 0)
    buffer = strconv.AppendInt (buffer, 432, 10) // with decimal
    println (string (buffer), " ", len (buffer), " ", cap (buffer))

    buffer = strconv.AppendBool (buffer, true)
    println (string (buffer), " ", len (buffer), " ", cap (buffer))

    buffer = strconv.AppendFloat (buffer, 0.37, 'E', -1, 32)
    println (string (buffer), " ", len (buffer), " ", cap (buffer))

  }

  {
    println ("-----------------------------------")
    elements := strings.Split ("/admn/fnlaf", "/")
    for i, v := range elements {
      println (i, " ", v)
    }
  }

}
