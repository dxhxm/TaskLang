%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(const char *s);
    int yylex();
    extern int line_num;

    #define MAX_TASKS 100

    char* task_list_store[MAX_TASKS];
    int task_count = 0;

    int task_exists(char* name) {
        for (int i = 0; i < task_count; i++) {
            if (strcmp(task_list_store[i], name) == 0) {
                return 1;
            }
        }
        return 0;
    }
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
    {
        if (task_exists($2)) {
            printf("Semantic Error: Duplicate task '%s'\n", $2);
        } else {
            task_list_store[task_count++] = strdup($2);
            printf("Task '%s' registered\n", $2);
        }
    }
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
    { printf("RUN command detected\n"); }
;

schedule_stmt:
    EVERY DAY AT TIME
    { printf("schedule: Daily task registered\n"); }
;

dependency_stmt:
    AFTER IDENTIFIER
    { printf("Dependency detected\n"); }
;

condition_stmt:
    IF SUCCESS
    { printf("Condition: Execute on success\n"); }
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