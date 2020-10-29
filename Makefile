lexical_analysis: lexer.l lex.yy.c
	flex lexer.l
	gcc lex.yy.c -lfl -o date_analysis