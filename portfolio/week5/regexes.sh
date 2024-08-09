#!/bin/bash

# ----------------------------------------------------
# Title: Regexes
#
# Description:
# Practices the grep command to search portfolio of work
# to return specific patterns/texts
#
# Author: David Wager
# Date created: 31 July 2024
# Last Edited: 9 August 2024 
# ----------------------------------------------------

# Set path name for searching

path="$HOME/student/scripts/portfolio"

# Sub-Titles in green, output in purple

# All sed statements

echo -ne "\033[032m"
echo -e "\nAll sed statements:\n"

echo -ne "\033[035m"
grep -r --color ' sed ' "$path"

# All lines starting with the letter M or m

echo -ne "\033[032m"
echo -e "\nAll lines starting with the letter m:\n"

echo -ne "\033[035m"
grep -r --color '^[Mm]' "$path"

# All lines with three digit numbers but not more

echo -ne "\033[032m"
echo -e "\nAll lines that contain 3 digit numbers:\n"

echo -ne "\033[035m"
grep -rP --color '(?<!\d)\d{3}(?!\d)' "$path"

# All echo statements with at least three words

echo -ne "\033[032m"
echo -e "\nAll echo statements with at least three words:\n"

echo -ne "\033[035m"
grep -rP --color '^echo .*\"[a-zA-Z]+\s.+[a-zA-Z]+\s.[a-zA-Z]+\s.+"' "$path"

# All lines with beginning with good passwords - at least 8 characters with numbers, letters 
# (both upper and lowercase) and symbols. This code does not work for
# lines with strong passwords that are not at the start.

echo -ne "\033[032m"
echo -e "\nAll lines that would make a good password:\n"

echo -ne "\033[035m"
echo ""
grep -rP  --color '(?=.*[A-Z]{1,})(?=.*[a-z]{1,})(?=.*[0-9]{1,})(?=.*[!@#$%^&*]{1,})[A-Za-z0-9!@#$%^&*]{8,}' 

# The following modified from https://rexegg.com/regex-lookarounds.php needs work but still has touble
# with strong passwords not at the start of lines

# grep -rP  --color '\A(?=[^a-z]*[a-z])(?=[^A-Z]*[A-Z])(?=\D*\d)(?=^[[:punct:]]*[[:punct:]])[[:graph:]]{8,}\z' "$path"

# Change colour back to default
echo -e "\033[0m"

exit 0

