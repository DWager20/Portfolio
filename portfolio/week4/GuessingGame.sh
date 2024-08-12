#!/bin/bash

# ---------------------------------------------------------------
# Title: Guessing Game
#
# Description:
# Uses functions printError and getNumber to get the user to 
# guess a number that is within 1 and 100. The program 
# helps the user by giving feedback whether the number is 
# too low or too high. Of course it makes sure no non integers
# or out of bound numbers are accepted.
#
# Author: David Wager
# Date created: 30 July 2024
# Last Edited: 12 August 2024 added check for specical characters 
#               immproved formatting and added colours.
# ----------------------------------------------------------------
      
#This function prints a given error with a red ERROR: at the start
      
printError() 
      
{   
    echo -e "\033[31mERROR:\033[0m $1"     
} 
      
 
      
#This function will get a value between the 2nd and 3rd arguments 
      
getNumber() 
      
{ 
      
    read -p "$1: "

    # Handles non integer inputs

    until [[ $REPLY =~ ^[0-9]+$ ]]; do
        
        printError "\033[32mInput must be an integer between $2 and $3\n"

        read -p "$1: "
    done
      
    # Handles out of bounds inputs

    while (( $REPLY < $2 || $REPLY> $3 )); do 
      
        printError "\033[32mInput must be between $2 and $3\n" 
      
        read -p "$1: " 
      
    done 
      
} 

# Explicitly state the correct value so can be easily changed and set the number of tries counter

correct=42
counter=1

echo -e "\n\033[032mWelcome to the guesing game!" 
echo ""
      
# Gets number and makes sure it is within range

getNumber "Please type a number between 1 and 100" 1 100

# Loops until the correct number is inputted

until [ $REPLY -eq $correct ]; do
    ((counter++))
    if [ $REPLY -lt $correct ]; then
        echo -e "\n\033[031mToo low!\033[032m Try again.\n"
    elif [  $REPLY -gt $correct ]; then
        echo -e "\n\033[031mToo high!\033[032m Try again.\n"
    fi 

    getNumber "Please type a number between 1 and 100" 1 100

done

# Congratulatory message on completion

echo -e "\nCongratulations you guessed it! \033[1;033m$correct\033[0;032m is the correct number"

# Informing user of the number of tries

if [ $counter -eq 1 ]; then
    echo -e "You got it first attempt!\n"
else
    echo -e "It took you $counter valid tries!\n"
fi
  

exit 0