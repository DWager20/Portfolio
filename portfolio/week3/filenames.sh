#!/bin/bash
#
# ---------------------------------------------------------------
# Title: File Names
#
# Description:
# Takes a filename as an argument. Goes through line by line in
# in the file and prints the line together with an evaluation
# whether it is a filename, a directory or unknown type.
# 
# Author: David Wager
# Date created: 25 July 2024
# Last Edited: 25 July 2024
# --------------------------------------------------------------
#
# Check for single argument

echo -ne "\033[032m"    # set text colour to green

if (( $#!=1 )); then 
      
    #Print an error and exit 
    echo -ne "\033[031mError! \033[032m"        # Red error  
    echo "Provide a single filename argument" && exit 1 
      
fi 

# Parse file line by line and evaluate for file or directory

for line in $(cat $1); do 
    if [ -f "$line" ]; then     
        echo "$line - that file exists"
    elif [ -d "$line" ]; then
        echo "$line - That's a directory"
    else 
        echo "$line - I don't know what that is!"
    fi
done

echo -ne "\033[0m"    # set text colour back to default

exit 0