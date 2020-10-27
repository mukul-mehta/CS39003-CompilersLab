#include <stdio.h>

int main()
{
    int num1, num2, greater;

    num1 = 45;
    num2 = 68;
    if (num1 > num2)    greater = num1;
    else                greater = num2;

    printf("\nThe greater number is: %d", greater);

    return 0;
}
