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

	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L2

# Call scanf

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)


# a + -12(%ebp)
	movl	a, %eax
	addl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)


# &-16(%ebp)

	pushl	-16(%ebp)

.data
.L3: .asciz "%d"
.text

	pushl	$.L3
	call	scanf
	addl	$8, %esp
	movl	%eax, -20(%ebp)

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -24(%ebp)

	movl	-24(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L1
.L2:

.readarray.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	readarray
	.set	readarray.size, 24

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

	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L6

# Call printf

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)


# a + -12(%ebp)
	movl	a, %eax
	addl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)


# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)


# a + -24(%ebp)
	movl	a, %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)


# *-28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)

	pushl	-20(%ebp)

.data
.L7: .asciz "%d "
.text

	pushl	$.L7
	call	printf
	addl	$8, %esp
	movl	%eax, -32(%ebp)

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -36(%ebp)

	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L5
.L6:


# Call printf

.data
.L8: .asciz "\n"
.text

	pushl	$.L8
	call	printf
	addl	$4, %esp
	movl	%eax, -40(%ebp)
.writearray.epilogue:
.L4:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	writearray
	.set	writearray.size, 40

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

# *12(%ebp)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)

	movl	-12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -16(%ebp)
	movl	-4(%ebp), %eax
	movl	12(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -20(%ebp)
.exchange.epilogue:
.L9:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	exchange
	.set	exchange.size, 20

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


# 12(%ebp) * $4
	movl	12(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -28(%ebp)


# 8(%ebp) + -28(%ebp)
	movl	8(%ebp), %eax
	addl	-28(%ebp), %eax
	movl	%eax, -32(%ebp)


# *-32(%ebp)
	movl	-32(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)

	movl	-24(%ebp), %eax
	movl	%eax, -12(%ebp)

# 12(%ebp) - $1
	movl	12(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -36(%ebp)

	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)

# 16(%ebp) + $1
	movl	16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -40(%ebp)

	movl	-40(%ebp), %eax
	movl	%eax, -8(%ebp)

.L11:

# -4(%ebp) < -8(%ebp)
	movl	-4(%ebp), %eax
	cmpl	-8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -44(%ebp)

	movl	-44(%ebp), %eax
	cmpl	$0, %eax
	je	.L12

# -8(%ebp) - $1
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	%eax, -8(%ebp)

.L13:

# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -52(%ebp)


# 8(%ebp) + -52(%ebp)
	movl	8(%ebp), %eax
	addl	-52(%ebp), %eax
	movl	%eax, -56(%ebp)


# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -64(%ebp)


# 8(%ebp) + -64(%ebp)
	movl	8(%ebp), %eax
	addl	-64(%ebp), %eax
	movl	%eax, -68(%ebp)


# *-68(%ebp)
	movl	-68(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -60(%ebp)


# -60(%ebp) > -12(%ebp)
	movl	-60(%ebp), %eax
	cmpl	-12(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -72(%ebp)

	movl	-72(%ebp), %eax
	cmpl	$0, %eax
	je	.L14

# -8(%ebp) - $1
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -76(%ebp)

	movl	-76(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L13
.L14:


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -80(%ebp)

	movl	-80(%ebp), %eax
	movl	%eax, -4(%ebp)

.L15:

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -84(%ebp)


# 8(%ebp) + -84(%ebp)
	movl	8(%ebp), %eax
	addl	-84(%ebp), %eax
	movl	%eax, -88(%ebp)


# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)


# 8(%ebp) + -96(%ebp)
	movl	8(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)


# *-100(%ebp)
	movl	-100(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -92(%ebp)


# -92(%ebp) < -12(%ebp)
	movl	-92(%ebp), %eax
	cmpl	-12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -104(%ebp)

	movl	-104(%ebp), %eax
	cmpl	$0, %eax
	je	.L16

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -108(%ebp)

	movl	-108(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L15
.L16:


# -4(%ebp) < -8(%ebp)
	movl	-4(%ebp), %eax
	cmpl	-8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -112(%ebp)


	movl	-112(%ebp), %eax
	cmpl	$0, %eax
	je	.L17

# Call exchange

# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -116(%ebp)


# 8(%ebp) + -116(%ebp)
	movl	8(%ebp), %eax
	addl	-116(%ebp), %eax
	movl	%eax, -120(%ebp)


# &-120(%ebp)

	pushl	-120(%ebp)

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -124(%ebp)


# 8(%ebp) + -124(%ebp)
	movl	8(%ebp), %eax
	addl	-124(%ebp), %eax
	movl	%eax, -128(%ebp)


# &-128(%ebp)

	pushl	-128(%ebp)
	call	exchange
	addl	$8, %esp
	movl	%eax, -132(%ebp)
	jmp	.L18
.L17:
.L18:

	jmp	.L11
.L12:


	movl	-8(%ebp), %eax
	jmp	.L10

.partition.epilogue:
.L10:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	partition
	.set	partition.size, 132

quicksort:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$quicksort.size, %esp

# 16(%ebp) > 12(%ebp)
	movl	16(%ebp), %eax
	cmpl	12(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)


	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L20

# Call partition
	pushl	16(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	partition
	addl	$12, %esp
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call quicksort
	pushl	-4(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	quicksort
	addl	$12, %esp
	movl	%eax, -16(%ebp)

# Call quicksort
	pushl	16(%ebp)

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -20(%ebp)

	pushl	-20(%ebp)
	pushl	8(%ebp)
	call	quicksort
	addl	$12, %esp
	movl	%eax, -24(%ebp)
	jmp	.L21
.L20:
.L21:

.quicksort.epilogue:
.L19:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	quicksort
	.set	quicksort.size, 24

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$8, %eax
	movl	%eax, n

# Call malloc

# n * $4
	movl	n, %eax
	imull	$4, %eax
	movl	%eax, -4(%ebp)

	pushl	-4(%ebp)
	call	malloc
	addl	$4, %esp
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, a

# Call readarray
	call	readarray
	movl	%eax, -12(%ebp)

# Call quicksort

# n - $1
	movl	n, %eax
	subl	$1, %eax
	movl	%eax, -16(%ebp)

	pushl	-16(%ebp)
	pushl	$0
	pushl	a
	call	quicksort
	addl	$12, %esp
	movl	%eax, -20(%ebp)

# Call writearray
	call	writearray
	movl	%eax, -24(%ebp)
.main.epilogue:
.L22:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 24

	.data
	.comm	n, 4, 4
	.comm	a, 4, 4
