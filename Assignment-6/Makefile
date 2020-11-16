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
	gcc -g -no-pie -Wall -c ass6_18CS10033_18CS30036.c

clean:
	rm -rf \
	test1 test2 test3 test4 test5 \
	lex.yy.c y.tab.h y.output y.tab.c \
	*.o *.s *.a *.out *.gch \
	test-outputs/* bin/*

ass6_18CS10033_18CS30036.c:
	touch ass6_18CS10033_18CS30036.c

run: libass6_18CS10033_18CS30036.a
	@mkdir -p test-outputs

	@echo "\nRunning Test Case 1\n"
	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test1.c > test-outputs/ass6_18CS10033_18CS30036_quad1.out
	mv output.s test-outputs/ass6_18CS10033_18CS30036_test1.s
	gcc -g -Wall  -c  test-outputs/ass6_18CS10033_18CS30036_test1.s -no-pie -o ass6_18CS10033_18CS30036_test1.o
	gcc -g -no-pie ass6_18CS10033_18CS30036_test1.o -o ./bin/test1 -L. -lass6_18CS10033_18CS30036

	@echo "\nRunning Test Case 2\n"
	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test2.c > test-outputs/ass6_18CS10033_18CS30036_quad2.out
	mv output.s test-outputs/ass6_18CS10033_18CS30036_test2.s
	gcc -g -Wall  -c  test-outputs/ass6_18CS10033_18CS30036_test2.s -no-pie -o ass6_18CS10033_18CS30036_test2.o
	gcc -g -no-pie ass6_18CS10033_18CS30036_test2.o -o ./bin/test2 -L. -lass6_18CS10033_18CS30036

	@echo "\nRunning Test Case 3\n"
	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test3.c > test-outputs/ass6_18CS10033_18CS30036_quad3.out
	mv output.s test-outputs/ass6_18CS10033_18CS30036_test3.s
	gcc -g -Wall  -c  test-outputs/ass6_18CS10033_18CS30036_test3.s -no-pie -o ass6_18CS10033_18CS30036_test3.o
	gcc -g -no-pie ass6_18CS10033_18CS30036_test3.o -o ./bin/test3 -L. -lass6_18CS10033_18CS30036

	@echo "\nRunning Test Case 4\n"
	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test4.c > test-outputs/ass6_18CS10033_18CS30036_quad4.out
	mv output.s test-outputs/ass6_18CS10033_18CS30036_test4.s
	gcc -g -Wall  -c  test-outputs/ass6_18CS10033_18CS30036_test4.s -no-pie -o ass6_18CS10033_18CS30036_test4.o
	gcc -g -no-pie ass6_18CS10033_18CS30036_test4.o -o ./bin/test4 -L. -lass6_18CS10033_18CS30036

	@echo "\nRunning Test Case 5\n"
	./bin/yatcc < test-inputs/ass6_18CS10033_18CS30036_test5.c > test-outputs/ass6_18CS10033_18CS30036_quad5.out
	mv output.s test-outputs/ass6_18CS10033_18CS30036_test5.s
	gcc -g -Wall  -c  test-outputs/ass6_18CS10033_18CS30036_test5.s -no-pie -o ass6_18CS10033_18CS30036_test5.o
	gcc -g -no-pie ass6_18CS10033_18CS30036_test5.o -o ./bin/test5 -L. -lass6_18CS10033_18CS30036

	@mv *_test*.o test-outputs/

	@echo "\nAll Binaries for test files can be found in bin/"
