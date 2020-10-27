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
