insert:
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	insert
	.set	insert.size, 0

search:
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	search
	.set	search.size, 0

preorder:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$preorder.size, %esp
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	preorder
	.set	preorder.size, 4

inorder:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$inorder.size, %esp
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	inorder
	.set	inorder.size, 4

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$0, %eax
	movl	%eax, -48(%ebp)
	movl	null, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -52(%ebp)


# $7 - $4
	movl	$7, %eax
	imull	$4, %eax
	movl	%eax, -56(%ebp)


# -52(%ebp) - -56(%ebp)
	movl	-52(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	%eax, -60(%ebp)


# *-60(%ebp)
	movl	-60(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -64(%ebp)


# &-64(%ebp)
	leal	-64(%ebp), %eax
	movl	%eax, -68(%ebp)

	pushl	-68(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -72(%ebp)


# $4 - $4
	movl	$4, %eax
	imull	$4, %eax
	movl	%eax, -76(%ebp)


# -72(%ebp) - -76(%ebp)
	movl	-72(%ebp), %eax
	addl	-76(%ebp), %eax
	movl	%eax, -80(%ebp)


# *-80(%ebp)
	movl	-80(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -84(%ebp)


# &-84(%ebp)
	leal	-84(%ebp), %eax
	movl	%eax, -88(%ebp)

	pushl	-88(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -92(%ebp)


# $1 - $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)


# -92(%ebp) - -96(%ebp)
	movl	-92(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)


# *-100(%ebp)
	movl	-100(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -104(%ebp)


# &-104(%ebp)
	leal	-104(%ebp), %eax
	movl	%eax, -108(%ebp)

	pushl	-108(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -112(%ebp)


# $0 - $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -116(%ebp)


# -112(%ebp) - -116(%ebp)
	movl	-112(%ebp), %eax
	addl	-116(%ebp), %eax
	movl	%eax, -120(%ebp)


# *-120(%ebp)
	movl	-120(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -124(%ebp)


# &-124(%ebp)
	leal	-124(%ebp), %eax
	movl	%eax, -128(%ebp)

	pushl	-128(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -132(%ebp)


# $5 - $4
	movl	$5, %eax
	imull	$4, %eax
	movl	%eax, -136(%ebp)


# -132(%ebp) - -136(%ebp)
	movl	-132(%ebp), %eax
	addl	-136(%ebp), %eax
	movl	%eax, -140(%ebp)


# *-140(%ebp)
	movl	-140(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -144(%ebp)


# &-144(%ebp)
	leal	-144(%ebp), %eax
	movl	%eax, -148(%ebp)

	pushl	-148(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -152(%ebp)


# $2 - $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -156(%ebp)


# -152(%ebp) - -156(%ebp)
	movl	-152(%ebp), %eax
	addl	-156(%ebp), %eax
	movl	%eax, -160(%ebp)


# *-160(%ebp)
	movl	-160(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -164(%ebp)


# &-164(%ebp)
	leal	-164(%ebp), %eax
	movl	%eax, -168(%ebp)

	pushl	-168(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -172(%ebp)


# $3 - $4
	movl	$3, %eax
	imull	$4, %eax
	movl	%eax, -176(%ebp)


# -172(%ebp) - -176(%ebp)
	movl	-172(%ebp), %eax
	addl	-176(%ebp), %eax
	movl	%eax, -180(%ebp)


# *-180(%ebp)
	movl	-180(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -184(%ebp)


# &-184(%ebp)
	leal	-184(%ebp), %eax
	movl	%eax, -188(%ebp)

	pushl	-188(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -192(%ebp)


# $6 - $4
	movl	$6, %eax
	imull	$4, %eax
	movl	%eax, -196(%ebp)


# -192(%ebp) - -196(%ebp)
	movl	-192(%ebp), %eax
	addl	-196(%ebp), %eax
	movl	%eax, -200(%ebp)


# *-200(%ebp)
	movl	-200(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -204(%ebp)


# &-204(%ebp)
	leal	-204(%ebp), %eax
	movl	%eax, -208(%ebp)

	pushl	-208(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	, %eax
	movl	%eax, -4(%ebp)
	pushl	
	call	printf
	addl	$4, %esp
	pushl	-4(%ebp)
	call	preorder
	addl	$4, %esp
	pushl	
	call	printf
	addl	$4, %esp
	pushl	-4(%ebp)
	call	inorder
	addl	$4, %esp
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 48

	.data
	.comm	null, 4, 4
