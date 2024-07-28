#!/bin/bash

#!/bin/bash

#
# ----------------------------------------------------
# Title: Menu
#
# Description:
# Uses previously created Password Check script as introduction
# to this interactive menu where users can 'log in', create a 
# folder, copy a folder or change their password. If there is
# no secret.txt file in the directory the program will ask the 
# user to generate a password which will be stored in secret.txt
# 
# Author: David Wager
# Date created: 18 July 2024
# Last Edited: 18 July 2024
# -----------------------------------------------------

# function create a folder

function_create_folder () {

    # Get name of new folder

    read -rp "Please enter the name of the new folder: " folderName

    # Validate non zero input

    while [ -z "$folderName" ]; do

        read -rp "Please enter non empty name of folder: " folderName

    done

    # Validate for existing folder name

    while [ -d "$folderName" ]; do

        read -rp "Please enter non existing name of folder: " folderName

    done

    mkdir "$folderName"
}

# function copy a folder

function_copy_folder () {

    # First get folder name

    read -rp "type the name of the folder you would like to copy: " folderName

    # Validate for existing folder name

    if [ -d "$folderName" ]; then

        # Read in new location

        read -rp "type the name of the destination folder: " newFolderName

        # Validate newFolderName checking for empty string
    
        while [ -z "$newFolderName" ];  do

            read -rp "Enter a non zero destination folder: " newFolderName
    
        done

        # Validate newFolderName checking to make sure not an existing folder

        while [ -d "$newFolderName" ]; do
    
            read -rp "Enter a non existing destination folder: " newFolderName
    
        done

        # Copy to new location

        cp -r "$folderName" "$newFolderName"
    
        # Print confirmation message
    
        RESULT=$?

        if [ "$RESULT" -eq 0 ]; then

            echo "Folder " "$folderName" " successfully copied to " "$newFolderName"
    
        else
    
            echo "Copy failed. Try again."
    
        fi

    else

        # otherwise, print an error

        echo "I couldn't find that folder!"

    fi

}

# function set password

function_set_password () {

    # Get password and re-enter for confirmation

    read -rsp "Type in new password: " password1

    echo ""

    read -rsp "Re-enter new password: " password2

    echo ""
        
    while [ "$password1" != "$password2" ]; do

       # passwords need to match

        echo "Passwords do not match! "/n

            read -rsp "Type in new password: " password1

            echo ""

            read -rsp "Re-enter new password: " password2

            echo ""
        
        done

    # save hash of password in secret.txt

    echo -n "$password1" | sha256sum > secret.txt
}

# Check if secret.txt exists, if not go to first time login and set password

if [ -f "secret.txt" ]; then

    # Run passwordCheck.sh to check access

    ./passwordCheck.sh
      
    result=$?

      if [ "$result" = 0 ]; then
        
        # print welcome section

        echo ""
        echo "Welcome"
        echo ""

        # Set up question for menu
        
        PS3="Enter choice (1/2/3/4): "

        # Run menu

        select opt in "Create a Folder" "Copy a Folder" "Set Password" "Quit"
        do
            case $opt in
                "Create a Folder") 
                    function_create_folder;
                    ;;
                "Copy a Folder")
                    function_copy_folder;
                    ;;
                "Set Password")
                    function_set_password
                    ;;
                "Quit")
                    break
                    ;;
                *)
                    echo "Invalid Option $REPLY"
                    ;;
            esac
        done


    else

        # Incorrect password

        echo ""
        echo "Please check the password and try again!"
        exit 1
    fi

else
    # No password file. Set password.

    function_set_password
fi

exit 0