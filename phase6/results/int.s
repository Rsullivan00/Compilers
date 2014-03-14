main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$100, %eax
	movl	%eax, -4(%ebp)
	movl	$30, %eax
	movl	%eax, -8(%ebp)
	movl	$2, %eax
	movl	%eax, -12(%ebp)

# -4(%ebp) + -8(%ebp)
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -36(%ebp)


# -36(%ebp) + -12(%ebp)
	movl	-36(%ebp), %eax
	addl	-12(%ebp), %eax
	movl	%eax, -40(%ebp)

	movl	-40(%ebp), %eax
	movl	%eax, -16(%ebp)

# -4(%ebp) - -8(%ebp)
	movl	-4(%ebp), %eax
	subl	-8(%ebp), %eax
	movl	%eax, -44(%ebp)


# -44(%ebp) - -12(%ebp)
	movl	-44(%ebp), %eax
	subl	-12(%ebp), %eax
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	%eax, -20(%ebp)

# -4(%ebp) * -8(%ebp)
	movl	-4(%ebp), %eax
	imull	-8(%ebp), %eax
	movl	%eax, -52(%ebp)


# -52(%ebp) * -12(%ebp)
	movl	-52(%ebp), %eax
	imull	-12(%ebp), %eax
	movl	%eax, -56(%ebp)

	movl	-56(%ebp), %eax
	movl	%eax, -24(%ebp)

# -4(%ebp) / -8(%ebp)
	movl	-4(%ebp), %eax
	movl	-8(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%eax, -60(%ebp)


# -60(%ebp) + -12(%ebp)
	movl	-60(%ebp), %eax
	addl	-12(%ebp), %eax
	movl	%eax, -64(%ebp)

	movl	-64(%ebp), %eax
	movl	%eax, -28(%ebp)

# -4(%ebp) % -8(%ebp)
	movl	-4(%ebp), %eax
	movl	-8(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%edx, -68(%ebp)


# -68(%ebp) - -12(%ebp)
	movl	-68(%ebp), %eax
	subl	-12(%ebp), %eax
	movl	%eax, -72(%ebp)

	movl	-72(%ebp), %eax
	movl	%eax, -32(%ebp)

# Call printf
	pushl	-16(%ebp)

.data
.L1: .asciz "%d\n"
.text

	pushl	$.L1
	call	printf
	addl	$8, %esp
	movl	%eax, -76(%ebp)

# Call printf
	pushl	-20(%ebp)

.data
.L2: .asciz "%d\n"
.text

	pushl	$.L2
	call	printf
	addl	$8, %esp
	movl	%eax, -80(%ebp)

# Call printf
	pushl	-24(%ebp)

.data
.L3: .asciz "%d\n"
.text

	pushl	$.L3
	call	printf
	addl	$8, %esp
	movl	%eax, -84(%ebp)

# Call printf
	pushl	-28(%ebp)

.data
.L4: .asciz "%d\n"
.text

	pushl	$.L4
	call	printf
	addl	$8, %esp
	movl	%eax, -88(%ebp)

# Call printf
	pushl	-32(%ebp)

.data
.L5: .asciz "%d\n"
.text

	pushl	$.L5
	call	printf
	addl	$8, %esp
	movl	%eax, -92(%ebp)
.main.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 92

