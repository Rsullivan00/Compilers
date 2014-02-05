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
	Scope *higherScope() const { return _higherScope; }
	const Symbols symbols() const { return _symbols; }
	const int numSymbols() const { return _symbols.size(); }

	/* Member functions */
	Symbol *find(const Symbol *symbol) {
		if (symbol == NULL) return NULL;
		for (unsigned i = 0; i < _symbols.size(); i++) {
			if (*symbol == _symbols[i])
				return &_symbols[i];
		}

		return NULL;
	}

	Symbol *findByName(const std::string &name) {
		for (unsigned i = 0; i < _symbols.size(); i++) {
			if (name == _symbols[i].name())
				return &_symbols[i];
		}

		return NULL;
	}

	Symbol *lookup(const Symbol *symbol) {
		Symbol *location = find(symbol);
	
		if (location != NULL)
			return location;

		return (!_higherScope ? NULL : _higherScope->lookup(symbol));
	}

	Symbol *lookupByName(const std::string &name) {
		Symbol *location = findByName(name);

		if (location != NULL) 
			return location;

		return (!_higherScope ? NULL : _higherScope->lookupByName(name));
	}

	/* Mutators */
	void insert(const Symbol *symbol) {
		if (symbol == NULL) return;
		_symbols.push_back(*symbol);
	}

	void remove(const Symbol *symbol) {
		if (symbol == NULL) return;
		for (unsigned i = 0; i < _symbols.size(); i++) {
			if (*symbol == _symbols[i]) {
				_symbols.erase(_symbols.begin() + i);
				return;
			}
		}
	}

	/* Constructors */
	Scope (Scope *higherScope, const Symbols symbols)
		:_higherScope(higherScope), _symbols(symbols) {};

	Scope (Scope *higherScope)	
		:_higherScope(higherScope) {};

	/* Destructor */
	~Scope () {
		_symbols.clear();
	}
};	

# endif
