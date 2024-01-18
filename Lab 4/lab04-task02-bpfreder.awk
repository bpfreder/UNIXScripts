#!/bin/awk
# an awk script to read the provided data file (lab0402.csv) and output the number of lines with a value of “onsite” and “online” in the Section field

BEGIN {
	FS = "," #sets comma as delimiter
	online = 0 #begins online counter at 0
	onsite = 0 #begins onsite counter at 0
}
NR != 1{ #starts at second record as first record is just a header with no values
	if ($3 == "online") { # runs if section is online
		online += 1 #adds 1 to total online counter
	} else if ($3 == "onsite") { # runs if section is onsite
		onsite += 1 # adds 1 to total onsite counter
	} else {
		print "Error occurred at line", NR, ". Invalid Section detected." #runs in the event of an invalid Section being found in a record
	}
}
END{
	print "online", online #prints online total
	print "onsite", onsite #prints onsite total
}
