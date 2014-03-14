main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp

# Call printf

.data
.L1: .asciz "hello world\n"
.text

	pushl	$.L1
	call	printf
	addl	$4, %esp
	movl	%eax, -4(%ebp)
.main.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 4

