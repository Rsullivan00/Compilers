# ifndef CHECKER_CPP
# define CHECKER_CPP

# include <string>
# include "Scope.h"
# include "Type.h"
# include "lexer.h" // For the report() function

Scope *globalScope;
Scope *currentScope;

void error(int errorType, std::string name) {
	switch (errorType) {
		case 1:	report("redefinition of '%s'", name);
			break;
		case 2:	report("redeclaration of '%s'", name);
			break;
		case 3:	report("conflicting types for '%s'", name);
			break;
		case 4:	report("'%s' undeclared", name);
			break;
		case 5:	report("'%s' has void type", name);
			break;
		default: report("Error not defined");
	}
}

/************************
 * Scoping
 * *********************/

void openScope() {
	std::cout << "opening scope" << std::endl;
	Scope *scope = new Scope(currentScope);

	if (globalScope == NULL) 
		globalScope = scope;

	currentScope = scope;	
}

void closeScope() {
	std::cout << "closing scope" << std::endl;
	Scope *higherScope = currentScope->higherScope();
	delete currentScope;
	currentScope = higherScope;
}

/*************************
 * Variables
 ************************/

void declareVar(Symbol *symbol) {
	if (currentScope == globalScope) {
		// Check for error E3	
		Symbol *prevDecl = currentScope->findByName(symbol->name());
		if (prevDecl && prevDecl->type() != symbol->type()) {
			error(3, symbol->name());
		}
	} else {
		if (currentScope->findByName(symbol->name()) != NULL) {
			// E2 Error
			error(2, symbol->name());
		}
	}

	// Remove old declarations before inserting
	currentScope->remove(symbol);
	currentScope->insert(symbol);
}

/* Array declaration */
void declareVar(int spec, unsigned indirection, std::string name, unsigned length) {
	Type newType(ARRAY, spec, indirection, length);
	declareVar(new Symbol(name, newType));
}

/* Scalar declaration */
void declareVar(int spec, unsigned indirection, std::string name) {
	Type newType(SCALAR, spec, indirection);
	declareVar(new Symbol(name, newType));
}

/* Checking to see if a variable has been declared in current or enclosing scopes. */
void checkVar(std::string name) {
	Symbol *prevDec = currentScope->lookupByName(name);
	if (prevDec == NULL)	
		error(4, name);
	//if (prevDec->type().specifier() == VOID)
	//	error(5, name);
}

/*************************
 * Functions
 ************************/

// NOTE: Still have to figure out how to handle parameters.
void defineFunc(int spec, unsigned indirection, std::string name, Parameters *params = NULL) {
	Type newType(FUNCTION, spec, indirection, 0, params);
	Symbol *func = new Symbol(name, newType, true);

	Symbol *prevDec = globalScope->findByName(name);
	
	if (prevDec) {
		if (prevDec->type() != func->type()) {
			error(3, name);		
		}

		// If function is already defined, throw an error.
		if (prevDec->defined()) {
			error(1, name);
		}
		// need to remove any of this function's declarations
		globalScope->remove(prevDec);
	}

	
	globalScope->insert(func);	
}

void declareFunc(int spec, unsigned indirection, std::string name, Parameters *params = NULL) {
	Type newType(FUNCTION, spec, indirection, 0, params);
	Symbol *func = new Symbol(name, newType);

	Symbol *prevDec = globalScope->findByName(name);

	if (prevDec) {
		if (prevDec->type() != func->type()) {
			error(3, name);
		} else if (*prevDec != *func) {
			// Redeclarations must be the same
			error(2, name);
		}
		
		// Keep defined functions
		if (prevDec->defined()) 
			return;
		// need to remove any previous declarations
		globalScope->remove(prevDec);
	}

	currentScope->insert(func);
}

void checkFunc(std::string name) {
	Symbol *func = globalScope->findByName(name); 
	if (func == NULL) {
		// Implicitly declare function
		declareFunc(INT, 0, name);
		return;
	}
}

# endif
