%{
#include <stdio.h>
#include <stdlib.h>
#include "bisonFile.tab.h"
#include "ST.h"

extern YYSTYPE yylval;

int nb_ligne = 1;
int nb_clmn = 1;
%}

/* -- Partie : Expressions régulières -- */
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}(_|{lettre}|{chiffre})*
COMM "##".*
cst {chiffre}+

%%  


"Entier"        { nb_clmn += yyleng; 
inserer(2, "Entier", "KW", "", "");
return entier; }

"Reel"          { nb_clmn += yyleng;
inserer(2, "Reel", "KW", "", "");
                    return real; }
"MainProgram"   { nb_clmn += yyleng; return mainpr; }
"Declaration"   { nb_clmn += yyleng; return kw_dec; }
"Body"          { nb_clmn += yyleng; return kw_body; }
"begin"         { nb_clmn += yyleng; return kw_begin; }
"end"           { nb_clmn += yyleng; return kw_end; }

"Write"         { nb_clmn += yyleng; return write; }

"If"            { nb_clmn += yyleng; return keywordIF; }
"Else"          { nb_clmn += yyleng; return keywordELSE; }
"EndIf"         { nb_clmn += yyleng; return keywordENDIF; }

"For"           { nb_clmn += yyleng; return For; }
"from"          { nb_clmn += yyleng; return from; }
"to"            { nb_clmn += yyleng; return to; }
"step"          { nb_clmn += yyleng; return step; }
"Do"            { nb_clmn += yyleng; return Do; }
"While"         { nb_clmn += yyleng; return whil; }


"["            { nb_clmn += yyleng; inserer(3, "[", "SEP", "", ""); return crochetOUV; } 
"]"            { nb_clmn += yyleng; inserer(3, "]", "SEP", "", ""); return crochetFER; } 
";"             { nb_clmn += yyleng; inserer(3, ";", "SEP", "", ""); return pvg; } 
","             { nb_clmn += yyleng; inserer(3, ",", "SEP", "", ""); return v; } 
":="            { nb_clmn += yyleng; return dp_egale; }
"+"             { nb_clmn += yyleng; return plus; }
"-"             { nb_clmn += yyleng; return moins; }
"*"             { nb_clmn += yyleng; return mult; }
"/"             { nb_clmn += yyleng; return divis; }
"("             { nb_clmn += yyleng; return POU; }
")"             { nb_clmn += yyleng; return PFER; }
":"             { nb_clmn += yyleng; return Dp; }
"{"             { nb_clmn += yyleng;inserer(3, "{", "SEP", "", ""); return AO; }
"}"             { nb_clmn += yyleng; inserer(3, "}", "SEP", "", ""); return AF; }


\"[^\"]*\"      { nb_clmn += yyleng; yylval.str = strdup(yytext); return String; }


">="            { nb_clmn += yyleng; return supegale; }
"<="            { nb_clmn += yyleng; return infegale; }
">"             { nb_clmn += yyleng; return supr; }
"<"             { nb_clmn += yyleng; return inf; }
"=="            { nb_clmn += yyleng; return equi; }
"!="            { nb_clmn += yyleng; return nonqui; }


"&&"            { nb_clmn += yyleng; return AND; }   
"||"            { nb_clmn += yyleng; return OR; }
"!"             { nb_clmn += yyleng; return NEG; }


{cst}           { nb_clmn += yyleng; yylval.entier = atoi(yytext); 
inserer(1, "", "", "CONST", yytext); 
        return cst; }
{IDF}           { nb_clmn += yyleng;
inserer(1, yytext, "IDF", "IDF", "");
 yylval.str = strdup(yytext); return idf; }


{COMM}          { nb_clmn += yyleng; }


\n              { nb_ligne++; nb_clmn = 1; }
[ \t]+          { nb_clmn += yyleng; }


. {
    printf("Erreur lexicale sur '%s' ligne %d col %d\n", yytext, nb_ligne, nb_clmn);
    nb_clmn += yyleng;
}

%%  


