/* expr.c */

void foo(int x, int *y)
{
    int a[10], i, *p;


    p = &p;                     /* invalid operands to binary = */
    p = &a;                     /* invalid lvalue in expression */
    p = &a[0];
    p = &i;
    x = 0;

    a[1] = i;
    a[p] = i;                   /* invalid operands to binary [] */

    x(1);                       /* called object is not a function */
    printf("hello world\n");

    *i = 0;                     /* invalid operand to unary * */
    *a = 0;
    p = p + 1;

    i = (p < foo);              /* invalid operands to binary < */

    &x = p;                     /* invalid lvalue in expression */

    foo(1, a);
    foo(1, 2, 3);               /* invalid arguments to called function */
}
