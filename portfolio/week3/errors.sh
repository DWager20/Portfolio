#!/bin/bash 
#
# ----------------------------------------------------
# Title: Errors
#
# Description:
# Script was given to class containing errors. The task 
# for the student was to run the debuggger in conjunction
# with this script to find and fix the errors.
# against the hash of the password stored in secret.txt.
# This file is assumed created by setPassword.sh and is
# located in an unknown subdirectory. It assumes only 
# one copy of this file.

# Fixes 
# - Move read command to before if statement. Otherwise
#   $REPLY is empty when if statment is called.
# - Case statement unecessary - can do everything in the 
#   if statement. Left as is as both methods can produce 
#   a result.
# - Case statement needs to have the "*" case at the end 
#   as this covers everything and will not allow a true 
#   result.
#
# Author: David Wager
# Date created: 20 July 2024
# Last Edited: 20 July 2024
# -----------------------------------------------------

# Define variable secret as a string
      
secret='shhh' #Don't tell anyone! 

read -s -p "what's the secret code?" 

#if the user types in the correct secret, tell them they got it right! 
      
if [ "$secret" = $REPLY ]; then 
      
    echo "You got it right!" 
      
    correct=true 
      
else     
    
    echo "You got it wrong :(" 
      
    correct=false 
      
fi 
      

      
echo 
      
case $correct in 
      
true) 
      
    echo "you have unlocked the secret menu!" 
      
    #TODO: add a secret menu for people in the know. 
      
    ;; 

*) 
      
    echo "Go Away!" #people who get it wrong need to be told to go away! 
      
    ;; 
          
esac 
     
     
     
					