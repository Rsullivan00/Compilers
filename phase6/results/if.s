main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$1, %eax
	movl	%eax, -4(%ebp)
	movl	$0, %eax
	movl	%eax, -8(%ebp)
	movl	$100, %eax
	movl	%eax, -12(%ebp)

	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L1

# Call printf
	pushl	-4(%ebp)

.data
.L3: .asciz "%d\n"
.text

	pushl	$.L3
	call	printf
	addl	$8, %esp
	movl	%eax, -16(%ebp)
	jmp	.L2
.L1:

# Call printf
	pushl	$0

.data
.L4: .asciz "%d\n"
.text

	pushl	$.L4
	call	printf
	addl	$8, %esp
	movl	%eax, -20(%ebp)
.L2:


	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
.L5:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -24(%ebp)


	movl	-24(%ebp), %eax
	cmpl	$0, %eax
	je	.L6
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
.L6:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -28(%ebp)


	movl	-28(%ebp), %eax
	cmpl	$0, %eax
	je	.L7

# Call printf
	pushl	-4(%ebp)

.data
.L9: .asciz "%d\n"
.text

	pushl	$.L9
	call	printf
	addl	$8, %esp
	movl	%eax, -32(%ebp)
	jmp	.L8
.L7:

# Call printf
	pushl	$4

.data
.L10: .asciz "%d\n"
.text

	pushl	$.L10
	call	printf
	addl	$8, %esp
	movl	%eax, -36(%ebp)
.L8:

.main.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 36

