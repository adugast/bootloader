; Small introduction to bootloader code
; 0x7C00 - The BIOS loads 512 bytes from this memory address - MAGIC NUMBER
; 0xAA55 - Last two bytes of the MBR - MAGIC NUMBER

BITS 16             ; PC boots in real mode so only 16bit instructions
jmp short _start
nop

string db "Printed from the bootloader", 0x0d, 0x0a, 0x00

_start:
    mov ax, 0x07C0      ; move 0x7C00 into ax
    mov ds, ax          ; set data segment to the start
    mov si, string      ; put string into si

    call print_str

    .infinite_loop:
        jmp .infinite_loop


print_str:
    mov ah, 0x0e        ; display character, function number = 0Eh
    .loop:
        lodsb           ; load string byte to al
        cmp al, 0x0     ; if al == 0
        je .done        ; end function
        int 0x10        ; else call INT 10h to print the character
        jmp .loop       ; continue until al == 0
    .done:
        ret

times 510-($-$$) db 0   ; fill the rest of MBR with 0s
dw 0xAA55               ; The last two bytes of the MBR must contain 0xAA55
