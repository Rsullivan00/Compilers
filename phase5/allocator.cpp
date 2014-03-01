# include "Tree.h"

void Block::allocate(int &offset) {
    std::vector<Symbol *> symbols = declarations()->symbols();
    for(unsigned i = 0; i < symbols.size(); i++) {
        if (symbols[i]->offset() == 0) {
            symbols[i]->_offset = offset;
            if (symbols[i]->type().indirection() == 0 && symbols[i]->type().isArray())
                offset -= 4 * symbols[i]->type().length();
            else 
                offset -= 4;
        }
    }
}

void Function::allocate(int &offset) {
    int numParams = _id->type().parameters()->size();

    for (int i = 0; i < numParams; i++) {
        _body->declarations()->symbols()[i]->_offset = offset;
        /* For this assignment, all parameters are 4 bytes. */
        offset += 4;
    }
    
    offset = -4;
    _body->allocate(offset);
}

