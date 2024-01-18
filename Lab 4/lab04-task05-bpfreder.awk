#!/bin/awk
# an awk script which reads the provided data file (lab0402.csv) and outputs the highest and lowest grade, as well as the average grade for the online and onsite sections

BEGIN{
	FS = "," # sets commas as field seperator
	onlineTotal=0 # sets default total of online grades at 0
	onsiteTotal=0 # sets default total of onsite grades at 0
	onlineCount=0 # sets default count of online grades at 0
	onsiteCount=0 # sets default count of onsite grades at 0
}
NR != 1{ # skips first record as it is just a header with no values
	if ($3 == "online") { # runs if section is online
		onlineCount += 1 # increase online count by 1
		onlineTotal += $2 # adds current grade to online total
	} else if ($3 == "onsite") { # run if section is onsite
		onsiteCount += 1 # increase onsite count by 1
		onsiteTotal += $2 # adds current grade to onsite total
	} else { # runs if section is neither online nor onsite
		print "Error at line ", NR, ". Invalid section detected." # alerts user of invalid section and provides number of corresponding record
	}
}
NR == 2{ # selects the second record
	HighestGrade = $2 # sets the second field as HighestGrade
	LowestGrade = $2 # sets the second field as LowestGrade
}
NR > 2{ # begins loop at third record
	if ($2 > HighestGrade) { # runs if current record is higher than current highest grade
		HighestGrade = $2 # sets current record as new highest grade
		LowestGrade = LowestGrade # keeps lowest grade as is
	} else if ($2 < LowestGrade) { # runs if current record is lower than current lowest grade
		HighestGrade = HighestGrade # keeps highest grade as is
		LowestGrade = $2 # sets current grade as lowest grade
	} else { # runs if current record is neither higher or lower than the highest and lowest grades respectively
		HighestGrade = HighestGrade # keeps highest grade as is
		LowestGrade = LowestGrade # keeps lowest grade as is
	}
}
END {
	onlineAvg = onlineTotal/onlineCount # averages total of online grades by the amount of online students
	onsiteAvg = onsiteTotal/onsiteCount # averages total of onsite grades by the amount of onsite students
	print "Section Average"
	printf "online %.2f", onlineAvg # prints online average to the second decimal
	printf "\nonsite %.2f", onsiteAvg # prints onsite average to the second decimal
	print "\n" # adds blank space in output for easier readability
	print "Highest Grade:", HighestGrade
	print "Lowest Grade:", LowestGrade
}
