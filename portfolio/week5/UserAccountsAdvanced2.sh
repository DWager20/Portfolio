#!/bin/bash

# ----------------------------------------------------
# Title: User Accounts Advanced 2
#
# Description:
# Uses awk to find lines in /etc/passwd and ouputs it into a neat
# colorful table. '/etc/passwd' could be defned as a variable to
# search other files however the formatting of the table 
# (line spacing, columns etc) is heavily dependant on 
# the file being searched so that remains hard-coded.

# This version provides a menu for the user to input what columns
# to search and then an input string to search for that string
# in that column. It is further enhanced by saving the awk command
# in an external .awk file and running it with the parameters of
# the user input.This program should behave exactly like User 
# Accounts Advanced with the only difference being the code in 
# this version being neater.

# Author: David Wager
# Date created: 7 August 2024
# Last Edited: 9 August 2024 
# ----------------------------------------------------
      
 
# Title

echo -e "\033[032m\nRecords in '/etc/passwd':" 
 
    until [ "$choice" = "7" ]; do
        echo -ne "\033[036m"   # Change text colour to cyan
       
        # Give menu options 
        echo -e "\nWhich record would you like to search?\n"
        echo "1. User Name"
        echo "2. User ID"
        echo "3. Group ID"
        echo "4. Home Directory"
        echo "5. Shell Directory"
        echo "6. Print all records"

        echo -ne "\033[0m"  # Change colour to white
        echo "7. Quit"
        echo -ne "\033[036m"  # Change colour to back to cyan
        echo ""
        # Get user selection
        read -rp "Enter choice (1-7): " choice

        echo -ne "\033[0m" # Change colour back to default 

        case "$choice" in
            "1")                 
                # User defined user name
                
                read -rp "Enter User Name to search: " userName

                awk -F":" -v column=1 -v search="$userName" -f UserAccounts.awk /etc/passwd
                
                ;;

            "2")
                # User defined ID
                
                read -rp "Enter User ID to search: " user_ID

                awk -F":" -v column=3 -v search="$user_ID" -f UserAccounts.awk /etc/passwd
                ;;
            "3")
                # User defined Group ID
                
                read -rp "Enter Group ID to search: " group_ID

                awk -F":" -v column=4 -v search="$group_ID" -f UserAccounts.awk /etc/passwd
                ;;
            "4")
                # User defined Home directory

                read -rp "Enter home directory to search: " home

                awk -F":" -v column=6 -v search="$home" -f UserAccounts.awk /etc/passwd       

                ;;
            "5")
                # User defined shell directory
                
                read -rp "Enter shell directory to search: " shell

                awk -F":" -v column=7 -v search="$shell" -f UserAccounts.awk /etc/passwd
                ;;
            6)  
                # Print all records

                awk -F":" -v column="All" -v search="everything" -f UserAccounts.awk /etc/passwd
                ;;              
            7)    
                exit 0
                ;;
            *)
                echo -ne "\033[031m" # Change colour to red for invalid input
                echo "Invalid selection!"
                echo -ne "\033[031m" # Change colour back to cyan for new input
                read -rp "Enter choice (1-7): " choice
                ;;
        esac

    done

exit 0
     
					
      
					