#!/bin/bash
#
# ---------------------------------------------------------------
# Title: Menu
#
# Description:
# Uses previously created Password Check script as introduction
# to this interactive menu where users can 'log in'. Successful 
# 'log in' allows the user to create a folder, copy a folder or
# change their password. These are all involve running separate 
# scripts. If there is
# no secret.txt file in the directory the program will ask the 
# user to generate a password which will be stored in secret.txt
# 
# Author: David Wager
# Date created: 18 July 2024
# Last Edited: 19 July 2024
# --------------------------------------------------------------

# Run passwordCheck.sh to check access
    
./passwordCheck.sh
     
result=$?

if [ "$result" = 0 ]; then # Access granted
        
    # print welcome section

    echo ""
    echo "Welcome"
    echo ""

    # Set up input request for menu
        
    PS3="Enter choice (1/2/3/4): "

    # Run menu

    select opt in "Create a Folder" "Copy a Folder" "Set Password" "Quit"
    do
        case $opt in
            "Create a Folder") 
                ./folderCreate.sh
                ;;
            "Copy a Folder")
                ./foldercopier.sh
                ;;
            "Set Password")
                ./setPassword.sh
                ;;
            "Quit")
                break
                    ;;
            *)
                echo "Invalid Option $REPLY"
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
    echo "Please resolve to run menu.sh"
else
    # access denied
    echo ""
    echo "access denied"
fi



exit 0