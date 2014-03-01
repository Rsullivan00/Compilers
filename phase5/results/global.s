foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp
	movl	$1, %eax
	movl	%eax, x
	movl	$2, %eax
	movl	%eax, y
	movl	$3, %eax
	movl	%eax, z
.foo.epilogue:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo
	.set	foo.size, 0

	.data
	.comm	x, 4, 4
	.comm	y, 4, 4
	.comm	z, 4, 4
