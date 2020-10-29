# Assignment - 5

## Machine Independent Code Translation for TinyC

<hr>

The objective of the assignment is to write semantic actions in Bison to translate a TinyC program into an carray of 3-address quad’s, a supporting symbol table, and other auxiliary data structures. Since TAC is an Intermediate-Representation, it should be able to target any architecture (ARM/x86/x86_64) by incorporating enough information needed when generating target code



The grammar and token definitions are inside of `ass5_18CS10033_18CS30036.y`. The flex specifications are in `ass5_18CS10033_18CS30036.l`. With the `.y` and `.l` files, `yacc` and `bison` can generate a parser which will used later when running programs with our translation unit. The file `ass5_18CS10033_18CS30036_translator.h` contains all function prototypes, class and struct definitions used by our translator. Functions and classes defined here are used to augment the grammar in the `.y` file and perform operations such as emitting quads, backpatching, merging and so on. The file `ass5_18CS10033_18CS30036_translator.cxx` contains the actual definitions of the functions and class methods. There are functions to print the quadArray and symbolTable for the program which is running

All compilation was done on a machine running GNU/Linux on the x86_64 platform using `gcc`

To build the program, there is a Makefile which can be run by invoking `make`


The test inputs are given inside `./test-inputs`. On running `make test`, outputs are generated in `./test-outputs`. The outputs consist of the symbol table for the program and the Three-Address-Code representation

