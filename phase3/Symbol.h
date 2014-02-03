# ifndef SYMBOL_H
# define SYMBOL_H
# include <string>
# include "Type.h"

class Symbol {
	typedef std::string string;
	
	string _name;
	Type _type;

public:
	/* Accessors */
	const string &name() const { return _name; }
	const Type &type() const { return _type; }

	/* Constructor */
	Symbol(const string &name, const Type &type)
		:_name(name), _type(type) {}
};

# endif
