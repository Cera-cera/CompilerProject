%{
#include <stdio.h>
#include <stdlib.h>
extern int nb_ligne;
extern int nb_clmn;
%}

/* UPDATE: suppression de end */
%token <str>idf pvg v dp_egale String
%token plus moins mult divis supegale infegale supr inf equi nonqui
%token keyword AO AF POU PFER keywordIF keywordELSE keywordENDIF
%token Dp write mainpr kw_dec kw_body kw_begin kw_end <entier>entier real
%token For from to step Do whil
%token crochetOUV crochetFER 
%token <entier>cst 
%token AND OR NEG

%start S

%union {
    int entier;
    char* str;
    float numvrg;
}

%%

S:
    mainpr idf pvg
    kw_dec PartieDeclarations
    kw_body kw_begin AO
    PartieInstructions AF
    kw_end
    {
        printf("\n\n--- Analyse syntaxique terminee avec succes ---\n");
    }
;

PartieDeclarations:
      DECnormale PartieDeclarations
    | DECvecteur PartieDeclarations
    | /* vide */
;

DECnormale:
    idf partieidf Dp type pvg ;

DECvecteur:
    idf crochetOUV cst crochetFER Dp type pvg ;

type:
      entier
    | real
;

partieidf:
      v idf partieidf
    | /* vide */
;

PartieInstructions:
      Instruction PartieInstructions
    | /* vide */
;

Instruction:
      AFF
    | WR
    | IF
    | FOR
    | WHILE
;

/* UPDATE: correction affectation */
AFF:
    FoneE dp_egale FoneE Next pvg
;

WR:
    write POU String PFER pvg
;

vect:
    idf crochetOUV idfORcst crochetFER
;


FoneE:
      idf
    | cst
    | vect
;


Fone:
      idf
    | cst
    | vect
;

idfORcst:
      idf
    | cst
;


Next:
      opp FoneE Next
    | divis cst   
        {
            if ($2 == 0) {
                printf("Erreur : division par zéro !\n");
                exit(1);
            }
        }
    | 
;

opp:
      plus
    | moins
    | mult
;

/*************** IF / ELSE ***************/
IF:
    keywordIF POU oppr PFER AO
    PartieInstructions AF
    partieELSE keywordENDIF pvg
;

partieELSE:
      keywordELSE AO PartieInstructions AF
    | 
;

oppr:
      opprComp
    | opprL
;

opprL:
      AND
    | OR
    | NEG
;

opprComp:
      expressionComp Comp expressionComp
;

Comp:
      supr | inf | supegale | infegale | equi | nonqui
;

expressionComp:
      Fone
    | POU Fone opp Fone PFER
;

/*************** FOR ***************/
FOR:
    For idf from Fone to Fone step Fone AO
    PartieInstructions AF
;

/*************** DO WHILE ***************/
WHILE:
    Do AO PartieInstructions AF
    whil POU oppr PFER pvg
;

%%

int main() {
    yyparse();
    printf ("\n ---Analyse sementique --- \n");
    printf("Table des symboles : \n");
    afficher();
    return 0;
}

int yyerror(const char *s) {
    printf("Erreur syntaxique ligne %d col %d : %s\n", nb_ligne, nb_clmn, s);
    return 0;
}

