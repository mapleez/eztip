package main

import "fmt"
import "time"

type frm_buff struct {
  _frame [] byte
  _len int
}

func (this *frm_buff) disp () {

  for _, v := range this._frame {
    fmt.Printf ("0x%02x ", v)
  }

}

func init_frm_buff (_id int) frm_buff {
  var res frm_buff = frm_buff { make ([] byte, 4), 4 }
  // res._frame = make ([] byte, 4)
  res._frame [0] = byte (_id)
  res._frame [1] = 0
  res._frame [2] = 0
  res._frame [3] = 0
  // res._len = 4
  return res
}

func (this *frm_buff) add_frm_buff () {
  // this._frame [0] += 1
  this._frame [1] += 1
  this._frame [2] += 1
  this._frame [3] += 1
}

func (this *frm_buff) sub_frm_buff () {
  this._frame [1] -= 1
  this._frame [2] -= 1
  this._frame [3] -= 1
}

func main () {
  // var buffs [8]*frm_buff //  = make ([8]*frm_buff)
  // var index chan uint = make (chan uint, 1)
  var buffs chan frm_buff = make (chan frm_buff, 8)
  var wait chan bool = make (chan bool)

  // productor
  go func () {
    var i = 0
    for {
      i ++
      var value frm_buff = init_frm_buff (i)
      buffs <- value
      fmt.Printf ("Index = %d: productor\n", value._frame [0])
      value.disp ()
      // value.add_frm_buff ()
      // index <- ((idx + 1) & 0x8)
    }
    close (wait)
  } ()

  // customer
  go func () {
    for {
      var value frm_buff = <-buffs
      fmt.Printf ("Index = %d: customer\n", value._frame [0])
      value.disp ()
      // value.sub_frm_buff ()
      time.Sleep (time.Millisecond * 100)
      // index <- ((idx - 1) & 0x07)
    }
    close (wait)
  } ()

  <-wait
}


