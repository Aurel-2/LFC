%{
	#include <stdio.h>
%}
%s CROCHETS
%%
Environnement		{printf("Environnement\n");}
NewTypeAgent		{printf("NewTypeAgent\n");}
NewAgent		{printf("NewAgent\n");}
NewContexte		{printf("NewContexte\n");}
int			{printf("Type d'attribut : %s\n",yytext);}
double			{printf("Type d'attribut : %s\n",yytext);}
char		 	{printf("Type d'attribut : %s\n",yytext);}
string			{printf("Type d'attribut : %s\n",yytext);}
boolean			{printf("Type d'attribut : %s\n",yytext);}
TRUE|FALSE		{printf("Booléen : %s\n",yytext);}
[a-zA-Z][a-zA-Z0-9_]*	{printf("Identificateur : %s\n",yytext);}
"["			{printf("Crochet ouvrant\n");BEGIN CROCHETS;}
"]"			{printf("Crochet fermant\n");BEGIN INITIAL;}
","			{printf("Virgule\n");}
"{"			{printf("Accolade ouvrante\n");}
"}"			{printf("Accolade fermante\n");}
":"			{printf("Deux-points\n");}
[1-9][0-9]*		{printf("Nombre entier : %s\n",yytext);}
"="			{printf("Egal\n");}
<INITIAL>[-+]?[0-9]+(","[0-9]+)?	{printf("Nombre réel : %s\n",yytext);}
\"[^"]+\"		{printf("Chaîne de caractères : %s\n",yytext);}
['].[']			{printf("Caractère : %s\n",yytext);}
(\n|\r\n|" ")+		;
.			{printf("Erreur lexicale. Caractère %s non reconnu\n",yytext);}