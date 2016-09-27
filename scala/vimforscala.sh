#!/bin/bash

#
# description : This file is for hightlight on vim when you 
#    program in scala.
#

mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do curl -o ~/.vim/$d/scala.vim https://raw.githubusercontent.com/gchen/scala.vim/master/scala.vim; done
