package ezlogger

/*
 * Author : ez
 * Date : 2015/12/23
 * Describe : An implement for console logger
*/

import (
		"log"
		"os"
		"runtime"
)

var colors = map [string] string {
	"red"     : "1;31",
	"green"   : "1;32",
	"yellow"  : "1;33",
	"blue"    : "1;34",
	"magenta" : "1;35",
	"cyan"    : "1;36",
	"white"   : "1;37",
}

var colormap = []string {
		// Levelemergency
		"red",

		// Levelerror
		"red",

		// Levelwarn
		"yellow",

		// Leveldebug
		"blue",

		// Levelinfo
		"blue",

		// Levelnote
		"green",

		// Levelalert
		"cyan",

		// Levelcritical
		"magenta",

		// Leveltrace = Leveldebug
		"blue",
}


type Consolelogger struct {
	lg *log.Logger
}

func colorful_string (_color, _str string) string {
	return "\033[" + colors [_color] + "m" + _str + "\033[0m"
}

func NewConsolelogger () Logger {
	res := new (Consolelogger)
	res.lg = log.New (os.Stdout, "", log.Ldate | log.Ltime)
	return res
}

func (this *Consolelogger) Init (_cfg string) error {
	return nil
}

func (this *Consolelogger) Writeln (_str string, _lv int) error {
	if OS := runtime.GOOS; OS == "windows" {
		this.lg.Println (_str)
	} else {
		this.lg.Println (colorful_string (colormap [_lv], _str))
	}
	return nil
}

func (this *Consolelogger) Despose () error {
	return nil
}

func (this *Consolelogger) Flush () error {
	return nil
}

