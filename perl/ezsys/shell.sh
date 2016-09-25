#!/bin/bash

file="testing.x"
x=`pwd`"/ez"

echo $x

# -f if file existing.
# -d if dir existing.
if [ -f $file ]; then
	rm $file
else
	echo "Cannot find $file, skipping..."
fi

