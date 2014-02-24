/*
 * This file will not be run through your compiler.
 */

void call_towers(int n, int from, int to, int spare)
{
    if (n > 1)
	towers(n - 1, from, to, spare);
}


void print_move(int from, int to)
{
    printf("move a peg from %d to %d\n", from, to);
}
