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


	cmpl	$0, -4(%ebp)
	jne	1

# 8(%ebp) == $1
	movl	8(%ebp), %eax
	cmpl	$1, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)

	cmpl	$0-8(%ebp)
.L1:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	2

	movl	$1, %eax
	jmp	.L0

	jmp	3
2:
