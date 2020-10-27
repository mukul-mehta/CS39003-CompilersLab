#include <stdio.h>

int GCD (int, int);
int GCD4 (int, int, int, int);

int main()
{
    int a = 45, b = 99, c = 18, d = 180, result;
    
    result = GCD4 (a, b, c, d);

    printf ("\nGCD of %d, %d, %d and %d is: %d", 
                                        a, b, c, d, result);

    printf ("\n");
    
    return 0;
}

int GCD4 (int n1, int n2, int n3, int n4)
{
    int t1, t2, t3;

    t1 = GCD (n1, n2);
    t2 = GCD (n3, n4);
    t3 = GCD (t1, t2);

    return t3;
}

int GCD (int num1, int num2)
{
    int temp;

    while (num1 % num2 != 0)
    {
        temp = num1 % num2;
        num1 = num2;
        num2 = temp;
    }

    return num2;
}
