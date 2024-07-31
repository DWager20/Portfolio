#!/bin/bash

# ----------------------------------------------------
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
# Last Edited: 30 July 2024 
# ----------------------------------------------------
      
 #This function prints a given error with a red ERROR: at the start
      
printError() 
      
{ 
      
    echo -e "\033[31mERROR:\033[0m $1" 
      
} 
      
 
      
#This function will get a value between the 2nd and 3rd arguments 
      
getNumber() 
      
{ 
      
    read -p "$1: " 
      
    while (( $REPLY < $2 || $REPLY> $3 )); do 
      
        printError "Input must be between $2 and $3" 
      
        read -p "$1: " 
      
    done 
      
} 

# Explicitly state the correct value so can be easily change and set the counter

correct=42
counter=1
      
echo "Welcome to the guesing game!" 
echo ""
      
# Gets number and makes sure it is within range

getNumber "Please type a number between 1 and 100" 1 100

# Loops until the correct number is inputted

until [ $REPLY -eq $correct ]; do
    ((counter++))
    if [ $REPLY -lt $correct ]; then
        echo "Too low! Try again."
    elif [  $REPLY -gt $correct ]; then
        echo "Too high! Try again."
    fi 

    getNumber "Please type a number between 1 and 100" 1 100

done

# Congratulatory message on completion

echo "Congratulations you guessed it! $correct is the correct number"

# Informing user of the number of tries

if [ $counter -eq 1 ]; then
    echo "You got it first time!"
else
    echo "It took you $counter tries!"
fi
  

exit 0