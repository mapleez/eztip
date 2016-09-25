/*
 * author : ez
 * create date : 2015/11/18
 * describe : for study basic grammar and interface, struct -_o
*/

package main

import "fmt"

func _test_vars () {
  var v1 int = 10
  var v2 = 10

  var v10 int
  v10 = 20 // initialize

  v3 := 102 // declare and initialize

  // the same as perl
  v3, v2 = v2, v3 // swap (&v3, &v2)
  v10, v1 = v1, v10

  var person1, person2 = new (_person), new (_person)
  person1._add_age ()
  person2._add_age ()

}

func _test_constance () {
  const PI float64 = 3.14159264
  const zero = 0.0

  // complexing type
  const (
      size int64 = 1024
      eof = -1
      )
  const u, v float32 = 0, 3
  const name, age = "ez", 22

}


type _anoymous interface { }

type _person struct {
  _age int
  _sex bool
  _name string
}

type _animal interface {
  _speek ()
}

func (this *_person) _add_age () {
  this._age ++
}

func (this *_person) _sub_age () {
  this._age --
}


func (this *_person) _speek () {
  fmt.Printf ("my name's %s, %d years old, and I'm %s\n",
      this._name,
      this._age,
      this._sex)
}


type person interface {
  speek ()
  echo ()
  manimplement ()
  womanimplement ()
}

type personA interface {
  manimplement ()
  speek ()
  echo ()
}

type personB interface {
  womanimplement ()
  speek ()
  echo ()
}

type man struct {}
type woman struct {}

func (man) speek () {
  print ("I'm Man.")
}

func (man) echo () {
  print ("Hi, Man.")
}

func (man) manimplement () {
  print ("manimplement")
}

// --------------------

func (woman) speek () {
  print ("I'm Woman.")
}

func (woman) echo () {
  print ("Hi, Woman.")
}

func (woman) womanimplement () {
  print ("womanimplement")
}



func main () {

  // person type

  // var _man personA = new (man)
  // _man.speek ()
  // _man.echo ()
  // _man.manimplement ()

  // println ("-----------------")

  // var _one person = _man
  // _one.speek ()
  // _one.echo ()
  // _one.manimplement ()

  var mark *_person
  // class function
  mark = &_person {20, true, "mark"}

  // var mark *_person = new (_person)
  // mark := new (_person)

  mark._speek ()

  mark._add_age ()
  mark._speek ()

  mark._sub_age ()
  mark._speek ()

  mark._add_age ()
  mark._speek ()

  // interface usage
  var animal _animal
  // animal = new (_person)
  animal = mark
  animal._speek ()

  var _t _anoymous = 201
  fmt.Println (_t)

  _t = "string"
  fmt.Println (_t)

  var _string = "fuck"
  fmt.Println (_string)

}


