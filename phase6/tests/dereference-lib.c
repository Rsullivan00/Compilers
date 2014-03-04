/*
 * This file will not be run through your compiler.
 */

extern int a, *b, *c, d;

int main(void)
{
    foo();
    printf("%d\n", a);
    printf("%d\n", *b);
    printf("%d\n", *c);
    printf("%d\n", d);
}
