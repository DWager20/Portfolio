#!/bin/bash

#
# ----------------------------------------------------
# Title: Password Check
#
# Description:
# Takes a user defined password and checks its hash
# against the hash of the password stored in secret.txt.
# This file is assumed created by setPassword.sh and is
# located in an unknown subdirectory. It assumes only 
# one copy of this file.
#
# Author: David Wager
# Date created: 18 July 2024
# Last Edited: 28 July 2024
# -----------------------------------------------------

# change text colour to red

echo -ne "\033[031m"

# Check if secret.txt exists in any subdirectory

pwd_file="secret.txt"

num_pwd=$(find . -name "$pwd_file" | wc -l)

case $num_pwd in
    0)
        echo "Error: No password file exist!"
        exit 2
        ;;
    1)

        # Get user password for comparison

        read -rsp "Please enter password: " password

        # Make sure password entered is not an empty string

        while [ -z "$password" ]; do
            read -rsp "Please enter a non empty password: " password
        done

        # define the hashes of the input and that in secret.txt as variables

        p_newhash=$(echo -n "$password" | sha256sum)
        p_oldhash=$(cat "$(find -name "$pwd_file")")

        # compare values to check passwords

        if [ "$p_newhash" = "$p_oldhash" ]; then
            echo ""
            echo -ne "\033[032m"     # change text colout to green
            echo "Access Granted!"
            echo -ne "\033[0m"       # restore default colour
            exit 0
        else    
            echo ""
            echo "Access Denied!"
            echo -ne "\033[0m"       # restore default colour
            exit 1
        fi
        ;;
    *)
        echo "Error: More than one password file!"
        echo -ne "\033[0m"       # restore default colour
        exit 3
esac

exit 0