#!/bin/sh

#----------------------------------
# author : ez
# 2015/11/20

# This script is for building Server
# and Client programs
# ---------------------------------

print_help()
{
cat<<EOF
This scripts is for you to debug, build, clean
and testing the programs more conveniently :)

Usage : compile.sh <command>
<command> : 
1) build, this command is just
   using go compiler and its build
   command simply.
2) clean, clear the bin file that
   ware compiled latest, and clear
   the ./bin directory
3) debug, build command without
   clearing debug information flag.
4) test, run the command:
    go test $2
   please input $2 arguments

Author : ez
Bug reports to kukunanhai_5207@126.com
EOF
}


if [ -z $1 ]; then
  print_help
  exit
fi

export GOPATH=`pwd`
if [ $1 = "build" ]; then
	echo $GOPATH
  go build ./src/main.go
  mv ./main ./bin/
elif [ $1 = "clean" ]; then
  rm ./bin/*
elif [ $1 = "debug" ]; then
  go build -gcflags "-N -l" ./src/main.go
  mv ./main ./bin/
elif [ $1 = "test" ]; then
  if [ -z $2 ]; then
    echo "testing $2"
    `go test $2`
  else
    echo "no such module $2"
    exit
  fi
else
  print_help
fi
