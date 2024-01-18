#!/bin/bash
# a Bash script that accepts a list of integers and adds them together using a loop and the shift command to allow for an unlimited number of integers to be provided as arguments

argsum=0 #setting variable for final sum of arguments
until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
do
	argsum=$((argsum + $1)) #adds current argument to total sum of arguments
	shift #shifts current argument out of set
done
echo "$argsum" #outputs final calculated sum
