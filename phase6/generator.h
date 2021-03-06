/*
 * File:	generator.h
 *
 * Description:	This file contains the function declarations for the code
 *		generator for Simple C.  Most of the function declarations
 *		are actually member functions provided as part of Tree.h.
 */

# ifndef GENERATOR_H
# define GENERATOR_H
# include "Tree.h"

void generateGlobals(const Symbols &globals);
void assignTemp(Expression &e);

class Label {
public:
    static int counter;
    int number;
    friend std::ostream &operator <<(std::ostream &os, const Label &label);
    Label() {
	number = counter++;
    }

};
# endif /* GENERATOR_H */
