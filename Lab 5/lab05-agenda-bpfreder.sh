#!/bin/sh

#agenda--Scans through the user's agenda.txt file to see if there
# are matches for the current or next day

agenda="agenda.txt" #source file for finding events corresponding to the given date

if [ ! -e $agenda ] #runs if no agenda file exists. Instructs user how to use addagenda
then
	echo "No agenda.txt file found."
	echo "Use lab05-addagenda-bpfreder to generate a agenda.txt file"
	echo "and add events to it."
	exit 1
fi

if [ $# -eq 0 ] #if no arguments given, runs the script using current date
then
	day=$(date +%d)
	month=$(date +%b)
	year=$(date +%Y)
	agendaDate="$day$month$year"
else
	if [ ! -z $(echo $1 | sed 's/[0-9]*//') ] #checks to ensure first argument is the day in only digits
	then
		echo "Error. Beginning of argument must be the day of the month. May only contain digits."
		exit 1
	else
		month=$(echo "$2" | tr '[:upper:]' '[:lower:]' | sed 's/^[a-z]/\U&/' | cut -b 1,2,3) #converts month to readable format for script
		if [ $(echo $month) = "Jan" ] #runs through each month to determine the number of days in the given month
		then
			monthNum=31
		elif [ $(echo $month) = "Feb" ]
		then
			monthNum=29
		elif [ $(echo $month) = "Mar" ]
		then
			monthNum=31
		elif [ $(echo $month) = "Apr" ]
		then
			monthNum=30
		elif [ $(echo $month) = "May" ]
		then
			monthNum=31
		elif [ $(echo $month) = "Jun" ]
		then
			monthNum=30
		elif [ $(echo $month) = "Jul" ]
		then
			monthNum=31
		elif [ $(echo $month) = "Aug" ]
		then
			monthNum=31
		elif [ $(echo $month) = "Sep" ]
		then
			monthNum=30
		elif [ $(echo $month) = "Oct" ]
		then
			monthNum=31
		elif [ $(echo $month) = "Nov" ]
		then
			monthNum=30
		elif [ $(echo $month) = "Dec" ]
		then
			monthNum=31
		else 				 #runs if month is invalid and exits script
			echo "Error, month entered not valid."
				exit 1
		fi
	fi
	if [ $# -eq 2 ] #runs checks for if only day and month are argued
	then
		if [ $monthNum = 31 ] #uses determined number of days in argued month to ensure argued day is present in argued month
		then
			if [ $1 -gt 31 ]
			then
				echo "Error. Day of the month for the month you selected cannot be greater than 31"
				exit 1
			else
				day=$1
			fi
		elif [ $monthNum = 30 ]
		then
			if [ $1 -gt 30 ]
			then
				echo "Error. Day of the month cannot be greater than 30"
				exit 1
			else
				day=$1
			fi
		else
			if [ $1 -gt 29 ]
			then
				echo "Error. Day of the month for February cannot be greater than 29"
				exit 1
			else
				day=$1
			fi
		fi
	elif [ $# -eq 3 ] #runs checks for if day, month, and year is argued
	then
		if [ $monthNum = 31 ] #uses determined number of days in argued month to ensure argued day is present in argued month
		then
			if [ $1 -gt 31 ]
			then
				echo "Error. Day of the month for the month of $2 cannot be greater than 31"
				exit 1
			else
				day=$1
			fi
		elif [ $monthNum = 30 ]
		then
			if [ $1 -gt 30 ]
			then
				echo "Error. Day of the month for the month of $2 cannot be greater than 30"
				exit 1
			else
				day=$1
			fi
		else 		                  #runs checks for if argued month is February
			leapYear=$(( $3 % 4 ))    #divides year by 4 and returns remainder
			if [ $leapYear = 0 ]      #if remainder from leapYear is 0, then argued year is a leap year
			then		          # and number of days of the month is 29. Otherwise number of days		
				if [ $1 -gt 29 ]  # in February is 28
				then
					echo "Error. Day of the month for February in $3 cannot be greater than 29"
					exit 1
				else
					day=$1
				fi
			else
				if [ $1 -gt 28 ]
				then
					echo "Error. Day of the month for February in $3 cannot be greater than 28"
					exit 1
				else
					day=$1
				fi	
			fi
		fi
		if [ ! -z $(echo $3 | sed 's/[0-9][0-9][0-9][0-9]//') ] #checks to ensure argued year is exactly 4 digits
		then
			echo "Error. Years in argued dates must be exactly 4 digits."
			exit 1
		else
			if [ $3 -lt 1970 ] #checks to ensure argued year is no earlier than 1970
			then
				echo "Error. Dates from before 1970 are not valid."
				exit 1
			else
				year=$3
			fi
		fi
	else #runs if too many arguments is given and informs user how to submit arguments
		echo "Error. When submitting a date as an argument to the script, please either submit it as"
		echo "either day & month (i.e. \"25 October\") for all events occurring on that date every year,"
		echo "or day, month, & year (i.e. \"25 October 2022\") for all eventc occuring on that specific date."
		exit 1
	fi
fi

if [ $# -eq 2 ] #creates agenda variable for only two arguments
then
	agendaDate="$day$month"
fi

if [ $# -eq 3 ] #creates agenda variable for three arguments
then
	agendaDate="$day$month$year"
fi

if [ $# -eq 0 ] #output for no arguments
then
	echo "On the agenda for today:"
	echo
	grep -i "$agendaDate" $agenda | sed "s/$agendaDate//g" | sed "s/|//g" 
	echo
	exit 0
else
	if [ $# -eq 2 ] #output for two arguments
	then
		echo "All events occuring on $2 $1:"
		echo
		grep -i "$agendaDate" $agenda | sed "s/$agendaDate//g" | sed "s/|/ /g" 
		echo
		exit 0
	else #output for three arguments
		echo "On the agenda for $2 $1, $3:"
		echo
		grep -i "$agendaDate" $agenda | sed "s/$agendaDate//g" | sed "s/|//g" 
		echo
		exit 0
	fi
fi
