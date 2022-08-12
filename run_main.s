.section .rodata
argu1: .asciz "%d"
argu2: .String  "%s"
getchar: .string " %c"
switchint: .string "%d"
pstring: .String "%d %s"
firstlen: .string "first pstring length:"
oldchar: .string "old char: "
newchar: .string ", new char: "
firststring: .string ", first string: "
secondstring: .string ", seond string: "
secondlen: .string ", second pstring length:"
error: .string "invaild option!"
error2: .string "invaild input!\n"
len: .string "length: "
cstring: .string ", string: "
cmpr: .string "compare result:"
enter: .string "\n"




   .text
   .global run_main
   .type run_main, @function
run_main:
    
pushq %rbp     #building
movq %rsp,%rbp
subq $528,%rsp
scanloop:
leaq (%rsp),%rsi # set the location from the scan
movq $argu1,%rdi
movq $0,%rax
call scanf
movzbq (%rsp),%r13  #save len in r13
scanloop2:
leaq -256(%rbp),%rsi
movq $argu2,%rdi
movq $0,%rax
call scanf
leaq -257(%rbp),%rsp
movb %r13b,(%rsp)
movq %rsp,%r12      
leaq -256(%rbp),%r12   # save the location of the string at r12 
leaq -257(%rbp),%r10
movb %r13b,(%r10)
movb %r13b,%r11b
leaq -256(%rbp,%r11),%r11
addq $1,%r11
movq $0,(%r11)        #put \0 at the end of the string
#movq %r13,%rsi
#movq %r12,%rdx
#movq $pstring,%rdi
#movq $0,%rax
#call printf



thirdscan:
leaq -528(%rbp),%rsp
leaq (%rsp),%rsi # set the location from the scan
movq $argu1,%rdi
movq $0,%rax
call scanf
movzbq (%rsp),%r11  #save len in r15
movq %r11,%r15
forthscan:
leaq -513(%rbp),%rsi
movq $argu2,%rdi
movq $0,%rax
call scanf
leaq -514(%rbp),%rsp   
movb %r15b,(%rsp)
movq %rsp,%r14  #save the adress of the pstring
leaq -513(%rbp),%r14
leaq -514(%rbp),%r10
movb %r15b,(%r10)
movb %r15b,%r11b
leaq -513(%rbp,%r11),%r11
addq $1,%r11
movq $0,(%r11)        #put \0 at the end of the string

##
#movq %r15,%rsi
#leaq -513(%rbp),%rdx
#movq $pstring,%rdi
#movq $0,%rax
#call printf

switchscan:
leaq -528(%rbp),%rsi
; leaq (%rsp),%rsi # set the location from the scan
leaq switchint,%rdi
movq $0,%rax
call scanf
movl -528(%rbp),%edi  
movq $0,%rax
leaq -528(%rbp), %rsp
leave
ret


   .text
   .global finishall
   .type finishall, @function
finishall:
leave
ret
