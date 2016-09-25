package main

import "fmt"
import "time"

// waiting all goroutines
func _print_range (x, y int, flag chan int) {
  for i := x; i < y; i ++ {
    fmt.Println ("the ", i, " range.")
  }
  flag <- x / 10
}

func _wait_all () {
  chans := make ([]chan int, 10)
  for i := 0; i < 10; i ++ {
    var start = i * 10
    chans [i] = make (chan int)
    go _print_range (start, start + 10, chans [i])
  }

  // waiting for all goroutines
  for _, ch := range (chans) {
    fmt.Println ("chans set: ", <-ch)
  }

}

// goroutine timeout
func _check_timeout () {
  _chan := make (chan int, 1)
  timeout := make (chan bool, 1)
  go func () {
    time.Sleep (time.Second * 3)
    println ("sleeped...")

    _chan <- 20
    println ("set chan...")

    timeout <- true
    println ("set timeout...")
  } ()

  for {
    select {
      case c := <-_chan:
        fmt.Println ("successed..", c)
      case <- timeout:
        println ("timeout")
        close (_chan)
        return
    }
  }
}

func _produce_customer () {
  _buff := make (chan int, 1)
  _wait := make (chan bool, 1)
  // produce
  go func (_x chan int) {
    var i = 1
    for {
      println ("produce:", i)
      _x <- i
      // time.Sleep (time.Second)
      i ++

      if i > 100 {
        break;
      }

    }
    _wait <- true
  } (_buff)

  // customer
  go func (_x chan int) {
    for {
      var value = <-_x
      println ("customer:", value)
      // _x <- value - 1
    }
    _wait <- true
  } (_buff)

  <-_wait
}


func _simple () {
  _ch := make (chan bool)
  go func () {
    for i := 0; i < 100; i ++ {
      print (i, " ")
    }
    close (_ch)
  } ()

  println ("waiting channel.")
  <-_ch
}

func main () {
  // _check_timeout ()
  /*
  wait := make (chan int, 1)
  _produce_customer (wait)
  println ("start line.")
  <- wait
  */
  // _simple ()

  _produce_customer ()

}
