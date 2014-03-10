allocate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$allocate.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
# Call malloc

# 8(%ebp) * $4
	movl	8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)

	pushl	-12(%ebp)
	call	malloc
	addl	$4, %esp
	movl	, %eax
	movl	%eax, -8(%ebp)

.L1:

# -4(%ebp) < 8(%ebp)
	movl	-4(%ebp), %eax
	cmpl	8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	cmpl	$0, -16(%ebp)
	je	2

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)


# -8(%ebp) + -20(%ebp)
	movl	-8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)


# *-24(%ebp)
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)

# Call malloc

# 8(%ebp) * $4
	movl	8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)

	pushl	-32(%ebp)
	call	malloc
	addl	$4, %esp
	movl	, %eax
	movl	%eax, -28(%ebp)

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -36(%ebp)

	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	1
.L2:


	movl	-8(%ebp), %eax
	jmp	.L0

.allocate.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	allocate
	.set	allocate.size, 8

initialize:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$initialize.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)

.L4:

# -4(%ebp) < 12(%ebp)
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)

	cmpl	$0, -12(%ebp)
	je	5
	movl	$0, %eax
	movl	%eax, -8(%ebp)

.L6:

# -8(%ebp) < 12(%ebp)
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	cmpl	$0, -16(%ebp)
	je	7

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)


# 8(%ebp) + -20(%ebp)
	movl	8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)


# *-24(%ebp)
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)


# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)


# -28(%ebp) + -32(%ebp)
	movl	-28(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)


# *-36(%ebp)
	movl	-36(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -40(%ebp)


# -4(%ebp) + -8(%ebp)
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -44(%ebp)

	movl	-44(%ebp), %eax
	movl	%eax, -40(%ebp)

# -8(%ebp) + $1
	movl	-8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	6
.L7:


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -52(%ebp)

	movl	-52(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	4
.L5:

.initialize.epilogue:
.L3:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	initialize
	.set	initialize.size, 8

display:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$display.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)

.L9:

# -4(%ebp) < 12(%ebp)
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	cmpl	$0, -16(%ebp)
	je	10
	movl	$0, %eax
	movl	%eax, -8(%ebp)

.L11:

# -8(%ebp) < 12(%ebp)
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)

	cmpl	$0, -20(%ebp)
	je	12

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
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

	movl	-32(%ebp), %eax
	movl	%eax, -12(%ebp)
# Call printf

# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -36(%ebp)


# -12(%ebp) + -36(%ebp)
	movl	-12(%ebp), %eax
	addl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)


# *-40(%ebp)
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)

	pushl	-44(%ebp)

.data
.L13: .asciz "%d "
.text

	pushl	$.L13
	call	printf
	addl	$8, %esp

# -8(%ebp) + $1
	movl	-8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	11
.L12:


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -52(%ebp)

	movl	-52(%ebp), %eax
	movl	%eax, -4(%ebp)
# Call printf

.data
.L14: .asciz "\n"
.text

	pushl	$.L14
	call	printf
	addl	$4, %esp
	jmp	9
.L10:

.display.epilogue:
.L8:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	display
	.set	display.size, 12

deallocate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$deallocate.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)

.L16:

# -4(%ebp) < 12(%ebp)
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)

	cmpl	$0, -8(%ebp)
	je	17
# Call free

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
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

	pushl	-20(%ebp)
	call	free
	addl	$4, %esp

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -24(%ebp)

	movl	-24(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	16
.L17:

# Call free
	pushl	8(%ebp)
	call	free
	addl	$4, %esp
.deallocate.epilogue:
.L15:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	deallocate
	.set	deallocate.size, 4

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
# Call scanf

# &-8(%ebp)
	leal	-8(%ebp), %eax
	movl	%eax, -12(%ebp)

	pushl	-12(%ebp)

.data
.L19: .asciz "%d"
.text

	pushl	$.L19
	call	scanf
	addl	$8, %esp
# Call allocate
	pushl	-8(%ebp)
	call	allocate
	addl	$4, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)
# Call initialize
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	initialize
	addl	$8, %esp
# Call display
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	display
	addl	$8, %esp
# Call deallocate
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	deallocate
	addl	$8, %esp
.main.epilogue:
.L18:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 8

