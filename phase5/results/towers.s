towers:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$towers.size, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	pushl	16(%ebp)
	pushl	20(%ebp)
	call	print
	addl	$16, %esp
	pushl	12(%ebp)
	pushl	16(%ebp)
	call	print
	addl	$8, %esp
	pushl	16(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	pushl	20(%ebp)
	call	print
	addl	$16, %esp
.towers.epilogue:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	towers
	.set	towers.size, 0

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$3, %eax
	movl	%eax, -4(%ebp)
	pushl	3
	pushl	2
	pushl	1
	pushl	-4(%ebp)
	call	print
	addl	$16, %esp
.main.epilogue:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 4

