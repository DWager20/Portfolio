#!/bin/bash

# ---------------------------------------------------------------
# Title: Second simple shell script
# Description:
# Prints a greeting to a name used in the argument entered by the user
#
# Author: David Wager
# Date created: 11 July 2024
# Last edited: 12 August 2024
# ---------------------------------------------------------------

# Change colour to green and print greeting

echo -e "\n\033[032mHi there!"

# Check if there is at least one argument

if [ "$#" -lt 1 ]; then
    echo -e "\033[031mError: \033[032mAt least 1 arguments is required."
    echo "Usage: $0 arg1 [arg2 ...]"
    echo -e "Please let me know who you are!\033[0m\n" 
    exit 1
fi

# If code gets to this point at least one argument was passed to the file
# Greet the person parsed in the file arguments with the name in yellow and bold

echo -ne "It's good to see you \033[1;033m"

for i in $*; do 
    echo -ne "$i "
done

#Print final exclamation mark in green and return to default colour

echo -e "\033[032m!\033[0m\n"

exit 0
					