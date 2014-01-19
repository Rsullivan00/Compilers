# include <iostream>
# include <string>
# include <stdio.h>
# include "lexer.h"
# include "tokens.h"

using namespace std;

int lookahead;

void expression();
void logicalOr();
void logicalAnd();
void equality();
void relational();
void additive();
void multiplicative();
void unary();
void index();
void primary();
void match(int);

void expression(){
	logicalOr();
}

void logicalOr() {
	logicalAnd();

	while(lookahead == OROR) {
		match(OROR);
		logicalAnd();
	}	
}

void logicalAnd() {
	equality();

	while(lookahead == ANDAND) {
		match(ANDAND);
		equality();
	}	
}

void equality() {
	relational();

	while(lookahead == EQUALEQUAL || lookahead == NOTEQUAL) {
		match(lookahead);
		relational();
	}
}

void relational() {
	additive();

	while(lookahead == LESSTHANEQUAL || lookahead == GREATERTHANEQUAL ||
		lookahead == '<' || lookahead == '>') {
		match(lookahead);
		additive();
	}
}

void additive() {
	multiplicative();

	while(lookahead == '+' || lookahead == '-') {
		match(lookahead);
		multiplicative();
	}
}

void multiplicative() {
	unary();

	while(lookahead == '*' || lookahead == '/' || lookahead == '%') {
		match(lookahead);
		unary();
	}
}

void unary() {
	while(lookahead == '!' || lookahead == '-' || lookahead == '&' ||
		lookahead == '*' || lookahead == SIZEOF) {
		match(lookahead);
	}

	index();	
}

void index() {
	while(lookahead == '[') {
		match('[');
		expression();
		match(']');
	}

	primary();
}

void primary() {
	switch (lookahead) {
		case '(': 
			match('{');
			expression();
			match(')');
			break;
		case NUM:
			match(NUM);
			break;
		case ID:
			match(ID);
			break;
			if (lookahead == '(') {
				match('(');
				if (lookahead != ')') {
					expression();
				}
				match(')');
			}
			break;
		case STRING:
			match(STRING);
			break;
		default:
			report("Parsing error");
	}
} 

void expressionList() {
	expression();
	
	while (lookahead == ',') {
		match(',');
		expression();
	}
}


/*
 *  * Function:	report
 *   *
 *    * Description:	Report an error to the standard error prefixed with the
 *     *		line number.  We'll be using this a lot later with an
 *      *		optional string argument, but C++'s stupid streams don't do
 *       *		positional arguments, so we actually resort to snprintf.
 *        *		You just can't beat C for doing things down and dirty.
 *         */

void report(const string &str, const string &arg)
{
    	char buf[1000];

    	snprintf(buf, sizeof(buf), str.c_str(), arg.c_str());
    	cerr << "line " << yylineno << ": " << buf << endl;
}

void match(int t) {
	if (lookahead == t) {
		lookahead = yylex();
	} else { 
		report("Token not matched: ");			
	}
}


int main()
{
    	lookahead = yylex();
	expression();
    	return 0;
}

