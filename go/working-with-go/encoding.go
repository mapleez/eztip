package main

import (
    "fmt"
    "encoding/xml"
    "io/ioutil"
    "os"
)

type Recurlyservers struct {
  XMLName xml.Name `xml:"servers"`
  Version string   `xml:"version,attr"`
  Svs     []server `xml:"server"`
  Description string `xml:",innerxml"`
}

type server struct {
  XMLName  xml.Name   `xml:"server"`
  ServerName string   `xml:"serverName"`
  ServerIP   string   `xml:"serverIP"`
}


func main () {
  file, err := os.Open ("./test/servers.xml")
  defer file.Close ()

  if err != nil {
    println ("error open File : ", err.Error ())
    return
  }

  data, err := ioutil.ReadAll (file)
  if err != nil {
    println ("error Read file: ", err.Error ())
    return
  }

  v := Recurlyservers {}
  err = xml.Unmarshal (data, &v)

  if err != nil {
    println ("error Unmarshal xml: ", err.Error ())
    return
  }

  fmt.Println (v)
}

