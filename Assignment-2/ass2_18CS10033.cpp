/*
####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 2    ####
####################################
*/

#include "toylib.h"

int printStringUpper(char *input)
{
    /*
    Prints a string with all characters in upper case
    Args:
        input: char * -> Input string
    Return:
        status: size of string printed
    */

    int count = 0;
    int t = 0;

    while (input[count] != '\0')
    {
        count++;
    }

    char output[count];
    while (input[t] != '\0')
    {
        if (input[t] >= 'a' && input[t] <= 'z')
        {
            output[t] = input[t] - 32;
        }
        else
        {
            output[t] = input[t];
        }

        t++;
    }

    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(output), "d"(count));

    return count;
}

int readHexInteger(int *n)
{
    /*
    Reads a hexadecimal number and loads the corresponding decimal value inside of the given argument to function

    Args:
        n: int * -> The integer pointer to load the hexadecimal number into
    Return:
        status: GOOD or BAD depending on whether the input was valid or invalid respectively
    */

    char *input = new char[100];

    int bCount = 20;
    int count = 0;
    int decValue = 0;

    bool flag = false;

    /* Inline Assembly commands to invoke system call to read STDIN into the char array 'input' */
    __asm__ __volatile__(
        "movl $0, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(input), "d"(bCount));

    /* If 1st digit is '-', it is a negative number. Set a bool flag to true */
    if (input[count] == '-')
    {
        flag = true;
        count++;
    }

    while (input[count] != ' ' && input[count] != '\t' && input[count] != '\n' && input[count] != '\r')
    {
        /* Convert from hexadecimal to decimal*/
        decValue *= 16;

        if (input[count] >= '0' && input[count] <= '9')
            decValue += (int)(input[count] - '0');

        else if (input[count] >= 'A' && input[count] <= 'F')
            decValue += (10 + (int)(input[count] - 'A'));

        else
            return BAD;

        count++;
    }

    if (flag)
        decValue *= -1;

    *n = decValue;
    return GOOD;
}

int printHexInteger(int n)
{
    /*
    Prints a hexadecimal string of a given decimal value

    Args:
        n: int -> The decimal integer to convert to hexadecimal and print to STDOUT
    Return:
        count: int -> The number of digits printed if success and return BAD if invalid
   */

    char *hexVal = new char[100];
    int count = 0;
    bool flag = false;

    if (!n)
    {
        hexVal[count] = '0';
        count++;
    }

    else
    {
        if (n < 0)
        {
            flag = true;
            n *= -1;
        }

        while (n)
        {
            /*Converting decimal to base-16*/
            int temp = n % 16;
            if (temp <= 9)
            {
                hexVal[count] = temp + '0';
                count++;
            }
            else
            {
                hexVal[count] = temp - 10 + 'A';
                count++;
            }
            n /= 16;
        }

        /* Handle negative numbers */
        if (flag)
        {
            hexVal[count] = '-';
            count++;
        }

        /* Set digits to correct places of output */
        for (int i = 0; i < count / 2; i++)
        {
            char t = hexVal[count - i - 1];
            hexVal[count - i - 1] = hexVal[i];
            hexVal[i] = t;
        }
    }

    /* Inline Assembly commands to invoke system call to print hexVal to STDOUT */
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(hexVal), "d"(count));

    return count;
}

int readFloat(float *f)
{
    /*
    Reads a floating point value and load corresponding number into the pointer given as argument to function

    Args:
        f: float * -> The float pointer to load value into
    Return:
        status: int -> GOOD or BAD if input is valid or invalid respectively
   */

    char *input = new char[100];
    int bCount = 20;
    int count = 0;

    bool flag = false;
    bool dec = false;

    float floatVal = 0;
    float unit = 1.0;

    /* Inline Assembly commands to invoke system call to read STDIN into the char array 'input' */
    __asm__ __volatile__(
        "movl $0, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(input), "d"(bCount));

    /* Check if input is a negative number */
    if (input[count] == '-')
    {
        flag = true;
        count++;
    }

    while (input[count] != ' ' && input[count] != '\t' && input[count] != '\n' && input[count] != '\r')
    {
        if ((((int)input[count] - '0' > 9) || ((int)input[count] - '0' < 0)) && (input[count] != '.'))
            return BAD;

        if (input[count] == '.' && dec)
            return BAD;

        if (input[count] == '.')
        {
            dec = true;
        }
        else if (dec)
        {
            /* Load all digits after the decimal point */
            unit *= 10;
            floatVal += (float)(input[count] - '0') / unit;
        }
        else
        {
            floatVal *= 10.0;
            floatVal += (float)(input[count] - '0');
        }

        count++;
    }

    /* Set value to negative if flag is set */
    if (flag)
        floatVal *= -1;

    *f = floatVal;
    return GOOD;
}

int printFloat(float f)
{
    /*
    Prints a float string of a given float value to STDOUT

    Args:
        f: float -> The float integer to print to STDOUT
    Return:
        count: int -> The number of digits printed if success and return BAD if invalid
   */

    char *floatVal = new char[100];
    int count = 0;

    bool flag = false;

    if (f < 0)
    {
        f *= -1;
        flag = true;
    }

    int intPart = (int)f;
    float decPart = f - intPart;

    if (f == 0)
    {
        floatVal[count] = '0';
        count++;

        floatVal[count] = '.';
        count++;

        floatVal[count] = '0';
        count++;
    }
    else
    {
        while ((decPart - (int)decPart) != 0)
        {
            decPart *= 10;
        }

        int t = (int)decPart;

        /* Loading digits after decimal place */
        if (t <= 0)
        {
            floatVal[count] = '0';
            count++;
        }
        else
        {
            while (t)
            {
                floatVal[count] = (t % 10) + '0';
                t /= 10;
                count++;
            }
        }
        floatVal[count] = '.';
        count++;

        if (intPart <= 0)
        {
            floatVal[count] = '0';
            count++;
        }
        else
        {
            while (intPart)
            {
                floatVal[count] = (intPart % 10) + '0';
                intPart /= 10;
                count++;
            }
        }

        /* handles negative no.s */
        if (flag)
        {
            floatVal[count] = '-';
            count++;
        }

        /* Set digits to correct places of output */
        for (int i = 0; i < count / 2; i++)
        {
            char t = floatVal[count - i - 1];
            floatVal[count - i - 1] = floatVal[i];
            floatVal[i] = t;
        }
    }
    /* Inline Assembly commands to invoke system call to print floatVal to STDOUT */
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(floatVal), "d"(count));

    return count;
}
