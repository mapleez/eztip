package main

import "pkgs"

func init () {
	println ("this is main package.")
}

func main () {
	println ("this is main.main.")
	pkgs.Pkg2 ()
	pkgs.Pkg3 ()
	pkgs.Pkg1 ()
}
