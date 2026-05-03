all: parser

parser: lex.yy.c parser.tab.c
	gcc lex.yy.c parser.tab.c -o parser -L/opt/homebrew/Cellar/flex/2.6.4_2/lib -lfl

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

run:
	./parser < test/valid.txt

clean:
	rm -f parser lex.yy.c parser.tab.c parser.tab.h *.output