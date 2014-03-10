lexan:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$lexan.size, %esp

# c == $0
	movl	c, %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	1
# Call getchar
	call	getchar
	movl	, %eax
	movl	%eax, c
	jmp	2
1:
