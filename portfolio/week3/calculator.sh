#!/bin/bash

# ----------------------------------------------------
# Title: Calculator
#
# Description:
# Inputs two integers and one operator from addition,
# subtraction, multiplication and division. Performs a
# basic calculation and outputs the results
#
# Author: David Wager
# Date created: 23 July 2024
# Last Edited: 28 July 2024 Added colours to inputs and menu
# -----------------------------------------------------

echo -ne "\033[032m"    # set text colour to green

# Funtion to read in two integers

function_get_two_integers () {

  # Get first integer

  read -rp "Enter first integer: " int1

  # Check to make sure integer. It does not handle floating point numbers
  # or scientific notation. However the program aims for just integers.

  # This test seems to work. Just need to make it negative for a 'while' loop

  until [ -n "$int1" ] && [ "$int1" -eq "$int1" ] 2>/dev/null; do
    echo -ne "\033[031mError! \033[032m"        # Red error
    echo "$int1" is not a valid integer
    read -rp "Enter first integer: " int1
  done


  # Get second integer

  read -rp "Enter second integer: " int2

  # Check to make sure integer. Same as int1

  until [ -n "$int2" ] && [ "$int2" -eq "$int2" ] 2>/dev/null; do
    echo -ne "\033[031mError! \033[032m"        # Red error
    echo "$int2" is not a valid integer
    read -rp "Enter second integer: " int2
  done

}
# Run initial use of get two integers function

function_get_two_integers;

# Get user to select operation

echo ""
echo "Select one of the following operations"
echo ""

select opt in "Addition" "Subtraction" "Multiplication" "Division" "Enter new numbers" "Quit"
    do
        case $opt in
            "Addition")        # output in blue
                echo -e "\033[34m"
                echo -n "$int1" '+' "$int2" '= '
                echo $(("$int1 + $int2"))
                echo -e "\033[032m"
                ;;
            "Subtraction")     # output in green
                echo -e "\033[32m"
                echo -n "$int1" '-' "$int2" '= '
                echo $(("$int1 - $int2"))
                echo -e "\033[032m"
                ;;
            "Multiplication")   # output in red
                echo -e "\033[31m"
                echo -n "$int1" '*' "$int2" '= '
                echo $(("$int1 * $int2"))
                echo -e "\033[032m"
                ;;
            "Division")         # output in purple
                echo -e "\033[35m"
                echo -n "$int1" '/' "$int2" '= '
                echo "scale=2; $int1 / $int2" | bc
                echo -e "\033[032m"
                ;;
            "Enter new numbers")
                function_get_two_integers;
                ;;
            "Quit")
                break
                    ;;
            *)
                echo -ne "\033[031mError! \033[032m"        # Red error
                echo "Invalid Option $REPLY"
                ;;
        esac
        
    done

echo -ne "\033[0m"    # set text colour back to default

exit 0
