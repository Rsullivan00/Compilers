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
int functionCounter;

int Label::counter = 0;

ostream &operator <<(ostream &os, const Label &label) {
    return os << label.number;
}

void String::generate() {
    Label label;

    cout << endl;
    cout << ".data" << endl;
    cout << ".L" << label << ": .asciz " << _value << endl;
    cout << ".text" << endl;
    cout << endl;

    stringstream ss;
    ss << "$.L" << label;

    operand = ss.str();
}

/*
 * Function:	operator <<
 *
 * Description:	Convenience function for writing the operand of an
 *		expression.
 */

ostream &operator <<(ostream &ostr, const Expression *expr)
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

    cout << endl;
    cout << "# Call " << _id->name() << endl;
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

    cout << "\tsubl\t$" << _id->name() << ".size, %esp" << endl;


    /* Generate the body of this function. */
    Label label;
    functionCounter = label.number;

    _body->generate();

    /* Generate our epilogue. */

    cout << "." << _id->name() << ".epilogue:" << endl;
    cout << ".L" << label << ":" << endl;
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
    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    arithmetic("+", "addl", _left, _right);
}

void Subtract::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);
    
    arithmetic("-", "subl", _left, _right); 
}

void Multiply::generate() {    
    _left->generate();
    _right->generate();
    assignTemp(*this);

    arithmetic("*", "imull", _left, _right);
}

void Expression::arithmetic(const string& op, const string& opcode, const Expression *_left, const Expression *_right) {
    cout << endl;
    cout << "# " << _left << " " << op << " " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\t" << opcode << "\t" << _right << ", \%eax" << endl;
    cout << "\tmovl\t\%eax, " << this << endl;
    cout << endl;
}

void Divide::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    remainderDivide("/", "\%eax", _left, _right);
}

void Remainder::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);
 
    remainderDivide("%", "\%edx", _left, _right);
}

void Expression::remainderDivide(const string& op, const string& reg, const Expression *_left, const Expression *_right) {
    cout << endl;
    cout << "# " << _left << " " << op << " " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\tmovl\t" << _right << ", \%ecx" << endl;
    cout << "\tcltd" << endl;
    cout << "\tidivl\t\%ecx" << endl;
    cout << "\tmovl\t" << reg << ", " << this << endl;
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
    cout << "\tmovl\t\%eax, " << this << endl;
    cout << endl;
}

void Negate::generate() {
    _expr->generate();
    assignTemp(*this);

    cout << endl;
    cout << "# -" << _expr << endl;
    cout << "\tmovl\t" << _expr << ", \%eax" << endl;
    cout << "\tnegl\t\%eax" << endl;
    cout << "\tmovl\t\%eax, " << this << endl;
    cout << endl;
}

void Dereference::generate() {
    _expr->generate();
    assignTemp(*this);

    /* Need to handle both rvalue and lvalue cases. */
    cout << endl;
    cout << "# *" << _expr << endl;
    cout << "\tmovl\t" << _expr << ", \%eax" << endl;
    cout << "\tmovl\t" << "(\%eax), \%eax" << endl;
    cout << "\tmovl\t" << "\%eax, " << this << endl;
    cout << endl;
}

void Address::generate() {
    _expr->generate();
    assignTemp(*this);

    cout << endl;
    cout << "# &" << _expr << endl;
    cout << "\tleal\t" << _expr << ", \%eax" << endl;
    cout << "\tmovl\t\%eax, " << this << endl;
    cout << endl;
}

void LessThan::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);

    comparison("<", "setl", _left, _right);
}

void GreaterThan::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);

    comparison(">", "setg", _left, _right);
}

void LessOrEqual::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);

    comparison("<=", "setle", _left, _right);
}

void GreaterOrEqual::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);

    comparison(">=", "setge", _left, _right);
}

void Equal::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);

    comparison("==", "sete", _left, _right);
}

void NotEqual::generate() {
    _left->generate();
    _right->generate();
    assignTemp(*this);

    comparison("!=", "setne", _left, _right);
}

void LogicalOr::generate() {
    _left->generate();

    Label label;

    cout << endl;
    cout << "\tcmpl\t$0, " << _left << endl;
    cout << "\tjne\t" << label.number << endl;

    _right->generate();
    assignTemp(*this);

    cout << "\tcmpl\t$0" << _right << endl;
    cout << ".L" << label.number << ":" << endl;
    cout << "\tsetne\t\%al" << endl;
    cout << "\tmovzbl\t\%al, \%eax" << endl;
    cout << "\tmovl\t\%eax, " << this << endl;
    cout << endl;
}
void LogicalAnd::generate() {
    _left->generate();

    Label label;

    cout << endl;
    cout << "\tcmpl\t$0, " << _left << endl;
    cout << "\tje\t" << label.number << endl;

    _right->generate();
    assignTemp(*this);

    cout << "\tcmpl\t$0" << _right << endl;
    cout << ".L" << label.number << ":" << endl;
    cout << "\tsetne\t\%al" << endl;
    cout << "\tmovzbl\t\%al, \%eax" << endl;
    cout << "\tmovl\t\%eax, " << this << endl;
    cout << endl;
}

void If::generate() {
    _expr->generate();

    Label label0, label1;

    cout << endl;
    cout << "\tmovl\t" << _expr << ", \%eax" << endl;
    cout << "\tcmpl\t$0, \%eax" << endl;
    cout << "\tje\t" << label0 << endl;

    _thenStmt->generate();

    cout << "\tjmp\t" << label1 << endl;
    cout << label0 << ":" << endl;

    /* Do we need a null check here? */
    _elseStmt->generate();
    cout << label1 << ":" << endl;
    cout << endl;
}

void While::generate() {
    Label label0, label1;

    cout << endl;
    cout << ".L" << label0 << ":" << endl;

    _expr->generate();
    
    cout << "\tcmpl\t$0, " << _expr << endl;
    cout << "\tje\t" << label1 << endl;
    _stmt->generate();
    cout << "\tjmp\t" << label0 << endl;

    cout << ".L" << label1 << ":" << endl;
    cout << endl;
}

void Return::generate() {
    _expr->generate();

    cout << endl;
    cout << "\tmovl\t" << _expr << ", \%eax" << endl;
    cout << "\tjmp\t.L" << functionCounter << endl;
    cout << endl;
}

/*
 * Helper functions
 */
void Expression::comparison(const string& op, const string& opcode, const Expression *_left, const Expression *_right) {
    cout << endl;
    cout << "# " << _left << " " << op << " " << _right << endl;
    cout << "\tmovl\t" << _left << ", \%eax" << endl;
    cout << "\tcmpl\t" << _right << ", \%eax" << endl;
    cout << "\t" << opcode << "\t\%al" << endl;
    cout << "\tmovzbl\t\%al, \%eax" << endl;
    cout << "\tmovl\t\%eax, " << this << endl;   
    cout << endl;
}
