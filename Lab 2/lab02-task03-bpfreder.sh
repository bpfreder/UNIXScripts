#!/bin/bash
# a piped command using head, tail, sort, cut, and sed to return the date of the latest event in the file (lab0202.csv) in yyyy/mm/dd format
cat lab0202.csv | cut -b 1-10 | sort | tail -n 2 | head -n 1 | sed 's/-/\//g'
