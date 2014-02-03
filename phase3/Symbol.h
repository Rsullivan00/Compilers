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

	/* Constructors */
	Symbol(const string &name, const Type &type)
		:_name(name), _type(type) {}

	/* Operators */
	bool operator==(const Symbol &rhs) const{
		if (this->_name != rhs._name) return false;
		if (this->_type != rhs._type) return false;
	
		return true;
	}

	bool operator!=(const Symbol &rhs) const{
		return !(*this == rhs);
	}
};

# endif
