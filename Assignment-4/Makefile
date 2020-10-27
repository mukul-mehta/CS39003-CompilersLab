####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 4    ####
####################################

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
