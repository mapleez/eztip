#!/bin/bash


array=(1 2 3 4 5)
array1=(1 .. 3) # array with 3 elements '1' '..' '3'

for i in ${array1[*]}
do
	echo $i
done
