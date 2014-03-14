int a, b, c;

int foo2(int *num) {
    *num = *num + 1;
    return 0;
}

void foo(void) {
    a = 1;
    b = a || 0;
    c = 0 || 0 || 0 || b || foo2(&a); 
    a = foo2(&a) || foo2(&a) || foo2(&a);
}
