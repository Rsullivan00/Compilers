main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$1, %eax
	movl	%eax, x
	movl	$5, %eax
	movl	%eax, y
	movl	$6, %eax
	movl	%eax, a
	movl	$7, %eax
	movl	%eax, b
	movl	$8, %eax
	movl	%eax, c

# Call print
	pushl	x
	call	print
	addl	$4, %esp
	movl	%eax, -4(%ebp)

# &x
	leal	x, %eax
	movl	%eax, -8(%ebp)

	movl	-8(%ebp), %eax
	movl	%eax, ip

# Call print
	pushl	x
	call	print
	addl	$4, %esp
	movl	%eax, -12(%ebp)

# *ip
	movl	ip, %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	movl	%eax, y

# Call print
	pushl	x
	call	print
	addl	$4, %esp
	movl	%eax, -20(%ebp)
	movl	$3, %eax
	movl	ip, %ecx
	movl	%eax, (%ecx)
	movl	%eax, -24(%ebp)

# Call print
	pushl	x
	call	print
	addl	$4, %esp
	movl	%eax, -28(%ebp)

# a + b
	movl	a, %eax
	addl	b, %eax
	movl	%eax, -32(%ebp)


# a - b
	movl	a, %eax
	subl	b, %eax
	movl	%eax, -36(%ebp)


# a * b
	movl	a, %eax
	imull	b, %eax
	movl	%eax, -40(%ebp)


# a / b
	movl	a, %eax
	movl	b, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -44(%ebp)


# a + b
	movl	a, %eax
	addl	b, %eax
	movl	%eax, -48(%ebp)


# -48(%ebp) - c
	movl	-48(%ebp), %eax
	subl	c, %eax
	movl	%eax, -52(%ebp)


# b * c
	movl	b, %eax
	imull	c, %eax
	movl	%eax, -56(%ebp)


# a + -56(%ebp)
	movl	a, %eax
	addl	-56(%ebp), %eax
	movl	%eax, -60(%ebp)


# a * b
	movl	a, %eax
	imull	b, %eax
	movl	%eax, -64(%ebp)


# -64(%ebp) / c
	movl	-64(%ebp), %eax
	movl	c, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -68(%ebp)


# b / c
	movl	b, %eax
	movl	c, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -72(%ebp)


# a - -72(%ebp)
	movl	a, %eax
	subl	-72(%ebp), %eax
	movl	%eax, -76(%ebp)


# x < y
	movl	x, %eax
	cmpl	y, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -80(%ebp)


	movl	-80(%ebp), %eax
	cmpl	$0, %eax
	je	.L1

# x + $1
	movl	x, %eax
	addl	$1, %eax
	movl	%eax, -84(%ebp)

	movl	-84(%ebp), %eax
	movl	%eax, x

# Call printf
	pushl	x

.data
.L3: .asciz "%d\n"
.text

	pushl	$.L3
	call	printf
	addl	$8, %esp
	movl	%eax, -88(%ebp)
	jmp	.L2
.L1:
.L2:


# x == $2
	movl	x, %eax
	cmpl	$2, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -92(%ebp)


	movl	-92(%ebp), %eax
	cmpl	$0, %eax
	je	.L4

# Call printf
	pushl	y

.data
.L6: .asciz "%d\n"
.text

	pushl	$.L6
	call	printf
	addl	$8, %esp
	movl	%eax, -96(%ebp)
	jmp	.L5
.L4:
.L5:


# x != $3
	movl	x, %eax
	cmpl	$3, %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -100(%ebp)


	movl	-100(%ebp), %eax
	cmpl	$0, %eax
	je	.L7

# Call printf
	pushl	x

.data
.L9: .asciz "%d\n"
.text

	pushl	$.L9
	call	printf
	addl	$8, %esp
	movl	%eax, -104(%ebp)
	jmp	.L8
.L7:
.L8:


# x > y
	movl	x, %eax
	cmpl	y, %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -108(%ebp)


	movl	-108(%ebp), %eax
	cmpl	$0, %eax
	je	.L10

# Call printf
	pushl	x

.data
.L12: .asciz "%d\n"
.text

	pushl	$.L12
	call	printf
	addl	$8, %esp
	movl	%eax, -112(%ebp)
	jmp	.L11
.L10:
.L11:


# x <= y
	movl	x, %eax
	cmpl	y, %eax
	setle	%al
	movzbl	%al, %eax
	movl	%eax, -116(%ebp)


	movl	-116(%ebp), %eax
	cmpl	$0, %eax
	je	.L13

# Call printf
	pushl	x

.data
.L15: .asciz "%d\n"
.text

	pushl	$.L15
	call	printf
	addl	$8, %esp
	movl	%eax, -120(%ebp)
	jmp	.L14
.L13:
.L14:


# x >= y
	movl	x, %eax
	cmpl	y, %eax
	setge	%al
	movzbl	%al, %eax
	movl	%eax, -124(%ebp)


	movl	-124(%ebp), %eax
	cmpl	$0, %eax
	je	.L16

# Call printf
	pushl	x

.data
.L18: .asciz "%d\n"
.text

	pushl	$.L18
	call	printf
	addl	$8, %esp
	movl	%eax, -128(%ebp)
	jmp	.L17
.L16:
.L17:


# Logical Or
	movl	c, %eax
	cmpl	$0, %eax
	jne	.L19

# b + x
	movl	b, %eax
	addl	x, %eax
	movl	%eax, -132(%ebp)


# -132(%ebp) - $2
	movl	-132(%ebp), %eax
	subl	$2, %eax
	movl	%eax, -136(%ebp)

	movl	-136(%ebp), %eax
	cmpl	$0, %eax
.L19:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -140(%ebp)


# -140(%ebp) >= $0
	movl	-140(%ebp), %eax
	cmpl	$0, %eax
	setge	%al
	movzbl	%al, %eax
	movl	%eax, -144(%ebp)


	movl	-144(%ebp), %eax
	cmpl	$0, %eax
	je	.L20

# Call printf

.data
.L22: .asciz "Greater than zero"
.text

	pushl	$.L22

.data
.L23: .asciz "%s\n"
.text

	pushl	$.L23
	call	printf
	addl	$8, %esp
	movl	%eax, -148(%ebp)
	jmp	.L21
.L20:
.L21:


.L24:

# c > $0
	movl	c, %eax
	cmpl	$0, %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -152(%ebp)

	movl	-152(%ebp), %eax
	cmpl	$0, %eax
	je	.L25

# Call printf
	pushl	c

.data
.L26: .asciz "%d\n"
.text

	pushl	$.L26
	call	printf
	addl	$8, %esp
	movl	%eax, -156(%ebp)

# c - $1
	movl	c, %eax
	subl	$1, %eax
	movl	%eax, -160(%ebp)

	movl	-160(%ebp), %eax
	movl	%eax, c
	jmp	.L24
.L25:


# !b
	movl	b, %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -164(%ebp)


	movl	-164(%ebp), %eax
	cmpl	$0, %eax
	je	.L27

# Call printf

.data
.L29: .asciz "Not b"
.text

	pushl	$.L29

.data
.L30: .asciz "%s\n"
.text

	pushl	$.L30
	call	printf
	addl	$8, %esp
	movl	%eax, -168(%ebp)
	jmp	.L28
.L27:
.L28:


# a == b
	movl	a, %eax
	cmpl	b, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -172(%ebp)


# !-172(%ebp)
	movl	-172(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -176(%ebp)


	movl	-176(%ebp), %eax
	cmpl	$0, %eax
	je	.L31

# Call printf

.data
.L33: .asciz "Not a==b"
.text

	pushl	$.L33

.data
.L34: .asciz "%s\n"
.text

	pushl	$.L34
	call	printf
	addl	$8, %esp
	movl	%eax, -180(%ebp)
	jmp	.L32
.L31:

# Call printf

.data
.L35: .asciz "a==b"
.text

	pushl	$.L35

.data
.L36: .asciz "%s\n"
.text

	pushl	$.L36
	call	printf
	addl	$8, %esp
	movl	%eax, -184(%ebp)
.L32:

.main.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 184

	.data
	.comm	a, 4, 4
	.comm	b, 4, 4
	.comm	c, 4, 4
	.comm	x, 4, 4
	.comm	y, 4, 4
	.comm	ip, 4, 4
