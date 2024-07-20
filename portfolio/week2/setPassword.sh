#!/bin/bash

# ----------------------------------------------------
# Title: Set Password
#
# Description:
# Creates a user defined folder and places a hash of a
# user defined password in secret.txt in that folder
#
# Author: David Wager
# Date created: 17 July 2024
# Last Edited: 19 July 2024
# -----------------------------------------------------


# First get folder name

read -p "Enter your new folder name: " folderName

# Validate input checking for existing file or empty string

while [[ -d "$folderName" ]] || [[ -z "$folderName" ]]; do
    if [ -d "$folderName" ]; then
        echo "Folder already exists!"
        read -p "Please enter another folder name: " folderName
    else
        echo "Can not accept empty value!"
        read -p "Please enter folder name: " folderName
    fi
done

# Create folder folderName

mkdir "$folderName"

# Get password and re-enter for confirmation

read -rsp "Enter new password: " password1
echo ""

# Validate input checking for empty string

while [ -z "$password1" ]; do
    echo "Can not accept empty value!"
    echo ""
    read -rsp "Enter new password: " password1
done

read -rsp "Re-enter new password: " password2
echo ""
        
    while [ "$password1" != "$password2" ]; do

       # passwords need to match

        echo "Passwords do not match! "/n

            read -rsp "Enter new password: " password1
            echo ""

            while [ -z "$password1" ]; do 
                echo "Can not accept empty value!"
                echo ""
                read -rsp "Enter new password: " password1
            done

            read -rsp "Re-enter new password: " password2
            echo ""
        
    done  

# Store hash of password in file secret.txt in folderName 

echo -n "$password1" | sha256sum > "$folderName"/secret.txt

exit 0