#!/bin/bash

# ----------------------------------------------------
# Title: User Accounts
#
# Description:
# Uses awk to find lines in /etc/passwd that have a 
# shell of /bin/bash and ouputs it into a neat colorful
# table. 
#
# The file to be parsed, /etc/passwd could be defned as a 
# variable to search other files however the formatting of 
# the table (line spacing, columns etc) is heavily dependant on 
# the file being searched so that remains hard-coded.
#
# The search parameters however can be both varied and user 
# defined. 
#
# See UserAccountsAdvanced for a version
# where the user can choose which field to search from a 
# menu and then what string to search for. 
#
# See UserAccountsAdvanced2 that further enhances this by
# exporting the awk command to a separate .awk file and
# running each case with the user defined parameters. 
# 
# Author: David Wager
# Date created: 6 August 2024
# Last Edited: 9 August 2024 
# ----------------------------------------------------
      
 
# Title

echo -e "\033[032m\n/bin/bash Shell Records in '/etc/passwd':" 
 
# set File Separator to ":" and search for shell field "bin/bash"

awk -F":" '$7 == "/bin/bash" ' /etc/passwd |

# Formats piped output of previous into a coloured table

 awk -F":" '
    
    BEGIN {     
        print "_____________________________________________________________________________________________"; 
        print "| \033[34mUser Name\033[0m           | \033[34mUser ID\033[0m | \033[34mGroup ID\033[0m | \033[34mHome\033[0m                      | \033[34mShell\033[0m              |"; 
        print "|_____________________|_________|__________|___________________________|____________________|";
    } 
   
    { 
        printf("| \033[33m%-19s\033[0m | \033[35m%-7s\033[0m | \033[35m%-8s\033[0m | \033[35m%-25s\033[0m | \033[35m%-18s\033[0m |\n", $1, $3, $4, $6, $7);             
    } 
      
    END {   
        print "_____________________________________________________________________________________________";  
        print "" 
    }'

exit 0     
					
      
					