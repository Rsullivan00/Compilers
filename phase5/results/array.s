main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$10, %eax
	movl	%eax, -4(%ebp)
	pushl	-4(%ebp)
	call	init_array
	addl	$4, %esp
	pushl	-4(%ebp)
	call	print_array
	addl	$4, %esp
.main.epilogue:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 4

	.data
	.comm	a, 40, 4
