package ezlogger

/*
 * Author : ez
 * Date : 2015/12/23
 * Describe : A logger interface. Implement this to 
 *       log in files, on console, in db, etc.
*/

import (
		"fmt"
		"sync"
)

const (
		Levelemergency = iota
		Levelerror
		Levelwarn
		Leveldebug
		Levelinfo
		Levelnote
		Levelalert
		Levelcritical
		Leveltrace = Leveldebug
		Leveldefault = Leveldebug
)


type Logger interface {
	Init (_cfg string) error
	Writeln (_str string, _lv int) error
	Despose () error
	Flush () error
}

type logmaker func () Logger

type message struct {
	msg string
	level int
}

type LogManager struct {
	lock sync.Mutex
	// level int
	async bool
	msg chan *message
	depths map [string] Logger
}

var logadapters map [string] logmaker

func init () {
	logadapters = make (map [string] logmaker)
}

func RegistAdapter (_nm string, _logger logmaker) {
	if _logger == nil {
		panic ("Error, You must support logmaker when regist an Adapter.")
	}
	if _, exists := logadapters [_nm]; exists {
		panic ("Error, You've registed the Adapter named" + _nm)
	}
	logadapters [_nm] = _logger;
}


func RemoveAdapter (_nm string) {
	if _, exists := logadapters [_nm]; exists {
		delete (logadapters, _nm)
	}
}

func NewLogManager (_chan_len int, _async bool) *LogManager {
	res := new (LogManager)
	// res.level = Leveldefault
	res.msg = make (chan *message, _chan_len)
	res.async = _async
	res.depths = make (map [string] Logger)
	return res
}

func (this *LogManager) AsyncGo () {
	if this.async {
		go this.startLogger ()
	} else {
		panic ("The LogManager cannot run asynchrously. Please set it.")
	}
}

func (this *LogManager) InitAdapter (_adapter, _cfg string) error {
	this.lock.Lock ()
	defer this.lock.Unlock ()
	if adapter, ok := logadapters [_adapter]; ok {
		log := adapter ()
		err := log.Init (_cfg)
		if err != nil {
			fmt.Println ("LogManager.InitAdapter () error:" + err.Error ())
			return err
		}
		this.depths [_adapter] = log
	} else {
		panic ("No such Logger named " + _adapter)
	}
	return nil
}

func (this *LogManager) startLogger () {
	for {
		select {
			case msg := <-this.msg:
				for _, log := range this.depths {
					err := log.Writeln (msg.msg, msg.level)
					if err != nil {
						fmt.Println ("Error, cannot write log:" + err.Error ())
					}
				}
		}
	}

}

// shutdown the logger manager when running asynchrously
func (this *LogManager) shutdownLogger () {
	for {
		if len (this.msg) > 0 {
			msg := <-this.msg
			for _, log := range this.depths {
				err := log.Writeln (msg.msg, msg.level)
				if err != nil {
					fmt.Println ("Error, cannot write log:" + err.Error ())
				}
			}
		}
		break;
	}

	for _, log := range this.depths {
		log.Flush ()
		log.Despose ()
	}
}

func (this *LogManager) writeln (_str string, _lv int) error {
	var msg = new (message)
	msg.msg = _str
	msg.level = _lv
	if this.async {
		this.msg <- msg
	} else {
		for _, log := range this.depths {
			err := log.Writeln (msg.msg, msg.level)
			if err != nil {
				fmt.Println  ("Error, cannot write log:" + err.Error ())
				return err
			}
		}
	}
	return nil
}

func (this *LogManager) Flush () {
	for _, log := range this.depths {
		log.Flush ()
	}
}

// func (this *LogManager) SetLevel (_lv int) int {
// 	this.level = _lv
// 	return
// }

func (this *LogManager) Alert (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[A] " + _fmt, _args)
	this.writeln (msg, Levelalert)
}

func (this *LogManager) Info (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[I] " + _fmt, _args)
	this.writeln (msg, Levelinfo)
}

func (this *LogManager) Debug (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[D] " + _fmt, _args)
	this.writeln (msg, Leveldebug)
}


func (this *LogManager) Error (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[E] " + _fmt, _args)
	this.writeln (msg, Levelerror)
}

func (this *LogManager) Warn (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[W] " + _fmt, _args)
	this.writeln (msg, Levelwarn)
}

func (this *LogManager) Notice (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[N] " + _fmt, _args)
	this.writeln (msg, Levelnote)
}

func (this *LogManager) Critical (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[C] " + _fmt, _args)
	this.writeln (msg, Levelcritical)
}

func (this *LogManager) Emergency (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[M] " + _fmt, _args)
	this.writeln (msg, Levelemergency)
}

func (this *LogManager) Trace (_fmt string, _args ...interface {}) {
	msg := fmt.Sprintf ("[D] " + _fmt, _args)
	this.writeln (msg, Leveltrace)
}

