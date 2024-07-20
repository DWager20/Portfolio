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
# Last Edited: 18 July 2024
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

# Get secret password 

read -sp "Enter secret password: " password 

# Validate input checking for empty string

while [ -z "$password" ]; do
    echo "Can not accept empty value!"
    read -sp "Enter secret password: " password
done

# Store hash of password in file secret.txt in folderName 

echo "$password" | sha256sum > "$folderName"/secret.txt

echo -e /n

exit 0