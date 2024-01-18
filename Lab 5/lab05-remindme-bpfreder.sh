#!/bin/bash

#remindme--searches remember.txt for reminders created by remember that match the argument given
# if no argument is given, the entire file is returned

remember="remember.txt"

if [ ! -f $remember ] #runs if no remember file exists
then
	echo "No remember file found. Use lab05-remember-bpfreder.sh to create"
	echo "the remember file and add reminders to it."
	exit 1
elif [ $# -eq 0 ] #runs if no argument is given, returns the entire file
then
	cat $remember
else #runs if an argument is given, returns only matching entries
	grep -i -s "$@" $remember
fi
exit 0
