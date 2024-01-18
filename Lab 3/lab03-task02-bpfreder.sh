#!/bin/bash
# a Bash script that will take in two numbers as input and add them together

echo "Enter the first number:"
read number1 #reads first number
echo "Enter the second number:"
read number2 #reads second number
numsum=$(( number1 + number2 )) #calculates sum of inputted numbers
echo "The sum of $number1 and $number2 is $numsum" #outputs sum to users
