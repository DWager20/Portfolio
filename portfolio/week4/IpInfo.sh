#!/bin/bash

# ----------------------------------------------------
# Title: IP Info
#
# Description:
# Uses sed command to take input from ifconfig command
# and only out put the ipV4 address lines with some
# cosmetic improvements for readability
#
# Author: David Wager
# Date created: 31 July 2024
# Last Edited: 31 July 2024 
# ----------------------------------------------------
    
#get info about networking from the ifconfig command 
      
net_info="$(ifconfig)" 
      
#parse out the ip address lines using sed 
      
addresses=$(echo "$net_info" | sed -n '/inet / { 
      
s/inet/IP Address:/ 
      
s/netmask/\n\t\tSubnet Mask:/ 
      
s/broadcast/\n\t\tBroadcast Address:/ 
      
p 
      
}') 
      
#format output 
      
echo -e "IP addresses on this computer are:\n$addresses" 

exit 0
     
					