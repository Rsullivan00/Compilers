int global1, global2;
int gArray1[5], gArray2[6];
int *gPointer, *gPointerArray[2];
int bar(int a);
void foo(void);

int bar(int a, int * b) {
	return a * 5;	
}

void foo(void) {
	return (bar(1, gPointer) + bar(2, gPointer)) * 2;
}

int main(void) {
	foo();
	gArray1[&gArray2[1] + 2];
	global1 = !*gPointer;
}
