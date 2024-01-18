#!/bin/bash
# a piped command using tail, cut, sort, uniq, and wc to read the provided data file (lab0202.csv) and print the number of unique ip addresses
cat lab0202.csv | tail -n 20 | cut -b 25-35 | sort -r | uniq | wc -w
