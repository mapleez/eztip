package main

import (
    "fmt"
    "reflect"
    )

type interface_x struct {
  _x, _y int
}

func main () {
  var ii *interface_x = new (interface_x)
  t := reflect.ValueOf (ii)
  fmt.Println (t)   // print <*main.interface_x Value>

  x := reflect.Indirect (t).Type ()
  fmt.Println (x)   // print main.interface_x

  fmt.Println (x.Name ())   // print interface_x
}
