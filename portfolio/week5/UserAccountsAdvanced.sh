#!/bin/bash

# ----------------------------------------------------
# Title: User Accounts Advanced
#
# Description:
# Uses awk to find lines in /etc/passwd that the user first 
# chooses from a menu which field to search and then inputs
# a string to search for. The file to be searched /etc/passwd
# is hard coded as the formating of the output is heavily
# dependant of how the input file is structured. 
#
# The column choice menu input is error checked but the input
# string is not. The assumption is that if it doesn't match a string 
# in that particular column it would output an empty table. There is
# no protection from malicious code injection.

# Author: David Wager
# Date created: 7 August 2024
# Last Edited: 9 August 2024 
# ----------------------------------------------------
      
 
# Title

echo -e "\033[032m\nRecord Search in '/etc/passwd':" 

 
    until [ "$choice" = "7" ]; do
        echo -ne "\033[036m"   # Change text colour to cyan
       
        # Give menu options 
        echo -e "\nWhich record would you like to search?\n"
        echo "1. User Name"
        echo "2. User ID"
        echo "3. Group ID"
        echo "4. Home Directory"
        echo "5. Shell Directory"
        echo "6. Print all records"

        echo -ne "\033[0m"  # Change colour to white
        echo "7. Quit"
        echo -ne "\033[036m"  # Change colour to back to cyan
        echo ""
        # Get user selection
        read -rp "Enter choice (1-7): " choice

        echo -ne "\033[0m" # Change colour back to default 

        case "$choice" in
            "1")                 
                # User defined user name
                
                read -rp "Enter User Name to search: " userName

                # set File Separator to ":" and search for userName in User Name field

                awk -F":" -v uname="$userName" '$1==uname ' /etc/passwd |

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
                ;;
            "2")
                # User defined ID
                
                read -rp "Enter User ID to search: " user_ID

                # set File Separator to ":" and search for user_ID in User ID field

                awk -F":" -v uid="$user_ID" '$3==uid ' /etc/passwd |

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
                ;;
            "3")
                # User defined Group ID
                
                read -rp "Enter Group ID to search: " group_ID

                # set File Separator to ":" and search for userName in User Name field

                awk -F":" -v gid="$group_ID" '$4==gid ' /etc/passwd |

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
                ;;
            "4")
                # User defined Home directory

                read -rp "Enter home directory to search: " home

                # set File Separator to ":" and search for home in Home Directory field

                awk -F":" -v hm="$home" '$6==hm ' /etc/passwd |

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
                ;;
            "5")
                # User defined shell directory
                
                read -rp "Enter shell directory to search: " shell

                # set File Separator to ":" and search for shell in Shell Directory field

                awk -F":" -v sh="$shell" '$7==sh ' /etc/passwd |

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
                ;;
            6)  
                # Print all records

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
      
                    }' /etc/passwd 
                ;;              
            7)    
                exit 0
                ;;
            *)
                echo -ne "\033[031m" # Change colour to red for invalid input
                echo "Invalid selection!"
                echo -ne "\033[031m" # Change colour back to cyan for new input
                read -rp "Enter choice (1-7): " choice
                ;;
        esac

    done

exit 0
					
      
					