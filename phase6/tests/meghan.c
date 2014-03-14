int a,b,c;
int x, y;
int *ip;

void main(void)
{
x=1;
y=5;
a=6;
b=7;
c=8;

print(x);

ip = &x;

print(x);

y = *ip;

print(x);

*ip = 3;
print(x);

a+b;
a-b;
a*b;
a/b;
a+b-c;
a+b*c;
a*b/c;
a-b/c;

if(x < y){
x = x+1;
printf("%d\n", x);
}
if(x==2)
printf("%d\n", y);
if(x!=3)
printf("%d\n", x);
if(x > y)
printf("%d\n", x);
if(x <= y)
printf("%d\n", x);
if(x >= y)
printf("%d\n", x);

if((c||(b+x-2)) >= 0)
printf("%s\n", "Greater than zero");
while(c>0){
printf("%d\n", c);
c = c-1;
}
if(!b)
printf("%s\n", "Not b");
if(!(a==b))
printf("%s\n", "Not a==b");
else
printf("%s\n", "a==b");

}

