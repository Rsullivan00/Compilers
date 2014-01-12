%{
#include <string>
#include <iostream>

using namespace std;

int customPrint(const string &construct);
int processComment(const string &comment);
%}

KEYWORD auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while 

OPERATOR "="|"||"|"&&"|"=="|"!="|"<"|">"|"<="|">="|"+"|"-"|"*"|"/"|"%"|"&"|"!"|"++"|"--"|"->"|"("|")"|"["|"]"|"{"|"}"|";"|":"|"."|","

IDENTIFIER [a-zA-z_][a-zA-Z_0-9]*

HEXADECIMAL 0[xX][0-9a-fA-F]+

STRING ["]([^\n"]|[\"])*["]

%option noyywrap
%%
[ \t\n]+	{/* Do nothing with whitespace */}
[/][*]		{processComment(yytext);}
{KEYWORD}	{customPrint("keyword");}
{IDENTIFIER}	{customPrint("identifier");}
0|0[0-7]+	{customPrint("octal");}
[0-9]+		{customPrint("decimal");}
{HEXADECIMAL}	{customPrint("hexadecimal");}
{STRING}	{customPrint("string");}
{OPERATOR}	{customPrint("operator");}
%%

int customPrint(const string &construct) {
	cout << construct << ' ' << yytext << endl;
	return 0;
}

int processComment(const string &comment) {
	char character;
	while(true) {
		character = yyinput();
		while (character == '*') {
			character = yyinput();
			if (character == '/') {
				return 0;
			}
		}
	}	
}

int main() {
	yylex();
	return 0;
}
