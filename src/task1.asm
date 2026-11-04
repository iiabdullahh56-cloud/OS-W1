%include "asm_io.inc"

segment .data
    val1    dd  10
    val2    dd  15
    sum     dd  0

segment .text
    global asm_main
asm_main:
    enter   0,0
    pusha

    mov     eax, [val1]
    add     eax, [val2]
    mov     [sum], eax

    mov     eax, [sum]
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret