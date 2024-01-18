#!/bin/bash

# addagenda--Prompts the user to add a new event for the agenda script

agenda="agenda.txt" #file for outputting agenda 

echo "Agenda: The Unix Reminder Service"
echo -n "Date of event (day & month OR day, month & year): "
read word1 word2 word3 junk #reads input, only concerns itself with first three fields

word2="$(echo $word2 | tr '[[:upper:]]' '[[:lower:]]' | cut -b 1,2,3)" #converts month to format for checking validity

if [ $(echo $word2) = "jan" ] #runs through each month to find a match from field 2 with a valid month
then
	monthCheck=1
elif [ $(echo $word2) = "feb" ]
then
	monthCheck=1
elif [ $(echo $word2) = "mar" ]
then
	monthCheck=1
elif [ $(echo $word2) = "apr" ]
then
	monthCheck=1
elif [ $(echo $word2) = "may" ]
then
	monthCheck=1
elif [ $(echo $word2) = "jun" ]
then
	monthCheck=1
elif [ $(echo $word2) = "jul" ]
then
	monthCheck=1
elif [ $(echo $word2) = "aug" ]
then
	monthCheck=1
elif [ $(echo $word2) = "sep" ]
then
	monthCheck=1
elif [ $(echo $word2) = "oct" ]
then
	monthCheck=1
elif [ $(echo $word2) = "nov" ]
then
	monthCheck=1
elif [ $(echo $word2) = "dec" ]
then
	monthCheck=1
else
	monthCheck=0 #if entered month is invalid, monthCheck is flagged with 0
fi

if [ $monthCheck = 0 ] #if monthCheck was flagged with 0 and month was invalid, user is informed and program terminates
then
	echo "Error. Invalid month entered."
	echo
	echo $word2
	exit 1
fi
if [ -z "$word2" ] #if less than two fields were submitted, user is informed of missing info and program terminates
then
	echo "Error. At least a day and month must be submitted."
	exit 1
fi
if [ ! -z "$(echo $word1|sed 's/[[:digit:]]//g')" ] #if first field is not exclusively digits, user is informed of error and program terminates
then
	echo "Error. Day must be entered first. Only digits are allowed."
	exit 1
fi
if [ "$word1" -lt 1 -o "$word1" -gt 31 ] #if day is not in the range of 1 and 31, user is informed of error and program terminates
then
	echo "Error. Day cannot be less than 1 or greater than 31."
	echo "Be aware that impossible dates (i.e. February 31) may be possible"
	echo "to submit with addagenda, but can't be retrieved with the agenda script."
	exit 1
fi

#if the script makes it this far without terminating, it means the day and month fields submitted by user were valid and correctly formatted

#word2, AKA the month of the given date, is transformed to capitalize the first letter
word2="$(echo -n $word2 | sed 's/jan/Jan/;s/feb/Feb/;s/mar/Mar/;s/apr/Apr/;s/may/May/;s/jun/Jun/;s/jul/Jul/;s/aug/Aug/;s/sep/Sep/;s/oct/Oct/;s/nov/Nov/;s/dec/Dec/;')"

if [ -z "$word3" ] 
then
	date="$word1$word2" #sets date variable for scenario in which only day and month were given
else
	if [ ! -z "$(echo $word3 | sed 's/[[:digit:]]//g')" ] #if any character other than digits were submitted for the year, the program terminates
	then
		echo "Error. Third field should be year."
		exit 1
	elif [ $word3 -lt 1970 ] #if the year submitted is earlier than 1970, the program terminates
	then
		echo "Error. Year cannot be earlier than 1970"
		exit 1
	fi
	date="$word1$word2$word3" #sets date variable for scenario in which day, month, and year were given
fi

echo -n "One-line description: " 
read description #reads description for event


echo "$(echo $date | sed 's/ //g')|$description" >> $agenda #date and corresponding description are added to agenda.txt

exit 0
