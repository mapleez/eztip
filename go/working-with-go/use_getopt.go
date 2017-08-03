/*
 * Author : ez
 * Date : 2017/8/3
 * Describe : Using golang 'flag' package to test function like
 *   Unix getopt.
 */
package main

import (
	"flag"
	"fmt"
)

var (
	PORT int
	HOST string
	USER string
	CMD string
)


func flag_defined () {
	flag.IntVar (&PORT, "port", 1025, "Connecting server port")
	flag.StringVar (&HOST, "host", "vubuntuez1", "Connecting Server address")
	flag.StringVar (&USER, "user", "ez", "User")
	flag.StringVar (&CMD, "command", "help", "Command to do.")
}

func init () {
	flag_defined ()
}

func main () {
	flag.Parse ()
	fmt.Printf ("PORT : %d\nHOST : %s\nUSER : %s\nCMD : %s\n",
		PORT, HOST, USER, CMD)
}
