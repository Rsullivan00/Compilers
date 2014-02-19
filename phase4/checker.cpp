/*
 * File:	checker.cpp
 *
 * Description:	This file contains the public and private function and
 *		variable definitions for the semantic checker for Simple C.
 *
 *		If a symbol is redeclared, the existing declaration is
 *		retained and the redeclaration discarded, except in the
 *		case of an implicitly declared function.  This behavior
 *		seems to be consistent with GCC, and who are we to argue
 *		with GCC?
 *
 *		Extra functionality:
 *		- inserting an undeclared symbol with the error type
 */

# include <iostream>
# include "lexer.h"
# include "checker.h"
# include "nullptr.h"
# include "tokens.h"
# include "Symbol.h"
# include "Scope.h"
# include "Type.h"

# define FUNCDEFN 1


using namespace std;

static Scope *outermost, *toplevel;
static const Type error;
static const Type integer(INT, 0);

static string redefined = "redefinition of '%s'";
static string redeclared = "redeclaration of '%s'";
static string conflicting = "conflicting types for '%s'";
static string undeclared = "'%s' undeclared";
static string void_object = "'%s' has void type";
/* Added */
static string E1 = "invalid return type";
static string E2 = "invalid type for test expression";
static string E3 = "invalid lvalue in expression";
static string E4 = "invalid operands to binary %s";
static string E5 = "invalid operand to unary %s";
static string E6 = "called object is not a function";
static string E7 = "invalid arguments to called function";

/*
 * Function:	checkIfVoidObject
 *
 * Description:	Check if TYPE is a proper use of the void type (if the
 *		specifier is void, then the indirection must be nonzero or
 *		the kind must be a function).  If the type is proper, it is
 *		returned.  Otherwise, the error type is returned.
 */

static Type checkIfVoidObject(const string name, const Type &type)
{
    if (type.specifier() != VOID)
	return type;

    if (type.indirection() == 0 && !type.isFunction()) {
	report(void_object, name);
	return error;
    }

    return type;
}


/*
 * Function:	openScope
 *
 * Description:	Create a scope and make it the new top-level scope.
 */

Scope *openScope()
{
    toplevel = new Scope(toplevel);

    if (outermost == nullptr)
	outermost = toplevel;

    return toplevel;
}


/*
 * Function:	closeScope
 *
 * Description:	Remove the top-level scope, and make its enclosing scope
 *		the new top-level scope.
 */

Scope *closeScope()
{
    Scope *old = toplevel;
    toplevel = toplevel->enclosing();
    return old;
}


/*
 * Function:	defineFunction
 *
 * Description:	Define a function with the specified NAME and TYPE.  A
 *		function is always defined in the outermost scope.
 */

Symbol *defineFunction(const string &name, const Type &type)
{
    Symbol *symbol = declareFunction(name, type);

    if (symbol->attributes & FUNCDEFN)
	report(redefined, name);

    symbol->attributes = FUNCDEFN;
    return symbol;
}


/*
 * Function:	declareFunction
 *
 * Description:	Declare a function with the specified NAME and TYPE.  A
 *		function is always declared in the outermost scope.  A
 *		later redeclaration does not replace an earlier one unless
 *		the earlier one was implicit.
 */

Symbol *declareFunction(const string &name, const Type &type)
{
    Symbol *symbol = outermost->find(name);

    if (symbol == nullptr) {
	symbol = new Symbol(name, checkIfVoidObject(name, type));
	outermost->insert(symbol);

    } else if (type != symbol->type()) {
	report(conflicting, name);
	delete type.parameters();

    } else if (symbol->type().parameters() == nullptr) {
	outermost->remove(name);
	delete symbol;

	symbol = new Symbol(name, checkIfVoidObject(name, type));
	outermost->insert(symbol);

    } else
	delete type.parameters();

    return symbol;
}


/*
 * Function:	declareVariable
 *
 * Description:	Declare a variable with the specified NAME and TYPE.  Any
 *		redeclaration is discarded.
 */

Symbol *declareVariable(const string &name, const Type &type)
{
    Symbol *symbol = toplevel->find(name);

    if (symbol == nullptr) {
	symbol = new Symbol(name, checkIfVoidObject(name, type));
	toplevel->insert(symbol);

    } else if (outermost != toplevel)
	report(redeclared, name);

    else if (type != symbol->type())
	report(conflicting, name);

    return symbol;
}


/*
 * Function:	checkIdentifier
 *
 * Description:	Check if NAME is declared.  If it is undeclared, then
 *		declare it as having the error type in order to eliminate
 *		future error messages.
 */

Symbol *checkIdentifier(const string &name)
{
    Symbol *symbol = toplevel->lookup(name);

    if (symbol == nullptr) {
	report(undeclared, name);
	symbol = new Symbol(name, error);
	toplevel->insert(symbol);
    }

    return symbol;
}


/*
 * Function:	checkFunction
 *
 * Description:	Check if NAME is a previously declared function.  If it is
 *		undeclared, then implicitly declare it.
 */

Symbol *checkFunction(const string &name)
{
    Symbol *symbol = toplevel->lookup(name);

    if (symbol == nullptr)
	symbol = declareFunction(name, Type(INT, 0, nullptr));

    return symbol;
}

/*
 * Stuff added by Rick
 */

const Type *checkLogicalOr(const Type *left, const Type *right)
{
    if (left->isError() || right->isError())
        return &error; 

    const Type *tempLeft = left->promote();
    const Type *tempRight = right->promote();

    if (tempLeft->isPredicate() && tempRight->isPredicate())
        return &integer; 

    report(E4, "||");
    return &error;
}

const Type *checkLogicalAnd(const Type *left, const Type *right)
{
    if (left->isError() || right->isError())
        return &error;

    const Type *tempLeft = left->promote();
    const Type *tempRight = right->promote();

    if (tempLeft->isPredicate() && tempRight->isPredicate())
        return &integer;

    report(E4, "&&");
    return &error;
}

const Type *checkMultiplicative(const Type *left, const Type *right, const string &op) {
    if (left->isError() || right->isError())
        return &error;

    if (left->specifier() != INT || right->specifier() != INT) {
        report(E4, op); 
        return &error;
    }

    return &integer;
}

/*
    int x int -> int
    ptr(T) x int -> ptr(T)   where T != void
    
For addition only:
    int x ptr(T) -> ptr(T)   where T != void
Subtraction only:
    ptr(T) x ptr(T) -> int  where T != void

*/
const Type *checkAdditive(const Type *left, const Type *right, const string &op) {
    if (left->isError() || right->isError())
        return &error;

    if (left->specifier() == VOID || right->specifier() == VOID) {
        report(E4, op);
        return &error;
    }

    const Type *tempLeft = left->promote();
    const Type *tempRight = right->promote();

    if (op == "+" && tempRight->indirection() > 0 && !left->indirection())
        return new Type(INT, tempRight->indirection());

    if (tempLeft->indirection() > 0 && !tempRight->indirection())
        return new Type(INT, tempLeft->indirection());

    /* All other cases return int */
    return &integer; 
}
    

const Type *checkRelational(const Type *left, const Type *right, const string &op) {
     if (left->isError() || right->isError())
        return &error;   

    const Type *tempLeft = left->promote();
    const Type *tempRight = right->promote();

    if (*tempLeft != *tempRight || !tempLeft->isPredicate() || !tempRight->isPredicate()) {
        report(E4, op);
        return &error;
    }

    return &integer;
} 

const Type *checkEquality(const Type *left, const Type *right, const string &op) {
    if (left->isError() || right->isError())
        return &error;   

    const Type *tempLeft = left->promote();
    const Type *tempRight = right->promote();

    if (!areCompatible(tempLeft, tempRight)) {
        report(E4, op);
        return &error;
    }

    return &integer;
}


const Type *checkPostfix(const Type *left, const Type *right) {
    if (left->isError() || right->isError())
        return &error;   

    const Type *tempLeft = left->promote();
    const Type *tempRight = right->promote();

    if ((tempLeft->specifier() == VOID && tempLeft->indirection() == 1) || *tempRight != integer) {
        report(E4, "[]");
        return &error;
    }

    return new Type(tempLeft->specifier(), tempLeft->indirection() - 1);
}

const Type *checkReturn(const Type *returnType, const Type *funcType) {
    if (returnType->isError() || funcType->isError())
        return &error;

    if (!areCompatible(returnType->promote(), funcType->promote())) {
        report(E1);
        return &error;
    }

    return returnType; 
}

const Type *checkStatementExpression(const Type *type) {
    if (type->isError())
        return &error;
       
    const Type *tempType = type->promote();

    if (!tempType->isPredicate()) {
        report(E2);
        return &error;
    }

    return tempType;
}

const Type *checkAssignment(const Type *left, const Type *right, const bool &lvalue) {
    if (left->isError() || right->isError())
	return &error;

    if (!lvalue) {
        report(E3);
        return &error;
    }

    if (!areCompatible(left->promote(), right->promote())) {
        report(E4, "=");
        return &error;
    }

    return left;
}

const Type *checkDeref(const Type *type) {
    if (type->isError())
	return &error;

    const Type *tempType = type->promote();

    if (!tempType->indirection() || tempType->specifier() == VOID) {
	report(E5, "*");
	return &error;
    }

    return new Type(tempType->specifier(), tempType->indirection() - 1);
}

const Type *checkAddress(const Type *type, const bool &lvalue) {
    if (type->isError())
	return &error;

    if (!lvalue) {
	report(E3);
	return &error;
    }

    const Type *tempType = type->promote();

    return new Type(tempType->specifier(), tempType->indirection() + 1);
}

const Type *checkNot(const Type *type) {
    if (type->isError())
	return &error;

    if (!type->isPredicate()) {
	report(E5, "!");
	return &error;
    } 

    return &integer;
}

const Type *checkNegation(const Type *type) {
    if (type->isError())
	return &error;

    if (type->specifier() != INT) {
	report(E5, "-");
	return &error;
    }

    return &integer;
}

const Type *checkSizeOf(const Type *type) {
    if (type->isError())
	return &error;

    if (!type->isPredicate() || (type->specifier() == VOID && !type->indirection())) {
	report(E5, "sizeof");
	return &error;
    }	

    return &integer;
}

const Type *checkFunction(const Type *type, std::vector<const Type *> &params) {
    if (type->isError())
	return &error;

    if (!type->isFunction()) {
	report(E6);
	return &error;
    }

    if (type->parameters() != NULL) {
	if (type->parameters()->size() != params.size()) {
	    report(E7);
	    return &error;
	}

	for(int i = 0; i < type->parameters()->size(); i++) {
	    if (!areCompatible(params.at(i)->promote(), type->parameters()->at(i).promote())) {
		report(E7);
		return &error;
	    }
	}
    }

    return new Type(type->promote()->specifier(), type->promote()->indirection());
}

bool areCompatible(const Type *left, const Type *right) {
    if (!left->isPredicate() || !right->isPredicate()) 
        return false;

    if (*left == *right)
        return true;

    if (left->indirection() > 0 && right->indirection() == 1 && right->specifier() == VOID)
        return true;
  
    if (right->indirection() > 0 && left->indirection() == 1 && left->specifier() == VOID)
        return true;

    return false;
}
