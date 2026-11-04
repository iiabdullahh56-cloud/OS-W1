%include "asm_io.inc"

segment .data
    prompt_start    db  "Enter start (1-100): ", 0
    prompt_end      db  "Enter end (1-100): ", 0
    err_msg         db  "Error: invalid range", 0

segment .bss
    array       resd 100
    start_val   resd 1
    end_val     resd 1

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

    mov     eax, prompt_start
    call    print_string
    call    read_int
    mov     [start_val], eax

    mov     eax, prompt_end
    call    print_string
    call    read_int
    mov     [end_val], eax

    mov     eax, [start_val]
    cmp     eax, 1
    jl      .error
    mov     ebx, [end_val]
    cmp     ebx, 100
    jg      .error
    cmp     eax, ebx
    jg      .error

    mov     ecx, eax
    dec     ecx
    mov     edx, ebx
    mov     esi, 0
.sumloop:
    cmp     ecx, edx
    jge     .donesum
    mov     eax, [array + ecx*4]
    add     esi, eax
    inc     ecx
    jmp     .sumloop

.donesum:
    mov     eax, esi
    call    print_int
    call    print_nl
    jmp     .done

.error:
    mov     eax, err_msg
    call    print_string
    call    print_nl

.done:
    popa
    mov     eax, 0
    leave
    ret