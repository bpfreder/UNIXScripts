#!/bin/bash
# a Bash script that takes in the following the following information and outputs it in the given format:
# 	User’s name
# 	Current date
# 	City name
# 	Temperature
# 	Name of that day’s birthday
# 	Current payable bill balance


echo "Enter your name:"
read name # recieves user input of name
echo "Enter the date:"
read date1 # recieves user input of date
datemonth=`date --date="$date1" '+%B'` #converts date1 to format date and grabs the month as a name
datedaynumber=`date --date="$date1" '+%d'` #converts date1 to format date and grabs the day as a number
dateyear=`date --date="$date1" '+%Y'` #converts date1 to format date and grabs the year as a four-digit number
dateday=`date --date="$date1" '+%A'` #converts date1 to format date and grabs the day of the week as a name
echo "Enter your city:"
read city # recieves user input of city
echo "Enter the current temperature:"
read temp # recieves user input of temperature
echo "Enter today's birthday:"
read bday # recieves user input of birthday
echo "Enter your payable bills:"
read bills # recieves user input of total payable bill amount
echo "Good day, $name. Today is $datemonth $datedaynumber, $dateyear in the city of $city. It is a beautiful $dateday, the temperature is $temp degrees. Today is $bday's birthday. Insurance is payable, as are the water, gas, and light bills for a total of \$$bills" # final output using user inputted data
