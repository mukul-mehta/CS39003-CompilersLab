/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 6               ####
####################################
*/

/*
	This file contains the header for our library
    It has functions prototypes and declarations for error handling
*/

#ifndef _MYL_H
#define _MYL_H

#define ERR 1
#define OK 0
#define MAXSIZE 100

/*
    int printStr(char *)
    Prints a string of characters to STDOUT using an inline assembly system call
    ------------------
    Parameters:
        input: char * -> Input string
    Return:
        _:int         ->  Size of string printed
*/
int printStr(char *);

/*
    int printInt(int)
    Prints an integer to STDOUT (Without a following newline character) using an inline assembly system call
    ------------------
    Parameters:
        n: int -> Input integer
    Return:
        _:int  ->  Number of characters printed
*/
int printInt(int);

/*
    int readInt(int *eP)
    Reads an integer from STDIN using an inline assembly system call
    ------------------
    Parameters:
        eP: int* -> Error reporting. Set to 1 if error, else set to 0
    Return:
        _:int  ->  The integer read from STDIN
*/
int readInt(int *eP);

#endif
