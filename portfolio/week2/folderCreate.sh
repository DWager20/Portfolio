#!/bin/bash
#
# ----------------------------------------------------------------------
# Title: Folder Create
#
# Description:
# Creates user defined folder. Error checks for existing of nil entries.
# 
# Author: David Wager
# Date created: 19 July 2024
# Last Edited: 28 July 2024 added colours
# ----------------------------------------------------------------------

echo -ne "\033[032m"    # set text colour to green

# Get name of new folder

read -rp "Please enter the name of the new folder: " folderName

# Validate non zero input

while [ -z "$folderName" ]; do
    
    echo -ne "\033[031mError! \033[032m"
    read -rp "Please enter non empty name of folder: " folderName

done

# Validate for existing folder name

while [ -d "$folderName" ]; do

    echo -ne "\033[031mError! \033[032m"
    read -rp "Please enter non existing name of folder: " folderName

done

mkdir "$folderName"

echo -ne "\033[0m"    # set text colour back to default

exit 0