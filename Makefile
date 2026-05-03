all:
	bison -d parser.y
	flex lexer.l
	gcc lex.yy.c parser.tab.c -o parser

run:
	./parser < test/valid.txt

clean:
	rm -f parser lex.yy.c parser.tab.c parser.tab.h