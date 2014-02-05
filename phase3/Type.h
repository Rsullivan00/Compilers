# ifndef TYPE_H
# define TYPE_H
# include <vector>

typedef std::vector<class Type> Parameters;
enum {ARRAY, FUNCTION, SCALAR};

class Type {
	int _kind;
	int _specifier;
	unsigned _indirection;
	unsigned _length;
	Parameters *_parameters;

public:
	/* Accessors */
	int specifier() const { return _specifier; }
	unsigned indirection() const { return _indirection; }
	unsigned length() const { return _length; }
	Parameters *parameters() const { return _parameters; }
	int kind() const { return _kind; }

	/* Constructor */
	Type(int kind, int specifier, unsigned indirection, unsigned length = 0, Parameters *parameters = NULL)
		:_kind(kind), _specifier(specifier), _indirection(indirection), _length(length), _parameters(parameters) {}

	/* Operator overloads */
	bool operator==(const Type &rhs) const {
		if (_kind != rhs._kind) return false;
		if (_specifier != rhs._specifier) return false;
		if (_indirection != rhs._indirection) return false;
		if (_kind == ARRAY && _length != rhs._length) return false;
		if (_kind == FUNCTION) {
			std::cout << "FUNC" << std::endl;
			if (_parameters == NULL) {
			std::cout << "LEFT PARAMS NULL" << std::endl;
				return true;
			} else if (rhs._parameters == NULL) {
			std::cout << "RIGHT PARAMS NULL" << std::endl;
				return true;
			} else {
				return *_parameters == *rhs._parameters;
			}
		}

		return true;
	}

	bool operator!=(const Type &rhs) const {
		return !(*this==rhs);
	}

	friend std::ostream& operator<<(std::ostream& out, const Type& type) {
		out << type.kind() << ' ' << type.specifier() << ' ' <<  type.indirection() << std::endl;
		if (type._parameters == NULL)
			out << "NULL";
		else {
			out << "Params: ";
			for (unsigned i = 0; i < type._parameters->size(); i++)
				out << (*(type._parameters))[i].specifier() << ' ';
		}
		out << std::endl;
		return out;
	}
};

# endif
