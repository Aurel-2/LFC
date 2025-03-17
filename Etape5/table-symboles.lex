%{
    #include <stdio.h>
    #include <stdlib.h> 
    #include <string.h> 

    // Déclaration de variables et structures globales
    char tableau2[100];
    int indice = 0;

    typedef struct
    {
        char* type[1000];
        int pos[1000];
        int len[1000];
        char* modele[1000]; 
    } tableau1;

    tableau1* tab1;

    // Fonction de vérification et d'enregistrement des informations
    int verification(char* text, char* type) 
    {
        if (indice == 0)
        {
            tab1->type[indice] = type;
            tab1->pos[indice] = 0;
            tab1->len[indice] = strlen(text);
        } 
        else 
        {
            for (int i = 0; i < indice; i++)
            {
                // Vérification si le texte est déjà présent dans tableau2
                if (strstr(tableau2, text))
                {
                    break;
                } 
                else  
                {
                    tab1->type[indice] = type;
                    tab1->pos[indice] = tab1->pos[indice-1] + tab1->len[indice-1];
                    tab1->len[indice] = strlen(text);
                }
            }
        }
        strcat(tableau2, text);  // Concaténer le texte dans tableau2
        indice++;
        return indice - 1;
    }
%}

%start INITIAL

%%

/* Règles Lex */

/* Types d'agents et contextes */
Environnement           { printf("Environnement\n"); }
NewTypeAgent           { printf("NewTypeAgent\n"); }
NewAgent               { printf("NewAgent\n"); }
NewContexte            { printf("NewContexte\n"); }

/* Types de données */
int                    { printf("Type d'attribut : %s\n", yytext); }
double                 { printf("Type d'attribut : %s\n", yytext); }
char                   { printf("Type d'attribut : %s\n", yytext); }
string                 { printf("Type d'attribut : %s\n", yytext); }
boolean                { printf("Type d'attribut : %s\n", yytext); }

/* Booléens */
TRUE|FALSE             { 
                            printf("Booléen : %s\n", yytext);
                            verification(yytext, "bool");
                        }

/* Identificateurs */
[a-zA-Z][a-zA-Z0-9_]*  { 
                            printf("Identificateur : %s\n", yytext);
                            verification(yytext, "idf");
                        }

/* Symboles */
"["                    { printf("Crochet ouvrant\n"); BEGIN CROCHETS; }
"]"                    { printf("Crochet fermant\n"); BEGIN INITIAL; }
","                    { printf("Virgule\n"); }
"{"                    { printf("Accolade ouvrante\n"); }
"}"                    { printf("Accolade fermante\n"); }
"="                    { printf("Egal\n"); }
":"                    { printf("Deux-points\n"); }

/* Nombres */
[1-9][0-9]*            { 
                            printf("Nombre entier : %s\n", yytext);
                            verification(yytext, "ent");
                        }

<INITIAL>[-+]?[0-9]+(","[0-9]+)? 
                        { 
                            printf("Nombre réel : %s\n", yytext);
                            verification(yytext, "reel");
                        }

/* Chaînes de caractères */
\"[^"]+\"              { 
                            printf("Chaîne de caractères : %s\n", yytext);
                            verification(yytext, "chaine");
                        }

/* Caractères */
['].[']                { 
                            printf("Caractère : %s\n", yytext);
                            verification(yytext, "caract");
                        }

/* Espaces blancs et retours à la ligne (ignorer) */
(\n|\r\n|" ")+         ;

/* Erreurs lexicales */
.                       { 
                            printf("Erreur lexicale. Caractère %s non reconnu\n", yytext);
                        }

%%

/* Fonction de wrapping */
int yywrap()
{
    for (int i = 0; i < 100; i++)
    {
        printf("%s ", tab1->type[i]);
        printf("%d ", tab1->pos[i]);
        printf("%d \n", tab1->len[i]);
    }
    printf("Tableau 2 : %s\n", tableau2);
}

/* Fonction principale */
int main()
{
    tab1 = malloc(sizeof(tableau1));  // Allocation dynamique de mémoire
    if (!tab1) 
    {
        fprintf(stderr, "Erreur d'allocation mémoire\n");
        return 1;
    }

    yylex();  // Lancer l'analyse lexicale
    return 0;
}
