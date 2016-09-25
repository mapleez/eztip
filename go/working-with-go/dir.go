package main

import (. "os")

func main () {

  Mkdir ("ezdir", 0777)
  MkdirAll ("ezdir/src/package", 0777)
  err := Remove ("ezdir")
  if err != nil {
    // it must be error due to the recursive directory
    println (err.Error ())
  }

  RemoveAll ("ezdir")
}
