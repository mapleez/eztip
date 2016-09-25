package main

import (
    "fmt"
    "html/template"
    "os"
    "strings"
    )


type Friend struct {
  Fname string
}

type Person struct {
  UserName string
  Emails []string
  Friends []*Friend
}

func EmailDealWith (args ...interface {}) string {
  var s string
  ok := false

  if len (args) == 1 {
    s, ok = args [0].(string)
  }

  if !ok {
    s= fmt.Sprint (args ...)
  }

  substrs := strings.Split (s, "@")
  if len (substrs) != 2 {
    return s
  }

  return substrs [0] + " at " + substrs [1]
}

func _test_html_template () {
  t, err := template.New ("foo").Parse (`{{define "T"}} Hello, {{.}}{{end}}`)
  err = t.ExecuteTemplate (os.Stdout, "T", "this is TTTT")
  if err != nil {
    println (err.Error ())
  }
}

func main () {
  _test_html_template ()
  println ("---------------------")
  f1 := Friend {Fname: "minux.ma"}
  f2 := Friend {Fname: "xushiwei"}
  t := template.New ("fieldname example")
  t = t.Funcs (template.FuncMap {"emailDeal": EmailDealWith})
  t, _ = t.Parse (`
hello {{.UserName}}!
{{range .Emails}}
  an emails {{.|emailDeal}}
{{end}}
{{with .Friends}}
  {{range .}}
    my friend name is {{.Fname}}
  {{end}}
{{end}}
      `)
  p := Person {UserName: "Astaxie",
      Emails: []string {"astaxie@beego.me", "astaxie@gmail.com"},
      Friends: []*Friend {&f1, &f2}}
  t.Execute (os.Stdout, p)
}

