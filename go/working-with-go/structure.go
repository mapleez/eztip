package main

import (
    "fmt"
    "encoding/json"
)

type person struct {
  _number int "number"
  _age int "age"
  _exp int "exp"
  _sex bool "sex"
}

func main () {

  var my_person person = person {
    2323,
    29,
    65535,
    true}

  bytes, err := json.Marshal (my_person)

  if err == nil {

    fmt.Println (string (bytes))
    for _, each := range bytes {
      fmt.Printf ("0x%08x ", int (each))
    }

    fmt.Println (my_person._age)
    fmt.Println (my_person._number)
    fmt.Println (my_person._sex)
    fmt.Println (my_person._exp)

  }

  /*
  else {
    fmt.Println (err)
  }
  */

}

