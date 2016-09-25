/*
 * A simple Web server
 * Author : ez
 * Date : 2015/11/25
*/
package main

import (
    "fmt"
    "net/http"
    "strings"
    "log"
)

func say_hello_name (w http.ResponseWriter, r *http.Request) {
  r.ParseForm ()
  fmt.Println (r.Form) // map []
  fmt.Println ("path", r.URL.Path) // almost "/"
  fmt.Println ("scheme", r.URL.Scheme) // scheme
  fmt.Println (r.Form ["url_long"]) // almost none

  for k, v := range r.Form {
    fmt.Println ("key:", k)
    fmt.Println ("val:", strings.Join (v, ""))
  }
  fmt.Fprintf (w, "Hello astaxie!")
}


func main () {
  http.HandleFunc ("/", say_hello_name)
  err := http.ListenAndServe (":9090", nil)

  if err != nil {
    log.Fatal ("ListenAndServer Error:", err)
  }

}
