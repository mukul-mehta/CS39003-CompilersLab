/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 6               ####
####################################
*/

#include "myl.h"

int printStr(char *input) {
    int count = 0;

    while (input[count] != '\0') {
        count++;
    }

    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(input), "d"(count));

    return count;
}

int printInt(int n) {
    char decVal[MAXSIZE];
    int count = 0;
    int flag = 1;

    if (!n) {
        decVal[count] = '0';
        count++;
    }

    else {
        if (n < 0) {
            flag = -1;
            n *= -1;
        }

        while (n) {
            int temp = n % 10;
            decVal[count++] = temp + '0';
            n /= 10;
        }

        /* Handle negative numbers */
        if (flag == -1) {
            decVal[count] = '-';
            count++;
        }

        /* Set digits to correct places of output */
        for (int i = 0; i < count / 2; i++) {
            char t = decVal[count - i - 1];
            decVal[count - i - 1] = decVal[i];
            decVal[i] = t;
        }
    }

    /* Inline Assembly commands to invoke system call to print hexVal to STDOUT */
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(decVal), "d"(count));

    return count;
}

int readInt(int *eP) {
    char input[MAXSIZE];

    for (int i = 0; i < MAXSIZE; i++) {
        input[i] = '0';
    }

    int count = 0;
    int decValue = 0;
    int flag = 1;

    /* Inline Assembly commands to invoke system call to read STDIN into the char array 'input' */
    __asm__ __volatile__(
        "movl $0, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(input), "d"(MAXSIZE));

    /* If 1st digit is '-', it is a negative number. Set a bool flag to true */
    if (input[count] == '-') {
        flag = -1;
        count++;
    }

    while (input[count] != ' ' && input[count] != '\t' && input[count] != '\n' && input[count] != '\r') {
        /* Convert from hexadecimal to decimal*/
        decValue *= 10;

        if (input[count] >= '0' && input[count] <= '9')
            decValue += (int)(input[count] - '0');

        else
            *eP = ERR;

        count++;
    }

    if (flag == -1)
        decValue *= -1;

    *eP = OK;
    return decValue;
}
