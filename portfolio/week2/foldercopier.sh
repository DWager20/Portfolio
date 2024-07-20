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
# Last Edited: 18 July 2024
# -----------------------------------------------------


# First get folder name

read -rp "Enter name of the folder you would like to copy: " folderName

# Validate for existing filename

if [ -d "$folderName" ]; then

    # Read in new location

    read -rp "Enter name of the destination folder: " newFolderName

    # Validate newFolderName checking for empty string
    
    while [ -z "$newFolderName" ];  do
    
        read -rp "Please enter a non zero destination folder: " newFolderName
    
    done

    # Validate newFolderName checking to make sure not an existing folder

    while [ -d "$newFolderName" ]; do
    
        read -rp "Please enter a non existing destination folder: " newFolderName
    
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

exit 0