# include <iostream>
# include <string>
# include <sstream>
# include <cmath>
# include "Tree.h"
# include "lexer.h"

using namespace std;

vector<Symbol *> globals;

void Function::printPrologue() {
    cout << _id->name() << ':' << endl;
    cout << "\tpushl\t\%ebp" << endl;
    cout << "\tmovl\t\%esp, \%ebp" << endl;
    cout << "\tsubl\t$" << _id->name() << ".size, \%esp" << endl;
}

void Function::printEpilogue(const int &funcSize) {
    cout << "." << _id->name() << ".epilogue:" << endl;
    cout << "\tmovl\t\%ebp, \%esp" << endl;
    cout << "\tpopl\t\%ebp" << endl;
    cout << "\tret" << endl << endl;
    
    cout << "\t.global\t" << _id->name() << endl;
    cout << "\t.set\t" << _id->name() << ".size, " << funcSize << endl << endl;
}

void Node::generate() {
    report("Node::generate() was reached.");
}

void Block::generate() {
    for (unsigned i = 0; i < _stmts.size(); i++) {
        _stmts[i]->generate();
    }

}

void Function::generate() {
    int offset = 8;
    allocate(offset);
    printPrologue();
    _body->generate();
    printEpilogue(abs((double)offset + 4));
}

void Assignment::generate() {
    _left->generate();
    _right->generate();
    cout << "\tmovl\t" << *_right << ", \%eax" << endl;
    cout << "\tmovl\t\%eax, " << *_left << endl;
}

void Identifier::generate() {
   if (_symbol->offset() == 0) {
        _operand = _symbol->name();
    } else {
        stringstream ss;
        ss << (_symbol->offset()) << "(\%ebp)";
        _operand = ss.str();
    }
}

void Number::generate() {
    stringstream ss;
    ss << "$" << value();
    _operand = ss.str();
}

void Call::generate() {
    for (int i = _args.size() - 1; i >=  0; i--) {
        _args[i]->generate();
        cout << "\tpushl\t" << *_args[i] << endl;
    }

    cout << "\tcall\t" << _id->name() << endl;
    cout << "\taddl\t$" << (_args.size() * 4) << ", \%esp" << endl;
}
