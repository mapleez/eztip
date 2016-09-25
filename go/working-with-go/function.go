package main

import ("fmt")

/*
 function with multiple return-value
*/
func _multi_retn (_a, _b int) (_add, _diff, _dev, _s , _mod int) {
  return _a + _b,
         _a - _b,
         _a * _b,
         _a / _b,
         _a % _b
}

/*
 I defined an anoymous function, and called it.
*/
func _anoymous_func () float32 {

  return func (_x, _y float32) float32 {
    return (_x + _y) / 2
  } (24.0, 1.5)

}

func _multi_params (_args ...interface {}) {
  // fmt.Println (len (_args))
  // var args = make ([] interface {}, 6)
  // println (len (_args))
  var args [] interface {} = [] interface {} (_args)
//   for i, v := range (_args) {
//     // println (i)
//     args [i] = v
//   }
  _second_multi_params (args...)
}

func _second_multi_params (_args ...interface {}) {
  // println (len (_args))
  for idx, arg := range _args {
    fmt.Println (idx, " ", arg)
  }
}

type _anoymous interface {}

var t []_anoymous

func _each_type_func (args ..._anoymous) {
  for _, i := range args {
    fmt.Println (i)
  }
}

func main () {

  // fmt.Println (_multi_retn (100, 20))
  // fmt.Println (_anoymous_func ())

  // var _array [0x10] int = [0x10] int {1, 2, 3}
  // fmt.Println (_array)
  // _multi_params (_array [0:8]...)
  _multi_params (10, 20, 30, 40, 21, 323)

  /*
  t = make ([]_anoymous, 5, 10)
  t = append (t, 10, 23, 3.14159, "fuck")
  _each_type_func (t ...)

  fmt.Println (t)
  */

}



