# Assignment - 3 (Lexer for TinyC)

<hr>

The objective of the assignment is write a small `flex` specification for a subset of the `TinyC` language and test it by generating tokens for a given input test file

The flex specification is inside `ass3_18CS10033.l`. The lexer is called from the file `ass3_18CS10033.c` which calls the `yylex()` function to tokenize the test file

All compilation was done on a machine running GNU/Linux on the x86_64 platform using `gcc`

To build the program, there is a Makefile which can be run by invoking `make`

```makefile
a.out : lex.yy.c ass3_18CS10033.c
	gcc ass3_18CS10033.c lex.yy.c -lfl

lex.yy.c : ass3_18CS10033.l
	flex ass3_18CS10033.l

clean :
	rm -f a.out lex.yy.c ass3_18CS10033_results.txt

test : a.out
	./a.out	> ass3_18CS10033_results.txt

ass3_18CS10033.c:
	touch ass3_18CS10033.c
```

Running `make` generates tokens for the file `ass3_18CS10033_test.c` and prints them out to STDOUT

