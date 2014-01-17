#include <iostream>
#include "tokens.h"



void expression(){

}

void expressionList() {

}
/*
 *  * Function:	report
 *   *
 *    * Description:	Report an error to the standard error prefixed with the
 *     *		line number.  We'll be using this a lot later with an
 *      *		optional string argument, but C++'s stupid streams don't do
 *       *		positional arguments, so we actually resort to snprintf.
 *        *		You just can't beat C for doing things down and dirty.
 *         */

void report(const string &str, const string &arg)
{
    char buf[1000];

    snprintf(buf, sizeof(buf), str.c_str(), arg.c_str());
    cerr << "line " << yylineno << ": " << buf << endl;
}

int main()
{
    yylex();
    return 0;
}

