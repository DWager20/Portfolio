#!/bin/bash

# ----------------------------------------------------
# Title: Folder Copier
#
# Description:
# Creates a copy of a user defined folder to a user 
# defined new folder
#
# Author: David Wager
# Date created: 17 July 2024
# Last Edited: 28 July 2024 added colours
# -----------------------------------------------------

echo -ne "\033[032m"    # set text colour to green

# First get folder name

read -rp "Enter name of the folder you would like to copy: " folderName

# Validate for existing filename

if [ -d "$folderName" ]; then

    # Read in new location

    read -rp "Enter name of the destination folder: " newFolderName

    # Validate newFolderName checking for empty string
    
    while [ -z "$newFolderName" ];  do
        
        echo -ne "\033[031mError! \033[032m"
        read -rp "Please enter a non zero destination folder: " newFolderName
    
    done

    # Validate newFolderName checking to make sure not an existing folder

    while [ -d "$newFolderName" ]; do
        
        echo -ne "\033[031mError! \033[032m"
        read -rp "Please enter a non existing destination folder: " newFolderName
    
    done

    # Copy to new location

    cp -r "$folderName" "$newFolderName"
    
    # Print confirmation message
    
    RESULT=$?

    if [ "$RESULT" -eq 0 ]; then

        echo "Folder " "$folderName" " successfully copied to " "$newFolderName"
    
    else

        echo -ne "\033[031mError! \033[032m"
        echo "Copy failed. Try again."
    
    fi

else

    # otherwise, print an error
    echo -ne "\033[031mError! \033[032m"
    echo "I couldn't find that folder!"

fi

echo -ne "\033[0m"    # set text colour back to default

exit 0