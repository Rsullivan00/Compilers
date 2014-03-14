fib:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$fib.size, %esp

# 8(%ebp) == $0
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)


# Logical Or
	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	jne	.L1

# 8(%ebp) == $1
	movl	8(%ebp), %eax
	cmpl	$1, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)

	movl	-8(%ebp), %eax
	cmpl	$0, %eax
.L1:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	.L2

	movl	$1, %eax
	jmp	.L0

	jmp	.L3
.L2:
.L3:


# Call fib

# 8(%ebp) - $1
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -16(%ebp)

	pushl	-16(%ebp)
	call	fib
	addl	$4, %esp
	movl	%eax, -20(%ebp)

# Call fib

# 8(%ebp) - $2
	movl	8(%ebp), %eax
	subl	$2, %eax
	movl	%eax, -24(%ebp)

	pushl	-24(%ebp)
	call	fib
	addl	$4, %esp
	movl	%eax, -28(%ebp)

# -20(%ebp) + -28(%ebp)
	movl	-20(%ebp), %eax
	addl	-28(%ebp), %eax
	movl	%eax, -32(%ebp)


	movl	-32(%ebp), %eax
	jmp	.L0

.fib.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	fib
	.set	fib.size, 32

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp

# Call scanf

# &-4(%ebp)
	leal	-4(%ebp), %eax
	movl	%eax, -8(%ebp)

	pushl	-8(%ebp)

.data
.L5: .asciz "%d"
.text

	pushl	$.L5
	call	scanf
	addl	$8, %esp
	movl	%eax, -12(%ebp)

# Call printf

# Call fib
	pushl	-4(%ebp)
	call	fib
	addl	$4, %esp
	movl	%eax, -16(%ebp)
	pushl	-16(%ebp)

.data
.L6: .asciz "%d\n"
.text

	pushl	$.L6
	call	printf
	addl	$8, %esp
	movl	%eax, -20(%ebp)
.main.epilogue:
.L4:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 20

