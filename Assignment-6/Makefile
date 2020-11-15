yatcc: y.tab.o lex.yy.o ass6_18CS10033_18CS30036_translator.o ass6_18CS10033_18CS30036_target_translator.o
	@mkdir -p bin
	g++ -g ass6_18CS10033_18CS30036_translator.o ass6_18CS10033_18CS30036_target_translator.o lex.yy.o y.tab.o -lfl -o bin/yatcc
	@echo "\nMake process successful. The binary generated is ./bin/yatcc (Yet-Another-TinyC-Compiler)"
lex.yy.c: ass6_18CS10033_18CS30036.l
	flex ass6_18CS10033_18CS30036.l

y.tab.c: ass6_18CS10033_18CS30036.y
	yacc -dtv ass6_18CS10033_18CS30036.y -Wno-empty-rule -Wno-yacc -Wno-conflicts-rr

y.tab.h: ass6_18CS10033_18CS30036.y
	yacc -dtv ass6_18CS10033_18CS30036.y -Wno-empty-rule -Wno-yacc -Wno-conflicts-rr

ass6_18CS10033_18CS30036_target_translator.o: ass6_18CS10033_18CS30036_target_translator.cxx
	g++ -g -c -no-pie ass6_18CS10033_18CS30036_target_translator.cxx
ass6_18CS10033_18CS30036_translator.o: ass6_18CS10033_18CS30036_translator.cxx
	g++ -g -c -no-pie ass6_18CS10033_18CS30036_translator.cxx
lex.yy.o: lex.yy.c
	g++ -g -c -no-pie lex.yy.c
y.tab.o:    y.tab.c
	g++ -g -no-pie -DYYDEBUG -c y.tab.c
libass6_18CS10033_18CS30036.a: ass6_18CS10033_18CS30036.o
	ar -rcs libass6_18CS10033_18CS30036.a ass6_18CS10033_18CS30036.o

ass6_18CS10033_18CS30036.o: ass6_18CS10033_18CS30036.c myl.h
	gcc -Wall  -c ass6_18CS10033_18CS30036.c -no-pie
clean:
	rm -rf \
	test1 test2 test3 test4 test5 \
	lex.yy.c y.tab.h y.output y.tab.c \
	*.o *.s *.a *.out *.gch \
	test-outputs/* bin/*

test1: ass6_18CS10033_18CS30036_test1.o libass6_18CS10033_18CS30036.a
	gcc -g -no-pie ass6_18CS10033_18CS30036_test1.o -o ./bin/test1 -L. -lass6_18CS10033_18CS30036
ass6_18CS10033_18CS30036_test1.o: test-outputs/ass6_18CS10033_18CS30036_test1.s myl.h
	gcc -g -Wall  -c  test-outputs/ass6_18CS10033_18CS30036_test1.s -no-pie -o ass6_18CS10033_18CS30036_test1.o

test2: ass6_18CS10033_18CS30036_test2.o libass6_18CS10033_18CS30036.a
	gcc -g  -no-pie ass6_18CS10033_18CS30036_test2.o -o ./bin/test2 -L. -lass6_18CS10033_18CS30036
ass6_18CS10033_18CS30036_test2.o: test-outputs/ass6_18CS10033_18CS30036_test2.s myl.h
	gcc -g -Wall -c test-outputs/ass6_18CS10033_18CS30036_test2.s -no-pie

test3: ass6_18CS10033_18CS30036_test3.o libass6_18CS10033_18CS30036.a
	gcc -g  -no-pie ass6_18CS10033_18CS30036_test3.o -o ./bin/test3 -L. -lass6_18CS10033_18CS30036
ass6_18CS10033_18CS30036_test3.o: test-outputs/ass6_18CS10033_18CS30036_test3.s myl.h
	gcc -g -Wall  -c test-outputs/ass6_18CS10033_18CS30036_test3.s -no-pie

test4: ass6_18CS10033_18CS30036_test4.o libass6_18CS10033_18CS30036.a
	gcc -g  -no-pie ass6_18CS10033_18CS30036_test4.o -o ./bin/test4 -L. -lass6_18CS10033_18CS30036
ass6_18CS10033_18CS30036_test4.o: test-outputs/ass6_18CS10033_18CS30036_test4.s myl.h
	gcc -g -Wall  -c test-outputs/ass6_18CS10033_18CS30036_test4.s -no-pie

test5: ass6_18CS10033_18CS30036_test5.o libass6_18CS10033_18CS30036.a
	gcc -g  -no-pie ass6_18CS10033_18CS30036_test5.o -o ./bin/test5 -L. -lass6_18CS10033_18CS30036
ass6_18CS10033_18CS30036_test5.o: test-outputs/ass6_18CS10033_18CS30036_test5.s myl.h
	gcc -g -Wall -c test-outputs/ass6_18CS10033_18CS30036_test5.s -no-pie

pointerhandling:pointerhandling.o libass6_18CS10033_18CS30036.a
	gcc -g  -no-pie pointerhandling.o -o ./bin/pointerhandling -L. -lass6_18CS10033_18CS30036
pointerhandling.o: test-outputs/pointerhandling.s myl.h
	gcc -g -no-pie -Wall -c test-outputs/pointerhandling.s

ass6_18CS10033_18CS30036.c:
	touch ass6_18CS10033_18CS30036.c

run:
	mkdir -p test-outputs

	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test1.c > test-outputs/ass6_18CS10033_18CS30036_quad1.out

	mv output.s test-outputs/ass6_18CS10033_18CS30036_test1.s

	make test1

	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test2.c > test-outputs/ass6_18CS10033_18CS30036_quad2.out

	mv output.s test-outputs/ass6_18CS10033_18CS30036_test2.s

	make test2

	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test3.c > test-outputs/ass6_18CS10033_18CS30036_quad3.out

	mv output.s test-outputs/ass6_18CS10033_18CS30036_test3.s

	make test3

	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test4.c > test-outputs/ass6_18CS10033_18CS30036_quad4.out

	mv output.s test-outputs/ass6_18CS10033_18CS30036_test4.s

	make test4

	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test5.c > test-outputs/ass6_18CS10033_18CS30036_quad5.out

	mv output.s test-outputs/ass6_18CS10033_18CS30036_test5.s

	make test5

	./bin/yatcc < test-inputs/pointerhandling.c > test-outputs/pointerhandling.out

	mv output.s test-outputs/pointerhandling.s

	make pointerhandling
	#Below are the individual commands for compiling each test file
	#./test1
	#./test2
	#./test3
	#./test4
	#./test5
	#./pointerhandling

	@mv *_test*.o test-outputs
