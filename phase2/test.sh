# Script for testing the parsing phase of the 
# Simple C Compiler

# Rick Sullivan

tests="sum malloc array fib hello params correctTest"
prog="scc"
inputDir="tests_in"
outputDir="tests_out"
solutionDir="solutions"

for i in $tests; do
	./$prog < $inputDir/$i.c > $outputDir/$i.out;
done

for i in $tests; do
	result=$(diff "./$outputDir/$i.out" "./$solutionDir/$i.out");
	if $result >/dev/null; then
		echo "Passed $i";
	else
		echo "Failed $i";
		echo "$result";
	fi 
done

