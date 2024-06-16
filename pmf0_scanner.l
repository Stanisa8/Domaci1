%{
#include <stdio.h>
#include "pmf0_parser.tab.h"

int yycolumn = 1;
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;

%}

%option noyywrap
%option yylineno

%%
"let"       { printf("Token: T_Let\n"); return T_Let; }
"in"        { printf("Token: T_In\n"); return T_In; }
"end"       { printf("Token: T_End\n"); return T_End; }
"then"      { printf("Token: T_Then\n"); return T_Then; }
"fi"        { printf("Token: T_Fi\n"); return T_Fi; }
"do"        { printf("Token: T_Do\n"); return T_Do; }
"read"      { printf("Token: T_Read\n"); return T_Read; }
"write"     { printf("Token: T_Write\n"); return T_Write; }
"if"        { printf("Token: T_If\n"); return T_If; }
"else"      { printf("Token: T_Else\n"); return T_Else; }
"while"     { printf("Token: T_While\n"); return T_While; }
"return"    { printf("Token: T_Return\n"); return T_Return; }
"for"       { printf("Token: T_For\n"); return T_For; }
"foreach"   { printf("Token: T_Foreach\n"); return T_Foreach; }
"switch"    { printf("Token: T_Switch\n"); return T_Switch; }
"case"      { printf("Token: T_Case\n"); return T_Case; }
"default"   { printf("Token: T_Default\n"); return T_Default; }
"break"     { printf("Token: T_Break\n"); return T_Break; }
"continue"  { printf("Token: T_Continue\n"); return T_Continue; }
"this"      { printf("Token: T_This\n"); return T_This; }
"int"       { printf("Token: T_Int\n"); return T_Int; }
"double"    { printf("Token: T_Double\n"); return T_Double; }
"char"      { printf("Token: T_Char\n"); return T_Char; }
"string"    { printf("Token: T_String\n"); return T_String; }
"bool"      { printf("Token: T_Bool\n"); return T_Bool; }
"void"      { printf("Token: T_Void\n"); return T_Void; }
"enum"      { printf("Token: T_Enum\n"); return T_Enum; }
"and"       { printf("Token: T_And\n"); return T_And; }
"or"        { printf("Token: T_Or\n"); return T_Or; }
"not"       { printf("Token: T_Not\n"); return T_Not; }
"true"      { printf("Token: T_Bool_Const\n"); yylval.val_bool = 1; return T_Bool_Const; }
"false"     { printf("Token: T_Bool_Const\n"); yylval.val_bool = 0; return T_Bool_Const; }

"\/\/".*$        { /* Ignore single-line comments */ }
\/\*([^*]|(\*+[^*/]))*\*+\/       { /* Ignore multi-line comments */ }

[a-zA-Z][a-zA-Z0-9_]{0,30} { yylval.identifier = strdup(yytext); return T_Identifier; }
[0-9]+                    { yylval.val_int = atoi(yytext); return T_Int_Const; }
(0x|0X)[0-9A-Fa-f]+       { yylval.val_int = strtol(yytext, NULL, 16); return T_Int_Const; }
[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?     { yylval.val_double = atof(yytext); return T_Double_Const; }
[0-9]+[eE][+-]?[0-9]+    { fprintf(stderr, "Error: Invalid double format: %s\n", yytext); return T_Error; }

\"(\\[^\n]|[^"\n\\])*\" { yylval.identifier = strdup(yytext); return T_String_Const; }         
\"([^"\n\\]|\\[^\n])*   { fprintf(stderr, "Error: Invalid string format %d: %s\n", yylineno, yytext); return T_Error; }

"+"         { printf("Token: T_Plus\n"); return T_Plus; }
"-"         { printf("Token: T_Minus\n"); return T_Minus; }
"*"         { printf("Token: T_Asterisk\n"); return T_Asterisk; }
"/"         { printf("Token: T_Slash\n"); return T_Slash; }
"%"         { printf("Token: T_Percent\n"); return T_Percent; }
"\\"        { printf("Token: T_Backslash\n"); return T_Backslash; }
"<"         { printf("Token: T_Less\n"); return T_Less; }
"<="        { printf("Token: T_Less_EQ\n"); return T_Less_EQ; }
">"         { printf("Token: T_Greater\n"); return T_Greater; }
">="        { printf("Token: T_Greater_EQ\n"); return T_Greater_EQ; }
"="         { printf("Token: T_Assign\n"); return T_Assign; }
"=="        { printf("Token: T_Equal\n"); return T_Equal; }
"!="        { printf("Token: T_Not_Equal\n"); return T_Not_Equal; }
"&&"        { printf("Token: T_And\n"); return T_And; }
"||"        { printf("Token: T_Or\n"); return T_Or; }
"!"         { printf("Token: T_Not\n"); return T_Not; }
";"         { printf("Token: T_Semicolon\n"); return T_Semicolon; }
","         { printf("Token: T_Comma\n"); return T_Comma; }
"."         { printf("Token: T_Dot\n"); return T_Dot; }
"("         { printf("Token: T_Lparen\n"); return T_Lparen; }
")"         { printf("Token: T_Rparen\n"); return T_Rparen; }
[ \t\n]+    { /* Ignore whitespace */ }
.           {  }

%%
