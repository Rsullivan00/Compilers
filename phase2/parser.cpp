# include <iostream>
# include <string>
# include <stdio.h>
# include "lexer.h"
# include "tokens.h"
# include "outputs.h"

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
		print("or");
	}	
}

void logicalAnd() {
	equality();

	while(lookahead == ANDAND) {
		match(ANDAND);
		equality();
		print("and");
	}	
}

void equality() {
	int prev;
	relational();

	while(lookahead == EQUALEQUAL || lookahead == NOTEQUAL) {
		prev = lookahead;
		match(lookahead);
		relational();
		print(prev);
	}
}

void relational() {
	int prev;
	additive();

	while(lookahead == LESSTHANEQUAL || lookahead == GREATERTHANEQUAL ||
		lookahead == '<' || lookahead == '>') {
		prev = lookahead;
		match(lookahead);
		additive();
		print(prev);
	}
}

void additive() {
	int prev;
	multiplicative();

	while(lookahead == '+' || lookahead == '-') {
		prev = lookahead;
		match(lookahead);
		multiplicative();
		print(prev);
	}
}

void multiplicative() {
	int prev;
	unary();

	while(lookahead == '*' || lookahead == '/' || lookahead == '%') {
		prev = lookahead;
		match(lookahead);
		unary();
		print(prev);
	}
}

void unary() {
	int prev;

	while(lookahead == '!' || lookahead == '-' || lookahead == '&' ||
		lookahead == '*' || lookahead == SIZEOF) {
		prev = lookahead;
		match(lookahead);
		printUnary(prev);
	}

	index();	
}

void index() {
	while(lookahead == '[') {
		match('[');
		expression();
		match(']');
		print("index");
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
			report("Parsing error.");
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

