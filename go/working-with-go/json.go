package main

import "encoding/json"
// import "fmt"
// import "io/ioutil"

type Point struct {
  Id int `json:"id",string`
  Value float32 `json:"value"`
  Constance float32 `json:"const"`
}

func main () {
  // pointB := 
  var pointarr []Point// := make ([]point, 2)
  pointarr = append (pointarr, Point {Id:102, Value: 1.23})
  pointarr = append (pointarr, Point {Id:101, Value: 2.32})
  // fmt.Println (pointB, pointA)
  bytebuff, err := json.Marshal (pointarr)
  if err != nil {
    println (err.Error ())
    return
  }
  println (string (bytebuff))
}

