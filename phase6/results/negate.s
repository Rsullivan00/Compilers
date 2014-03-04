foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	movl	%eax, a

# -a
	movl	a, %eax
	negl	%eax
	movl	%eax, -4

	movl	-4(%ebp), %eax
	movl	%eax, b

# -b
	movl	b, %eax
	negl	%eax
	movl	%eax, -8


# --8(%ebp)
	movl	-8(%ebp), %eax
	negl	%eax
	movl	%eax, -12


# --12(%ebp)
	movl	-12(%ebp), %eax
	negl	%eax
	movl	%eax, -16

	movl	-16(%ebp), %eax
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
