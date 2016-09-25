/**
author : ez
Date : 2015/11/18
Discribe : a simple helloworld
*/

package main

import "fmt"
import "math/rand"
import "time"

// testing array 
func _array () {

  var x [0xff] byte
  for i := 0; i < len (x); i ++ {
    x [i] = byte (i)
  }

  for _, v := range x {
    fmt.Printf ("%d ", v)
  }

}

// structure array
func _struct_array () {
  /*
  var arr [10] struct {x, y int32}
  for _, v := range arr {
    fmt.Println (v)
  }
  */

  var _struct struct {x, y int}
  _struct = struct {x, y int} {1, 2}
  fmt.Println (_struct)

  type _point struct {
    x, y int
  }

  // var points *[10] _point = new ([10] _point)
  var points [10] _point = [10] _point {
    {1, 2},
    {3, 2},
    {3, 2},
    {90, 2},
    {90, 2},
    {90, 2},
    {3, 31},
    {91, 31},
    {2, 31},
    {3, 2},
  }

  for _, v := range points {
    fmt.Println (v)
  }

}

// slice
func _slice () {
  var arr_i [10] int = [10] int {1, 3:2, 2:5}
  fmt.Println (arr_i)

  // create slice with an array
  var _slice [] int = arr_i [:5]
  fmt.Println (_slice)

  // create directively
  // we declare the slice with 5 element and remained 100 space
  var _slice2 = make ([] int, 5, 0x64)
  fmt.Println (_slice2)

  // length = 5, and capacity is 0x64
  fmt.Println ("element num:", len (_slice2), " capacity:", cap (_slice2))

  // append element to slice real
  _slice2 = append (_slice2, 1, 2, 3)
  _slice = append (_slice2, 9, 3, 8)
  fmt.Println ("_slice2 ", _slice2)
  fmt.Println ("_slice ", _slice)

  // full with random integer (32bits)
  var _slice3 = make ([]int, 4, 0x40)
  r := rand.New (rand.NewSource (time.Now ().UnixNano ()))

  for idx, _ := range _slice3 {
    _slice3 [idx] = r.Intn (1000)
  }

  fmt.Println ("_slice3 ", _slice3)
  // copy from _slice2 to _slice3
  fmt.Println ("I'v copyed ", copy (_slice3, _slice2), " elements.")
  fmt.Println ("_slice3 ", _slice3)


}

// testing map
func _map () {

  var ascii_table map [int] byte 
  ascii_table = make (map [int] byte)
  for i := 0x41; i <= 0x5A; i++ {
    ascii_table [i] = byte (i)
  }

  fmt.Println (ascii_table)
  fmt.Println ("\n------------------------------\n")
  type _page struct {
    _vmaddr int32
    _vmpageidx int
    _vmsize int64
  }

  // map, a hash
  var page_table map [int] _page = map [int] _page {
    1 : _page {1, 2, 0x1000},
    2 : _page {2, 3, 0x1000},
    3 : _page {3, 3, 0x1000},
    4 : _page {4, 3, 0x1000},
    5 : _page {5, 3, 0x1000},
    6 : _page {6, 3, 0x1000},
  }

  // add a tuple
  page_table [7] = _page {7, 8, 0x1000}

  // delete a tuple
  // (map, key)
  delete (page_table, 6)

  // search
  value, ok := page_table [100]
  if (ok) {
    fmt.Println (value)
  } else {
    fmt.Printf ("no key named %d\n", 100)
  }

  // variable is boolean type
  value, ok = page_table [2]
  if (ok) {
    fmt.Println (ok, value)
  } else {
    fmt.Printf ("no key named %d\n", 100)
  }

  fmt.Println ("len = ", len (page_table))

  fmt.Println (page_table)

}

func _arraycopy () {
	// var dst = [100] byte {0}
// 	var src = [10] byte {1,2,3,4,5,6,7,8,9,10}
// 
// 	dst = src [0:10]
// 
// 	println (dst)
}

func main () {
  // _array ()
  // _struct_array ()

  // @ cannot access the code defined structure _point
  // var pnt _point = _point {1, 2}
  // pnt.x = pnt.x + pnt.y

  // @ testing slice
  // _slice ()

  // @ testing map
  // _map ()

	// @ testing copy data from src to dst
	// _arraycopy ()

	var str string = "0123456789"
	println (str)

	// get the range from index 1 to 3 (3 bytes length)
	var _str = str [1:4]
	println (_str)

	var str_bytes [] byte = [] byte (str)
	str_bytes = str_bytes [1:4]
	println (string (str_bytes))

  {
    println ("-----------------------")
    var elms [] int// = make ([] int)
    elms = append (elms, 10);
    elms = append (elms, 20);
    elms = append (elms, 30);
    elms = append (elms, 40);
    elms = append (elms, 50);
    elms = append (elms, 60);
    elms = append (elms, 70);
    elms = append (elms, 80);
    elms = append (elms, 90);
    elms = append (elms, 100);

    println ("-----------------------")
    for i, v := range elms {
      println (i, " ", v)
    }

    elms = elms [1:]
    println ("-----------------------")
    for i, v := range elms {
      println (i, " ", v)
    }
    elms = elms [:len (elms) - 1]
    println (len (elms))

    println ("-----------------------")
    for i, v := range elms {
      println (i, " ", v)
    }


  }
}

