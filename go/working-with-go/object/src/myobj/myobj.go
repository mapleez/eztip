/*
 * author : ez
 * date : 2015/11/19
 * describe : objected oriented
*/

// package myobj
package main
import "math"

type Point struct {
  _x, _y int
}

type Rect struct {
  _a, _b Point
}

type IFunc interface {
  Start () int
}

func (this *Rect) Start () int {
  return this._a._x + this._a._y +
    this._b._x + this._b._y
}

func (this Rect) Area () int {
  var width = this._b._x - this._a._x
  var height = this._b._y - this._a._y

  return int (math.Abs (float64 (width * height)))
}

// constructor
func NewRect (_wid, _hig int) *Rect {

  var res *Rect = new (Rect)
  res._a._x = 0
  res._a._y = _hig

  res._b._x = _wid
  res._b._y = 0

  // var x IFunc = res
  // println (x.Start ())

  return res

}

func main () {
  var m = NewRect (10, 20)
  var x IFunc = m
  println (x.Start ())
}

