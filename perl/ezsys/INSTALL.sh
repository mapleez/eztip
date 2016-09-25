#!/bin/bash

LIB_DIR="/usr/local/share/perl/5.20.2/ez"
SRC_DIR=`pwd`"/ez"
files=(Fileproc.pm Record.pm Statistic.pm)


install() {
	if [ ! -d $LIB_DIR ]
	then
		mkdir $LIB_DIR
	fi
	if [ -d $SRC_DIR ]; then
		for file in ${files[@]}; do
			echo "Install $SRC_DIR/$file..."
			cp "$SRC_DIR/$file" "$LIB_DIR/$file"
		done
	fi
}

uninstall() {
	for file in ${files[@]}; do
	# for file in ${files[@]}
	# do
		if [ -f $LIB_DIR/$file ]; then
			echo "Delete $LIB_DIR/$file"
			rm "$LIB_DIR/$file"
		else
			echo "Cannot find $LIB_DIR/$file, skipping..."
		fi
	done
}


_help() {
	echo "  Type command for install and uninstall library into
your computer:
	o ./install.sh install
	o ./install.sh uninstall"
	exit 0
}

comd= $1
if [ $# -lt 1 ] 
then
  _help
fi

if [ $comd="install" ]; then
	install
elif [ $comd="uninstall" ]; then
	uninstall
else
	_help
fi

# if [-x "$INSTALL_DIR/Fileproc.pm"] then
# # rm "$INSTALL_DIR/Fileproc.pm"
# 	echo "$INSTALL_DIR/Fileproc.pm"
# fi

