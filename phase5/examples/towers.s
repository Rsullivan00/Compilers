towers:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	16(%ebp)
	pushl	20(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	call_towers
	addl	$16, %esp
	pushl	16(%ebp)
	pushl	12(%ebp)
	call	print_move
	addl	$8, %esp
	pushl	12(%ebp)
	pushl	16(%ebp)
	pushl	20(%ebp)
	pushl	8(%ebp)
	call	call_towers
	addl	$16, %esp
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
	pushl	$3
	pushl	$2
	pushl	$1
	pushl	-4(%ebp)
	call	towers
	addl	$16, %esp
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 4

