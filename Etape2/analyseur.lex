%{
    // TP3 Groupe 7
    //
    //Compilation
    //lex -v exemple0.lex
    //gcc -Wall lex.yy.c -o analyseur -lfl
#include <stdio.h>
%}
ENTIER ([1-9][0-9]*|0)

%START CROCHET HORS_CROCHET

%%

Environnement { printf("Environnement\n");
}

NewTypeAgent { printf("NewTypeAgent\n");
}

NewAgent { printf("NewAgent\n");
}

NewContexte { printf("NewContexte\n");
}

int { printf("Type d'attribut : int\n");
}

double { printf("Type d'attribut : double\n");
}

char { printf("Type d'attribut : char\n");
}

string { printf("Type d'attribut : string\n");
}

boolean { printf("Type d'attribut : boolean\n");
}

TRUE { printf("Booléen : TRUE\n");
}

FALSE { printf("Booléen : FALSE\n");
}

"[" { printf("Crochet ouvrant\n"); BEGIN CROCHET;
}

"]" { printf("Crochet fermant\n"); BEGIN HORS_CROCHET;
}

"{" { printf("Accolade ouvrante\n");
}

"}" { printf("Accolade fermante\n");
}

"," { printf("Virgule\n"); 
}

":" { printf("Deux-points\n"); 
}

"=" { printf("Egal\n"); 
}

[a-zA-Z]+[_a-zA-Z0-9]* { printf("Identificateur : %s\n", yytext); 
}

\"[^"]*\" { printf("Chaîne de caractères : %s\n", yytext);
}

\'.\' { printf("Caractère : %s\n", yytext);
}

<HORS_CROCHET>[+-]?[0-9]+(","[0-9]+)? { printf("Nombre réel : %s\n", yytext);
}

{ENTIER} { printf("Nombre entier : %s\n", yytext);
}

[ \t\n]+ ;

. { printf("Erreur lexicale, caractère %s non reconnu\n", yytext);
}
%%

int main() {
    BEGIN HORS_CROCHET;
    yylex();
    return 0;
}

