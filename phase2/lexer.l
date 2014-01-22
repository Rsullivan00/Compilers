%{
/*
 * File:	lexer.l
 *
 * Description:	This file contains the flex description for the lexical
 *		analyzer for Simple C.
 */

# include <string>
# include <iostream>
# include "lexer.h"
# include "tokens.h"

using namespace std;

static void printToken(const string &label);
static void ignoreComment();
%}

%option nounput noyywrap
%%

"/*"				{ignoreComment();}

"auto"				{return AUTO;}
"break"				{return BREAK;}
"case"				{return CASE;}
"char"				{return CHAR;}
"const"				{return CONST;}
"continue"			{return CONTINUE;}
"default"			{return DEFAULT;}
"do"				{return DO;}
"double"			{return DOUBLE;}
"else"				{return ELSE;}
"enum"				{return ENUM;}
"extern"			{return EXTERN;}
"float"				{return FLOAT;}
"for"				{return FOR;}
"goto"				{return GOTO;}
"if"				{return IF;}
"int"				{return INT;}
"long"				{return LONG;}
"register"			{return REGISTER;}
"return"			{return RETURN;}
"short"				{return SHORT;}
"signed"			{return SIGNED;}
"sizeof"			{return SIZEOF;}
"static"			{return STATIC;}
"struct"			{return STRUCT;}
"switch"			{return SWITCH;}
"typedef"			{return TYPEDEF;}
"union"				{return UNION;}
"unsigned"			{return UNSIGNED;}
"void"				{return VOID;}
"volatile"			{return VOLATILE;}
"while"				{return WHILE;}

"||"				{return OROR;}
"&&"				{return ANDAND;}
"=="				{return EQUALEQUAL;}
"!="				{return NOTEQUAL;}
"<="				{return LESSTHANEQUAL;}
">="				{return GREATERTHANEQUAL;}
"++"				{return PLUSPLUS;}
"--"				{return MINUSMINUS;}
"->"				{return ARROW;}
[-=<>+*/%&!()\[\]{};:.,]	{return *yytext;}

0[0-7]*				{return NUM;}
[1-9][0-9]*			{return NUM;}
0[xX][0-9a-fA-F]+		{return NUM;}
[a-zA-Z_][a-zA-Z_0-9]*		{return ID;}
\"(\\.|[^\\\n"])*\"		{return STRING;}

\n+				{yylineno += yyleng;}
[ \t]+				{/* ignored */}
.				{/* ignored */}

%%

/*
 * Function:	ignoreComment
 *
 * Description:	Ignore a comment after recognizing its beginning.
 */

static void ignoreComment()
{
    int c1, c2;


    while ((c1 = yyinput()) != 0) {
	while (c1 == '*') {
	    if ((c2 = yyinput()) == '/' || c2 == 0)
		return;

	    c1 = c2;
	}

	if (c1 == '\n')
	    yylineno ++;
    }

    if (c1 == 0)
	report("unterminated comment");
}

/*
 * Function:	printToken
 *
 * Description:	Print the current lexeme prefixed by a label.
 */

static void printToken(const string &label)
{
    cout << label << " " << yytext << endl;
}

