foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$0, %eax
	movl	%eax, a

# !a
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, b

# !b
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)


# !-8(%ebp)
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


# !-12(%ebp)
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

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
