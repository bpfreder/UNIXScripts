#!/bin/awk
# an awk script that will take in a list of animals - such as the following - and output random combinations as a new creature

BEGIN{
	FS = " "
}
{
	if (NF == 3) { # Combines records that have animal adjectives across two words into one field for consistency with records where the adjective is only one word
		$1 = $1 " " $2 # fields 1 and 2 are combined into field 1
		$2 = $3 # field 3 is moved to field 2
	}
}
{
	First[NR]=$1 # adjective field is added to the corresponding array
	Last[NR]=$2 # animal field is added to the corresponding array
}
END{
	for (i=0; i<8; i++) { # We run this loop 8 times to get 8 random combinations of adjectives and animals
		randomNum1 = (rand()*1000) # generates a number between 0 & 1000
		randomNum2 = (rand()*1000) # generates another number between 0 & 1000
		if (randomNum1 <= 37) { # There are 27 records in this file. 1000 divided by 27 is roughly 37. By creating an if-else statement that assigns a field from the (cont.)
			FirstOut = First[1] # adjective array based on ranges of roughly 37, we can randomly select an entry from the field.
		} else if (randomNum1 > 37 && randomNum1 <= 74) {
			FirstOut = First[2]
		} else if (randomNum1 > 74 && randomNum1 <= 111) {
			FirstOut = First[3]
		} else if (randomNum1 > 111 && randomNum1 <= 148) {
			FirstOut = First[4]
		} else if (randomNum1 > 148 && randomNum1 <= 185) {
			FirstOut = First[5]
		} else if (randomNum1 > 185 && randomNum1 <= 222) {
			FirstOut = First[6]
		} else if (randomNum1 > 222 && randomNum1 <= 259) {
			FirstOut = First[7]
		} else if (randomNum1 > 259 && randomNum1 <= 296) {
			FirstOut = First[8]
		} else if (randomNum1 > 296 && randomNum1 <= 333) {
			FirstOut = First[9]
		} else if (randomNum1 > 370 && randomNum1 <= 407) {
			FirstOut = First[10]
		} else if (randomNum1 > 407 && randomNum1 <= 444) {
			FirstOut = First[11]
		} else if (randomNum1 > 444 && randomNum1 <= 481) {
			FirstOut = First[12]
		} else if (randomNum1 > 481 && randomNum1 <= 518) {
			FirstOut = First[13]
		} else if (randomNum1 > 518 && randomNum1 <= 555) {
			FirstOut = First[14]
		} else if (randomNum1 > 555 && randomNum1 <= 592) {
			FirstOut = First[15]
		} else if (randomNum1 > 592 && randomNum1 <= 629) {
			FirstOut = First[16]
		} else if (randomNum1 > 629 && randomNum1 <= 666) {
			FirstOut = First[17]
		} else if (randomNum1 > 666 && randomNum1 <= 703) {
			FirstOut = First[18]
		} else if (randomNum1 > 703 && randomNum1 <= 740) {
			FirstOut = First[19]
		} else if (randomNum1 > 740 && randomNum1 <= 777) {
			FirstOut = First[20]
		} else if (randomNum1 > 777 && randomNum1 <= 814) {
			FirstOut = First[21]
		} else if (randomNum1 > 814 && randomNum1 <= 851) {
			FirstOut = First[22]
		} else if (randomNum1 > 851 && randomNum1 <= 888) {
			FirstOut = First[23]
		} else if (randomNum1 > 888 && randomNum1 <= 925) {
			FirstOut = First[24]
		} else if (randomNum1 > 925 && randomNum1 <= 962) {
			FirstOut = First[25]
		} else if (randomNum1 > 962 && randomNum1 <= 980) {
			FirstOut = First[26]
		} else if (randomNum1 > 980 && randomNum1 <= 998) {
			FirstOut = First[27]
		} else {
			FirstOut = "Smelly" # in the rare event that the randomly generated number equals 999 or 1000, this bonus adjective is selected
		}
		if (randomNum2 <= 37) { # we apply the same principle of using ranges of about 37 for picking a random animal from the array we created from our file
			LastOut = Last[1]
		} else if (randomNum2 > 37 && randomNum2 <= 74) {
			LastOut = Last[2]
		} else if (randomNum2 > 74 && randomNum2 <= 111) {
			LastOut = Last[3]
		} else if (randomNum2 > 111 && randomNum2 <= 148) {
			LastOut = Last[4]
		} else if (randomNum2 > 148 && randomNum2 <= 185) {
			LastOut = Last[5]
		} else if (randomNum2 > 185 && randomNum2 <= 222) {
			LastOut = Last[6]
		} else if (randomNum2 > 222 && randomNum2 <= 259) {
			LastOut = Last[7]
		} else if (randomNum2 > 259 && randomNum2 <= 296) {
			LastOut = Last[8]
		} else if (randomNum2 > 296 && randomNum2 <= 333) {
			LastOut = Last[9]
		} else if (randomNum2 > 370 && randomNum2 <= 407) {
			LastOut = Last[10]
		} else if (randomNum2 > 407 && randomNum2 <= 444) {
			LastOut = Last[11]
		} else if (randomNum2 > 444 && randomNum2 <= 481) {
			LastOut = Last[12]
		} else if (randomNum2 > 481 && randomNum2 <= 518) {
			LastOut = Last[13]
		} else if (randomNum2 > 518 && randomNum2 <= 555) {
			LastOut = Last[14]
		} else if (randomNum2 > 555 && randomNum2 <= 592) {
			LastOut = Last[15]
		} else if (randomNum2 > 592 && randomNum2 <= 629) {
			LastOut = Last[16]
		} else if (randomNum2 > 629 && randomNum2 <= 666) {
			LastOut = Last[17]
		} else if (randomNum2 > 666 && randomNum2 <= 703) {
			LastOut = Last[18]
		} else if (randomNum2 > 703 && randomNum2 <= 740) {
			LastOut = Last[19]
		} else if (randomNum2 > 740 && randomNum2 <= 777) {
			LastOut = Last[20]
		} else if (randomNum2 > 777 && randomNum2 <= 814) {
			LastOut = Last[21]
		} else if (randomNum2 > 814 && randomNum2 <= 851) {
			LastOut = Last[22]
		} else if (randomNum2 > 851 && randomNum2 <= 888) {
			LastOut = Last[23]
		} else if (randomNum2 > 888 && randomNum2 <= 925) {
			LastOut = Last[24]
		} else if (randomNum2 > 925 && randomNum2 <= 962) {
			LastOut = Last[25]
		} else if (randomNum2 > 962 && randomNum2 <= 980) {
			LastOut = Last[26]
		} else if (randomNum2 > 980 && randomNum2 <= 998) {
			LastOut = Last[27]
		} else {
			LastOut = "Unicorn" # in the rare event that the randomly generated number equals 999 or 1000, this bonus animal is selected
		}
		print FirstOut, LastOut # Our randomly selected adjective and animal are printed to the console
	}
}
