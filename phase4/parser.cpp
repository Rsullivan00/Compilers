/*
 * File:	parser.c
 *
 * Description:	This file contains the public and private function and
 *		variable definitions for the recursive-descent parser for
 *		Simple C.
 */

# include <cstdlib>
# include <iostream>
# include "checker.h"
# include "tokens.h"
# include "lexer.h"

using namespace std;

static int lookahead;

static const Type *expression(bool &lvalue);
static void statement();


/*
 * Function:	error
 *
 * Description:	Report a syntax error to standard error.
 */

static void error()
{
    if (lookahead == DONE)
	report("syntax error at end of file");
    else
	report("syntax error at '%s'", yytext);

    exit(EXIT_FAILURE);
}


/*
 * Function:	match
 *
 * Description:	Match the next token against the specified token.  A
 *		failure indicates a syntax error and will terminate the
 *		program since our parser does not do error recovery.
 */

static void match(int t)
{
    if (lookahead != t)
	error();

    lookahead = yylex();
}


/*
 * Function:	expect
 *
 * Description:	Match the next token against the specified token, and
 *		return its lexeme.  We must save the contents of the buffer
 *		from the lexical analyzer before matching, since matching
 *		will advance to the next token.
 */

static string expect(int t)
{
    string buf = yytext;
    match(t);
    return buf;
}


/*
 * Function:	number
 *
 * Description:	Match the next token as a number and return its value.
 */

static unsigned number()
{
    int value;


    value = strtoul(expect(NUM).c_str(), NULL, 0);
    return value;
}


/*
 * Function:	isSpecifier
 *
 * Description:	Return whether the given token is a type specifier.
 */

static bool isSpecifier(int token)
{
    return token == INT || token == VOID;
}


/*
 * Function:	specifier
 *
 * Description:	Parse a type specifier.  Simple C has only int and void.
 *
 *		specifier:
 *		  int
 *		  void
 */

static int specifier()
{
    int typespec = ERROR;


    if (isSpecifier(lookahead)) {
	typespec = lookahead;
	match(lookahead);
    } else
	error();

    return typespec;
}


/*
 * Function:	pointers
 *
 * Description:	Parse pointer declarators (i.e., zero or more asterisks).
 *
 *		pointers:
 *		  empty
 *		  * pointers
 */

static unsigned pointers()
{
    unsigned count = 0;


    while (lookahead == '*') {
	match('*');
	count ++;
    }

    return count;
}


/*
 * Function:	declarator
 *
 * Description:	Parse a declarator, which in Simple C is either a scalar
 *		variable or an array, with optional pointer declarators.
 *
 *		declarator:
 *		  pointers identifier
 *		  pointers identifier [ num ]
 */

static void declarator(int typespec)
{
    unsigned indirection;
    string name;


    indirection = pointers();
    name = expect(ID);

    if (lookahead == '[') {
	match('[');
	declareVariable(name, Type(typespec, indirection, number()));
	match(']');
    } else
	declareVariable(name, Type(typespec, indirection));
}


/*
 * Function:	declaration
 *
 * Description:	Parse a local variable declaration.  Global declarations
 *		are handled separately since we need to detect a function
 *		as a special case.
 *
 *		declaration:
 *		  specifier declarator-list ';'
 *
 *		declarator-list:
 *		  declarator
 *		  declarator , declarator-list
 */

static void declaration()
{
    int typespec;


    typespec = specifier();
    declarator(typespec);

    while (lookahead == ',') {
	match(',');
	declarator(typespec);
    }

    match(';');
}


/*
 * Function:	declarations
 *
 * Description:	Parse a possibly empty sequence of declarations.
 *
 *		declarations:
 *		  empty
 *		  declaration declarations
 */

static void declarations()
{
    while (isSpecifier(lookahead))
	declaration();
}


/*
 * Function:	primaryExpression
 *
 * Description:	Parse a primary expression.
 *
 *		primary-expression:
 *		  ( expression )
 *		  identifier ( expression-list )
 *		  identifier ( )
 *		  identifier
 *		  string
 *		  num
 *
 *		expression-list:
 *		  expression
 *		  expression , expression-list
 */

static const Type *primaryExpression(bool &lvalue)
{
    const Type *type;
    Symbol *symbol;

    string name;

    if (lookahead == '(') {
	match('(');
	type = expression(lvalue);
	match(')');

    } else if (lookahead == STRING) {
	match(STRING);
	type = new Type(STRING);	
    lvalue = false;

    } else if (lookahead == NUM) {
	match(NUM); type = new Type(INT);
	lvalue = false;

    } else if (lookahead == ID) {
	name = expect(ID);

	if (lookahead == '(') {
	    match('(');

	    if (lookahead != ')') {
		expression(lvalue);

		while (lookahead == ',') {
		    match(',');
		    expression(lvalue);
		}
	    }

	    match(')');
	    symbol = checkFunction(name);
	    type = &(symbol->type());
        lvalue = false;

	} else
	    symbol = checkIdentifier(name);
	    type = &(symbol->type());
        // Do we need to assign lvalue here?

    } else {
	error();
	type = new Type();
    }

    return type;
}


/*
 * Function:	postfixExpression
 *
 * Description:	Parse a postfix expression.
 *
 *		postfix-expression:
 *		  primary-expression
 *		  postfix-expression [ expression ]
 */

static const Type *postfixExpression(bool &lvalue)
{
    const Type *left, *right;
    left = primaryExpression(lvalue);

    while (lookahead == '[') {
        match('[');
        right = expression(lvalue);
        left = checkPostfix(left, right);
        lvalue = true;
        match(']');
    }

    return left;
}


/*
 * Function:	prefixExpression
 *
 * Description:	Parse a prefix expression.
 *
 *		prefix-expression:
 *		  postfix-expression
 *		  ! prefix-expression
 *		  - prefix-expression
 *		  * prefix-expression
 *		  & prefix-expression
 *		  sizeof prefix-expression
 */

// TODO: WRITE CHECKING FOR THIS
static const Type *prefixExpression(bool &lvalue)
{
    const Type *type;

    if (lookahead == '!') {
	match('!');
	type = prefixExpression(lvalue);
	lvalue = false;

    } else if (lookahead == '-') {
	match('-');
	type = prefixExpression(lvalue);
	lvalue = false;

    } else if (lookahead == '*') {
	match('*');
	type = prefixExpression(lvalue);
	lvalue = true;

    } else if (lookahead == '&') {
	match('&');
	type = prefixExpression(lvalue);
	lvalue = false;

    } else if (lookahead == SIZEOF) {
	match(SIZEOF);
	type = prefixExpression(lvalue);
	lvalue = false;

    } else {
	type = postfixExpression(lvalue);
	lvalue = false;
    }

    return type;
}


/*
 * Function:	multiplicativeExpression
 *
 * Description:	Parse a multiplicative expression.  Simple C does not have
 *		cast expressions, so we go immediately to prefix
 *		expressions.
 *
 *		multiplicative-expression:
 *		  prefix-expression
 *		  multiplicative-expression * prefix-expression
 *		  multiplicative-expression / prefix-expression
 *		  multiplicative-expression % prefix-expression
 */

static const Type *multiplicativeExpression(bool &lvalue)
{
    const Type *left, *right;
    left = prefixExpression(lvalue);

    while (1) {
	if (lookahead == '*') {
	    match('*');
	    right = prefixExpression(lvalue);

	    left = checkMultiplicative(left, right, "*");
	    lvalue = false;

	} else if (lookahead == '/') {
	    match('/');
	    right = prefixExpression(lvalue);

	    left = checkMultiplicative(left, right, "/");
	    lvalue = false;

	} else if (lookahead == '%') {
	    match('%');
	    right = prefixExpression(lvalue);

	    left = checkMultiplicative(left, right, "%");
	    lvalue = false;

	} else
	    break;
    }

    return left;
}


/*
 * Function:	additiveExpression
 *
 * Description:	Parse an additive expression.
 *
 *		additive-expression:
 *		  multiplicative-expression
 *		  additive-expression + multiplicative-expression
 *		  additive-expression - multiplicative-expression
 */

static const Type *additiveExpression(bool &lvalue)
{
    const Type *left, *right;

    left = multiplicativeExpression(lvalue);

    while (1) {
	if (lookahead == '+') {
	    match('+');
	    right = multiplicativeExpression(lvalue);
        left = checkAdditive(left, right, "+");
        lvalue = false;

	} else if (lookahead == '-') {
	    match('-');
	    right = multiplicativeExpression(lvalue);
        left = checkAdditive(left, right, "-");
        lvalue = false;

	} else
	    break;
    }

    return left;
}


/*
 * Function:	relationalExpression
 *
 * Description:	Parse a relational expression.  Note that Simple C does not
 *		have shift operators, so we go immediately to additive
 *		expressions.
 *
 *		relational-expression:
 *		  additive-expression
 *		  relational-expression < additive-expression
 *		  relational-expression > additive-expression
 *		  relational-expression <= additive-expression
 *		  relational-expression >= additive-expression
 */

static const Type *relationalExpression(bool &lvalue)
{
    const Type *left, *right;
    left = additiveExpression(lvalue);

    while (1) {
	if (lookahead == '<') {
	    match('<');
	    right = additiveExpression(lvalue);
        left = checkRelational(left, right, "<");
        lvalue = false;

	} else if (lookahead == '>') {
	    match('>');
	    right = additiveExpression(lvalue);
        left = checkRelational(left, right, ">");
        lvalue = false;

	} else if (lookahead == LEQ) {
	    match(LEQ);
	    right = additiveExpression(lvalue);
        left = checkRelational(left, right, "<=");
        lvalue = false;

	} else if (lookahead == GEQ) {
	    match(GEQ);
	    right = additiveExpression(lvalue);
        left = checkRelational(left, right, ">=");
        lvalue = false;

	} else
	    break;
    }

    return left;
}


/*
 * Function:	equalityExpression
 *
 * Description:	Parse an equality expression.
 *
 *		equality-expression:
 *		  relational-expression
 *		  equality-expression == relational-expression
 *		  equality-expression != relational-expression
 */

static const Type *equalityExpression(bool &lvalue)
{
    const Type *left, *right;
    left = relationalExpression(lvalue);

    while (1) {
	if (lookahead == EQL) {
	    match(EQL);
	    right = relationalExpression(lvalue);
        left = checkEquality(left, right, "=="); 
        lvalue = false;

	} else if (lookahead == NEQ) {
	    match(NEQ);
	    right = relationalExpression(lvalue);
        left = checkEquality(left, right, "!="); 
        lvalue = false;

	} else
	    break;
    }

    return left;
}


/*
 * Function:	logicalAndExpression
 *
 * Description:	Parse a logical-and expression.  Note that Simple C does
 *		not have bitwise-and expressions.
 *
 *		logical-and-expression:
 *		  equality-expression
 *		  logical-and-expression && equality-expression
 */

static const Type *logicalAndExpression(bool &lvalue)
{
    const Type *left, *right;
    left = equalityExpression(lvalue);

    while (lookahead == AND) {
	match(AND);
	right = equalityExpression(lvalue);

	left = checkLogicalAnd(left, right);
	lvalue = false;
    }

    return left;
}


/*
 * Function:	expression
 *
 * Description:	Parse an expression, or more specifically, a logical-or
 *		expression, since Simple C does not allow comma or
 *		assignment as an expression operator.
 *
 *		expression:
 *		  logical-and-expression
 *		  expression || logical-and-expression
 */

static const Type *expression(bool &lvalue)
{
    const Type *left, *right;
    left = logicalAndExpression(lvalue);

    while (lookahead == OR) {
	match(OR);
	right = logicalAndExpression(lvalue);

	left = checkLogicalOr(left, right);
	lvalue = false;
    }

    return left;
}


/*
 * Function:	statements
 *
 * Description:	Parse a possibly empty sequence of statements.  Rather than
 *		checking if the next token starts a statement, we check if
 *		the next token ends the sequence, since a sequence of
 *		statements is always terminated by a closing brace.
 *
 *		statements:
 *		  empty
 *		  statement statements
 */

static void statements()
{
    while (lookahead != '}')
	statement();
}


/*
 * Function:	statement
 *
 * Description:	Parse a statement.  Note that Simple C has so few
 *		statements that we handle them all in this one function.
 *
 *		statement:
 *		  { declarations statements }
 *		  return expression ;
 *		  while ( expression ) statement
 *		  if ( expression ) statement
 *		  if ( expression ) statement else statement
 *		  expression = expression ;
 *		  expression ;
 */

static void statement()
{
	const Type *left, *right;
    bool lvalue;

    if (lookahead == '{') {
	match('{');
	openScope();
	declarations();
	statements();
	closeScope();
	match('}');

    } else if (lookahead == RETURN) {
	match(RETURN);
	left = expression(lvalue);
    checkReturn(left);
	match(';');

    } else if (lookahead == WHILE) {
	match(WHILE);
	match('(');
	left = expression(lvalue);
    checkStatementExpression(left);
	match(')');
	statement();

    } else if (lookahead == IF) {
	match(IF);
	match('(');
	left = expression(lvalue);
    checkStatementExpression(left);
	match(')');
	statement();

	if (lookahead == ELSE) {
	    match(ELSE);
	    statement();
	}

    } else {
	left = expression(lvalue);

	if (lookahead == '=') {
	    match('=');
	    right = expression(lvalue);
        checkAssignment(left, right, lvalue);
	}

	match(';');
    }
}


/*
 * Function:	parameter
 *
 * Description:	Parse a parameter, which in Simple C is always a scalar
 *		variable with optional pointer declarators.
 *
 *		parameter:
 *		  specifier pointers ID
 */

static Type parameter()
{
    unsigned indirection;
    int typespec;
    string name;


    typespec = specifier();
    indirection = pointers();
    name = expect(ID);

    Type type = Type(typespec, indirection);
    declareVariable(name, type);
    return type;
}


/*
 * Function:	parameters
 *
 * Description:	Parse the parameters of a function, but not the opening or
 *		closing parentheses.
 *
 *		parameters:
 *		  void
 *		  void pointers identifier remaining-parameters
 *		  int pointers identifier remaining-parameters
 *
 *		remaining-parameters:
 *		  empty
 *		  , parameter remaining-parameters
 */

static Parameters *parameters()
{
    Parameters *params;
    unsigned indirection;
    int typespec;
    string name;
    Type type;


    openScope();
    typespec = lookahead;
    params = new Parameters();

    if (lookahead == VOID) {
	match(VOID);

	if (lookahead == ')')
	    return params;

    } else
	match(INT);

    indirection = pointers();
    name = expect(ID);

    type = Type(typespec, indirection);
    declareVariable(name, type);
    params->push_back(type);

    while (lookahead == ',') {
	match(',');
	params->push_back(parameter());
    }

    return params;
}


/*
 * Function:	globalDeclarator
 *
 * Description:	Parse a declarator, which in Simple C is either a scalar
 *		variable, an array, or a function, with optional pointer
 *		declarators.
 *
 *		global-declarator:
 *		  pointers identifier
 *		  pointers identifier [ num ]
 *		  pointers identifier ( parameters )
 */

static void globalDeclarator(int typespec)
{
    unsigned indirection;
    string name;


    indirection = pointers();
    name = expect(ID);

    if (lookahead == '[') {
	match('[');
	declareVariable(name, Type(typespec, indirection, number()));
	match(']');

    } else if (lookahead == '(') {
	match('(');
	declareFunction(name, Type(typespec, indirection, parameters()));
	match(')');
	closeScope();

    } else
	declareVariable(name, Type(typespec, indirection));
}


/*
 * Function:	remainingDeclarators
 *
 * Description:	Parse any remaining global declarators after the first.
 *
 * 		remaining-declarators
 * 		  ;
 * 		  , global-declarator remaining-declarators
 */

static void remainingDeclarators(int typespec)
{
    while (lookahead == ',') {
	match(',');
	globalDeclarator(typespec);
    }

    match(';');
}


/*
 * Function:	globalOrFunction
 *
 * Description:	Parse a global declaration or function definition.
 *
 * 		global-or-function:
 * 		  specifier pointers identifier remaining-decls
 * 		  specifier pointers identifier [ num ] remaining-decls
 * 		  specifier pointers identifier ( parameters ) remaining-decls 
 * 		  specifier pointers identifier ( parameters ) { ... }
 */

static void globalOrFunction()
{
    Parameters *params;
    unsigned indirection;
    int typespec;
    string name;


    typespec = specifier();
    indirection = pointers();
    name = expect(ID);

    if (lookahead == '[') {
	match('[');
	declareVariable(name, Type(typespec, indirection, number()));
	match(']');
	remainingDeclarators(typespec);

    } else if (lookahead == '(') {
	match('(');
	params = parameters();
	match(')');

	if (lookahead == '{') {
	    defineFunction(name, Type(typespec, indirection, params));
	    match('{');
	    declarations();
	    statements();
	    closeScope();
	    match('}');

	} else {
	    closeScope();
	    declareFunction(name, Type(typespec, indirection, params));
	    remainingDeclarators(typespec);
	}

    } else {
	declareVariable(name, Type(typespec, indirection));
	remainingDeclarators(typespec);
    }
}


/*
 * Function:	main
 *
 * Description:	Analyze the standard input stream.
 */

int main()
{
    openScope();
    lookahead = yylex();

    while (lookahead != DONE)
	globalOrFunction();

    closeScope();
    exit(EXIT_SUCCESS);
}
