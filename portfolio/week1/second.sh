#!/bin/bash

# ---------------------------------------------------------------
# Title: Second simple shell script
# Description:
# Prints a greeting to a name used in the argument entered by the user
#
# Author: David Wager
# Date created: 11 July 2024
# Last edited: 28 July 2024
# ---------------------------------------------------------------



echo "Hi there!"

# Input is quite robust on its own. Zero arguments mean just printing
# "It's good to see you !" which is acceptable. If more than one argument
# is provided, the additional arguments are ignored which is also acceptable 
# for this simple program.

echo "It's good to see you $1!"

exit 0
					