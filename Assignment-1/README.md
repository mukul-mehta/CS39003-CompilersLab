# Assignment - 1 (Annotating Assembly Code)

<hr>

The objective of the assignment is to generate assembly (`.s`) files for the following 2 C programs and annotating the generated assembly code to explain what each line does

The programs were compiled with the following command, to ensure no optimisation is done by GCC. All compilation was done on a machine running GNU/Linux on the x86_64 platform

```bash
gcc -Wall -O0 -S <FILENAME>
```



#### ass1a.c

```c
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
```



#### ass1b.c

```c
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
```

