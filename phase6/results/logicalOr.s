foo2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo2.size, %esp

# *8(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -4(%ebp)


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -8(%ebp)

	movl	-8(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -12(%ebp)

	movl	$0, %eax
	jmp	.L0

.foo2.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo2
	.set	foo2.size, 12

foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp
	movl	$1, %eax
	movl	%eax, a

# Logical Or
	movl	a, %eax
	cmpl	$0, %eax
	jne	.L2
	movl	$0, %eax
	cmpl	$0, %eax
.L2:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, b

# Logical Or
	movl	$0, %eax
	cmpl	$0, %eax
	jne	.L3
	movl	$0, %eax
	cmpl	$0, %eax
.L3:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)


# Logical Or
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	jne	.L4
	movl	$0, %eax
	cmpl	$0, %eax
.L4:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


# Logical Or
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	jne	.L5
	movl	b, %eax
	cmpl	$0, %eax
.L5:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)


# Logical Or
	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	jne	.L6

# Call foo2

# &a
	leal	a, %eax
	movl	%eax, -20(%ebp)

	pushl	-20(%ebp)
	call	foo2
	addl	$4, %esp
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	cmpl	$0, %eax
.L6:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -28(%ebp)

	movl	-28(%ebp), %eax
	movl	%eax, c

# Call foo2

# &a
	leal	a, %eax
	movl	%eax, -32(%ebp)

	pushl	-32(%ebp)
	call	foo2
	addl	$4, %esp
	movl	%eax, -36(%ebp)

# Logical Or
	movl	-36(%ebp), %eax
	cmpl	$0, %eax
	jne	.L7

# Call foo2

# &a
	leal	a, %eax
	movl	%eax, -40(%ebp)

	pushl	-40(%ebp)
	call	foo2
	addl	$4, %esp
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	cmpl	$0, %eax
.L7:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -48(%ebp)


# Logical Or
	movl	-48(%ebp), %eax
	cmpl	$0, %eax
	jne	.L8

# Call foo2

# &a
	leal	a, %eax
	movl	%eax, -52(%ebp)

	pushl	-52(%ebp)
	call	foo2
	addl	$4, %esp
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	cmpl	$0, %eax
.L8:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -60(%ebp)

	movl	-60(%ebp), %eax
	movl	%eax, a
.foo.epilogue:
.L1:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo
	.set	foo.size, 60

	.data
	.comm	a, 4, 4
	.comm	b, 4, 4
	.comm	c, 4, 4
