# ifndef CHECKER_CPP
# define CHECKER_CPP

# include <string>
# include "Scope.h"
# include "Type.h"


Scope *globalScope;
Scope *currentScope;

void error(int errorType, std::string name) {
	switch (errorType) {
		case 1:	std::cerr << "E1. redefinition of '" << name << "'" << std::endl;
			break;
		case 2:	std::cerr << "E2. redeclaration of '" << name << "'" << std::endl;
			break;
		case 3:	std::cerr << "E3. conflicting types for '" << name << "'" << std::endl;
			break;
		case 4:	std::cerr << "E4. '" << name << "' undeclared" << std::endl;
			break;
		case 5:	std::cerr << "E5. '" << name << "' has void type" << std::endl;
			break;
		default: std::cout << "Error not defined" << std::endl;
	}
}

/************************
 * Scoping
 * *********************/

void openScope() {
	Scope *scope = new Scope(currentScope);

	if (globalScope == NULL) 
		globalScope = scope;

	currentScope = scope;	
}

void closeScope() {
	Scope *higherScope = currentScope->higherScope();
	delete currentScope;
	currentScope = higherScope;
}

/*************************
 * Variables
 ************************/

void declareVar(Symbol *symbol) {
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

void checkVar(Symbol *symbol) {

}

/*************************
 * Functions
 ************************/

void defineFunc(Symbol *func) {
	// need to remove any of this function's declarations
	currentScope->insert(func);	
}

void defineFunc(int spec, unsigned indirection, std::string name) {
	Type newType(FUNCTION, spec, indirection);
	defineFunc(new Symbol(name, newType));
}

void declareFunc(Symbol *func) {
	// need to remove any previous declarations
	currentScope->insert(func);
}

void declareFunc(int spec, unsigned indirection, std::string name) {
	Type newType(FUNCTION, spec, indirection);
	defineFunc(new Symbol(name, newType));
}

void checkFunc(Symbol *func) {

}

# endif
