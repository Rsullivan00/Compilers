fib:
    pushl    %ebp
    movl    %esp, %ebp
    subl    $fib.size, %esp

    # If

    # Equal
    movl    8(%ebp), %eax
    cmpl    $0, %eax
    sete    %al
    movzbl    %al, %eax
    movl    %eax, -4(%ebp)


    # LogicalOr
    cmpl    $0, -4(%ebp)
    jne        .L3

    # Equal
    movl    8(%ebp), %eax
    cmpl    $1, %eax
    sete    %al
    movzbl    %al, %eax
    movl    %eax, -8(%ebp)

    cmpl    $0, -8(%ebp)
.L3:
    setne    %al
    movzbl    %al, %eax
    movl    %eax, -12(%ebp)
    movl    -12(%ebp), %eax
    cmpl    $0, %eax
    je        .L1
    # Then

    # Return
    movl    $1, %eax
    jmp        .R0
    jmp        .L2
.L1:
.L2:

    # Subtract
    movl    8(%ebp), %eax
    subl    $1, %eax
    movl    %eax, -16(%ebp)

    pushl    -16(%ebp)
    call    fib
    addl    $4, %esp
    movl    %eax, -20(%ebp)

    # Subtract
    movl    8(%ebp), %eax
    subl    $2, %eax
    movl    %eax, -24(%ebp)

    pushl    -24(%ebp)
    call    fib
    addl    $4, %esp
    movl    %eax, -28(%ebp)

    # Add
    movl    -20(%ebp), %eax
    addl    -28(%ebp), %eax
    movl    %eax, -32(%ebp)


    # Return
    movl    -32(%ebp), %eax
    jmp        .R0
.R0:
    movl    %ebp, %esp
    popl    %ebp
    ret

    .global    fib
    .set    fib.size, 32

main:
    pushl    %ebp
    movl    %esp, %ebp
    subl    $main.size, %esp
    leal    -4(%ebp), %eax
    movl    %eax, -8(%ebp)
    pushl    -8(%ebp)
.data
.L5: .asciz "%d"
.text
    pushl    $.L5
    call    scanf
    addl    $8, %esp
    movl    %eax, -12(%ebp)
    pushl    -4(%ebp)
    call    fib
    addl    $4, %esp
    movl    %eax, -16(%ebp)
    pushl    -16(%ebp)
.data
.L6: .asciz "%d\n"
.text
    pushl    $.L6
    call    printf
    addl    $8, %esp
    movl    %eax, -20(%ebp)
.R4:
    movl    %ebp, %esp
    popl    %ebp
    ret

    .global    main
    .set    main.size, 20



