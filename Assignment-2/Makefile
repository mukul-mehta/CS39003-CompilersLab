

a.out: main.o libass2_18CS10033.a
	g++ main.o -L. -lass2_18CS10033

main.o: main.c toylib.h
	g++ -Wall -c main.c

libass2_18CS10033.a: ass2_18CS10033.o
	ar -rcs libass2_18CS10033.a ass2_18CS10033.o

ass2_18CS10033.o: ass2_18CS10033.cpp toylib.h
	g++ -Wall -c ass2_18CS10033.cpp

clean:
	rm -f a.out main.o libass2_18CS10033.a ass2_18CS10033.o