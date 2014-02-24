# include "lexer.h"
# include "Tree.h"

void Node::generate() {
    report("Node::generate() was reached.");
}

void Block::allocate(int &offset) {

}

void Function::allocate(int &offset) {
    Parameters *params = _id->type().parameters();

    for (unsigned i = 0; i < params->size(); i++) {
	params->at(i)._offset = offset;
	offset += sizeof(params->at(i));
    }
    
    _body->allocate(offset);
}

