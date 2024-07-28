#!/bin/bash

# ----------------------------------------------------
# Title: Mega Folder Maker
#
# Description:
# Inputs two numeric arguments at run time and uses them to create
# directories. The directories are in the format of 'week $i' 
# where $i starts at the first number and continues to the last
# number. The arguments are assumed to be integers and the second
# integer is greater than the first.
#
# Author: David Wager
# Date created: 25 July 2024
# Last Edited: 28 July 2024 Added colours
# -----------------------------------------------------

echo -ne "\033[032m"    # set text colour to green

#If there aren't two arguments to the script 
      
if (( $#!=2 )); then 
      
    #Print an error and exit 
    echo -ne "\033[031mError! \033[032m"        # Red error  
    echo "Provide two numbers" && exit 1 
      
fi 
      
#For every number between the first argument and the last 
      
for ((i = $1; i <= $2; i++)) 
      
do 
      
    #Create a new folder for that number 
      
    echo "Creating directory number $i" 
      
    mkdir week$i
      
done 
     
echo -ne "\033[0m"    # set text colour back to default

exit 0