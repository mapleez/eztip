/*
 * author : ez
 * describe : file handle study
 * date : 2015/11/27
*/

package main

import (
  "os"
)

func _test_file_base () {
  // var fd *os.File = os.NewFile (, "./test/testfile.dat")
  fd, ok := os.OpenFile ("./test/testfile.dat", os.O_CREATE | os.O_RDWR, os.ModePerm)
  defer fd.Close ()

  if ok != nil {
    println (ok.Error ())
  }
  var wroten, err = fd.WriteString ("this is testing string for file.")
  if err != nil {
    println (err.Error ())
    return
  }
  println ("ascii bytes wroten into file: ", wroten)
}

// A simple file reading loop
func _test_file_read_loop () {
  var (
      buff []byte = make ([]byte, 0xff)
      readlen, totallen int = 0, 0
      offset int64 = 0
  )

  fd, ok := os.OpenFile ("./file.go", os.O_RDONLY, os.ModePerm)
  defer fd.Close ()
  if ok != nil {
    println (ok.Error ())
    return
  }

  readlen, err := fd.Read (buff)
  if err != nil {
    println (err.Error ())
    return
  }

  for ; readlen > 0;  {

    totallen += readlen
    print (string (buff [0 : readlen]))
    offset += int64 (readlen)

    readlen, err = fd.Read (buff)
    if err != nil {
      if (err.Error () == "EOF") {
        return
      } else {
        println (err.Error ())
        return
      }
    }

  }

}

func _test_file_read () {
  var (
      buff []byte = make ([]byte, 10)
      readlen int
      wrotenlen int
  )

  fd, ok := os.OpenFile ("./test/testfile.dat", os.O_RDWR, os.ModePerm)
  defer fd.Close ()

  if ok != nil {
    println (ok.Error ())
    return
  }

  readlen, err := fd.Read (buff)
  if err != nil {
    println (err.Error ())
    return
  }
  println ("read len : ", readlen, " content : ", string (buff))

  wrotenlen, err = fd.WriteAt ([]byte ("_hzongjnfajflnzhfneafkljaehzfd"), int64 (readlen))
  if err != nil {
    println (err.Error ())
    return
  }

  println ("wroten len : ", wrotenlen)


}

func main() {

  _test_file_read_loop ()
  // _test_file_base ()
  // _test_file_read ()

  // filename := "./function.go"
  // // outfile := "./test.foo"
  // buffer, ok := ioutil.ReadFile(filename)
  // if ok != nil {
  // 	println("open file error.")
  // } else {
  // 	println("successful in read file.")
  // 	println(string(buffer))
  // 
  // 	/*
  // 	   err := ioutil.WriteFile (outfile, buffer, 0644)
  // 	   if err != nil {
  // 	     println ("Error writing file:", err)
  // 	   }
  // 	*/
  // 
  // }
  // 
  // // pfile, _ := os.OpenFile (filename, 0, 0666)
  // // println (pfile)
}

