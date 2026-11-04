%include "asm_io.inc"

segment .text
    global asm_main
asm_main:
    enter   0,0
    pusha

    call    read_int
    push    eax
    call    read_int
    pop     ebx
    add     eax, ebx

    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret