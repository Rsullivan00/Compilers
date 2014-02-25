# include <iostream>
# include <string>
# include "Tree.h"
# include "lexer.h"

using namespace std;

static std::string prologue = "Prologue";
static std::string epilogue= "Epilogue";

void Node::generate() {
    report("Node::generate() was reached.");
}

void Block::generate() {

}

void Function::generate() {
    int offset = 8;
    allocate(offset);
    cout << prologue << endl;
    _body->generate();
    cout << epilogue << endl;
}

void Assignment::generate() {}

void Call::generate() {}
