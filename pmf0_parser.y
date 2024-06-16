%{
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "pmf0_parser.tab.h"

extern int yylex();
void yyerror(const char *msg);

%}

%locations

%union {
    int val_int;
    char* identifier;
    int val_bool;
    double val_double;
}

%token <val_int> T_Int_Const
%token <val_double> T_Double_Const
%token <identifier> T_String_Const
%token <identifier> T_Identifier
%token <val_bool> T_Bool_Const

%type<val_int> expr 

%token T_Let T_In T_End T_Then T_Fi T_Do T_Read T_Write T_If T_Else T_While T_Return
%token T_For T_Foreach T_Switch T_Case T_Default T_Break T_Continue T_This T_Skip
%token T_Int T_Double T_Char T_String T_Bool T_Void T_Enum
%token T_And T_Or T_Not
%token T_Plus T_Minus T_Asterisk T_Slash T_Percent T_Backslash
%token T_Less T_Less_EQ T_Greater T_Greater_EQ
%token T_Assign T_Equal T_Not_Equal
%token T_Semicolon T_Comma T_Dot T_Lparen T_Rparen
%token T_Error T_Unknown

%left T_Plus T_Minus
%left T_Asterisk T_Slash T_Percent
%left T_And T_Or

%nonassoc T_Less T_Less_EQ T_Greater T_Greater_EQ
%nonassoc T_Equal T_Not_Equal
%nonassoc T_Assign

%right T_Not

%%

program : T_Let declarations T_In command_sequence T_End                         
;

declarations: 
      declaration T_Semicolon declarations
    | declaration T_Semicolon
    ;

declaration: T_Int ident_decl
    | T_Double ident_decl
    | T_String ident_decl
    | T_Bool ident_decl
    | T_Int Id_seq_with_init
    | T_Double Id_seq_with_init
    | T_String Id_seq_with_init
    | T_Bool Id_seq_with_init
;  

ident_decl: T_Identifier T_Comma ident_decl
    | T_Identifier
;

Id_seq_with_init : T_Identifier T_Assign expr T_Comma Id_seq_with_init
    | T_Identifier T_Assign expr
;

command_sequence: 
      command_sequence command
    | command
    ;

command: 
      T_Skip T_Semicolon
    | T_Identifier T_Assign expr T_Semicolon
    | T_If expr T_Then command_sequence T_Else command_sequence T_Fi T_Semicolon
    | T_While expr T_Do command_sequence T_End T_Semicolon
    | T_Read T_Identifier T_Semicolon
    | T_Write expr T_Semicolon
    | T_String_Const T_Semicolon
    ;

expr: 
      expr T_Or expr                        { $$ = $1 || $3; }
    | expr T_Assign expr                    { $$ = $3; }
    | expr T_Less expr                      { $$ = $1 < $3; }
    | expr T_Greater expr                   { $$ = $1 > $3; }
    | expr T_Plus expr                      { $$ = $1 + $3; }
    | expr T_Minus expr                     { $$ = $1 - $3; }
    | expr T_Asterisk expr                  { $$ = $1 * $3; }
    | expr T_Slash expr                     { $$ = $1 / $3; }
    | expr T_Percent expr                   { $$ = $1 % $3; }
    | expr T_Greater_EQ expr                { $$ = $1 >= $3; }
    | expr T_Less_EQ expr                   { $$ = $1 <= $3; }
    | expr T_Equal expr                     { $$ = $1 == $3; }
    | expr T_Not_Equal expr                 { $$ = $1 != $3; }
    | T_Not expr                            { $$ = !$2; }
    | expr T_And expr                       { $$ = $1 && $3; }
    | T_Lparen expr T_Rparen                { $$ = $2; }
    | T_Int_Const                           { $$ = $1; }
    | T_Double_Const                        { $$ = $1; }
    | T_String_Const                        { $$ = atoi($1); }  
    | T_Identifier                          { $$ = atoi($1); }  
    | T_Bool_Const                          { $$ = $1; }
;

%%

int main() {
    int res = yyparse(); 
    if (res == 0) {
        printf("Parsing successful.\n");
    } else {
        printf("Parsing failed.\n"); 
    }
    return 0; 
}

void yyerror(const char *msg) {
    fprintf(stderr, "The error is at position (%d, %d), please check. -> %s\n", yylloc.first_line, yylloc.first_column, msg);
}
