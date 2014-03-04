foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	movl	%eax, a
	movl	$2, %eax
	movl	%eax, d
# &a
	leal	a, %eax
	%eax, -4
	movl	-4(%ebp), %eax
	movl	%eax, b
# *b
	movl	b, %eax
	movl	(%eax), %eax
	movl	%eax, -8
	movl	$0, %eax
	movl	%eax, -8(%ebp)
# &d
	leal	d, %eax
	%eax, -12
	movl	-12(%ebp), %eax
	movl	%eax, b
	movl	b, %eax
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
	.comm	d, 4, 4
