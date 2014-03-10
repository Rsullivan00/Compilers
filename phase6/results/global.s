foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp

# x + $1
	movl	x, %eax
	addl	$1, %eax
	movl	%eax, -4(%ebp)

	movl	-4(%ebp), %eax
	movl	%eax, x

# x + $1
	movl	x, %eax
	addl	$1, %eax
	movl	%eax, -8(%ebp)


	movl	-8(%ebp), %eax
	jmp	.L0

.foo.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	foo
	.set	foo.size, 0

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$65, %eax
	movl	%eax, x
# Call putchar
	pushl	x
	call	putchar
	addl	$4, %esp
# Call putchar
# Call foo
	call	foo
	pushl	
	call	putchar
	addl	$4, %esp
# Call putchar
	pushl	x
	call	putchar
	addl	$4, %esp
# Call putchar
	pushl	$10
	call	putchar
	addl	$4, %esp
.main.epilogue:
.L1:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 0

	.data
	.comm	x, 4, 4
