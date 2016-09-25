package main

import "net/http"
// import "net"

func http_get () {
  resp, err := http.Get ("http://github.com")
  if err != nil {
    print (err.Error ())
  }

  var cookies []*http.Cookie = resp.Cookies ()
  for _, i := range cookies {
    println (i.String ())
  }
}

func main () {
}
