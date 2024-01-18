#!/bin/bash
# a piped command using grep and cut to read the provided data file (lab0202.csv), find the entries that occurred in January at or before noon and used port 22, and print the IP address number of those entries. 
grep -E '(^19[7-9][0-9]|20[0-1][0-9]|202[0-2])-01-(0[1-9]|[1-2][0-9]) (0[1-9]|[1][0-2])' lab0202.csv | cut -f4-6 -d ' ' | grep '22 [0-9]*$' | cut -f1 -d ' '
