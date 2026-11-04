%include "asm_io.inc"

segment .bss
    array   resd 100

segment .text
    global asm_main
asm_main:
    enter   0,0
    pusha

    mov     ecx, 0
.fill:
    mov     eax, ecx
    inc     eax
    mov     [array + ecx*4], eax
    inc     ecx
    cmp     ecx, 100
    jl      .fill

    mov     ecx, 0
    mov     ebx, 0
.sum:
    mov     eax, [array + ecx*4]
    add     ebx, eax
    inc     ecx
    cmp     ecx, 100
    jl      .sum

    mov     eax, ebx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret