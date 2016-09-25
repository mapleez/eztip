package main

import (
    "fmt"
    "html/template"
    "log"
    "net/http"
    "crypto/md5"
    "io"
    "strconv"
    "time"
    // "strings"
)

func sayhelloName (_w http.ResponseWriter, _r *http.Request) {
  _r.ParseForm ()
  print ("request: path= ", _r.URL.Path)
  // println (_r.Form)
  // println ("path:", _r.URL.Path)
  // println ("scheme:", _r.URL.Scheme)
  // println ("Form")
  fmt.Fprintf (_w, "Hello go web!")
}

func login (_w http.ResponseWriter, _r *http.Request) {
  println ("method: ", _r.Method)
  if _r.Method == "GET" {
    curtime := time.Now ().Unix ()
    md5 := md5.New ()
    io.WriteString (md5, strconv.FormatInt (curtime, 10))
    token := fmt.Sprintf ("%x", md5.Sum (nil))

    t, _ := template.ParseFiles ("login.gtpl")
    t.Execute (_w, token)
  } else {
    // use this function to parse form at first time.
    // donot use _r.Form at first time.
    // we can use the name of element to get value
    token := _r.FormValue ("token")
    if token != "" {
      println ("ok, token existing.")
    } else {
      println (":-o, token don't existing.")
    }

    println ("username: ", _r.FormValue ("username"))
    println ("password: ", _r.FormValue ("password"))
  }
}

func main () {
	// use DefaultServerMux.HandleFunc (), and @1 is the 
	// var DefaultServeMux = NewServeMux ()
	// request path
  http.HandleFunc ("/", sayhelloName)
  http.HandleFunc ("/login", login)

	// this function Call Server.ListenAndServe ()
	// initialize a new default HTTP server and listening
	// this function start a socket first and call srv.Serve ()
	// with parameter tcpKeepAliveListener {socket}
	//    type tcpKeepAliveListener struct {net.TCPListener}
  err := http.ListenAndServe (":9090", nil)

	// Server.Serve (l net.Listener)
	//  l.Accpet ()
	//  srv.newConn (rw)
	//  c.setState () // type conn struct
	//  go c.serve () // type ConnState int

  if err != nil {
    log.Fatal ("ListenAndServer: ", err)
  }
}


