foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	movl	%eax, a
	movl	$2, %eax
	movl	%eax, b

# a + b
	movl	a, %eax
	addl	b, %eax
	movl	%eax, -4

	movl	-4(%ebp), %eax
	movl	%eax, c
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo
	.set	foo.size, 0

	.data
	.comm	a, 4, 4
	.comm	b, 4, 4
	.comm	c, 4, 4
