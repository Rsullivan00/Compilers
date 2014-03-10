foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp
	movl	$2, %eax
	movl	%eax, a

# a / $2
	movl	a, %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, b

# b / a
	movl	b, %eax
	movl	a, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -8(%ebp)

	movl	-8(%ebp), %eax
	movl	%eax, c
.foo.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo
	.set	foo.size, 0

	.data
	.comm	a, 4, 4
	.comm	b, 4, 4
	.comm	c, 4, 4
