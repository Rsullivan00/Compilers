const char* getOutput (int t) {
	switch (t) {
		case OROR: 		return "or";
		case ANDAND: 		return "and"; 
		case EQUALEQUAL:	return "eql";
		case NOTEQUAL:		return "neq";
		case '<':		return "ltn";
		case '>':		return "gtn";
		case LESSTHANEQUAL:	return "leq";
		case GREATERTHANEQUAL:	return "geq";
		case '+':		return "add";
		case '-':		return "sub";
		case '*': 		return "mul";
		case '/':		return "div";
		case '%':		return "rem";
		// Skip unary operators to avoid duplicates
		case '[':		return "index";
		default:		return "No output for " << t;
	}
}

const char* getOutputUnary (int t) {
	switch (t) {
		case '&':		return "addr";
		case '*':		return "deref";
		case '!':		return "not";
		case '-':		return "neg";
		case SIZEOF:		return "sizeof";
		default:		return "No output for " << t;
	}
}
