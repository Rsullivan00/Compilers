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
	je	.L1

# Call getchar
	call	getchar
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, c
	jmp	.L2
.L1:
.L2:


.L3:

# Call isspace
	pushl	c
	call	isspace
	addl	$4, %esp
	movl	%eax, -20(%ebp)

	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L5

# c != LF
	movl	c, %eax
	cmpl	LF, %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -24(%ebp)

	movl	-24(%ebp), %eax
	cmpl	$0, %eax
.L5:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -28(%ebp)

	movl	-28(%ebp), %eax
	cmpl	$0, %eax
	je	.L4

# Call getchar
	call	getchar
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, c
	jmp	.L3
.L4:


# Call isdigit
	pushl	c
	call	isdigit
	addl	$4, %esp
	movl	%eax, -36(%ebp)

# !-36(%ebp)
	movl	-36(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -40(%ebp)


	movl	-40(%ebp), %eax
	cmpl	$0, %eax
	je	.L6
	movl	c, %eax
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	movl	%eax, c

	movl	-8(%ebp), %eax
	jmp	.L0

	jmp	.L7
.L6:
.L7:

	movl	$0, %eax
	movl	%eax, -4(%ebp)

.L8:

# Call isdigit
	pushl	c
	call	isdigit
	addl	$4, %esp
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	cmpl	$0, %eax
	je	.L9

# -4(%ebp) * $10
	movl	-4(%ebp), %eax
	imull	$10, %eax
	movl	%eax, -48(%ebp)


# -48(%ebp) + c
	movl	-48(%ebp), %eax
	addl	c, %eax
	movl	%eax, -52(%ebp)


# -52(%ebp) - $48
	movl	-52(%ebp), %eax
	subl	$48, %eax
	movl	%eax, -56(%ebp)

	movl	-56(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call getchar
	pushl	c
	call	getchar
	addl	$4, %esp
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, c
	jmp	.L8
.L9:

	movl	-4(%ebp), %eax
	movl	%eax, lexval

	movl	NUM, %eax
	jmp	.L0

.lexan.epilogue:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	lexan
	.set	lexan.size, 60

match:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$match.size, %esp

# lookahead != 8(%ebp)
	movl	lookahead, %eax
	cmpl	8(%ebp), %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)


	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L11

# Call printf
	pushl	lookahead

.data
.L13: .asciz "syntax error at %d\n"
.text

	pushl	$.L13
	call	printf
	addl	$8, %esp
	movl	%eax, -8(%ebp)

# Call exit
	pushl	$1
	call	exit
	addl	$4, %esp
	movl	%eax, -12(%ebp)
	jmp	.L12
.L11:
.L12:


# Call lexan
	call	lexan
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, lookahead
.match.epilogue:
.L10:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	match
	.set	match.size, 16

factor:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$factor.size, %esp

# lookahead == LPAREN
	movl	lookahead, %eax
	cmpl	LPAREN, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)


	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L15

# Call match
	pushl	LPAREN
	call	match
	addl	$4, %esp
	movl	%eax, -12(%ebp)

# Call expr
	call	expr
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call match
	pushl	RPAREN
	call	match
	addl	$4, %esp
	movl	%eax, -20(%ebp)

	movl	-4(%ebp), %eax
	jmp	.L14

	jmp	.L16
.L15:
.L16:

	movl	lexval, %eax
	movl	%eax, -4(%ebp)

# Call match
	pushl	NUM
	call	match
	addl	$4, %esp
	movl	%eax, -24(%ebp)

	movl	-4(%ebp), %eax
	jmp	.L14

.factor.epilogue:
.L14:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	factor
	.set	factor.size, 24

term:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$term.size, %esp

# Call factor
	call	factor
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)

.L18:

# lookahead == MUL
	movl	lookahead, %eax
	cmpl	MUL, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


# Logical Or
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	jne	.L20

# lookahead == DIV
	movl	lookahead, %eax
	cmpl	DIV, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	cmpl	$0, %eax
.L20:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)

	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L19

# lookahead == MUL
	movl	lookahead, %eax
	cmpl	MUL, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -24(%ebp)


	movl	-24(%ebp), %eax
	cmpl	$0, %eax
	je	.L21

# Call match
	pushl	MUL
	call	match
	addl	$4, %esp
	movl	%eax, -28(%ebp)

# Call factor
	call	factor
	movl	%eax, -32(%ebp)

# -4(%ebp) * -32(%ebp)
	movl	-4(%ebp), %eax
	imull	-32(%ebp), %eax
	movl	%eax, -36(%ebp)

	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L22
.L21:

# Call match
	pushl	DIV
	call	match
	addl	$4, %esp
	movl	%eax, -40(%ebp)

# Call factor
	call	factor
	movl	%eax, -44(%ebp)

# -4(%ebp) / -44(%ebp)
	movl	-4(%ebp), %eax
	movl	-44(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	%eax, -4(%ebp)
.L22:

	jmp	.L18
.L19:


	movl	-4(%ebp), %eax
	jmp	.L17

.term.epilogue:
.L17:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	term
	.set	term.size, 48

expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$expr.size, %esp

# Call term
	call	term
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)

.L24:

# lookahead == ADD
	movl	lookahead, %eax
	cmpl	ADD, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)


# Logical Or
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	jne	.L26

# lookahead == SUB
	movl	lookahead, %eax
	cmpl	SUB, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	cmpl	$0, %eax
.L26:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)

	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L25

# lookahead == ADD
	movl	lookahead, %eax
	cmpl	ADD, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -24(%ebp)


	movl	-24(%ebp), %eax
	cmpl	$0, %eax
	je	.L27

# Call match
	pushl	ADD
	call	match
	addl	$4, %esp
	movl	%eax, -28(%ebp)

# Call term
	call	term
	movl	%eax, -32(%ebp)

# -4(%ebp) + -32(%ebp)
	movl	-4(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)

	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L28
.L27:

# Call match
	pushl	SUB
	call	match
	addl	$4, %esp
	movl	%eax, -40(%ebp)

# Call term
	call	term
	movl	%eax, -44(%ebp)

# -4(%ebp) - -44(%ebp)
	movl	-4(%ebp), %eax
	subl	-44(%ebp), %eax
	movl	%eax, -48(%ebp)

	movl	-48(%ebp), %eax
	movl	%eax, -4(%ebp)
.L28:

	jmp	.L24
.L25:


	movl	-4(%ebp), %eax
	jmp	.L23

.expr.epilogue:
.L23:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	expr
	.set	expr.size, 48

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$10, %eax
	movl	%eax, LF
	movl	$40, %eax
	movl	%eax, LPAREN
	movl	$41, %eax
	movl	%eax, RPAREN
	movl	$42, %eax
	movl	%eax, MUL
	movl	$43, %eax
	movl	%eax, ADD
	movl	$45, %eax
	movl	%eax, SUB
	movl	$47, %eax
	movl	%eax, DIV
	movl	$256, %eax
	movl	%eax, NUM

# Call lexan
	call	lexan
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, lookahead

.L30:

# -$1
	movl	$1, %eax
	negl	%eax
	movl	%eax, -12(%ebp)


# lookahead != -12(%ebp)
	movl	lookahead, %eax
	cmpl	-12(%ebp), %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)

	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	je	.L31

# Call expr
	call	expr
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -4(%ebp)

# Call printf
	pushl	-4(%ebp)

.data
.L32: .asciz "%d\n"
.text

	pushl	$.L32
	call	printf
	addl	$8, %esp
	movl	%eax, -24(%ebp)

.L33:

# lookahead == LF
	movl	lookahead, %eax
	cmpl	LF, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -28(%ebp)

	movl	-28(%ebp), %eax
	cmpl	$0, %eax
	je	.L34

# Call match
	pushl	LF
	call	match
	addl	$4, %esp
	movl	%eax, -32(%ebp)
	jmp	.L33
.L34:

	jmp	.L30
.L31:

.main.epilogue:
.L29:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.global	main
	.set	main.size, 32

	.data
	.comm	ADD, 4, 4
	.comm	SUB, 4, 4
	.comm	MUL, 4, 4
	.comm	DIV, 4, 4
	.comm	NUM, 4, 4
	.comm	LF, 4, 4
	.comm	LPAREN, 4, 4
	.comm	RPAREN, 4, 4
	.comm	lookahead, 4, 4
	.comm	c, 4, 4
	.comm	lexval, 4, 4
