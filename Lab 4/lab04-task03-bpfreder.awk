#!/bin/awk
#  an awk script to read the provided data file (lab0402.csv) and calculate the letter grade based on the value for the Final Grade field
# 	A = 90 to 100
# 	B = 80 to 89
# 	C = 70 to 79
#	D = 60 to 69
# 	E = 0 to 59

BEGIN {
	FS = "," #sets comma as delimiter
	LetterGrade = "I" #sets I as default Letter Grade
}
NR != 1{ #skips first record since it is just a header with no values
	if ($2 >= 90) { #runs if final grade is 90 or higher
		LetterGrade = "A"
	} else if ($2 >= 80 && $2 < 90) { #runs if final grade is 80 or higher and less than 90
		LetterGrade = "B"
	} else if ($2 >= 70 && $2 < 80) { #runs if final grade is 70 or higher and less than 80
		LetterGrade = "C"
	} else if ($2 >= 60 && $2 < 70) { #runs if final grade is 60 or higher and less than 70
		LetterGrade = "D"
	} else if ($2 >= 0 && $2 < 60) { #runs if final grade is 0 or higher and less than 60
		LetterGrade = "E"
	} else { #runs if final grade is outside the range of 0 and 100
		LetterGrade = "I"
	}
	print $1, "	", LetterGrade #prints name and letter grade with a tab inbetween
}
END {
}
