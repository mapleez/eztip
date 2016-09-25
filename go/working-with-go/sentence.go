package main

import "fmt"

func _test_sent (_cmd string) {
  switch _cmd {
    case "hello":
      fmt.Println ("hello")
    case "csdn":
      fmt.Println ("csdn")
    case "ftp":
      fmt.Println ("ftp")
      fallthrough
    case "tcp":
      fmt.Println ("tcp")
    case "udp":
      fmt.Println ("udp")
    default:
      fmt.Println ("I cannot understhand you :(")
  }

}

func _test_defer (_a, _b int) {
  if _a > 1 {
    println ("> 1")
  }

  defer func () {
    println ("first func ().")
  } ()

  if (_a < 6) {
    println ("< 6")
  }
  defer func () {
    println ("second func ().")
  } ()

  if (_a < 0) {
    println ("< 0")
  }
  defer func () {
    println ("third func ().")
  } ()

  if (_a < -20) {
    println ("< -20")
    if (_b == 0) {
      panic ("second argument is 0.")
    }
   //  else {
   //    println (_a / _b)
   //  }
  }
  defer func () {
    println ("forth func ().")
    if r := recover (); r != nil {
      println ("Runtime error caught", r)
    }
  } ()

}

func _test_panic_defer (_num int) {

  defer func () {
    if r := recover (); r != nil {
      fmt.Println ("Runtime error: ", r)
    }
  } ()

  if (_num == 0) {
    panic ("argument must not be 0.")
  } else {
    print (100 / _num)
  }

}


func _testbool_1 () bool {
  println ("this is _testbool_1.")
  return true
}

func _testbool_2 () bool {
  println ("this is _testbool_2.")
  return true
}

func main () {
  // _test_sent ("ftp")
  // _test_defer (-30, 0)
  // _test_panic_defer (0)
  // if _testbool_1 () && _testbool_2 () {}
}


