insert:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$insert.size, %esp

# !8(%ebp)
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)


	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L1

# Call malloc

# $3 * $4
	movl	$3, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)

	pushl	-8(%ebp)
	call	malloc
	addl	$4, %esp
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 8(%ebp)

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)


# 8(%ebp) + -16(%ebp)
	movl	8(%ebp), %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)

	movl	12(%ebp), %eax
	movl	-20(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -24(%ebp)

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -28(%ebp)


# 8(%ebp) + -28(%ebp)
	movl	8(%ebp), %eax
	addl	-28(%ebp), %eax
	movl	%eax, -32(%ebp)

	movl	null, %eax
	movl	-32(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -36(%ebp)

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -40(%ebp)


# 8(%ebp) + -40(%ebp)
	movl	8(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)

	movl	null, %eax
	movl	-44(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -48(%ebp)
	jmp	.L2
.L1:

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -52(%ebp)


# 8(%ebp) + -52(%ebp)
	movl	8(%ebp), %eax
	addl	-52(%ebp), %eax
	movl	%eax, -56(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -64(%ebp)


# 8(%ebp) + -64(%ebp)
	movl	8(%ebp), %eax
	addl	-64(%ebp), %eax
	movl	%eax, -68(%ebp)


# *-68(%ebp)
	movl	-68(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -60(%ebp)


# 12(%ebp) < -60(%ebp)
	movl	12(%ebp), %eax
	cmpl	-60(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -72(%ebp)


	movl	-72(%ebp), %eax
	cmpl	$0, %eax
	je	.L3

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -76(%ebp)


# 8(%ebp) + -76(%ebp)
	movl	8(%ebp), %eax
	addl	-76(%ebp), %eax
	movl	%eax, -80(%ebp)


# Call insert
	pushl	12(%ebp)

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -84(%ebp)


# 8(%ebp) + -84(%ebp)
	movl	8(%ebp), %eax
	addl	-84(%ebp), %eax
	movl	%eax, -88(%ebp)


# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)


# 8(%ebp) + -96(%ebp)
	movl	8(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)


# *-100(%ebp)
	movl	-100(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -92(%ebp)

	pushl	-92(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -104(%ebp)
	movl	-104(%ebp), %eax
	movl	-80(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -108(%ebp)
	jmp	.L4
.L3:

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -112(%ebp)


# 8(%ebp) + -112(%ebp)
	movl	8(%ebp), %eax
	addl	-112(%ebp), %eax
	movl	%eax, -116(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -124(%ebp)


# 8(%ebp) + -124(%ebp)
	movl	8(%ebp), %eax
	addl	-124(%ebp), %eax
	movl	%eax, -128(%ebp)


# *-128(%ebp)
	movl	-128(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -120(%ebp)


# 12(%ebp) > -120(%ebp)
	movl	12(%ebp), %eax
	cmpl	-120(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -132(%ebp)


	movl	-132(%ebp), %eax
	cmpl	$0, %eax
	je	.L5

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -136(%ebp)


# 8(%ebp) + -136(%ebp)
	movl	8(%ebp), %eax
	addl	-136(%ebp), %eax
	movl	%eax, -140(%ebp)


# Call insert
	pushl	12(%ebp)

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -144(%ebp)


# 8(%ebp) + -144(%ebp)
	movl	8(%ebp), %eax
	addl	-144(%ebp), %eax
	movl	%eax, -148(%ebp)


# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -156(%ebp)


# 8(%ebp) + -156(%ebp)
	movl	8(%ebp), %eax
	addl	-156(%ebp), %eax
	movl	%eax, -160(%ebp)


# *-160(%ebp)
	movl	-160(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -152(%ebp)

	pushl	-152(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -164(%ebp)
	movl	-164(%ebp), %eax
	movl	-140(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -168(%ebp)
	jmp	.L6
.L5:
.L6:

.L4:

.L2:


	movl	8(%ebp), %eax
	jmp	.L0

.insert.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	insert
	.set	insert.size, 168

search:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$search.size, %esp

# !8(%ebp)
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)


	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L8

	movl	$0, %eax
	jmp	.L7

	jmp	.L9
.L8:
.L9:


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)


# 8(%ebp) + -8(%ebp)
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)


# 8(%ebp) + -20(%ebp)
	movl	8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)


# *-24(%ebp)
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)


# 12(%ebp) < -16(%ebp)
	movl	12(%ebp), %eax
	cmpl	-16(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -28(%ebp)


	movl	-28(%ebp), %eax
	cmpl	$0, %eax
	je	.L10

# Call search
	pushl	12(%ebp)

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)


# 8(%ebp) + -32(%ebp)
	movl	8(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)


# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -44(%ebp)


# 8(%ebp) + -44(%ebp)
	movl	8(%ebp), %eax
	addl	-44(%ebp), %eax
	movl	%eax, -48(%ebp)


# *-48(%ebp)
	movl	-48(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -40(%ebp)

	pushl	-40(%ebp)
	call	search
	addl	$8, %esp
	movl	%eax, -52(%ebp)

	movl	-52(%ebp), %eax
	jmp	.L7

	jmp	.L11
.L10:
.L11:


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -56(%ebp)


# 8(%ebp) + -56(%ebp)
	movl	8(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	%eax, -60(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -68(%ebp)


# 8(%ebp) + -68(%ebp)
	movl	8(%ebp), %eax
	addl	-68(%ebp), %eax
	movl	%eax, -72(%ebp)


# *-72(%ebp)
	movl	-72(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -64(%ebp)


# 12(%ebp) > -64(%ebp)
	movl	12(%ebp), %eax
	cmpl	-64(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -76(%ebp)


	movl	-76(%ebp), %eax
	cmpl	$0, %eax
	je	.L12

# Call search
	pushl	12(%ebp)

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -80(%ebp)


# 8(%ebp) + -80(%ebp)
	movl	8(%ebp), %eax
	addl	-80(%ebp), %eax
	movl	%eax, -84(%ebp)


# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -92(%ebp)


# 8(%ebp) + -92(%ebp)
	movl	8(%ebp), %eax
	addl	-92(%ebp), %eax
	movl	%eax, -96(%ebp)


# *-96(%ebp)
	movl	-96(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -88(%ebp)

	pushl	-88(%ebp)
	call	search
	addl	$8, %esp
	movl	%eax, -100(%ebp)

	movl	-100(%ebp), %eax
	jmp	.L7

	jmp	.L13
.L12:
.L13:


	movl	$1, %eax
	jmp	.L7

.search.epilogue:
.L7:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	search
	.set	search.size, 100

preorder:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$preorder.size, %esp

	movl	8(%ebp), %eax
	cmpl	$0, %eax
	je	.L15

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)


# 8(%ebp) + -8(%ebp)
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)


# 8(%ebp) + -20(%ebp)
	movl	8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)


# *-24(%ebp)
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call printf

# *-4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)

	pushl	-28(%ebp)

.data
.L17: .asciz "%d\n"
.text

	pushl	$.L17
	call	printf
	addl	$8, %esp
	movl	%eax, -32(%ebp)

# Call preorder

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -36(%ebp)


# 8(%ebp) + -36(%ebp)
	movl	8(%ebp), %eax
	addl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)


# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -48(%ebp)


# 8(%ebp) + -48(%ebp)
	movl	8(%ebp), %eax
	addl	-48(%ebp), %eax
	movl	%eax, -52(%ebp)


# *-52(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)

	pushl	-44(%ebp)
	call	preorder
	addl	$4, %esp
	movl	%eax, -56(%ebp)

# Call preorder

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -60(%ebp)


# 8(%ebp) + -60(%ebp)
	movl	8(%ebp), %eax
	addl	-60(%ebp), %eax
	movl	%eax, -64(%ebp)


# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -72(%ebp)


# 8(%ebp) + -72(%ebp)
	movl	8(%ebp), %eax
	addl	-72(%ebp), %eax
	movl	%eax, -76(%ebp)


# *-76(%ebp)
	movl	-76(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -68(%ebp)

	pushl	-68(%ebp)
	call	preorder
	addl	$4, %esp
	movl	%eax, -80(%ebp)
	jmp	.L16
.L15:
.L16:

.preorder.epilogue:
.L14:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	preorder
	.set	preorder.size, 80

inorder:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$inorder.size, %esp

	movl	8(%ebp), %eax
	cmpl	$0, %eax
	je	.L19

# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)


# 8(%ebp) + -8(%ebp)
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)


# 8(%ebp) + -20(%ebp)
	movl	8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)


# *-24(%ebp)
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call inorder

# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -28(%ebp)


# 8(%ebp) + -28(%ebp)
	movl	8(%ebp), %eax
	addl	-28(%ebp), %eax
	movl	%eax, -32(%ebp)


# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -40(%ebp)


# 8(%ebp) + -40(%ebp)
	movl	8(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)


# *-44(%ebp)
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -36(%ebp)

	pushl	-36(%ebp)
	call	inorder
	addl	$4, %esp
	movl	%eax, -48(%ebp)

# Call printf

# *-4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -52(%ebp)

	pushl	-52(%ebp)

.data
.L21: .asciz "%d\n"
.text

	pushl	$.L21
	call	printf
	addl	$8, %esp
	movl	%eax, -56(%ebp)

# Call inorder

# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -60(%ebp)


# 8(%ebp) + -60(%ebp)
	movl	8(%ebp), %eax
	addl	-60(%ebp), %eax
	movl	%eax, -64(%ebp)


# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -72(%ebp)


# 8(%ebp) + -72(%ebp)
	movl	8(%ebp), %eax
	addl	-72(%ebp), %eax
	movl	%eax, -76(%ebp)


# *-76(%ebp)
	movl	-76(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -68(%ebp)

	pushl	-68(%ebp)
	call	inorder
	addl	$4, %esp
	movl	%eax, -80(%ebp)
	jmp	.L20
.L19:
.L20:

.inorder.epilogue:
.L18:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	inorder
	.set	inorder.size, 80

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$0, %eax
	movl	%eax, -48(%ebp)

.L23:

# -48(%ebp) < $8
	movl	-48(%ebp), %eax
	cmpl	$8, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -52(%ebp)

	movl	-52(%ebp), %eax
	cmpl	$0, %eax
	je	.L24

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -56(%ebp)


# -48(%ebp) * $4
	movl	-48(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -60(%ebp)


# -56(%ebp) + -60(%ebp)
	movl	-56(%ebp), %eax
	addl	-60(%ebp), %eax
	movl	%eax, -64(%ebp)

	movl	-48(%ebp), %eax
	movl	-64(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	%eax, -68(%ebp)

# -48(%ebp) + $1
	movl	-48(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -72(%ebp)

	movl	-72(%ebp), %eax
	movl	%eax, -48(%ebp)
	jmp	.L23
.L24:

	movl	null, %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -76(%ebp)


# $7 * $4
	movl	$7, %eax
	imull	$4, %eax
	movl	%eax, -80(%ebp)


# -76(%ebp) + -80(%ebp)
	movl	-76(%ebp), %eax
	addl	-80(%ebp), %eax
	movl	%eax, -84(%ebp)


# &-84(%ebp)

	pushl	-84(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -88(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -92(%ebp)


# $4 * $4
	movl	$4, %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)


# -92(%ebp) + -96(%ebp)
	movl	-92(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)


# &-100(%ebp)

	pushl	-100(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -104(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -108(%ebp)


# $1 * $4
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -112(%ebp)


# -108(%ebp) + -112(%ebp)
	movl	-108(%ebp), %eax
	addl	-112(%ebp), %eax
	movl	%eax, -116(%ebp)


# &-116(%ebp)

	pushl	-116(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -120(%ebp)
	movl	-120(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -124(%ebp)


# $0 * $4
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -128(%ebp)


# -124(%ebp) + -128(%ebp)
	movl	-124(%ebp), %eax
	addl	-128(%ebp), %eax
	movl	%eax, -132(%ebp)


# &-132(%ebp)

	pushl	-132(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -136(%ebp)
	movl	-136(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -140(%ebp)


# $5 * $4
	movl	$5, %eax
	imull	$4, %eax
	movl	%eax, -144(%ebp)


# -140(%ebp) + -144(%ebp)
	movl	-140(%ebp), %eax
	addl	-144(%ebp), %eax
	movl	%eax, -148(%ebp)


# &-148(%ebp)

	pushl	-148(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -152(%ebp)
	movl	-152(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -156(%ebp)


# $2 * $4
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -160(%ebp)


# -156(%ebp) + -160(%ebp)
	movl	-156(%ebp), %eax
	addl	-160(%ebp), %eax
	movl	%eax, -164(%ebp)


# &-164(%ebp)

	pushl	-164(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -168(%ebp)
	movl	-168(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -172(%ebp)


# $3 * $4
	movl	$3, %eax
	imull	$4, %eax
	movl	%eax, -176(%ebp)


# -172(%ebp) + -176(%ebp)
	movl	-172(%ebp), %eax
	addl	-176(%ebp), %eax
	movl	%eax, -180(%ebp)


# &-180(%ebp)

	pushl	-180(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -184(%ebp)
	movl	-184(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call insert

# &-44(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -188(%ebp)


# $6 * $4
	movl	$6, %eax
	imull	$4, %eax
	movl	%eax, -192(%ebp)


# -188(%ebp) + -192(%ebp)
	movl	-188(%ebp), %eax
	addl	-192(%ebp), %eax
	movl	%eax, -196(%ebp)


# &-196(%ebp)

	pushl	-196(%ebp)
	pushl	-4(%ebp)
	call	insert
	addl	$8, %esp
	movl	%eax, -200(%ebp)
	movl	-200(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call printf

.data
.L25: .asciz "preorder traversal:\n"
.text

	pushl	$.L25
	call	printf
	addl	$4, %esp
	movl	%eax, -204(%ebp)

# Call preorder
	pushl	-4(%ebp)
	call	preorder
	addl	$4, %esp
	movl	%eax, -208(%ebp)

# Call printf

.data
.L26: .asciz "inorder traversal:\n"
.text

	pushl	$.L26
	call	printf
	addl	$4, %esp
	movl	%eax, -212(%ebp)

# Call inorder
	pushl	-4(%ebp)
	call	inorder
	addl	$4, %esp
	movl	%eax, -216(%ebp)
.main.epilogue:
.L22:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 216

	.data
	.comm	null, 4, 4
