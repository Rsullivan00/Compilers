foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp
	movl	$4, %eax
	movl	%eax, a

# a % $3
	movl	a, %eax
	movl	$3, %ecx
	cltd
	idivl	%ecx
	movl	%edx, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, b

# a % b
	movl	a, %eax
	movl	b, %ecx
	cltd
	idivl	%ecx
	movl	%edx, -8(%ebp)

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
