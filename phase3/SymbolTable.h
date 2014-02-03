# ifndef SYMBOL_TABLE_H
# define SYMBOL_TABLE_H
# include "Scope.h"

class SymbolTable {
	Scope *_global;
	Scope *_current;

public: 
	/* Accessors */
	const Scope *global() const { return _global; }
	const Scope *current() const { return _current; }

	/* Constructor */
  	SymbolTable(Scope *global, Scope *current)
  		:_global(global), _current(current) {}

  	SymbolTable(Scope *global)
		:_global(global), _current(global) {}
};

# endif
