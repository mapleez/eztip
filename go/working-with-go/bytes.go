package main

// import "strconv"
import "fmt"
import "bytes"
// import "log"
// import "unsafe"
// import "encoding/gob"
import "encoding/binary"


type frame struct {
  _a uint8
  _b uint8
  _c uint8
  _d uint8
}

func _split_test () {
  var strbuff = "strfanvnzstrnjklafstrkvnlsd"
  var sep = "str"
  a := bytes.Split ([] byte(strbuff), [] byte ("s"))

  println (strbuff, " ", sep)
  for i, v := range (a) {
    println (i, string (v))
  }
}

func main () {
  _split_test ()
  // var f *frame = new (frame)
  // f._a = 0x01
  // f._b = 0x02
  // f._c = 0x03
  // f._d = 0x04

  // var ptr *byte = (*byte) (unsafe.Pointer (f))
  // for _, v := *ptr {
  //   println (strconv.Itoa (int (v)))
  // }

  // example_basic ()

  // for i := 0; i < 4; i ++ {
  //   println (strconv.Itoa (int (*(ptr + i))))
  // }

}

type P struct {
  X, Y, Z int
  Name string
}

type Q struct {
  X, Y uint32
  // Name string
	Z float32
}

func example_basic () {
  var network bytes.Buffer        // Stand-in for a network connection
	var q Q = Q { 0xf0f1f2f3, 0xf4f5f6f7, 0x0000ff0f }
	err := binary.Write (&network, binary.LittleEndian, q)
	if err != nil {
		println ("binary write failed :", err)
		return
	}

	for _, b  := range network.Bytes () {
		// print (b, " ")
		fmt.Printf ("0x%02x ", b)
	}
  // enc := gob.NewEncoder(&network) // Will write to network.
  // dec := gob.NewDecoder(&network) // Will read from network.

  //   // Encode (send) some values.
  // err := enc.Encode(P{3, 4, 5, "Pythagoras"})
  // if err != nil {
  //   log.Fatal("encode error:", err)
  // }
  // err = enc.Encode(P{1782, 1841, 1922, "Treehouse"})
  // if err != nil {
  //   log.Fatal("encode error:", err)
  // }

  // // Decode (receive) and print the values.
  // var q Q
  // err = dec.Decode(&q)
  // if err != nil {
  //   log.Fatal("decode error 1:", err)
  // }
  // fmt.Printf("%q: {%d, %d}\n", q.Name, *q.X, *q.Y)
  // err = dec.Decode(&q)
  // if err != nil {
  //   log.Fatal("decode error 2:", err)
  // }

  // fmt.Printf("%q: {%d, %d}\n", q.Name, *q.X, *q.Y)

}

