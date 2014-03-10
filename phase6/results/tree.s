insert:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$insert.size, %esp

# !8(%ebp)
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)


	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	1
# Call malloc

# $3 * $4
	movl	$3, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)

	pushl	-8(%ebp)
	call	malloc
	addl	$4, %esp
	movl	, %eax
	movl	%eax, 8(%ebp)

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)


# 8(%ebp) + -12(%ebp)
	movl	8(%ebp), %eax
	addl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)


# *-16(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)

	movl	12(%ebp), %eax
	movl	%eax, -20(%ebp)

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)


# 8(%ebp) + -24(%ebp)
	movl	8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)


# *-28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)

	movl	null, %eax
	movl	%eax, -32(%ebp)

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -36(%ebp)


# 8(%ebp) + -36(%ebp)
	movl	8(%ebp), %eax
	addl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)


# *-40(%ebp)
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)

	movl	null, %eax
	movl	%eax, -44(%ebp)
	jmp	2
1:

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -48(%ebp)


# 8(%ebp) + -48(%ebp)
	movl	8(%ebp), %eax
	addl	-48(%ebp), %eax
	movl	%eax, -52(%ebp)


# *-52(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -56(%ebp)


# 12(%ebp) < -56(%ebp)
	movl	12(%ebp), %eax
	cmpl	-56(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -60(%ebp)


	movl	-60(%ebp), %eax
	cmpl	$0, %eax
	je	3

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -64(%ebp)


# 8(%ebp) + -64(%ebp)
	movl	8(%ebp), %eax
	addl	-64(%ebp), %eax
	movl	%eax, -68(%ebp)


# *-68(%ebp)
	movl	-68(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -72(%ebp)

# Call insert
	pushl	12(%ebp)

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -76(%ebp)


# 8(%ebp) + -76(%ebp)
	movl	8(%ebp), %eax
	addl	-76(%ebp), %eax
	movl	%eax, -80(%ebp)


# *-80(%ebp)
	movl	-80(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -84(%ebp)

	pushl	-84(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -72(%ebp)
	jmp	4
3:

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -88(%ebp)


# 8(%ebp) + -88(%ebp)
	movl	8(%ebp), %eax
	addl	-88(%ebp), %eax
	movl	%eax, -92(%ebp)


# *-92(%ebp)
	movl	-92(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -96(%ebp)


# 12(%ebp) > -96(%ebp)
	movl	12(%ebp), %eax
	cmpl	-96(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -100(%ebp)


	movl	-100(%ebp), %eax
	cmpl	$0, %eax
	je	5

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -104(%ebp)


# 8(%ebp) + -104(%ebp)
	movl	8(%ebp), %eax
	addl	-104(%ebp), %eax
	movl	%eax, -108(%ebp)


# *-108(%ebp)
	movl	-108(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -112(%ebp)

# Call insert
	pushl	12(%ebp)

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -116(%ebp)


# 8(%ebp) + -116(%ebp)
	movl	8(%ebp), %eax
	addl	-116(%ebp), %eax
	movl	%eax, -120(%ebp)


# *-120(%ebp)
	movl	-120(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -124(%ebp)

	pushl	-124(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -112(%ebp)
	jmp	6
5:
