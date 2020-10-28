# Assignment - 4 (Parser for TinyC)

<hr>

The objective of the assignment is write a bison specification to define the tokens used and writing a grammar for the `tinyC` language as given in the assignment

The grammar and token definitions are inside of `ass4_18CS10033.y`.The file `ass4_18CS10033.c` takes the `ass4_18CS10033_test.c` file and parses it to generate all terminal symbols using the production rules given

All compilation was done on a machine running GNU/Linux on the x86_64 platform using `gcc`

To build the program, there is a Makefile which can be run by invoking `make`

```makefile
a.out: lex.yy.o y.tab.o ass4_18CS10033.o
	gcc lex.yy.o y.tab.o ass4_18CS10033.o -lfl

ass4_18CS10033.o: ass4_18CS10033.c
	gcc -c ass4_18CS10033.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.c: ass4_18CS10033.l y.tab.h
	flex ass4_18CS10033.l

y.tab.c: ass4_18CS10033.y
	yacc -dtv ass4_18CS10033.y -Wnone -Wno-empty-rule

y.tab.h: ass4_18CS10033.y
	yacc -dtv ass4_18CS10033.y -Wnone -Wno-empty-rule

clean:
	rm -f lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass4_18CS10033.o y.output a.out

test:
	./a.out < ass4_18CS10033_test.c

ass4_18CS10033.c:
	touch ass4_18CS10033.c
```

Running `make` followed by `make test` will print all symbols to STDOUT

