%{
    #include "parser.tab.h"
    #include <stdio.h>
%}

%%

"TASK" { return TASK; }
"RUN" { return RUN; }
"EVERY" { return EVERY; }
"DAY" { return DAY; }
"AT" { return AT; }
"AFTER" { return AFTER; }
"IF" { return IF; }
"SUCCESS" { return SUCCESS; }

\"[^\"]*\"   { return STRING; }


[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }

[ \t\n]     ;

.           { printf("Lexical Error: Unknown character %s\n", yytext); }

%%