/*
####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 4    ####
####################################
*/

/*
    This file takes the input code and checks if
    it is syntatically correct and parses it according
    to production rules defined in the assignment
*/

#include "y.tab.h"
#include <stdio.h>

extern int yyparse();

int main()
{
    yyparse();
    return 0;
}