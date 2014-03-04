/*
 * File:	generator.cpp
 *
 * Description:	This file contains the public and member function
 *		definitions for the code generator for Simple C.
 *
 *		Extra functionality:
 *		- putting all the global declarations at the end
 */

# include <sstream>
# include <iostream>
# include "generator.h"
# include "machine.h"

using namespace std;

int globalTemp;

/*
 * Function:	operator <<
 *
 * Description:	Convenience function for writing the operand of an
 *		expression.
 */

ostream &operator <<(ostream &ostr, Expression *expr)
{
    return ostr << expr->operand;
}


/*
 * Function:	Identifier::generate
 *
 * Description:	Generate code for an identifier.  Since there is really no
 *		code to generate, we simply update our operand.
 */

void Identifier::generate()
{
    stringstream ss;


    if (_symbol->offset != 0) {
	ss << _symbol->offset << "(%ebp)";
	operand = ss.str();
    } else
	operand = _symbol->name();
}


/*
 * Function:	Number::generate
 *
 * Description:	Generate code for a number.  Since there is really no code
 *		to generate, we simply update our operand.
 */

void Number::generate()
{
    stringstream ss;


    ss << "$" << _value;
    operand = ss.str();
}


/*
 * Function:	Call::generate
 *
 * Description:	Generate code for a function call expression, in which each
 *		argument is simply a variable or an integer literal.
 */

void Call::generate()
{
    unsigned numBytes = 0;


    for (int i = _args.size() - 1; i >= 0; i --) {
	_args[i]->generate();
	cout << "\tpushl\t" << _args[i] << endl;
	numBytes += _args[i]->type().size();
    }

    cout << "\tcall\t" << _id->name() << endl;

    if (numBytes > 0)
	cout << "\taddl\t$" << numBytes << ", %esp" << endl;
}


/*
 * Function:	Assignment::generate
 *
 * Description:	Generate code for this assignment statement, in which the
 *		right-hand side is an integer literal and the left-hand
 *		side is an integer scalar variable.  Actually, the way
 *		we've written things, the right-side can be a variable too.
 */

void Assignment::generate()
{
    _left->generate();
    _right->generate();

    cout << "\tmovl\t" << _right << ", %eax" << endl;
    cout << "\tmovl\t%eax, " << _left << endl;
}


/*
 * Function:	Block::generate
 *
 * Description:	Generate code for this block, which simply means we
 *		generate code for each statement within the block.
 */

void Block::generate()
{
    for (unsigned i = 0; i < _stmts.size(); i ++)
	_stmts[i]->generate();
}


/*
 * Function:	Function::generate
 *
 * Description:	Generate code for this function, which entails allocating
 *		space for local variables, then emitting our prologue, the
 *		body of the function, and the epilogue.
 */

void Function::generate()
{
    int offset = 0;


    /* Generate our prologue. */

    allocate(offset);
    cout << _id->name() << ":" << endl;
    cout << "\tpushl\t%ebp" << endl;
    cout << "\tmovl\t%esp, %ebp" << endl;

    if (offset != 0)
	cout << "\tsubl\t$" << _id->name() << ".size, %esp" << endl;


    /* Generate the body of this function. */

    _body->generate();


    /* Generate our epilogue. */

    cout << "\tmovl\t%ebp, %esp" << endl;
    cout << "\tpopl\t%ebp" << endl;
    cout << "\tret" << endl << endl;

    cout << "\t.global\t" << _id->name() << endl;
    cout << "\t.set\t" << _id->name() << ".size, " << -offset << endl;

    cout << endl;
}


/*
 * Function:	generateGlobals
 *
 * Description:	Generate code for any global variable declarations.
 */

void generateGlobals(const Symbols &globals)
{
    if (globals.size() > 0)
	cout << "\t.data" << endl;

    for (unsigned i = 0; i < globals.size(); i ++) {
	cout << "\t.comm\t" << globals[i]->name();
	cout << ", " << globals[i]->type().size() << ", 4" << endl;
    }
}

void assignTemp(Expression &e) {
    stringstream ss;
    globalTemp -= e.type().size();

    ss << globalTemp << "(\%ebp)";
    e.operand = ss.str();
}

void Add::generate() {    
    string opcode = "addl";

    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    cout << endl;
    cout << "# " << _left << " + " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\t" << opcode << "\t" << _right << ", \%eax" << endl;
    cout << "\tmovl\t\%eax, " << globalTemp << endl;
    cout << endl;
}

void Subtract::generate() {
    string opcode = "subl";

    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    cout << endl;
    cout << "# " << _left << " - " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\t" << opcode << "\t" << _right << ", \%eax" << endl;
    cout << "\tmovl\t\%eax, " << globalTemp << endl;
    cout << endl;
}

void Multiply::generate() {    
    string opcode = "imull";

    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    cout << endl;
    cout << "# " << _left << " * " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\t" << opcode << "\t" << _right << ", \%eax" << endl;
    cout << "\tmovl\t\%eax, " << globalTemp << endl;
    cout << endl;
}

void Divide::generate() {
    string reg = "\%eax";

    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    cout << endl;
    cout << "# " << _left << " / " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\tmovl\t" << _right << ", \%eax" << endl;
    cout << "\tcltd" << endl;
    cout << "\tidivl\t\%eax" << endl;
    cout << "\tmovl\t" << reg << ", " << globalTemp << endl;
    cout << endl;
}

void Remainder::generate() {
    string reg = "\%edx";

    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    cout << endl;
    cout << "# " << _left << " % " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\tmovl\t" << _right << ", \%eax" << endl;
    cout << "\tcltd" << endl;
    cout << "\tidivl\t\%eax" << endl;
    cout << "\tmovl\t" << reg << ", " << globalTemp << endl;
    cout << endl;
}

void Not::generate() {
    _expr->generate();
    assignTemp(*this);

    cout << endl;
    cout << "# !" << _expr << endl;
    cout << "\tcmpl\t" << "$0, \%eax" << endl;
    cout << "\tsete\t" << "\%al" << endl;
    cout << "\tmovzbl\t" << "\%al, \%eax" << endl;
    cout << "\tmovl\t\%eax, " << globalTemp << endl;
    cout << endl;
}

void Negate::generate() {
    _expr->generate();
    assignTemp(*this);

    cout << endl;
    cout << "# -" << _expr << endl;
    cout << "\tmovl\t" << _expr << ", \%eax" << endl;
    cout << "\tnegl\t\%eax" << endl;
    cout << "\tmovl\t\%eax, " << globalTemp << endl;
    cout << endl;
}

void Dereference::generate() {
    _expr->generate();
    assignTemp(*this);

    /* Need to handle both rvalue and lvalue cases. */
    cout << "# *" << _expr << endl;
    cout << "\tmovl\t" << _expr << ", \%eax" << endl;
    cout << "\tmovl\t" << "(\%eax), \%eax" << endl;
    cout << "\tmovl\t" << "\%eax, " << globalTemp << endl;

}

void Address::generate() {
    _expr->generate();
    assignTemp(*this);

    cout << "# &" << _expr << endl;
    cout << "\tleal\t" << _expr << ", \%eax" << endl;
    cout << "\t\%eax, " << globalTemp << endl;
}
