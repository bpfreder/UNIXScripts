#!/bin/bash
# a Bash script that accepts an operator and a list of integers and performs the operation on the list. 
# The script is able to handle addition, subtraction, multiplication, division, exponentiation, modulo, and uses a loop and the shift command to allow for an unlimited number of integers to be provided as arguments


if [[ "$1" = "add" ]] || [[ "$1" = "sub" ]] || [[ "$1" = "mul" ]] || [[ "$1" = "div" ]] || [[ "$1" = "exp" ]] || [[ "$1" = "mod" ]] #tests if operator input is acceptable
then
	:
else
	echo "Operator argument is invalid, please try again" #informs user of invalid operator input
	exit #aborts script
fi
if [[ "$1" = "add" ]] #if-elif-else statement for determining calculation, beginning with addition
then
	argsum=0 #setting variable for final sum of arguments
	shift #removes operator from calculations
	until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
	do
		argsum=$((argsum + $1)) #adds current argument to total sum of arguments
		shift #shifts current argument out of set
	done
	echo "$argsum" #outputs final sum of arguments
elif [[ "$1" = "sub" ]]
then
	argsum="$2" #setting variable for final sum of arguments
	shift 2 #removes operator and first number argument from calculations
	until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
	do
		argsum=$((argsum - $1)) #subtracts current argument to total sum of arguments
		shift #shifts current argument out of set
	done
	echo "$argsum" #outputs final sum of arguments
elif [[ "$1" = "mul" ]]
then
	argsum="$2" #setting variable for final sum of arguments
	shift 2 #removes operator and first number argument from calculations
	until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
	do
		argsum=$((argsum * $1)) #multiplies current argument to total sum of arguments
		shift #shifts current argument out of set
	done
	echo "$argsum" #outputs final sum of arguments
elif [[ "$1" = "div" ]]
then
	argsum="$2" #setting variable for final sum of arguments
	shift 2 #removes operator and first number argument from calculations
	until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
	do
		argsum=$((argsum / $1)) #divides current argument to total sum of arguments
		shift #shifts current argument out of set
	done
	echo "$argsum" #outputs final sum of arguments
elif [[ "$1" = "exp" ]]
then
	argsum="$2" #setting variable for final sum of arguments
	shift 2 #removes operator and first number argument from calculations
	until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
	do
		argsum=$((argsum ** $1)) #multiples previous sum of arguments by the exponential of the current argument
		shift #shifts current argument out of set
	done
	echo "$argsum" #outputs final sum of arguments
elif [[ "$1" = "mod" ]]
then
	argsum="$2" #setting variable for final sum of arguments
	shift 2 #removes operator and first number argument from calculations
	until [ "$#" -eq 0 ] #loop that continues until shifting causes it to run out of arguments
	do
		argsum=$((argsum % $1)) #returns of the remainder from the previous sum of arguments divided by the current argument
		shift #shifts current argument out of set
	done
	echo "$argsum" #outputs final sum of arguments
else
	echo "Unexpected error occurred. Operator invalid." #returned if somehow the operator is invalid, mostly exists just to keep modulo functionality under an elif statement for easier readability
fi
