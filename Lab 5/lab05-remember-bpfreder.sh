#!/bin/bash

#remember--A script to simlate a reminder pad

remember="remember.txt" #file for concantating user input

if [ $# -eq 0 ] #runs if user provides no arguments and instead prompts for input and then reads it
then
	echo -n "Enter note then end with CTRL+D: "
	read userInput
	if [[ ! -z $(echo "$userInput" | grep -s "$userInput" $remember) ]] #runs if the entered text matches existing text in the file and informs the user that
	then                                                                # it may be a duplicate entry. The user is shown the similar entries and is given the
		responseValid=0 #variable for tracking valid responses      # option to discard their input or add it to the file
		echo "The note your making looks similar to previously added note(s): "
		echo
		grep -i -s "$userInput" $remember #outputs matched phrases in remember files
		echo
		echo -n "Do you still want to add this note? (Yes/No): "
		while [[ $responseValid != 1 ]] #runs until a valid response is given
		do
			read response
			response="$(echo $response | tr '[:upper:]' '[:lower:]' | sed 's/yes/y/;s/no/n/')" #takes yes or no and converts them to a simple "y" and "n", respectively
			if [[ $(echo $response) == "y" ]] #validates a yes response
			then
				responseValid=1
			elif [[ $(echo $response) == "n" ]] #validates a no response
			then
				responseValid=1
			else #flags invalid responses and prompts the user to try again
				echo
				echo -n "Invalid Response. Please answer \"Yes\" or \"No\": "
			fi
		done
		if [[ $(echo $response) == "y" ]] #appends the file at the user's request
		then
			echo "$userInput" >> $remember
		else #discards the input at the user's request
			exit 1	
		fi
	else #takes the entered text and appends it to the remember file
		echo "$userInput" >> $remember
	fi
elif [[ ! -z $(echo "$@" | grep -s "$@" $remember) ]]             #runs if the argued text matches existing text in the file and informs the user that
then                                  		                  # it may be a duplicate entry. The user is shown the similar entries and is given the
	responseValid=0 #variable for tracking valid responses    # option to discard their input or add it to the file
	echo "The note your making looks similar to previously added note(s): "
	echo
	grep -i -s "$@" $remember #outputs matched phrases in remember files
	echo
	echo -n "Do you still want to add this note? (Yes/No): "
	while [[ $responseValid != 1 ]] #runs until a valid response is given
	do
		read response
		response="$(echo $response | tr '[:upper:]' '[:lower:]' | sed 's/yes/y/;s/no/n/')" #takes yes or no and converts them to a simple "y" and "n", respectively
		if [[ $(echo $response) == "y" ]] #validates a yes response
		then
			responseValid=1
		elif [[ $(echo $response) == "n" ]] #validates a no response
		then
			responseValid=1
		else #flags invalid responses and prompts the user to try again
			echo
			echo -n "Invalid Response. Please answer \"Yes\" or \"No\": "
		fi
	done
	if [[ $(echo $response) == "y" ]] #appends the file at the user's request
	then
		echo "$@" >> $remember
	else #discards the input at the user's request
		exit 1	
	fi
else #takes the argued text and appends it to the remember file
	echo "$@" >> $remember
fi

exit 0
