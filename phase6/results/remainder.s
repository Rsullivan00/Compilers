foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	movl	%eax, a
	movl	$2, %eax
	movl	%eax, b

# b % a
	movl	b, %eax
	movl	a, %eax
	cltd
	idivl	%eax
	movl	%edx, -4

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
