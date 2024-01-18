#!/bin/awk
# an awk script that will take the following data file (lab0401.csv) and process each record based on the keyword in the first field

BEGIN{
	FS = "," #sets comma as the delimiter
}
{
	final=0 #final number as the result of addition or subtraction
	split($0, NumArray, ",") #splits record into array for looping
	if (NumArray[1] == "ADD") { #occurs if addition operator is detected
		for (i=2; i<=NF; i++) { #loops through each field of the array for the amount of fields in selected record
			final += NumArray[i] #adds field to total sum
		}
		print final #prints final result for the record
	} else if (NumArray[1] == "SUB") { #occurs if subtraction operator is detected
		for (i=2; i<=NF; i++) { #loops through each field of the array for the amount of fields in selected record
			final = final - NumArray[i] #subtracts field from final number
		}
		print final #prints final result for the record
	} else {
		print "Error: Invalid operator." #prints if operator is detected other than ADD or SUB
	}
}
END{
}
