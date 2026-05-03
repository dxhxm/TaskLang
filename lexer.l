%{
    #include "parser.tab.h"
    #include <stdio.h>
    #include <string.h>

    int line_num = 1;
%}

%%

"TASK"      { return TASK; }
"RUN"       { return RUN; }
"EVERY"     { return EVERY; }
"DAY"       { return DAY; }
"AT"        { return AT; }
"AFTER"     { return AFTER; }
"IF"        { return IF; }
"success"   { return SUCCESS; }

"{"         { return '{'; }
"}"         { return '}'; }

[0-9]{2}":"[0-9]{2}         { return TIME; }

\"[^\"]*\"                  { return STRING; }

[a-zA-Z_][a-zA-Z0-9_]*     { return IDENTIFIER; }

\n          { line_num++; }
[ \t\r]     { /* skip whitespace */ }

.           { fprintf(stderr, "Lexical Error at line %d: unknown character '%s'\n", line_num, yytext); }

%%

int yywrap() {
    return 1;
}