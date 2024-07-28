#!/bin/bash
#
# ---------------------------------------------------------------
# Title: Internet Downloader
#
# Description:
# Downloads a user specified file from the internet to a user
# specified directory.
# 
# Author: David Wager
# Date created: 28 July 2024
# Last Edited: 28 July 2024
# --------------------------------------------------------------

echo -ne "\033[032m"    # set text colour to green

# First get URL of file to be downloaded

    read -rp "Enter the URL of a file to download or type 'exit' to quit : " webAddress


# Loop until the user types'exit'

until [ "$webAddress" = "exit" ]; do


    
    # Validate webAddress checking for empty string.

    while [ -z "$webAddress" ];  do
    
        echo -ne "\033[031mError! \033[032m"        # Red error
        read -rp "Please enter a non zero URL: " webAddress
    
    done

    # Then get directory of file to be downladed

    read -rp "Enter the destination directory: " destDirectory

    # Validate existing directory otherwise give user option to create it

    until [ -d "$destDirectory" ]; do
        
        echo -ne "\033[031mError! \033[032m"        # Red error
        read -rp "Directory does not exist! Do you want to create it? (y/n) " response

        if [ "$response" = "y" ]; then
            mkdir "$destDirectory"
        else 
            echo -ne "\033[031mError! \033[032m"        # Red error
            read -rp "Please enter valid directory: " destDirectory
        fi
    done

    # Dowload file from webAddress to destination directory

    wget -qP "$destDirectory" "$webAddress"

    if [ $? -eq 0 ]; then
        echo "Dowload of $webAddress to $destDirectory successful"
    else
        echo -ne "\033[031mError! \033[032m"        # Red error
        echo "Download unsuccessful"
    fi

# Offer the option to download another file or exit

    read -rp "Enter the URL of another file to download or type 'exit' to quit : " webAddress
done

echo -ne "\033[0m"    # set text colour back to default

exit 0