#!/bin/bash

if [ -z $1 ]; then
	scalac *.scala
else
	if [ $1 == "clean" ]; then
		rm *.class	
	fi
fi
