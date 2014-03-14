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
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -8(%ebp)

.L1:

# -4(%ebp) < 8(%ebp)
	movl	-4(%ebp), %eax
	cmpl	8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)

	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L2

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)


# -8(%ebp) + -24(%ebp)
	movl	-8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)


# Call malloc

# 8(%ebp) * $4
	movl	8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)

	pushl	-32(%ebp)
	call	malloc
	addl	$4, %esp
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	-28(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -40(%ebp)

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -44(%ebp)

	movl	-44(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L1
.L2:


	movl	-8(%ebp), %eax
	jmp	.L0

.allocate.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	allocate
	.set	allocate.size, 44

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

	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	movl	$0, %eax
	movl	%eax, -8(%ebp)

.L6:

# -8(%ebp) < 12(%ebp)
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	je	.L7

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)


# 8(%ebp) + -20(%ebp)
	movl	8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)


# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)


# 8(%ebp) + -32(%ebp)
	movl	8(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)


# *-36(%ebp)
	movl	-36(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)


# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -40(%ebp)


# -28(%ebp) + -40(%ebp)
	movl	-28(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)


# -4(%ebp) + -8(%ebp)
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	-44(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -52(%ebp)

# -8(%ebp) + $1
	movl	-8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -56(%ebp)

	movl	-56(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L6
.L7:


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -60(%ebp)

	movl	-60(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L5:

.initialize.epilogue:
.L3:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	initialize
	.set	initialize.size, 60

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

	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	je	.L10
	movl	$0, %eax
	movl	%eax, -8(%ebp)

.L11:

# -8(%ebp) < 12(%ebp)
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)

	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L12

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)


# 8(%ebp) + -24(%ebp)
	movl	8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)


# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -36(%ebp)


# 8(%ebp) + -36(%ebp)
	movl	8(%ebp), %eax
	addl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)


# *-40(%ebp)
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)

	movl	-32(%ebp), %eax
	movl	%eax, -12(%ebp)

# Call printf

# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -44(%ebp)


# -12(%ebp) + -44(%ebp)
	movl	-12(%ebp), %eax
	addl	-44(%ebp), %eax
	movl	%eax, -48(%ebp)


# -8(%ebp) * $4
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -56(%ebp)


# -12(%ebp) + -56(%ebp)
	movl	-12(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	%eax, -60(%ebp)


# *-60(%ebp)
	movl	-60(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -52(%ebp)

	pushl	-52(%ebp)

.data
.L13: .asciz "%d "
.text

	pushl	$.L13
	call	printf
	addl	$8, %esp
	movl	%eax, -64(%ebp)

# -8(%ebp) + $1
	movl	-8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -68(%ebp)

	movl	-68(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L11
.L12:


# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -72(%ebp)

	movl	-72(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call printf

.data
.L14: .asciz "\n"
.text

	pushl	$.L14
	call	printf
	addl	$4, %esp
	movl	%eax, -76(%ebp)
	jmp	.L9
.L10:

.display.epilogue:
.L8:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	display
	.set	display.size, 76

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

	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L17

# Call free

# -4(%ebp) * $4
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)


# 8(%ebp) + -12(%ebp)
	movl	8(%ebp), %eax
	addl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)


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
	movl	%eax, -20(%ebp)

	pushl	-20(%ebp)
	call	free
	addl	$4, %esp
	movl	%eax, -32(%ebp)

# -4(%ebp) + $1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -36(%ebp)

	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L16
.L17:


# Call free
	pushl	8(%ebp)
	call	free
	addl	$4, %esp
	movl	%eax, -40(%ebp)
.deallocate.epilogue:
.L15:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	deallocate
	.set	deallocate.size, 40

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
	movl	%eax, -16(%ebp)

# Call allocate
	pushl	-8(%ebp)
	call	allocate
	addl	$4, %esp
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call initialize
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	initialize
	addl	$8, %esp
	movl	%eax, -24(%ebp)

# Call display
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	display
	addl	$8, %esp
	movl	%eax, -28(%ebp)

# Call deallocate
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	deallocate
	addl	$8, %esp
	movl	%eax, -32(%ebp)
.main.epilogue:
.L18:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 32

