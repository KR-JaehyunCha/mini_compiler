/*
    What is lexer.l file?

    1) Reads the C code.
    2) Analyzes each code (keyword, variable, numbers, etc.) and changes it to a token.
    3) Outputs the token or passes it to the Parser.
*/

/*
    Example Input Code:

        int x = 5 + 10;

    Expected Lexer Output:

        KEYWORD(int)
        IDENTIFIER(x)
        SYMBOL(=)
        NUMBER(5)
        SYMBOL(+)
        NUMBER(10)
        SYMBOL(;)
*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

// yywrap()을 직접 정의하여 오류 해결
int yywrap() {
    return 1;  // 기본적으로 입력이 끝났음을 의미
}
%}

%%

"int"         { return INT; }
"return"      { return RETURN; }

[0-9]+           { yylval.num = atoi(yytext); return NUMBER; }  
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }

[ \t\r\n]+       { /* Ignore whitespace */ }
"//".*           { /* Ignore single-line comments */ }
"/\*([^*]|\*+[^*/])*\*+/" { /* Ignore multi-line comments */ }

"+"           { return PLUS; }
"-"           { return MINUS; }
"*"           { return STAR; }
"/"           { return SLASH; }
"="           { return EQUAL; }
";"           { return SEMICOLON; }
"("           { return LPAREN; }
")"           { return RPAREN; }
"{"           { return LBRACE; }
"}"           { return RBRACE; }

.             { printf("UNKNOWN(%s)\n", yytext); return UNKNOWN; }

%%
