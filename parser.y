%{
    #include <stdio.h>
    #include <stdlib.h>

    void yyerror(const char *s);
    int yylex();
%}

%token TASK RUN EVERY DAY AT AFTER IF SUCCESS IDENTIFIER STRING TIME

%%

program:
    tasks
;

tasks:
    tasks task
    | task
;

task:
    TASK IDENTIFIER RUN STRING schedule dependency condition
;

schedule:
    EVERY DAY AT TIME
;
 
dependency:
    AFTER IDENTIFIER
    | /* empty */
;

condition:
    IF SUCCESS
    | /* empty */
;

%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    printf("Parsing started...\n");
    yyparse();
    printf("Parsing completed.\n");
    return 0;
}
