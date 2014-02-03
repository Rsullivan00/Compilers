# ifndef SCOPE_H
# define SCOPE_H
# include <vector>
# include "Symbol.h"

typedef std::vector<Symbol> Symbols;

class Scope {
	Scope *_higherScope;
	Symbols _symbols;

public:
	/* Accessors */
	const Scope *higherScope() const { return _higherScope; }
	const Symbols symbols() const { return _symbols; }
	const int numSymbols() const { return _symbols.size(); }

	/* Mutators */
	void addSymbol(Symbol *symbol) {
		_symbols.push_back(*symbol);
	}

	/* Constructor */
	Scope (Scope *higherScope, Symbols symbols)
		:_higherScope(higherScope), _symbols(symbols) {}	

	Scope (Scope *higherScope)	
		:_higherScope(higherScope) {}
};	

# endif
