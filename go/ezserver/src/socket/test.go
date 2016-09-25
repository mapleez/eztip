package main

import ("strings")

func main () {
  var str string = "stfndafan\n"

  print (str)
  // res := strings.Replace (str, "\n")
  res := strings.TrimSpace (str)
  print (res)
}
