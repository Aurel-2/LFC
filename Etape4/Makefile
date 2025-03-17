
y.tab.c: projet.yacc
	yacc projet.yacc

y.tab.h: projet.yacc
	yacc -d projet.yacc

lex.yy.c: projet.lex
	lex projet.lex

lex.yy.o: lex.yy.c y.tab.h
	gcc -Wall -c lex.yy.c

analyseur: y.tab.c lex.yy.o
	gcc -Wall y.tab.c lex.yy.o -lfl -o analyseur

clear:
	rm -f y.tab.h y.tab.c lex.yy.c *.o analyseur