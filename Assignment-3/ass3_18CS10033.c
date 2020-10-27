/*
####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 3    ####
####################################
*/

/*
This file is called main.c because having the same
name for the .l and .c file results in multiple errors of the form
multiple definition of yylex etc
*/

#include <stdio.h>
#include "ass3_18CS10033.h"

extern int yylex();
extern char *yytext;

int main()
{
	extern FILE *yyin;

    char filename[24] = "./ass3_18CS10033_test.c";
	yyin = fopen(filename, "r"); /* Open the file which we need to tokenize */

	int token;
    while (token = yylex())
	{
		switch (token)
		{
			case KEYWORD:
				printf("<KEYWORD, %s>\n", yytext);
				break;

            case PUNCTUATOR:
				printf("<PUNCTUATOR, %s>\n", yytext);
				break;

			case IDENTIFIER:
				printf("<IDENTIFIER, %s>\n", yytext);
				break;

			case CONSTANT:
				printf("<CONSTANT, %s>\n", yytext);
				break;

			case STRING_LITERAL:
				printf("<STRING_LITERAL, %s>\n", yytext);
				break;

			default:
				break;
		}
	}

	fclose(yyin);
	return 0;
}