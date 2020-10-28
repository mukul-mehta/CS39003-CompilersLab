# Assignment - 2 (Library for x86_64)

<hr>

The objective of the assignment is to build a library without using any functions from the C/C++ standard library. All I/O operations were done directly by invoking kernel sys calls using the `__asm__` directive

Following functions are present in the library (Defined in a header `toylib.h`)

- `int  printStringUpper  (char  *) ` -> Takes a `\0` terminated string and prints it in upper string. Return value is the number of characters printed excluding the terminating character
- `int readHexInteger (int *n)` -> Reads a hexadecimal integer in the `0x` format from STDIN and stores its decimal value in `n`. Returns GOOD on success and BAD on failure (GOOD and BAD are constants defined in the header)
- `int printHexInteger (int n)` -> Print the given (signed) decimal in hexadecimal form (including a minus sign). On success, return the number of characters printed. On failure, return BAD
- `int readFloat (float *f )` -> Read a floating point number and store it's value in `f`. Return GOOD or BAD on success or failure respectively
- `int  printFloat  (float  f )` -> Print the given floating point number `f`. The printed number must contain a decimal point (Even if it isn't needed). On success, return number of characters printed and on failure, return BAD 



All compilation was done on a machine running GNU/Linux on the x86_64 platform using `gcc`

To build the program, there is a Makefile which can be run by invoking `make`. It will create all objects and libraries needed to link properly and generate a binary executable `a.out`. The library functions can be tested by executing `a.out`, the code that invokes the library functions lives inside `main.c`

