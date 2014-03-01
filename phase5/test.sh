# Script for testing the parsing phase of the 
# Simple C Compiler

# Rick Sullivan

tests="array global local putchar towers"
prog="scc"
inputDir="examples"
outputDir="results"
solutionDir="examples"

for i in $tests; do
	./$prog < ./$inputDir/$i.c 1> ./$outputDir/$i.out 2> ./$outputDir/$i.err;
done

for i in $tests; do
	result="$(diff "./${outputDir}/${i}.err" "./${solutionDir}/${i}.err")"
	if $result >/dev/null 2>&1; then
		echo "Passed $i";
	else
		echo "Failed $i";
		echo "$result";
	fi 
done

