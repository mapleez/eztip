package main

import (
    "net/http"
    "os"
    "fmt"
    "html/template"
    "log"
    "crypto/md5"
    "io"
    "strconv"
    "time"
)

func upload_handle (_w http.ResponseWriter, _r *http.Request) {
  println ("request -> Method: ", _r.Method)
  if _r.Method == "GET" {
    curtime := time.Now ().Unix ()
    md5 := md5.New ()
    io.WriteString (md5, strconv.FormatInt (curtime, 10))
    token := fmt.Sprintf ("%x", md5.Sum (nil))

    t, _ := template.ParseFiles ("upload.html")
    t.Execute (_w, token)
  } else {
    _r.ParseMultipartForm (32 << 20)
    file, handler, err := _r.FormFile ("uploadfile")
    if err != nil {
      fmt.Println (err)
      return
    }

    defer file.Close ()
    fmt.Fprintf (_w, "%v", handler.Header)
    f, err := os.OpenFile ("./test/" + handler.Filename, os.O_WRONLY|os.O_CREATE, 066)
    if err != nil {
      println (err)
      return
    }
    defer f.Close ()
    io.Copy (f, file)

    //token := _r.FormValue ("token")
    //if token != "" {
    //  println ("ok, token existing.")
    //} else {
    //  println (":-o, token don't existing.")
    //}
  }
}

func main () {
  http.HandleFunc ("/upload", upload_handle)
  err := http.ListenAndServe (":9090", nil)
  if err != nil {
    log.Fatal ("ListenAndServe: ", err.Error ())
  }
}


