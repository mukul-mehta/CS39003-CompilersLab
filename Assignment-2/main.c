/*
####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 2    ####
####################################
*/

/*
Driver code to test the functions defined
in the created library
*/

#include "toylib.h"
#include<stdio.h>

int main()
{
    printf("#### Testing printStringUpper Function ####\n");
    printStringUpper("Yo Yo Yo, this is a hacky print String function ya boi wrote\n");

    printf("#### Testing readHexInteger and printHexInteger Functions ####\n");
    int n;
    int status;

    printf("Enter a (valid or invalid) hexadecimal number: \n");
    status = readHexInteger(&n);

    if (status == GOOD)
    {
        printHexInteger(n);
        printf("\n");
    }
    else
    {
        printStringUpper("The given number is not a valid hexadecimal\n");
    }

    printf("#### Testing readFloat and printFloat Functions ####\n");

    float f;
    printf("Enter a (valid or invalid) floating point value: \n");
    status = readFloat(&f);

    if (status == GOOD)
    {
        printFloat(f);
        printf("\n");
    }

    else
    {
        printf("The given number is not a valid floating point value\n");
    }

    printf("#### Done with testing. If you're here, everything worked. Yaaaay! ####\n");
    return 0;
}