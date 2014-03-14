foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp
	movl	$0, %eax
	movl	%eax, a

# !a
	movl	a, %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, b

# !b
	movl	b, %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)


# !-8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


# !-12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	movl	%eax, c
.foo.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo
	.set	foo.size, 16

	.data
	.comm	a, 4, 4
	.comm	b, 4, 4
	.comm	c, 4, 4
