#!/usr/bin/python3
# ----------------------------------------------------
# Title: Brute Force Attack
#
# Description:
# Performs a brute force attack on a password that has
# been secured using the sha256 hash algorithm.
#
# It is assummed that the password is a string of
# characters consisting of letters (either upper case or 
# lower case) and digits but not symbols. The attack completes
# when the password is found or all combinations are checked to
# a maximum number of characters set to a variable 'maxlen'.
# Although the password and maxlen are hard-coded, they are set
# as variables before the main function to give the programmer 
# the flexibility to easily change them to test the program. 
#
# This could be enhanced by allowing the user to specify maxlen
# and also to allow symbols (increasing the complexity and time
# taken to crack).
#
# In another direction provision could also be made to allow the 
# user to input the password or password hash to 'brute force' check. 
# Of course any user input needs to be validated to be within 
# expected values. 
#
# There is also the possibility of creating a menu of different 
# hashing functions and to either select one or several for 
# brute force attack. 
#
# Author: David Wager
# Date created: 10 August 2024
# Last Edited: 12 August 2024 Minor edit
# ----------------------------------------------------
#
# Libraries required
#
import hashlib
import itertools
import string
import datetime as dt
#
# Password and sha256 hash of it. Allows for easy changing
# of the password for testing purposes.
#
password = "9Q6w"
passwordHash = hashlib.sha256(password.encode("utf-8")).hexdigest()
#
# Print title
# 
print("\n\033[1;32mBRUTE Force Password Cracker\n")
print('CALCULATING...')
#
# Variable to measure start time
#
start = dt.datetime.now()
#
# Variable for maximum number of characters in password to be checked.
# Taken out of loop so can be easily changed.
#
maxlen = 6
#
# Function for guessing password. Modified from
# https://stackoverflow.com/questions/40269605/how-to-create-a-brute-force-password-cracker-for-alphabetical-and-alphanumerical
#
def guess_password(real):
    #
    # Define variable that contains the full list of characters to be checked
    #
    chars = string.ascii_letters + string.digits
    #
    # Counter for number of guesses
    #
    attempts = 0
    #
    # Outer loop - each iteration adds a character to the password being checked up to max len
    #
    for password_length in range(1, maxlen):
        #
        # Inner nested loop checking every possible combination of chars of a particular length
        #
        for guess in itertools.product(chars, repeat=password_length):
            attempts += 1
            guess = ''.join(guess)
            #
            # Taking the guess string and producing a sha256 hash of it
            #
            guessHash = hashlib.sha256(guess.encode("utf-8")).hexdigest()
            #
            # Check if password is cracked
            #
            if guessHash == real:
                #
                # Get final time and print found password, number of attempts and time taken
                #
                end = dt.datetime.now()
                print("\033[1;34m\nPassword found to be:\033[1;33m {}".format(guess))
                print("\033[1;34mFound with {} guesses".format(attempts))
                print('Time taken was',round((end - start).total_seconds()),'seconds')
                return "\033[1;32m\nProgram was successful!\n\033[0;37m"
    #
    # Loop failed to find password
    #
    print("\033[1;31m\nError: Password is longer than ",maxlen," charaters or contains non digit/letter characters!\n\033[0;37m")
    
#
# Run the guess password function
#
guess_password(passwordHash)
