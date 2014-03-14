 int g(int x){
printf("Int func g: %d\n", x);
return x;
}

int h(int y){
printf("In func h: %d\n", y);
return y;
}
int main(void){
int n;
int x;
int y;

y = 4;
printf("%d\n", y);

x = 1+y;
printf("%d\n", x);

n = 3;
printf("%d\n", n);

n = g(h(5));

printf("In main: %d\n", n);

if(n > 0){
if(y > 0){
if(x < 0){
printf("All excpet x are greater than 0\n");
}
else{
printf("All greater than 0\n");
}
}
}

x = 5;
y = 5;
while(x != 0){
while(y != 0){
printf("y is: %d\n", y);
y = y - 1;
}
printf("X is: %d\n", x);
x = x - 1;
}
return 0;
}
