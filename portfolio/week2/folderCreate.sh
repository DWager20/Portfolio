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
# Last Edited: 19 July 2024
# ----------------------------------------------------------------------

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

exit 0