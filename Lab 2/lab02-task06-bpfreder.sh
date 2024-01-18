#!/bin/bash
# a piped command using grep, sort, uniq, tail, wc, and cut to read the provided data file (lab0202.csv) and return the number of unique IP addresses that match the following criteria:
# 	IP address begins with 11
# 	Occurred before August 2018
# 	Occurred at an even numbered hour
# 	Has a size less than or equal to 100
cat lab0202.csv | tail -n 20 | grep -E '^2018-0[1-7]-(0[1-9]|[1-2][0-9]|3[0-1]) (02|04|06|08|10|12|14|16|18|20|22)' | cut -f4-6 -d ' ' | grep -E ' ([1-9]|[1-9][0-9])$' | cut -f1 -d ' ' | grep '^11' | wc -l
