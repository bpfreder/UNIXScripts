#!/bin/bash
# a piped command using grep and cut to read the provided data file (lab0202.csv), find the entries that use UDP protocol to transmit packets less than 100 bytes, and print the port number of those entries. 
grep 'UDP' lab0202.csv | grep ' [0-9][0-9]$' | cut -f5 -d ' '
