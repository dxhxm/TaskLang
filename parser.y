%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(const char *s);
    int yylex();
    extern int line_num;
%}

%token TASK RUN EVERY DAY AT AFTER IF SUCCESS
%token IDENTIFIER STRING TIME

%%

program:
    task_list
    { printf("\n--- EXECUTION COMPLETE ---\n"); }
;

task_list:
    task_list task
    | task
;

task:
    TASK IDENTIFIER '{' statements '}'
;

statements:
    statements statement
    | statement
;

statement:
    run_stmt
    | schedule_stmt
    | dependency_stmt
    | condition_stmt
;

run_stmt:
    RUN STRING
;

schedule_stmt:
    EVERY DAY AT TIME
;

dependency_stmt:
    AFTER IDENTIFIER
;

condition_stmt:
    IF SUCCESS
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error at line %d: %s\n", line_num, s);
}

int main() {
    printf("Parsing TaskLang++ input...\n\n--- EXECUTION START ---\n");
    yyparse();
    return 0;
}