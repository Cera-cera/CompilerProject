#include <stddef.h>   // pour NULL, size_t
#include <string.h>   // pour strcpy, strcmp
#include <stdlib.h>   // pour malloc, atoi, free
#include <stdio.h>    


typedef struct {
    
    char name[20];
    char code[20];
    char type[20];
    char val[20];
} TypeTS;

typedef struct {
    
    char nomEntite[20];
    char Code[20];
} TypeSM;

typedef struct NodeTS {
    TypeTS data;
    struct NodeTS *next;
} NodeTS;

typedef struct NodeSM {
    TypeSM data;
    struct NodeSM *next;
} NodeSM;         

NodeTS *TS_head = NULL;     // Table des symboles (IDF + CONST)
NodeSM *TM_head = NULL;     // Table des mots-cles
NodeSM *TSep_head = NULL;   // Table des separateurs

NodeTS* createNodeTS(TypeTS val) {
    NodeTS *n = (NodeTS*)malloc(sizeof(NodeTS));
    n->data = val;
    n->next = NULL;
    return n;
}
NodeSM* createNodeSM(TypeSM val) {
    NodeSM *n = (NodeSM*)malloc(sizeof(NodeSM));
    n->data = val;
    n->next = NULL;
    return n;
}

int rechercherTS(char entite[]) {
    NodeTS *temp = TS_head;
    int pos = 0;

    while (temp != NULL) {
        if (strcmp(entite, temp->data.name) == 0)
            return pos;
        temp = temp->next;
        pos++;
    }
    return -1;
}

int rechercherSM(NodeSM *head, char entite[]) {
    NodeSM *temp = head;
    int pos = 0;

    while (temp != NULL) {
        if (strcmp(entite, temp->data.nomEntite) == 0)
            return pos;
        temp = temp->next;
        pos++;
    }
    return -1;
}

void inserer(int tableType, char name[], char code[], char type[], char val[]) {
    switch(tableType) {
        case 1: // TS : identifiants ou constantes
        {
            if (rechercherTS(name) != -1)
                return; // déjà existant

            TypeTS t;
            strcpy(t.name, name);
            strcpy(t.code, code);
            strcpy(t.type, type);
            strcpy(t.val, val);

            NodeTS *newNode = createNodeTS(t);
            newNode->next = TS_head;
            TS_head = newNode;
            break;
        }
        case 2: // TM  mots-clés
        {
            if (rechercherSM(TM_head, name) != -1)
                return;

            TypeSM t;
            strcpy(t.nomEntite, name);
            strcpy(t.Code, code);

            NodeSM *n = createNodeSM(t);
            n->next = TM_head;
            TM_head = n;
            break;
        }
        case 3: // TSep 
        {
            if (rechercherSM(TSep_head, name) != -1)
                return;

            TypeSM t;
            strcpy(t.nomEntite, name);
            strcpy(t.Code, code);

            NodeSM *n = createNodeSM(t);
            n->next = TSep_head;
            TSep_head = n;
            break;
        }
        default:
            printf("Erreur : tableType inconnu\n");
    }
}

void afficher() {
    NodeTS *tempTS;
    NodeSM *tempSM;

    printf("/-------------Table des  IDF---------------/\n");
    printf("____________________________________________________________________\n");
    printf("\t| Nom_Entite | Code_Entite | Type_Entite | Val_Entite\n");
    printf("____________________________________________________________________\n");

    tempTS = TS_head;
    while (tempTS != NULL) {
        printf("\t| %10s | %12s | %12s | %12s\n",
               tempTS->data.name,
               tempTS->data.code,
               tempTS->data.type,
               tempTS->data.val);
        tempTS = tempTS->next;
    }

    printf("\n/--------------Table des  keywords-------------/\n");
    printf("_____________________________________\n");
    printf("\t| NomEntite | CodeEntite\n");
    printf("_____________________________________\n");

    tempSM = TM_head;
    while (tempSM != NULL) {
        printf("\t| %10s | %12s\n",
               tempSM->data.nomEntite,
               tempSM->data.Code);
        tempSM = tempSM->next;
    }

    printf("\n/---------------Table des SEP -------------------/\n");
    printf("_____________________________________\n");
    printf("\t| NomEntite | CodeEntite\n");
    printf("_____________________________________\n");

    tempSM = TSep_head;
    while (tempSM != NULL) {
        printf("\t| %10s | %12s\n",
               tempSM->data.nomEntite,
               tempSM->data.Code);
        tempSM = tempSM->next;
    }

    printf("\n");
}
