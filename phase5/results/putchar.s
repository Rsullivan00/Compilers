main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	pushl	83
	call	print
	addl	$4, %esp
	pushl	101
	call	print
	addl	$4, %esp
	pushl	103
	call	print
	addl	$4, %esp
	pushl	109
	call	print
	addl	$4, %esp
	pushl	101
	call	print
	addl	$4, %esp
	pushl	110
	call	print
	addl	$4, %esp
	pushl	116
	call	print
	addl	$4, %esp
	pushl	97
	call	print
	addl	$4, %esp
	pushl	116
	call	print
	addl	$4, %esp
	pushl	105
	call	print
	addl	$4, %esp
	pushl	111
	call	print
	addl	$4, %esp
	pushl	110
	call	print
	addl	$4, %esp
	pushl	32
	call	print
	addl	$4, %esp
	pushl	102
	call	print
	addl	$4, %esp
	pushl	97
	call	print
	addl	$4, %esp
	pushl	117
	call	print
	addl	$4, %esp
	pushl	108
	call	print
	addl	$4, %esp
	pushl	116
	call	print
	addl	$4, %esp
	pushl	10
	call	print
	addl	$4, %esp
.main.epilogue:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 0

