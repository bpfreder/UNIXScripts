#!/bin/bash
# a single regular expression using grep to read the provided data file and return only the valid email addresses from lab0207.txt
grep -E '(b|o|p)([A-Z]|[a-z]|[0-9]){6}@asu\.edu$' lab0207.txt
