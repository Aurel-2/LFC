%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(char *s);
%}

%union {
    int ival;
    double rval;
    char *str;
}


%token <str> IDF
%token <ival> INT
%token <rval> REEL
%token <str> CH
%token <str> CAR
%token <str> BOOL
%token <str> NTYPA
%token <str> NAG
%token <str> NCT
%token <str> ENV
%token <str> DPT
%token <str> TINT
%token <str> TDOUBL
%token <str> TCAR
%token <str> TCH
%token <str> TBOOL
%token <str> AO
%token <str> AF
%token <str> VG
%token <str> EG
%token <str> CO
%token <str> CF

%start Program


%%

Program:
    decla_env suite_prog
    ;

decla_env:
    ENV IDF CO INT VG INT CF
    ;

suite_prog:
    instruction
    | instruction suite_prog
    ;

instruction:
    new_typ_agent
    | new_agent
    | new_context
    ;

new_typ_agent:
    NTYPA IDF AO liste_decla_attributs AF
    ;

liste_decla_attributs:
    decla_attribut
    | decla_attribut VG liste_decla_attributs
    ;

decla_attribut:
    IDF DPT type_attribut
    ;

type_attribut:
    TINT
    | TDOUBL
    | TCAR
    | TCH
    | TBOOL
    ;

new_agent:
    NAG IDF DPT IDF CO INT VG INT CF AO liste_affect_attributs AF
    ;

liste_affect_attributs:
    affect_attribut
    | affect_attribut VG liste_affect_attributs
    ;

affect_attribut:
    IDF EG valeur_attribut
    ;

valeur_attribut:
    INT
    | REEL
    | CH
    | CAR
    | BOOL
    ;

new_context:
    NCT IDF CO INT CF
    | NCT IDF CO INT VG INT VG INT VG INT CF
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}
