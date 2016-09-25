package main

import "fmt"

func _add_closure (_apnd int) int {

  // var _closure func (_a int) int

  return /*_closure =*/ func (_a int) int {
    var _closure_val = 0
    _closure_val += _a
    return _closure_val
  } (_apnd)


}

func main () {
  // var _closure_val = 0
  fmt.Println (_add_closure (100),
      _add_closure (21),
      _add_closure (23),
      _add_closure (99),
      _add_closure (27))

  // var _closure func (int) int
  // _closure = func (_a int) int {
  //   var _closure_val = 0
  // }

  // fmt.Println (_add_closure (0))
}

