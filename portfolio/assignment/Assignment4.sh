#!/bin/bash

# ----------------------------------------------------
# Title: Assignment 4
#
# Description:
# Provides an introduction to downloading data from a 
# website, formatting it in a neat colourful table and
# give the user the ability to perform various search
# options on the data to return pertinent data of interest.
#
# The program is password protected with only the hash of 
# the password stored on the system. 
#
# The website gives information on a large number of data
# breaches that have occured releasing significant amounts 
# of private information to less than reputable recipients.
# 
# The API data are downloaded from 
# https://haveibeenpwned.com/api/v3/breaches, 
# https://haveibeenpwned.com/api/v3/latestbreach and 
# https://haveibeenpwned.com/api/v3/dataclasses
#
# The fields saved for the table are:
# - Name given to the breach
# - Date breach was discovered
# - Date the information about the breach was last modified
# - What types of data were compromised
#
# Temporary files are created and modified from the
# website files to produce .csv files that can be parsed
# into tabular form. The files are deleted at the end of 
# the program.
# 
# The program dependencies are:
# - passwordCheck.sh to check the password
# - PrintTable.awk to shoulder most of the file printing duties
# - Dataclass.awk to print the unique table of dataclasses
# 
# setPassword.sh has been included in the directory in the case of no password
# though is not called by this program.
#
# Author: David Wager
# Date created: 13 August 2024
# Last Edited: 18 August 2024 
# ----------------------------------------------------

#-----------------------------------------------------
# CONSTANTS used in program
# ----------------------------------------------------
# Defined here so can be easily modified

website="https://haveibeenpwned.com/api/v3/breaches"
datalist="https://haveibeenpwned.com/api/v3/dataclasses"
mostrecent="https://haveibeenpwned.com/api/v3/latestbreach"

# ----------------------------------------------------
# FUNCTIONS used in program
# ----------------------------------------------------

#This function prints a given error with a red ERROR: at the start
      
printError()      
{   
    echo -e "\033[31mERROR:\033[0m $1"     
} 

# This function dowloads the web files and converts to a .csv
# file ready for printing into a table.
# Although downloading the files each time the program is run
# is bandwidth heavy, it does ensure the most recent information
# is presented.

filepreprocessing()
{
    # Get the main breaches file from the website

    wget -qO breaches.json "$1"

    # Modify downloaded file to add the following fields:
    #   DCLen - counts how many Data Classes are in each record
    #   BreachDate_Epoch - convert breachDate to ISO 8006 format then to unix epoch time via fromdate
    #   ModDateShort - convert ModifiedDate to remove time element to make for easier to read data
    #   ModDate_Epoch -  convert ModifiedDate to unix epoch time via fromdate

    # Code modified from https://stackoverflow.com/questions/64191907/jq-calculate-length-of-each-array-in-json-and-update-it
    # and https://www.devtoolsdaily.com/jq/concat/ and https://github.com/jqlang/jq/issues/700

    jq '.[] |= . + { DCLen:.DataClasses|length, BreachDate_Epoch:(.BreachDate + "T00:00:00Z")|fromdate, ModDateShort:.ModifiedDate|.[0:10], ModDate_Epoch:.ModifiedDate|fromdate } ' breaches.json > mod.json

    # Convert mod.json into csv format and extract the particular information for the table

    jq -r '.[] | [.Name, .BreachDate, .BreachDate_Epoch, .ModDateShort, .ModDate_Epoch, .PwnCount, .DCLen, .DataClasses[]] | @csv' mod.json > table.csv

    # Get the dataclasses info from website. The format is not converted to .csv as 
    # apart from the array brackets, the file is in .csv format

    wget -qO datalist.json "$2"

    # Get the most recent breach record from website and prepare a .csv file as per above. 
    # There is some unecessary fields created in the process however it means the same PrintTable.awk
    # file can be used.

    wget -qO mostrecent.json "$3"

    jq '. |= . + { DCLen:.DataClasses|length, BreachDate_Epoch:(.BreachDate + "T00:00:00Z")|fromdate, ModDateShort:.ModifiedDate|.[0:10], ModDate_Epoch:.ModifiedDate|fromdate } ' mostrecent.json > mostrecentmod.json
    jq -r '. | [.Name, .BreachDate, .BreachDate_Epoch, .ModDateShort, .ModDate_Epoch, .PwnCount, .DCLen, .DataClasses[]] | @csv' mostrecentmod.json > mostrecent_table.csv

}

# This function cleans up the directory of temporary files created
# During running of the program

filepostprocessing()
{
    rm breaches.json mod.json table.csv datalist.json mostrecent.json mostrecentmod.json mostrecent_table.csv
}

# This function checks if a date entered is valid and returns true if the 
# date is in the correct format (YYYY-MM-DD) and false if otherwise

isValidDate()
{
    # Code modified from https://stackoverflow.com/questions/18731346/validate-date-format-in-a-shell-script/18736035#18736035
    
    result=$(echo "$1" | awk  -F '-' '{ print (match($1, /^[1-2][0-9][0-9][0-9]$/) && match($2, /^[0-1][0-9]$/) && $2 <= 12 && match($3, /^[0-3][0-9]$/) && $3 <= 31) ? "Valid Date" : "Invalid Date" }')
    echo "$result"
    if [ "$result" = "Valid Date" ]; then
        return 0
    else
        return 1
    fi
}

# This function returns two dates for a date range to search table. The
# dates are validated to the correct format. Empty inputs
# revert to default vaules before the earliest record and today's date.

getdates()
{
    # Set default values 

    startDate="1970-01-01"
    endDate=$(date +"%Y-%m-%d")

    # Define variables with the unix epoch times of startDate and endDate

    sDate_Epoch=$(date -d "$startDate" +"%s")
    eDate_Epoch=$(date -d "$endDate" +"%s")

    echo -e "\033[032m"    # Change colour to green

    # Get first date

    echo -e "\033[032mEnter Start of Date Range (Blank will default to $startDate)"    # Change colour to green
    read -rp "Format needs to be YYYY-MM-DD and date must be before today: " date1
    
    # Check if date is valid
    
    if [ -z "$date1" ]; then
        
        # Blank string input so no need to change default start date
        
        echo -e "\nNo date supplied. Default starting date to be used is $startDate\n"
    
    else
        
        # Non zero string entered. Need to check if valid date format is entered.
        
        isValidDate "$date1"

        # Loop until the input is valid or empty string entered

        until [ "$result" = "Valid Date" ] || [ -z "$date1" ]; do 

            echo -e "\033[032mEnter Start of Date Range (Blank will default to $startDate)"    # Change colour to green
            read -rp "Format needs to be YYYY-MM-DD and date must be before today: " date1
            isValidDate "$date1"       
        
        done    

        # Entered date may have become zero string. Need to deal with this
         
        if [ -z "$date1" ]; then
            
            # Blank string input so no need to change default start date
            
            echo -e "\nNo date supplied. Default starting date to be used is $startDate\n"

        else
        
            # Although the date here is validly formatted it still may not be in range.

            # Define unix epoch time for date1

            date1_Epoch=$(date -d "$date1" +"%s")
        
            # Compare epoch times
        
            if [ $sDate_Epoch -gt $date1_Epoch ]; then

                # Entered date is before default so use default

                printError "\n\033[032mStart date is less than default starting date so $startDate will be used\n"

            elif [ $date1_Epoch -gt $eDate_Epoch ]; then

                # Entered date is in the future so use default

                printError "\n\033[032mStart date is in the future! Default starting date of $startDate will be used\n"

            else
        
                # Date is validly formated and in range

                startDate="$date1"
                sDate_Epoch=$date1_Epoch
            fi  
        fi  
    fi
    
    # Get second date

    echo -e "\033[032mEnter End of Date Range (Blank will default to today's date)"    # Change colour to green
    read -rp "Format needs to be YYYY-MM-DD and date must not be in the future: " date2

    # Check if date is valid
    
    if [ -z "$date2" ]; then
        
        # Blank string input so no need to change default end date

        echo -e "\nNo date supplied. Default end date to be used is $endDate\n"

    else
       
        # Non zero string entered. Need to check if valid date format is entered.
       
        isValidDate "$date2"

        # Loop until the input is valid or empty string entered

        until [ "$result" = "Valid Date" ] || [ -z "$date2" ]; do 
            
            echo -e "\033[032mEnter End of Date Range (Blank will default to today's date)"    # Change colour to green
            read -rp "Format needs to be YYYY-MM-DD and date must not be in the future: " date2
            isValidDate "$date2"       
        
        done    

        # Entered date may have become zero string. Need to deal with this
         
        if [ -z "$date2" ]; then
            
            # Blank string input so no need to change default end date
            
            echo -e "\nNo date supplied. Default end date to be used is $endDate\n"

        else

            # Although the date here is validly formatted it still may not be in range

            date2_Epoch=$(date -d "$date2" +"%s")

            if [ "$eDate_Epoch" -lt "$date2_Epoch" ]; then

                # Entered date is in the future so use default

                printError "\n\033[032mEnd date is in the future! Default end date of $endDate will be used\n"

            elif [ "$date2_Epoch" -lt "$sDate_Epoch" ]; then

                # Entered date is before start date so use default

                printError "\n\033[032mEnd date is before start date! Default end date of $endDate will be used\n"

            else
        
                # Date is validly formated and in range

                endDate="$date2"
                eDate_Epoch="$date2_Epoch"
            fi    
        fi
    fi

    echo -e "\033[032mDate range to be searched is $startDate to $endDate"
}


gettwonumbers()
{
    # Set default values 

    lowvalue=0
    highvalue=1000000000000    # Random high number 1E12

    echo -e "\033[032m"    # Change colour to green

    # Get first number

    read -rp "Enter minimum number of breaches to search for (Blank will default to zero): " num1
    
    # Check if number is valid
    
    if [ -z "$num1" ]; then
        
        # Blank string input so no need to change default lowvalue
        
        echo -e "\nNo minimum number supplied. Default minimum number is $lowvalue\n"
    
    else
        
        # Non zero string entered. Need to check if valid number is entered.
        
        until [ -n "$num1" ] && [ "$num1" -eq "$num1" ] 2>/dev/null; do
            
            if [ -z "$num1" ]; then
                
                # Blank string entered

                break
            
            else
                # Error message for invalid integer and get number again

                printError "\033[032m$num1 is not a valid integer"
                read -rp "Enter first integer: " num1
            
            fi
        
        done
       
        # Allow for num1 to become a zero string
         
        if [ -z "$num1" ]; then
            
            # Blank input so no need to change default lowvalue
            
            echo -e "\nNo minimum number supplied. Default minimum number is $lowvalue\n"

        # Although the number is a valid integer it may not be in range
        
        elif [ $lowvalue -gt $num1 ]; then

        # Entered number is before minimum default so use default

            printError "\033[032mMinimum number is less than default so $lowvalue will be used\n"

        elif [ $num1 -gt $highvalue ]; then

        # Entered number is greater than maximum default so use default

            printError "\033[032mMinimum number is greater than maximum default! Minimum nuber will revert to  $lowvalue will be used\n"

        else
        
        # Number is valid and in range

            lowvalue=$num1
        fi    
    fi
    
    # Get maximum number

     read -rp "Enter maximum number of breaches to search for (Blank will default to $highvalue): " num2
    
    # Check if number is valid
    
    if [ -z "$num2" ]; then
        
        # Blank string input so no need to change default highvalue
        
        echo -e "\nNo maximum number supplied. Default maximum number is $highvalue\n"
    
    else
        
        # Non zero string entered. Need to check if valid number is entered.
        
        until [ -n "$num2" ] && [ "$num2" -eq "$num2" ] 2>/dev/null; do
            
            if [ -z "$num2" ]; then
               
                # Blank string entered
                
                break
           
            else
                # Error message for invalid integer and get number again

                printError "\033[032m$num2 is not a valid integer"
                read -rp "Enter second integer: " num2
            
            fi
        
        done
       
        # Allow for num1 to become a zero string
         
        if [ -z "$num2" ]; then
            
            # Blank input so no need to change default high value
            
            echo -e "\nNo maximum number supplied. Default maximum number is $highvalue\n"

        # Although the number is a valid integer it may not be in range.

        
        elif [ $highvalue -lt $num2 ]; then

        # Entered number is greater than maximum default so use default

            printError "\033[032mMaximum number is greater than default maximum number so $highvalue will be used\n"

        elif [ $num2 -lt $lowvalue ]; then

        # Entered number is less than minimum default so use default

            printError "\033[032mMaximum number is less than default minimum number! Maximum number will revert to  $highvalue will be used\n"

        else
        
        # Number is valid and in range

            highvalue=$num2
        fi    
    fi

    echo -e "\033[032mBreaches Range is $lowvalue to $highvalue"
}

# -----------------------------------------------------------------------
# MAIN program
# -----------------------------------------------------------------------

# Title

echo -e "\033[032m\nWelcome to Assignment 4 Data Search!\n" 

# Run passwordCheck.sh to check access. Removed global path
# as this is easier to just use the local directory
# for moving assignmet folder around for submission

./passwordCheck.sh
     
result=$?

if [ "$result" = 0 ]; then # Access granted
        
    # print welcome section

    echo -e "\033[033mData from: "
    echo -e "       $website" # Print in  yellow
    echo -e "       $datalist"
    echo -e "       $mostrecent\n"

    # Get information from website, extract relevant infomation
    # Set up for making a colourful table

    filepreprocessing $website $datalist $mostrecent

    # Top level menu. Loop until ready to quit

    until [ "$choice1" = "5" ]; do

        # Give menu options 

        echo -e "\n\033[032mWhat would you like to do?\n"    # Chage colour to Green
        echo "1. Show Entire Table"
        echo "2. Show list of all types of Compromised Data"
        echo "3. Search Table"
        echo "4. Show Most Recent Breach Details"
        echo -e "\033[0m5. Quit\033[032m\n" # Highlight quit in white

        # Get user selection

        read -rp "Enter choice (1-5): " choice1

        echo -ne "\033[0m" # Change colour back to default 

        case "$choice1" in
            "1")    
                # Print entire record in tabular form

                awk -F"," -v column="All" -f PrintTable.awk table.csv      
                ;;

            "2")
                # Print table of data classes

                awk -F"[" -v RS="," -f DataClass.awk datalist.json
                ;;
            "3")
                # First Sub menu to search for different records. Loop until ready to quit
                
                # choice 2 needs to be reset otherwise can be set to 5 and not allow entry into menu

                choice2=""

                # Loop until quit

                until [ "$choice2" = "5" ]; do

                    # Give menu options

                    echo -e "\n\033[032mWhat record would you like to search?\n"
        
                    echo "1. Breach Date"
                    echo "2. Date Last Modified"
                    echo "3. Number of Records Breached"
                    echo "4. What Data was Compromised"
                    echo -e "\033[0m5. Quit\033[032m\n" # Highlight quit in white

                    # Get user selection

                    read -rp "Enter choice (1-5): " choice2
                    echo -ne "\033[0m" # Change colour back to default

                    case "$choice2" in
                        "1")
                            # Search for records filtered by breach dates 

                            getdates    # First get the range of dates to search

                            # Print Table showing all records in the breach date range

                            awk -F"," -v column=2 -v lowval=$sDate_Epoch -v hival=$eDate_Epoch -f PrintTable.awk table.csv
                            ;;
                        "2")
                            # Search for records filtered by last modified dates

                            getdates    # First get the range of dates to search

                            # Print Table showing all records in the breach last modified date range

                            awk -F"," -v column=4 -v lowval=$sDate_Epoch -v hival=$eDate_Epoch -f PrintTable.awk table.csv
                            ;;
                        "3")
                            # Search for records filtered by number of breaches
                            
                            gettwonumbers # First get the range of numbers to search

                            # Print Table showing all records in the number of breaches range

                            awk -F"," -v column=6 -v lowval=$lowvalue -v hival=$highvalue -f PrintTable.awk table.csv
                            ;;
                        "4")
                            # Search for records filtered by what was compromised
                            # Get user input string with warning about using "" and using exact matching string
                            # If not matching string then will return an empty table

                            echo -e "\033[032mEnter type of data that was compromised (e.g. \"Email addresses\")" # Change to green
                
                            read -rp "Important: Include double quotations and make exact string match: " searchstring

                            # Awk does have a feature to search for part of a string using ~ /somestring/ however
                            # the author does not know how to use a variable for somestring in the .awk file so
                            # program unfortunately is very strict in string matching.

                            awk -F"," -v column=8 -v search="$searchstring" -f PrintTable.awk table.csv
                            ;;
                        "5")
                            # Condition met for exiting loop

                            echo ""
                            ;;
                        *)
                            # Invalid input - not one of the five options

                            printError "\033[032mInvalid selection!\n" # Red error
                            ;;
                    esac
                done
                ;;
            "4")
                # Print table showing most recent breach details

                awk -F"," -v column="All" -f PrintTable.awk mostrecent_table.csv

                ;;
            "5")             
                # Condition met for exiting loop

                echo ""
                ;;
            *)
                # Invalid input - not one of the five options

                printError "\033[032mInvalid selection!" # Red error
                ;;
        esac
    done

elif [ "$result" = 2 ]; then

    # Incorrect password. Assumes the presence of setPassword.sh to set one.
    # However if security was more important this message could be changed to:
    # "Please contact system administrator to organise password."

    echo -e "\033[032mRun setPassord.sh to create one\n"
    exit 1


elif [ "$result" = 3 ]; then

    # More than one password

    echo -e "\033[032Please resolve to run Assignment4.sh\n"
    exit 1

else
    
    # Password hash does not match stored value so access denied

    printError "\033[032mPlease check the password and try again!\n"
    exit 1

fi

echo -e "\033[0m"     # change text colour back to default

# Clean up temporary files

filepostprocessing

exit 0

# ----------------------------------------------------------------------
# END MAIN program
# ---------------------------------------------------------------------- 
					
      
					