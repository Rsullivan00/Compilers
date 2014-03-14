int main (void)
{
    int a, b, c;
    a = 1;
    b = 0;
    c = 100;

    if (a)
	printf("%d\n", a);
    else
	printf("%d\n", 0);

    if (a && b && c) {
	printf("%d\n", a);
    } else {
	printf("%d\n", 4);
    } 
}
