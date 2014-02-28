int a[10];
int *p;
int ****b;
int *c[20];
void *d;
void *e;
void ****f[90];
void g;                         /* 'g' has void type */
int **g;                        /* conflicting types for 'g' */
int *p;
int **********h[2];

void *h(void);                  /* conflicting types for 'h' */
void **i(int a, int b);
int hello(void);
int j(int k);
void l(int m);

void **i(int x, int z)
{
        if(x == 1)
                return **x;     /* invalid operand to unary * */
        return 2;               /* invalid return type */
}

int hello(void)
{
        if("hello")             /* invalid type for test expression */
                return 1;
        return 2;
}

void j(int k)                   /* conflicting types for 'j' */
{
        int b;

        if(a == b)              /* invalid operands to binary == */
                return 2;       /* invalid return type */

        if(a || b)
                return 1;       /* invalid return type */

        b = b + 2;

        if(a && b)
                return 2;       /* invalid return type */
        a = a-3;                /* invalid lvalue in expression */

        if(a > b)               /* invalid operands to binary > */
                return 1;       /* invalid return type */
        a = &1;                 /* invalid lvalue in expression */

        if(b <= b)
                return 4;       /* invalid return type */
        b = *b;                 /* invalid operand to unary * */
        return 1;               /* invalid return type */
}

int j(int k)                    /* redefinition of 'j' */
{
        if(p == a)
                return p;       /* invalid return type */
        if(p || a)
                return k;
        if(**p == *a)           /* invalid operand to unary * */
                return a;       /* invalid return type */
}

int y(void)
{
        if(y(a))                /* invalid arguments to called function */
                return 1;
}

void x(void)
{
        int a;
        a =  3+2;
}
int z(void)
{
        int y;
        if(a(b))                /* called object is not a function */
                return 1;
        if(j(2, 3, 4))          /* invalid arguments to called function */
                return 2;

        if((*a)%6)
                return 4;
        if(b%3)
                return 5;
        if(&a)                  /* invalid lvalue in expression */
                return 7;
        if(&9)                  /* invalid lvalue in expression */
                return 0;
        while(*a[34])           /* invalid operand to unary * */
                return 1;
        while(!x())             /* invalid operand to unary ! */
                return 2;
        while(!x)               /* invalid operand to unary ! */
                return 4;
        while(sizeof(x))        /* invalid operand to unary sizeof */
                return 5;
        if(x[2])                /* invalid operands to binary [] */
                return 6;
        if(a[2])
                return 8;
        if(**a)                 /* invalid operand to unary * */
                return 1;
        h();                    /* called object is not a function */
        i();                    /* invalid arguments to called function */
        *p = i(2, 3);           /* invalid operands to binary = */
        *q=0;                   /* 'q' undeclared */
        *y=u(3);                /* invalid operand to unary * */
        y = -x();               /* invalid operand to unary - */
}