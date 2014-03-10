readarray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$readarray.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)

.L1:

# -4(%ebp) < n
	movl	-4(%ebp), %eax
	cmpl	n, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)

	cmpl	$0, -8(%ebp)
	je	2
# Call scanf

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)


# a + -12(%ebp)
	movl	a, %eax
	addl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)


# *-16(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)


# &-20(%ebp)
	leal	-20(%ebp), %eax
	movl	%eax, -24(%ebp)

	pushl	-24(%ebp)

.data
.L3: .asciz "%d"
.text

	pushl	$.L3
	call	scanf
	addl	$8, %esp

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -28(%ebp)

	movl	-28(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	1
.L2:

.readarray.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	readarray
	.set	readarray.size, 4

writearray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$writearray.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)

.L5:

# -4(%ebp) < n
	movl	-4(%ebp), %eax
	cmpl	n, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)

	cmpl	$0, -8(%ebp)
	je	6
# Call printf

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)


# a + -12(%ebp)
	movl	a, %eax
	addl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)


# *-16(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)

	pushl	-20(%ebp)

.data
.L7: .asciz "%d "
.text

	pushl	$.L7
	call	printf
	addl	$8, %esp

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -24(%ebp)

	movl	-24(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	5
.L6:

# Call printf

.data
.L8: .asciz "\n"
.text

	pushl	$.L8
	call	printf
	addl	$4, %esp
.writearray.epilogue:
.L4:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	writearray
	.set	writearray.size, 4

exchange:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$exchange.size, %esp

# *8(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -8(%ebp)

	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)

# *8(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)


# *12(%ebp)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	movl	%eax, -12(%ebp)

# *12(%ebp)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, -20(%ebp)
.exchange.epilogue:
.L9:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	exchange
	.set	exchange.size, 4

partition:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$partition.size, %esp

# 12(%ebp) * $4
	movl	12(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)


# 8(%ebp) + -16(%ebp)
	movl	8(%ebp), %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)


# *-20(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)

	movl	-24(%ebp), %eax
	movl	%eax, -12(%ebp)

# 12(%ebp) - $1
	movl	12(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -28(%ebp)

	movl	-28(%ebp), %eax
	movl	%eax, -4(%ebp)

# 16(%ebp) + $1
	movl	16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -32(%ebp)

	movl	-32(%ebp), %eax
	movl	%eax, -8(%ebp)

.L11:

# -4(%ebp) < -8(%ebp)
	movl	-4(%ebp), %eax
	cmpl	-8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -36(%ebp)

	cmpl	$0, -36(%ebp)
	je	12

# -8(%ebp) - $1
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -40(%ebp)

	movl	-40(%ebp), %eax
	movl	%eax, -8(%ebp)

.L13:

# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -44(%ebp)


# 8(%ebp) + -44(%ebp)
	movl	8(%ebp), %eax
	addl	-44(%ebp), %eax
	movl	%eax, -48(%ebp)


# *-48(%ebp)
	movl	-48(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -52(%ebp)


# -52(%ebp) > -12(%ebp)
	movl	-52(%ebp), %eax
	cmpl	-12(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -56(%ebp)

	cmpl	$0, -56(%ebp)
	je	14

# -8(%ebp) - $1
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -60(%ebp)

	movl	-60(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	13
.L14:


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -64(%ebp)

	movl	-64(%ebp), %eax
	movl	%eax, -4(%ebp)

.L15:

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -68(%ebp)


# 8(%ebp) + -68(%ebp)
	movl	8(%ebp), %eax
	addl	-68(%ebp), %eax
	movl	%eax, -72(%ebp)


# *-72(%ebp)
	movl	-72(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -76(%ebp)


# -76(%ebp) < -12(%ebp)
	movl	-76(%ebp), %eax
	cmpl	-12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -80(%ebp)

	cmpl	$0, -80(%ebp)
	je	16

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -84(%ebp)

	movl	-84(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	15
.L16:


# -4(%ebp) < -8(%ebp)
	movl	-4(%ebp), %eax
	cmpl	-8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -88(%ebp)


	movl	-88(%ebp), %eax
	cmpl	$0, %eax
	je	17
# Call exchange

# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -92(%ebp)


# 8(%ebp) + -92(%ebp)
	movl	8(%ebp), %eax
	addl	-92(%ebp), %eax
	movl	%eax, -96(%ebp)


# *-96(%ebp)
	movl	-96(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -100(%ebp)


# &-100(%ebp)
	leal	-100(%ebp), %eax
	movl	%eax, -104(%ebp)

	pushl	-104(%ebp)

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -108(%ebp)


# 8(%ebp) + -108(%ebp)
	movl	8(%ebp), %eax
	addl	-108(%ebp), %eax
	movl	%eax, -112(%ebp)


# *-112(%ebp)
	movl	-112(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -116(%ebp)


# &-116(%ebp)
	leal	-116(%ebp), %eax
	movl	%eax, -120(%ebp)

	pushl	-120(%ebp)
	call	exchange
	addl	$8, %esp
	jmp	18
17:
