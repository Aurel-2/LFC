%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(char *s);

char listeNotes[100]; 
%}

%union {
    int valeur;
    char chaine[3];  
}

%token <chaine> note
%token <valeur> duree
%token <valeur> repet
%type <valeur> R
%type <valeur> G
%type <valeur> P

%start P

%%

P : R duree note G {
    $$ = $2 * $1 + $4;
    for (int i = 0; i < $1; ++i) {
        strcat(listeNotes, $3);
    }
    printf("Durée totale %d\nListe des notes : %s\n", $$, listeNotes);
}
;

G : R duree note G {
    $$ = $2 * $1 + $4;
    for (int i = 0; i < $1; ++i) {
        strcat(listeNotes, $3);
    }
}
| { $$ = 0; }
;

R : repet {
    $$ = yylval.valeur;
}
| { $$ = 1; }
;

%%

int main() {
    listeNotes[0] = '\0';
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Erreur %s\n", s);
}
