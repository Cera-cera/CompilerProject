
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     idf = 258,
     pvg = 259,
     v = 260,
     dp_egale = 261,
     String = 262,
     plus = 263,
     moins = 264,
     mult = 265,
     divis = 266,
     supegale = 267,
     infegale = 268,
     supr = 269,
     inf = 270,
     equi = 271,
     nonqui = 272,
     keyword = 273,
     AO = 274,
     AF = 275,
     POU = 276,
     PFER = 277,
     keywordIF = 278,
     keywordELSE = 279,
     keywordENDIF = 280,
     Dp = 281,
     write = 282,
     mainpr = 283,
     kw_dec = 284,
     kw_body = 285,
     kw_begin = 286,
     kw_end = 287,
     entier = 288,
     real = 289,
     For = 290,
     from = 291,
     to = 292,
     step = 293,
     Do = 294,
     whil = 295,
     crochetOUV = 296,
     crochetFER = 297,
     cst = 298,
     AND = 299,
     OR = 300,
     NEG = 301
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 20 "bisonFile.y"

    int entier;
    char* str;
    float numvrg;



/* Line 1676 of yacc.c  */
#line 106 "bisonFile.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


