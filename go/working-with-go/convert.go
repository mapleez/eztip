package main

import "fmt"
import "strconv"

func main () {

  var integer int = 1
  var str string = strconv.Itoa (integer)
  // var err error

  // i, err = strconv.Atoi (s)
  ret, _ := strconv.ParseInt (str, 10, 32)
  flt, _ := strconv.ParseFloat ("3.14159", 32)

  fmt.Println (ret, " ", flt)

}
