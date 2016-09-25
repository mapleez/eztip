package main

// import "fmt"
import "text/template"
import "net/http"
// import "bytes"
// import "os"
import "log"

type head_content struct {
  Title string
  Content string
  // HeadTitle string
}

func _init_page (_w http.ResponseWriter, _r *http.Request) {

  // buff := bytes.Buffer {}
  println ("method: ", _r.Method)
  if _r.Method == "GET" {

    _struct := head_content {Title: "template demo",
               Content: "hello :)",}
               // HeadTitle: "ez Go testing."}

    index, _ := template.ParseFiles ("./pages/head.tmpl",
        "./pages/content.tmpl", "./pages/index.tmpl")
    // println ("-------------content---------------")
    index.ExecuteTemplate (_w, "head", "ez Go testing.")
    index.ExecuteTemplate (_w, "content", _struct)
    index.ExecuteTemplate (_w, "index", nil)
    // println ("-------------head---------------")
    // println ("-------------index---------------")

  } else {
    println ("err !")
  }
}

func main () {

  http.HandleFunc ("/", _init_page)
  err := http.ListenAndServe (":9090", nil)
  if err != nil {
    log.Fatal ("ListenAndServer: ", err.Error ())
  }

}
