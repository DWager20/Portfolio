#!/bin/bash

# ----------------------------------------------------
# Title: IP Addresses Only
#
# Description:
# Takes output of IpInfo.sh and only prints lines
# containing "IP Address"
#
# Author: David Wager
# Date created: 31 July 2024
# Last Edited: 31 July 2024 
# ----------------------------------------------------

./IpInfo.sh | sed -n '/IP Address/ p'   

exit 0