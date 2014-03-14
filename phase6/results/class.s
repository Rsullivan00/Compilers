g:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$g.size, %esp

# Call printf
	pushl	8(%ebp)

.data
.L1: .asciz "Int func g: %d\n"
.text

	pushl	$.L1
	call	printf
	addl	$8, %esp
	movl	%eax, -4(%ebp)

	movl	8(%ebp), %eax
	jmp	.L0

.g.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	g
	.set	g.size, 4

h:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$h.size, %esp

# Call printf
	pushl	8(%ebp)

.data
.L3: .asciz "In func h: %d\n"
.text

	pushl	$.L3
	call	printf
	addl	$8, %esp
	movl	%eax, -4(%ebp)

	movl	8(%ebp), %eax
	jmp	.L2

.h.epilogue:
.L2:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	h
	.set	h.size, 4

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$4, %eax
	movl	%eax, -12(%ebp)

# Call printf
	pushl	-12(%ebp)

.data
.L5: .asciz "%d\n"
.text

	pushl	$.L5
	call	printf
	addl	$8, %esp
	movl	%eax, -16(%ebp)

# $1 + -12(%ebp)
	movl	$1, %eax
	addl	-12(%ebp), %eax
	movl	%eax, -20(%ebp)

	movl	-20(%ebp), %eax
	movl	%eax, -8(%ebp)

# Call printf
	pushl	-8(%ebp)

.data
.L6: .asciz "%d\n"
.text

	pushl	$.L6
	call	printf
	addl	$8, %esp
	movl	%eax, -24(%ebp)
	movl	$3, %eax
	movl	%eax, -4(%ebp)

# Call printf
	pushl	-4(%ebp)

.data
.L7: .asciz "%d\n"
.text

	pushl	$.L7
	call	printf
	addl	$8, %esp
	movl	%eax, -28(%ebp)

# Call g

# Call h
	pushl	$5
	call	h
	addl	$4, %esp
	movl	%eax, -32(%ebp)
	pushl	-32(%ebp)
	call	g
	addl	$4, %esp
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call printf
	pushl	-4(%ebp)

.data
.L8: .asciz "In main: %d\n"
.text

	pushl	$.L8
	call	printf
	addl	$8, %esp
	movl	%eax, -40(%ebp)

# -4(%ebp) > $0
	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -44(%ebp)


	movl	-44(%ebp), %eax
	cmpl	$0, %eax
	je	.L9

# -12(%ebp) > $0
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -48(%ebp)


	movl	-48(%ebp), %eax
	cmpl	$0, %eax
	je	.L11

# -8(%ebp) < $0
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -52(%ebp)


	movl	-52(%ebp), %eax
	cmpl	$0, %eax
	je	.L13

# Call printf

.data
.L15: .asciz "All excpet x are greater than 0\n"
.text

	pushl	$.L15
	call	printf
	addl	$4, %esp
	movl	%eax, -56(%ebp)
	jmp	.L14
.L13:

# Call printf

.data
.L16: .asciz "All greater than 0\n"
.text

	pushl	$.L16
	call	printf
	addl	$4, %esp
	movl	%eax, -60(%ebp)
.L14:

	jmp	.L12
.L11:
.L12:

	jmp	.L10
.L9:
.L10:

	movl	$5, %eax
	movl	%eax, -8(%ebp)
	movl	$5, %eax
	movl	%eax, -12(%ebp)

.L17:

# -8(%ebp) != $0
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -64(%ebp)

	movl	-64(%ebp), %eax
	cmpl	$0, %eax
	je	.L18

.L19:

# -12(%ebp) != $0
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -68(%ebp)

	movl	-68(%ebp), %eax
	cmpl	$0, %eax
	je	.L20

# Call printf
	pushl	-12(%ebp)

.data
.L21: .asciz "y is: %d\n"
.text

	pushl	$.L21
	call	printf
	addl	$8, %esp
	movl	%eax, -72(%ebp)

# -12(%ebp) - $1
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -76(%ebp)

	movl	-76(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	.L19
.L20:


# Call printf
	pushl	-8(%ebp)

.data
.L22: .asciz "X is: %d\n"
.text

	pushl	$.L22
	call	printf
	addl	$8, %esp
	movl	%eax, -80(%ebp)

# -8(%ebp) - $1
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -84(%ebp)

	movl	-84(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L17
.L18:


	movl	$0, %eax
	jmp	.L4

.main.epilogue:
.L4:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 84

