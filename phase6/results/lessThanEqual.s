foo:
	pushl	%ebp
	movl	%esp, %ebp

# $0 <= $1
	movl	$0, %eax
	cmpl	$1, %eax
	setle	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, a

# $1 <= $0
	movl	$1, %eax
	cmpl	$0, %eax
	setle	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)

	movl	-8(%ebp), %eax
	movl	%eax, b
	movl	$1, %eax
	movl	%eax, d

# d <= a
	movl	d, %eax
	cmpl	a, %eax
	setle	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)

	movl	-12(%ebp), %eax
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
