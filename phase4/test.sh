#!/bin/bash
################################################################################
# File:         test.sh
#
# Desctription: A simple test script for phase 4
#
# Directions:   Note: anyting after a $ is a command
#               -download this file and save it in your phase4 directory
#               -open a terminal and change directories into your phase4 
#               directory
#               -$chmod +x test.sh
#               -$mkdir results
#               -$./test.sh
#               -open ./results/report to view your results
################################################################################

# Run example programs through our phase4 scc
./scc < examples/expr.c 2> results/expr.err
./scc < examples/stmt.c 2> results/stmt.err
./scc < examples/tree.c 2> results/tree.err
./scc < examples/void.c 2> results/void.err
./scc < examples/meghan.c 2> results/meghan.err
./scc < examples/shweta.c 2> results/shweta.err
./scc < examples/kevin.c 2> results/kevin.err

# Now diff the results with the example results and pipe the results into a file
echo "$USER's report for phase 4" > results/report
echo "(c) Daniel Leif Marks 2014" >> results/report
echo "" >> results/report

echo "expr.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/expr.err examples/expr.err >> results/report
echo "" >> results/report

echo "stmt.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/stmt.err examples/stmt.err >> results/report
echo "" >> results/report

echo "tree.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/tree.err examples/tree.err >> results/report
echo "" >> results/report

echo "void.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/void.err examples/void.err >> results/report
echo "" >> results/report

echo "kevin.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/kevin.err examples/kevin.err >> results/report
echo "" >> results/report

echo "meghan.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/meghan.err examples/meghan.err >> results/report
echo "" >> results/report

echo "shweta.c" >> results/report
echo "--------------------------------------------------------------------------------" >> results/report
diff results/shweta.err examples/shweta.err >> results/report

exit 0
