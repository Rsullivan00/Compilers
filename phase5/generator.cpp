# include <iostream>
# include <string>
# include <cmath>
# include "Tree.h"
# include "lexer.h"

using namespace std;

void Function::printPrologue() {
    cout << _id->name() << ':' << endl;
    cout << "\tpushl\t\%ebp" << endl;
    cout << "\tmovl\t\%esp, \%ebp" << endl;
}

void Function::printEpilogue(const int &funcSize) {
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
    for(unsigned i = 0; i < _stmts.size(); i++) {
        _stmts[i]->generate();
    }
}

void Function::generate() {
    int offset = 8;
    allocate(offset);
    printPrologue();
    _body->generate();
    printEpilogue(abs(offset + 4));
}

void Assignment::generate() {
    // Need to handle globals vs locals
    cout << "\tmovl\t$" << _right->operand() << ", \%ebp" << endl;
    cout << "\tmovl\t\%eax, " << _left->operand() << endl;
}

void Call::generate() {}
