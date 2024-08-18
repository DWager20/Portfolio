BEGIN {   
    print "_________________________________________________";   
    print "| \033[34mNo.\033[0m | \033[34mWhat was Compromised\033[0m                    |"; 
    print "|_____|_________________________________________|";     
} 
   
{ 
    if (NR > 1) {
        printf("| \033[33m%-3s\033[0m | \033[35m%-39s\033[0m |\n", NR-1, $1); 
    }
}
                        
END {    
    print "_________________________________________________";   
    print ""
}
