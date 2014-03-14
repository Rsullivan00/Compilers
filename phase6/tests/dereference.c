int a, *b, *c, d;

void foo(void) {
    a = 1;
    d = 2;
    b = &a;
    *b = 0;
    b = &d;
    c = &*b; 
}
