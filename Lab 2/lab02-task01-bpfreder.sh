#!/bin/bash
# a piped command using cat, grep, and cut to read the provided data file (lab0201.csv) and print the Name field from each line where the section is online
cat lab0201.csv | grep 'online' | cut -f1 -d ','
