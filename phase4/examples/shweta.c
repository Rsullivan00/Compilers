int x;
int *y;
int z[10];

void voidFunc(int z)
{
	return z+z; 			/* invalid return type */
}

int func(int *x, int y)
{
	return x; 				/* invalid return type */
}

int main(void)
{
	int a;
	int *b;
	int c[5];
	int **p;

	c[1] = 5;
	y = &x;
	x = z[1];
	x = &z; 					/* invalid lvalue in expression */ 
	b = y;
	y = b;
	c[1] = z[5];
	a = x;
	&z = x; 					/* invalid lvalue in expression */

	**p = 1;
	p = &y;
	p = y; 					/* invalid operands to binary = */
	y = *p;

	printf("hiii \n %d", p);

	while(z[1] > 0)
	{
		z[1] = z[1] - 1;
		if(z[2] > 0)
		{
			a = x;
		}
		else
		{
			z = 4; 			/* invalid lvalue in expression */
		}
	}

	if(*b == 6 || a != 9)
	{
		if(c[0] >= 6 && y == 2) /* invalid operands to binary == */
		{
			*p = 5; 			/* invalid operands to binary = */
		}
	}

	a = voidFunc(a); 		/* invalid operands to binary = */
	
	return func(&p, a);	/* invalid arguments to called function */
}

