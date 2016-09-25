package main

/*
 * Author : ez
 * Date : 2015/12/23
 * Describe : For unit testing :)
*/

import (
		"ezlogger"
)

var mng *ezlogger.LogManager;

func main () {
	ezlogger.RegistAdapter ("console", ezlogger.NewConsolelogger)
	mng = ezlogger.NewLogManager (1, false)
	mng.InitAdapter ("console", "config.conf")

	mng.Info ("strconmfdasf %s", "fuck")
	mng.Notice ("strconmfdasf %s", "fuck")
	mng.Critical ("strconmfdasf %s", "fuck")
	mng.Emergency ("strconmfdasf %s", "fuck")
	mng.Trace ("strconmfdasf %s", "fuck")
	mng.Debug ("strconmfdasf %s", "fuck")
	mng.Warn ("strconmfdasf %s", "fuck")
	mng.Error ("strconmfdasf %s", "fuck")
	mng.Alert ("strconmfdasf %s", "fuck")
}
