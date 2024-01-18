#!/bin/awk
# an awk script to output the number of each letter grade using the Task 03 script

BEGIN {
	FS = "," # sets comma as delimiter
	LetterGrade = "I" # sets I as default Letter Grade
	Acount=0 # sets default count of A letter grades to 0
	Bcount=0 # sets default count of B letter grades to 0
	Ccount=0 # sets default count of C letter grades to 0
	Dcount=0 # sets default count of D letter grades to 0
	Ecount=0 # sets default count of E letter grades to 0
	Icount=0 # sets default count of I letter grades to 0
}
NR != 1{ # skips first record since it is just a header with no values
	if ($2 >= 90) { #runs if final grade is 90 or higher
		LetterGrade = "A"
	} else if ($2 >= 80 && $2 < 90) { # runs if final grade is 80 or higher and less than 90
		LetterGrade = "B"
	} else if ($2 >= 70 && $2 < 80) { # runs if final grade is 70 or higher and less than 80
		LetterGrade = "C"
	} else if ($2 >= 60 && $2 < 70) { # runs if final grade is 60 or higher and less than 70
		LetterGrade = "D"
	} else if ($2 >= 0 && $2 < 60) { # runs if final grade is 0 or higher and less than 60
		LetterGrade = "E"
	} else { # runs if final grade is outside the range of 0 and 100
		LetterGrade = "I"
	}
	if (LetterGrade == "A") { #runs if letter grade is A
		Acount +=1 # adds one to count of A letter grades
	} else if (LetterGrade == "B") { # runs if letter grade is B
		Bcount +=1 # adds one to count of B letter grades
	} else if (LetterGrade == "C") { # runs if letter grade is C
		Ccount +=1 # adds one to count of C letter grades
	} else if (LetterGrade == "D") { # runs if letter grade is D
		Dcount +=1 # adds one to count of D letter grades
	} else if (LetterGrade == "E") { # runs if letter grade is E
		Ecount +=1 # adds one to count of E letter grades
	} else { #runs if letter grade is I
		Icount +=1 # adds one to count of I letter grades
	}
}
END {
	print "A,", Acount # prints final count of A letter grades
	print "B,", Bcount # prints final count of B letter grades
	print "C,", Ccount # prints final count of C letter grades
	print "D,", Dcount # prints final count of D letter grades
	print "E,", Ecount # prints final count of E letter grades
}
