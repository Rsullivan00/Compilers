# ifndef TYPE_H
# define TYPE_H
# include <vector>

typedef std::vector<class Type> Parameters;
enum {ARRAY, FUNCTION, SCALAR};

class Type {
	int _specifier;
	unsigned _indirection;
	unsigned _length;
	Parameters *_parameters;;
	int _kind;

public:
	/* Accessors */
	int specifier() const { return _specifier; }
	unsigned indirection() const { return _indirection; }
	unsigned length() const { return _length; }
	Parameters *parameters() const { return _parameters; }
	int kind() const { return _kind; }

	/* Constructor */
	Type(int kind, int specifier, int indirection, int length = 0, Parameters *parameters = NULL)
		:_kind(kind), _specifier(specifier), _indirection(indirection), _length(length), _parameters(parameters) {}

	/* Operator overloads */
	bool operator==(const Type &rhs) const {
		if (_kind != rhs._kind) return false;
		if (_specifier != rhs._specifier) return false;
		if (_kind == ARRAY && _length != rhs.length) return false;
		if (_kind == FUNCTION) {
			if (_parameters == NULL)
				return true;
			else if (rhs._parameters == NULL)
				return true;
			else
				return *_parameters == *rhs._parameters;
		}

		return true;
	}

	bool operator!=(const Type &rhs) const {
		return !(*this==rhs);
	}
};

# endif
