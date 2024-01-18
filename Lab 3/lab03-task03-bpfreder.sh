#!/bin/bash
# a Bash script that will take in two numbers and an operator as input and then perform the given operation. 
# It is able to handle adding, subtracting, multiplying, dividing, exponentiation, and Modulo

function OperatorEntry() { # funtion for reading operator
echo "Please select one of the following:" # lists acceptable options for user entry
echo "add sub mul div exp mod"
echo "Enter the operator:"
read operator # grabs user input
if [[ "$operator" = "add" ]] || [[ "$operator" = "sub" ]] || [[ "$operator" = "mul" ]] || [[ "$operator" = "div" ]] || [[ "$operator" = "exp" ]] || [[ "$operator" = "mod" ]] # tests if operator input is acceptable
then
	validoperator=True # marks input as valid
else
	validoperator=False # marks input as invalid
fi
}
OperatorEntry # runs function for reading operator
while [ "$validoperator" = False ] # repeatedly asks for input until given valid input
do
	echo "Invalid operator. Please try again." # informs user of invalid input
	OperatorEntry # runs function for reading operator
done
echo "Enter first number"
read number1 # recieves first number input
echo "Enter second number:"
read number2 # recieves second number input
if [[ "$operator" = "add" ]] # if-elif-else statement for determining calculation, beginning with addition
then
	result=$(( number1 + number2 )) # adds the two numbers
	echo "The $operator of $number1 and $number2 is $result"
elif [[ "$operator" = "sub" ]]
then
	result=$(( number1 - number2 )) # subtracts the two numbers
	echo "The $operator of $number1 and $number2 is $result"
elif [[ "$operator" = "mul" ]]
then
	result=$(( number1 * number2 )) # multiplies the two numbers
	echo "The $operator of $number1 and $number2 is $result"
elif [[ "$operator" = "div" ]]
then
	result=$(( number1 / number2 )) # divides the two numbers
	echo "The $operator of $number1 and $number2 is $result"
elif [[ "$operator" = "exp" ]]
then
	result=$(( number1 ** number2 )) # multiples the first number by the exponent value of the second number
	echo "The $operator of $number1 and $number2 is $result"
elif [[ "$operator" = "mod" ]]
then
	result=$(( number1 % number2 )) # returns the remainder of the division
	echo "The $operator of $number1 and $number2 is $result"
else
	echo "Unexpected error occurred. Operator invalid." # returned if somehow the operator is invalid, mostly exists just to keep modulo functionality under an elif statement for easier readability
fi
