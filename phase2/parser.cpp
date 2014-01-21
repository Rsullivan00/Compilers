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
void expressionList();
void statements();
void statement();
void declarations();
void declaration();
void declaratorList();
void declarator();
void specifier();
void pointers();
void translationUnit();
void globalDeclaration();
void globalDeclaratorList();
void remainingGlobalDeclarators();
void globalDeclarator();
void parameters();
void remainingParameters();
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
			match('(');
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
			// Do nothing
			break;
	}
} 

void expressionList() {
	expression();
	
	while (lookahead == ',') {
		match(',');
		expression();
	}
}

void statements() {
	while (lookahead != '\0' && lookahead != EOF) {
		statement();
	}
}

void statement() {
	switch (lookahead) {
		case '{':	
			match('{');
			declarations();
			statements();
			match('}');
			break;
		case RETURN:
			match(RETURN);
			expression();
			match(';');
			break;
		case WHILE:
			match(WHILE);
			match('(');
			expression();
			match(')');
			statement();
			break;
		case IF:
			match(IF);
			match('(');
			expression();
			match(')');
			statement();
			if (lookahead == ELSE) {
				match(ELSE);
				statement();
			}
			break;
		default:
			expression();
			if (lookahead == '=') {
				match('=');
				expression();
			}
			match(';');
	}
}

void declarations() {
	while (lookahead != '\0' && lookahead != EOF) {
		declaration();
	}
}

void specifier() {
	if (lookahead == INT || lookahead == VOID) {
		match(lookahead);
	}
}

void declaration() {
	specifier();
	declaratorList();
	match(';');
}

void declaratorList() {
	declarator();
	
	while (lookahead == ',') {
		match(',');
		declarator();
	}
}

void declarator() {
	pointers();
	match(ID);
	if (lookahead == '[') {
		match('[');
		match(NUM);
		match(']');
	}
}

void pointers() {
	while (lookahead == '*') {
		match('*');
	}
}

void globalDeclarator() {
	specifier();
	pointers();
	match(ID);

	if (lookahead == '[') {
		match('[');
		match(NUM);
		match(']');
	} else if (lookahead == '(') {
		match('(');
		parameters();
		match(')');
	}
}

void globalDeclaratorList() {
	globalDeclarator();
	
	while (lookahead == ',') {
		match(',');
		globalDeclarator();
	}
}

void globalDeclaration() {
	specifier();
	globalDeclaratorList();
	match(';');
}

void functionDefinition() {
	specifier();
	pointers();
	match(ID);
	match('(');
	parameters();
	match(')');
	match('{');
	declarations();
	statements();
	match('}');
}

void remainingGlobalDeclarators() {
	while (lookahead == ',') {
		match(',');
		globalDeclarator();
	}
}

void translationUnit() {
	while (lookahead == INT || lookahead == VOID) {
		specifier();
		pointers();
		match(ID);

		if (lookahead == '(') {
			match('(');
			parameters();
			match(')');
			if (lookahead == '{') { //Function definition
				declarations();
				statements();
			} else {
				remainingGlobalDeclarators();
			}
		} else if (lookahead == '[') {
			match('[');
			match(NUM);
			match(']');
			remainingGlobalDeclarators();
		} else {
			remainingGlobalDeclarators();
		}
	}
}	

void parameters() {
	if (lookahead == VOID || lookahead == INT) {
		match(lookahead);
		pointers();
		match(ID);
		remainingParameters();
	}
}

void remainingParameters() {
	while (lookahead == ',') {
		// Parameter
		specifier();
		pointers();
		match(ID);
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
    	cerr << "line " << yylineno << ": " << buf << lookahead << endl;
}

void match(int t) {
	if (lookahead == t) {
		lookahead = yylex();
	} else { 
		cout << t << endl;
		report("Token not matched.");			
	}
}


int main()
{
    	lookahead = yylex();
	declaration();
	statement();
    	return 0;
}

