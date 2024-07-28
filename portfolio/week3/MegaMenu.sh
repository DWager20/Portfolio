#!/bin/bash
#
# ---------------------------------------------------------------
# Title: Mega Menu
#
# Description:
# Expands on previously created menu.sh script with the addition
# of week 3 scripts. These include a simple arithmetic calculator,
# a script that creates multiple week folders, one that checks
# filenames and one that downloads a file from the internet to a
# user defined directory. Changed method of menu from select command
# to until and case commands to provide flexibility in colour options.
#
# If file secret.txt does not exist, need to run setPassword.sh
# first.
# 
# Author: David Wager
# Date created: 28 July 2024
# Last Edited: 28 July 2024
# --------------------------------------------------------------

# Run passwordCheck.sh to check access
    
./passwordCheck.sh
     
result=$?

echo -ne "\033[031m"     #Change text colour to red for error messages

if [ "$result" = 0 ]; then # Access granted
        
    # print welcome section

    echo ""
    echo -ne "\033[034m"   # Change text colour to blue
    echo "Welcome"
    

    

    # Set up input request for menu

    until [ "$choice" = "8" ]; do
        echo -ne "\033[036m"   # Change text colour to cyan
       
        # Give menu options 
        echo ""
        echo "1. Create a Folder"
        echo "2. Copy a Folder"
        echo "3. Set Password"
        echo "4. Calculator"
        echo "5. Create Week Folders"
        echo "6. Check Filenames"
        echo "7. Download a File"
        echo -ne "\033[0m"  # Change colour to white
        echo "8. Quit"
        echo -ne "\033[036m"  # Change colour to back to cyan
        echo ""
        # Get user selection
        read -rp "Enter choice (1-8): " choice

        echo -ne "\033[0m" # Change colour back to default for all the scripts

        case "$choice" in
            "1")                 
                ./folderCreate.sh
                ;;
            "2")
                ./foldercopier.sh
                ;;
            "3")
                ./setPassword.sh
                ;;
            "4")
                ./calculator.sh
                ;;
            "5")
                echo -ne "\033[032m"    # set text colour to green
                
                # get first argument
                
                read -rp "Enter first week number: " week1
                
                # Check to make sure integer. It does not handle floating point numbers
                # or scientific notation. However the program aims for just integers.


                until [ -n "$week1" ] && [ "$week1" -eq "$week1" ] 2>/dev/null; do
                    echo -e "\033[031m$week1 is not a valid integer\033[032m"  # Error message in red
                    read -rp "Enter first week number: " week1
                done


                 # Get second argument

                read -rp "Enter second week number: " week2

                 # Check to make sure integer. Same as week1

                until [ -n "$week2" ] && [ "$week2" -eq "$week2" ] 2>/dev/null; do
                    echo -e "\033[031m$week2 is not a valid integer\033[032m" # Error message in red
                    read -rp "Enter second integer: " week2
                done

                echo -e "\033[0m"     # change text colour back to default

                ./megafoldermaker.sh "$week1" "$week2"
            ;;
            6)
                echo -ne "\033[032m"    # set text colour to green

                # Get argument

                read -rp "Enter file to be evaluated (including extension): " fileName
                
                # Check for non zero input

                while [ -z "$fileName" ]; do
                    echo -ne "\033[032mError: Need non-zero input\033[032m"   # Red error message
                    read -rp "Enter file to be evaluated (including extension): " fileName
                done

                echo -e "\033[0m"     # change text colour back to default

                ./filenames.sh "$fileName"
                ;;
            7)
                ./InternetDownloader.sh
                ;; 
            8)      
                exit 0
                ;;
            *)
                echo -ne "\033[031m" # Change colour to red for invalid input
                echo "Invalid selection!"
                echo -ne "\033[031m" # Change colour back to cyan for new input
                read -rp "Enter choice (1-8): " choice
                ;;
        esac

  
    done

elif [ "$result" = 2 ]; then

    # Incorrect password

    echo ""
    echo "No password exists!"
    exit 1
elif [ "$result" = 3 ]; then
    # More than one password
    echo ""
    echo "Please resolve to run MegaMenu.sh"
else
    # access denied
    echo ""
    echo "Please check the password and try again!"
fi

echo -e "\033[0m"     # change text colour back to default


exit 0