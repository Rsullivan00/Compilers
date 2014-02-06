# ifndef SYMBOL_H
# define SYMBOL_H
# include <string>
# include "Type.h"

class Symbol {
	typedef std::string string;
	
	string _name;
	Type _type;
	bool _defined;

public:
	/* Accessors */
	const string &name() const { return _name; }
	const Type &type() const { return _type; }
	const bool &defined() const { return _defined; }

	/* Constructors */
	Symbol(const string &name, const Type &type, const bool &defined = false)
		:_name(name), _type(type), _defined(defined) {}

	/* Operators */
	bool operator==(const Symbol &rhs) const{
		if (this->_name != rhs._name) return false;
		if (this->_type != rhs._type) return false;
	
		return true;
	}

	bool operator!=(const Symbol &rhs) const{
		return !(*this == rhs);
	}

	friend std::ostream& operator<<(std::ostream& out, const Symbol& symbol) {
		out << "Name: " << symbol._name << " Type: " << symbol._type << " Defined: " << symbol._defined << std::endl;
		return out;
	}
};

# endif
