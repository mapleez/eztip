package main

import "regexp"

func main () {
  if m, _ := regexp.MatchString ("[0-8]-[a-c]", "asd789"); m {
    println ("successful ", m)
  } else {
    println ("not match...")
  }
}
