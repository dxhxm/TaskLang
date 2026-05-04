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
"WEEK"      { return WEEK; }
"AT"        { return AT; }
"AFTER"     { return AFTER; }
"IF"        { return IF; }
"SUCCESS"   { return SUCCESS; }

"{"         { return '{'; }
"}"         { return '}'; }

\"[^\"]*\" {
    yylval.str = strdup(yytext);
    return STRING;
}

[0-9]{2}":"[0-9]{2} {
    yylval.str = strdup(yytext);
    return TIME;
}

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.str = strdup(yytext);
    return IDENTIFIER;
}

\n          { line_num++; }
[ \t\r]     { /* skip whitespace */ }

.           { fprintf(stderr, "Lexical Error at line %d: unknown character '%s'\n", line_num, yytext); }

%%

int yywrap() {
    return 1;
}