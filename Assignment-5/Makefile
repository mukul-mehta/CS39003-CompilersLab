a.out: lex.yy.o y.tab.o ass5_18CS10033_18CS30036_translator.o
	g++ lex.yy.o y.tab.o ass5_18CS10033_18CS30036_translator.o -lfl

ass5_18CS10033_18CS30036_translator.o: ass5_18CS10033_18CS30036_translator.cxx ass5_18CS10033_18CS30036_translator.h
	g++ -c ass5_18CS10033_18CS30036_translator.h
	g++ -c ass5_18CS10033_18CS30036_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass5_18CS10033_18CS30036.l y.tab.h ass5_18CS10033_18CS30036_translator.h
	flex ass5_18CS10033_18CS30036.l

y.tab.c: ass5_18CS10033_18CS30036.y
	yacc -dtv ass5_18CS10033_18CS30036.y -Wno-empty-rule -Wno-yacc

y.tab.h: ass5_18CS10033_18CS30036.y
	yacc -dtv ass5_18CS10033_18CS30036.y -Wno-empty-rule -Wno-yacc

test: a.out
	@echo "\nTest Inputs are in ./test-inputs. Running on test files\n"
	./a.out < test-inputs/ass5_18CS10033_18CS30036_test1.c > test-outputs/ass5_18CS10033_18CS30036_quads1.out
	./a.out < test-inputs/ass5_18CS10033_18CS30036_test2.c > test-outputs/ass5_18CS10033_18CS30036_quads2.out
	./a.out < test-inputs/ass5_18CS10033_18CS30036_test3.c > test-outputs/ass5_18CS10033_18CS30036_quads3.out
	./a.out < test-inputs/ass5_18CS10033_18CS30036_test4.c > test-outputs/ass5_18CS10033_18CS30036_quads4.out
	./a.out < test-inputs/ass5_18CS10033_18CS30036_test5.c > test-outputs/ass5_18CS10033_18CS30036_quads5.out
	./a.out < test-inputs/ass5_18CS10033_18CS30036_test6.c > test-outputs/ass5_18CS10033_18CS30036_quads6.out
	@echo "\nTest outputs generated and written to ./test-outputs!\n"

clean:
	rm -f lex.yy.c y.tab.c y.tab.h y.output *.o a.out *.gch test-outputs/*_quads*.out
