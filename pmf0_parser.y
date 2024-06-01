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
    double val_double;
    char *val_string;
    int val_bool;
}

%token <val_int> T_Int_Const
%token <val_double> T_Double_Const
%token <val_string> T_String_Const 
%token <val_bool> T_Bool_Const

%token T_Let T_In T_End T_Then T_Fi T_Do T_Read T_Write T_If T_Else T_While T_Return
%token T_For T_Foreach T_Switch T_Case T_Default T_Break T_Continue T_This T_Skip
%token T_Int T_Double T_Char T_String T_Bool T_Void T_Enum
%token T_And T_Or T_Not
%token T_Identifier
%token T_Plus T_Minus T_Asterisk T_Slash T_Percent T_Backslash
%token T_Less T_Less_EQ T_Greater T_Greater_EQ
%token T_Assign T_Equal T_Not_Equal
%token T_Semicolon T_Comma T_Dot T_Lparen T_Rparen
%token T_Error T_Unknown

%type <val_int> int_expression
%type <val_double> double_expression
%type <val_bool> bool_expression
%type <val_string> string_expression

%left T_Plus T_Minus
%left T_Asterisk T_Slash T_Percent
%left T_And T_Or

%nonassoc T_Less T_Less_EQ T_Greater T_Greater_EQ
%nonassoc T_Equal T_Not_Equal
%nonassoc T_Assign

%right T_Not

%%
program:
    T_Let declarations T_In command_sequence T_End
  ;
  
declarations:
    /* Empty */
  | declarations type ident_decl T_Semicolon
  ;

ident_decl:
    identifier
  | ident_decl T_Comma identifier
  ;

type:
    T_Int
  | T_Double
  | T_Bool
  | T_String
  ;

identifier:
    T_Identifier
;

command_sequence:
    command
  | command_sequence T_Semicolon command
  ;

command:
    T_Skip T_Semicolon
  | identifier T_Assign expression T_Semicolon
  | T_If expression T_Then command_sequence T_Else command_sequence T_Fi T_Semicolon
  | T_While expression T_Do command_sequence T_End T_Semicolon
  | T_Read identifier T_Semicolon
  | T_Write expression T_Semicolon
  ;

expression:
    int_expression
  | double_expression
  | bool_expression
  | string_expression
  ;

int_expression:
    T_Int_Const  { $$ = $1; }
  | int_expression T_Plus int_expression   { $$ = $1 + $3; }
  | int_expression T_Minus int_expression  { $$ = $1 - $3; }
  | int_expression T_Asterisk int_expression { $$ = $1 * $3; }
  | int_expression T_Slash int_expression   { $$ = $1 / $3; }
  | int_expression T_Equal int_expression { $$ = ($1 == $3); }
  | int_expression T_Not_Equal int_expression { $$ = ($1 != $3); }
  | int_expression T_Less int_expression { $$ = ($1 < $3); }
  | int_expression T_Less_EQ int_expression { $$ = ($1 <= $3); }
  | int_expression T_Greater int_expression { $$ = ($1 > $3); }
  | int_expression T_Greater_EQ int_expression { $$ = ($1 >= $3); }
  | '(' int_expression ')'  { $$ = $2; }
  ;

double_expression:
    T_Double_Const  { $$ = $1; }
  | double_expression T_Plus double_expression   { $$ = $1 + $3; }
  | double_expression T_Minus double_expression  { $$ = $1 - $3; }
  | double_expression T_Asterisk double_expression { $$ = $1 * $3; }
  | double_expression T_Slash double_expression   { $$ = $1 / $3; }
  | '(' double_expression ')'                     { $$ = $2; }
  ;

bool_expression:
    T_Bool_Const { $$ = $1; }
  | bool_expression T_And bool_expression { $$ = $1 && $3; }
  | bool_expression T_Or bool_expression  { $$ = $1 || $3; }
  | T_Not bool_expression                 { $$ = !$2; }
  | '(' bool_expression ')'               { $$ = $2; }
  ;

string_expression:
    T_String_Const { $$ = strdup($1); }
  | string_expression T_Plus string_expression { $$ = strcat($1, $3); }
  | '(' string_expression ')' { $$ = $2; }
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
