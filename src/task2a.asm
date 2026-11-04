%include "asm_io.inc"

segment .data
    prompt_name     db  "Enter your name: ", 0
    prompt_num      db  "How many times to print welcome (51-99): ", 0
    welcome_msg     db  "Welcome, ", 0
    err_msg         db  "Error: number out of range", 0

segment .bss
    name_buf        resb 50
    num             resd 1

segment .text
    global asm_main
asm_main:
    enter   0,0
    pusha

    mov     eax, prompt_name
    call    print_string

    mov     edi, name_buf
.read_name_loop:
    call    read_char
    cmp     eax, 10
    je      .name_done
    mov     [edi], al
    inc     edi
    jmp     .read_name_loop
.name_done:
    mov     byte [edi], 0

    mov     eax, prompt_num
    call    print_string
    call    read_int
    mov     [num], eax

    cmp     eax, 50
    jle     .error
    cmp     eax, 100
    jge     .error

    mov     ecx, eax
.loop:
    push    ecx
    mov     eax, welcome_msg
    call    print_string
    mov     eax, name_buf
    call    print_string
    call    print_nl
    pop     ecx
    loop    .loop
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