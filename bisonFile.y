%{
#include <stdio.h>
#include <stdlib.h>
extern int nb_ligne;
extern int nb_clmn;

char currentType[20];
%}

/* UPDATE: suppression de end */

%token <str> idf String
%token <entier> cst entier
%token <numvrg> real

%token  pvg v dp_egale 
%token plus moins mult divis supegale infegale supr inf equi nonqui
%token keyword AO AF POU PFER keywordIF keywordELSE keywordENDIF
%token Dp write mainpr kw_dec kw_body kw_begin kw_end 
%token For from to step Do whil
%token crochetOUV crochetFER 
%type <str> type

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
    | 
;

DECnormale:
    idf partieidf Dp type pvg  {
        
        if (estDejaDeclare($1)) {
            printf("Erreur ligne %d: '%s' is declared \n", nb_ligne, $1);
        } else {
            declarerVariableFinale($1, currentType);
        }
    };

DECvecteur:
    idf crochetOUV cst crochetFER Dp type pvg {
        // verifier si la variable a ete declaree
        if (!estDejaDeclare($1)) {
            printf("Erreur semantique  ligne %d: '%s' not declared\n", nb_ligne, $1);
        }
        
        
        declarerTableauFinal($1, currentType, $3);
        
    }
;

type:
      entier { strcpy(currentType, "Entier"); }
    | real { strcpy(currentType, "Reel"); }
;

partieidf:
      v idf partieidf
      {
        if (estDejaDeclare($2)) {
            printf("Erreur semantique ligne %d: '%s' is declared \n", nb_ligne, $2);
        } else {
            declarerVariableFinale($2, currentType);
        }
    }
    | 
;

PartieInstructions:
      Instruction PartieInstructions
    | 
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
    idf crochetOUV idfORcst crochetFER {
        // verifier si la variable a ete declaree
        if (!estDejaDeclare($1)) {
            printf("Erreur semantique  ligne %d: '%s' not declared\n", nb_ligne, $1);
        }
        
    }
;


FoneE:
      idf  {
        // verifier si la variable a ete declaree
        if (!estDejaDeclare($1)) {
            printf("Erreur semantique  ligne %d: '%s' not declared\n", nb_ligne, $1);
        }
        
    }
    | cst
    | vect
;


Fone:
      idf {
        // verifier si la variable a ete declaree
        if (!estDejaDeclare($1)) {
            printf("Erreur semantique  ligne %d: '%s' not declared\n", nb_ligne, $1);
        }
        
    }
    | cst
    | vect
;

idfORcst:
      idf {
        // verifier si la variable a ete declaree
        if (!estDejaDeclare($1)) {
            printf("Erreur semantique  ligne %d: '%s' not declared\n", nb_ligne, $1);
        }
        
    }
    | cst
;


Next:
      opp FoneE Next
    | divis cst   
        {
            if ($2 == 0) {
                printf("Erreur : division par zero !\n");
                
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
    PartieInstructions AF {
        // verifier si la variable a ete declaree
        if (!estDejaDeclare($2)) {
            printf("Erreur semantique  ligne %d: '%s' not declared\n", nb_ligne, $2);
        }
        
    }
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

