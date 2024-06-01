/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PMF0_PARSER_TAB_H_INCLUDED
# define YY_YY_PMF0_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_Int_Const = 258,             /* T_Int_Const  */
    T_Double_Const = 259,          /* T_Double_Const  */
    T_String_Const = 260,          /* T_String_Const  */
    T_Bool_Const = 261,            /* T_Bool_Const  */
    T_Let = 262,                   /* T_Let  */
    T_In = 263,                    /* T_In  */
    T_End = 264,                   /* T_End  */
    T_Then = 265,                  /* T_Then  */
    T_Fi = 266,                    /* T_Fi  */
    T_Do = 267,                    /* T_Do  */
    T_Read = 268,                  /* T_Read  */
    T_Write = 269,                 /* T_Write  */
    T_If = 270,                    /* T_If  */
    T_Else = 271,                  /* T_Else  */
    T_While = 272,                 /* T_While  */
    T_Return = 273,                /* T_Return  */
    T_For = 274,                   /* T_For  */
    T_Foreach = 275,               /* T_Foreach  */
    T_Switch = 276,                /* T_Switch  */
    T_Case = 277,                  /* T_Case  */
    T_Default = 278,               /* T_Default  */
    T_Break = 279,                 /* T_Break  */
    T_Continue = 280,              /* T_Continue  */
    T_This = 281,                  /* T_This  */
    T_Skip = 282,                  /* T_Skip  */
    T_Int = 283,                   /* T_Int  */
    T_Double = 284,                /* T_Double  */
    T_Char = 285,                  /* T_Char  */
    T_String = 286,                /* T_String  */
    T_Bool = 287,                  /* T_Bool  */
    T_Void = 288,                  /* T_Void  */
    T_Enum = 289,                  /* T_Enum  */
    T_And = 290,                   /* T_And  */
    T_Or = 291,                    /* T_Or  */
    T_Not = 292,                   /* T_Not  */
    T_Identifier = 293,            /* T_Identifier  */
    T_Plus = 294,                  /* T_Plus  */
    T_Minus = 295,                 /* T_Minus  */
    T_Asterisk = 296,              /* T_Asterisk  */
    T_Slash = 297,                 /* T_Slash  */
    T_Percent = 298,               /* T_Percent  */
    T_Backslash = 299,             /* T_Backslash  */
    T_Less = 300,                  /* T_Less  */
    T_Less_EQ = 301,               /* T_Less_EQ  */
    T_Greater = 302,               /* T_Greater  */
    T_Greater_EQ = 303,            /* T_Greater_EQ  */
    T_Assign = 304,                /* T_Assign  */
    T_Equal = 305,                 /* T_Equal  */
    T_Not_Equal = 306,             /* T_Not_Equal  */
    T_Semicolon = 307,             /* T_Semicolon  */
    T_Comma = 308,                 /* T_Comma  */
    T_Dot = 309,                   /* T_Dot  */
    T_Lparen = 310,                /* T_Lparen  */
    T_Rparen = 311,                /* T_Rparen  */
    T_Error = 312,                 /* T_Error  */
    T_Unknown = 313                /* T_Unknown  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "pmf0_parser.y"

    int val_int;
    double val_double;
    char *val_string;
    int val_bool;

#line 129 "pmf0_parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;

int yyparse (void);


#endif /* !YY_YY_PMF0_PARSER_TAB_H_INCLUDED  */
