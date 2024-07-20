#!/bin/bash

# ---------------------------------------------------------------
# Title: undo Set Password
#
# Description:
# REmove directories and password files created by Set Password
#
# Author: David Wager
# Date created: 18 July 2024
# Last edited: 18 July 2024
# ---------------------------------------------------------------


# First get folder to be removed

read -rp "Please enter folder to be removed: " folderName

# Validate input checking to see if file is not empty string

while [ -z "$folderName" ]; do
    echo "Can not accept nil value!"
    read -rp "Please enter folder to be removed: " folderName
done

# Check if existing file and confirm deletion
# Assumes the existence of secret.txt in folderName and 
# it is the only contents in the directory (ie. not fully robust)

if [ -d "$folderName" ]; then
    read -rp "Please confirm deletion of folder and contents: (y/n) " confirm
    if [[ "$confirm" -eq "y" ]] || [[ "$confirm" -eq "Y" ]]; then
        rm "$folderName"/secret.txt
        rmdir "$folderName"
    else
        exit 0
    fi
else 
    echo "Folder does not exist!"
fi

exit 0