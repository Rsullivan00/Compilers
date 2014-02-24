# include <iostream>
# include <string>
# include "Tree.h"

using namespace std;

static string prologue = "Prologue";
static string epilogue= "Epilogue";

void Function::generate() {
    int offset = 0;
    allocate(offset);
    cout << prologue << endl;
    _body->generate();
    cout << epilogue << endl;
}


