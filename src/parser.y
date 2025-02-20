%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Bring yylex from lexer.l
extern int yylex();
void yyerror(const char *s);
%}

/* YYSTYPE 정의 */
%union {
    int num;
    char *str;
}

/* Token */
%token INT RETURN
%token <str> IDENTIFIER
%token <num> NUMBER
%token PLUS MINUS STAR SLASH EQUAL SEMICOLON
%token LPAREN RPAREN LBRACE RBRACE
%token UNKNOWN

/* 연산자 우선순위 */
%left PLUS MINUS
%left STAR SLASH

%%

program:
    program statement
    | statement
    ;

statement:
    INT IDENTIFIER EQUAL NUMBER SEMICOLON  { printf("Variable Declaration: int %s = %d;\n", $2, $4); free($2); }
    | IDENTIFIER EQUAL NUMBER SEMICOLON     { printf("Assignment: %s = %d;\n", $1, $3); free($1); }
    | RETURN NUMBER SEMICOLON               { printf("Return Statement: return %d;\n", $2); }
    | LBRACE program RBRACE                 { printf("Block statement\n"); }
    ;

%%

/* Error */
void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    printf("Parsing Code...\n");
    yyparse();
    return 0;
}
