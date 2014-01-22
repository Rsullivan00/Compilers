int global1, global2;
int gArray1[5], gArray2[6];
int* gPointer1, gPointer2;
int bar(int a);
void foo(void);

int bar(int a) {
	return a * 5;	
}

void foo(void) {
	return (bar(1) + bar(2)) * 2;
}

int main(int a, int b, int c) {
	foo();
}
