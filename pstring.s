.section .rodata
argu1: .asciz "%d"
argu2: .String  "%s"
getchar: .string " %c"
switchint: .string " %d"
pstring: .String "%d %s"
firstlen: .string "first pstring length:"
oldchar: .string "old char: "
newchar: .string ", new char: "
firststring: .string ", first string: "
secondstring: .string ", seond string: "
secondlen: .string ", second pstring length:"
error: .string "invalid option!"
error2: .string "invalid input!\n"
len: .string "length: "
cstring: .string ", string: "
cmpr: .string "compare result:"
enter1: .string "\n"  
           
.text
.global pstrlen
.type pstrlen @function
pstrlen:
movq $firstlen, %rdi   #put the sentence before the len in the rdi
movq $0,%rax           #zeroing the rax
call printf            # print the sentence first len
movq %r13,%rsi         #move the len value to the rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf
call printf            #print the first len   
movq $secondlen, %rdi  #put the sentence before the len in the rdi
movq $0,%rax           #zeroing the rax
call printf            # print the sentence second len
movq %r15,%rsi         #move the len value to the rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf            #print the second len
; jmp  finishall
ret



.text
.global replaceChar
.type replaceChar @function
replaceChar:
### getting old char
subq $16,%rsp     #down one byte to scan char
movq $getchar,%rdi
movq %rsp,%rsi
addq $1,%rsi
movq $0,%rax
call scanf        # old char at -15 rsp
### getting new char
movq %rsp,%rsi
movq $getchar,%rdi
movq $0,%rax
call scanf       # new char at -16 rsp
movq (%rsp),%r8  #new char at r8
addq $1,%rsp
movq (%rsp),%r9  #old char  at r9

movq $0,%rcx
movq %r12,%r10  # save the first string location at %10
movq $0,%rdx
for1:
cmpq %r13,%rdx
je end
movq $0,%rbx
movzbq (%r10),%rbx  #saving the current char
cmpb %bl,%r9b 
je replace1
addq $1,%r10
addq $1,%rdx
jmp for1
end:
movq %r14,%r10
movq $0,%rdx
jmp for2
jmp  finishall

replace1:
movq %r8,%rbx
movb %bl,(%r10)   # curr char = new char
addq $1,%r10
addq $1,%rdx
jmp for1
;jmp  finishall
ret

for2:
cmpq %r15,%rdx
je end2
movq $0,%rbx
movzbq (%r10),%rbx  #saving the current char
cmpb %bl,%r9b 
je replace2
addq $1,%r10
addq $1,%rdx
jmp for2
end2:
jmp print

replace2:
movq %r8,%rbx
movb %bl,(%r10)   # curr char = new char
addq $1,%r10
addq $1,%rdx
jmp for2
;jmp  finishall
ret

print:
subq $1,%rsp
movb (%rsp),%bl
addq $1,%rsp
movq $oldchar,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq (%rsp),%rsi
movq $getchar,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq $newchar,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf
subq $1,%rsp  
movb %bl,%sil
movq $getchar,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq $firststring,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf 
movq $pstring,%rsi
movq %r12,%rdi
movq $0,%rax
call printf
movq $secondstring,%rdi
movq $0,%rax
call printf
movq $pstring,%rsi
movq %r14,%rdi
movq $0,%rax
call printf
;jmp  finishall
ret



########
.text
.global swapCase
.type swapCase @function
swapCase:
movq %r12,%r10  # save the first string location at %10
movq $0,%rdx
forr1:
cmpq %rdx, %r13 # copmare to len
je done
movzbq (%r10),%rbx  #saving the current char
cmpb $65,%bl # check if the number bigger than 40 in ascii
jns len1loop1 # if > 65
addq $1,%r10
addq $1,%rdx
jmp forr1
len1loop1:
cmpb $96,%bl # check if the number bigger than 40 in ascii
jns len1loop2 # if > 96
cmpb $91,%bl # if <91 and >65 capital letter
js  len1swapcapital
addq $1,%r10  # current between 91-96
addq $1,%rdx
jmp forr1
### swap the letter from capital to small by adding 32 on the valu
len1swapcapital:
movq (%r10),%rbx
addb $32,%bl
movb %bl,(%r10)
addq $1,%r10
addq $1,%rdx
jmp forr1
len1loop2: #curr > 96
cmpb $123,%bl  
js len1swapsmall   #96 < curr <123
addq $1,%r10
addq $1,%rdx
jmp forr1
### swap letter from small to capital curr-32
len1swapsmall:
movq (%r10),%rbx
subb $32,%bl
movb %bl,(%r10)
addq $1,%r10
addq $1,%rdx
jmp forr1

done:
movq %r14,%r10  # save the first string location at %10
movq $0,%rdx

forr2:
cmpq %rdx, %r13 # copmare to len
je done2
movzbq (%r10),%rbx  #saving the current char
cmpb $65,%bl # check if the number bigger than 40 in ascii
jns len2loop1 # if > 65
addq $1,%r10
addq $1,%rdx
jmp forr2
len2loop1:
cmpb $96,%bl # check if the number bigger than 40 in ascii
jns len2loop2 # if > 96
cmpb $91,%bl # if <91 and >65 capital letter
js  len2swapcapital
addq $1,%r10  # current between 91-96
addq $1,%rdx
jmp forr2
### swap the letter from capital to small by adding 32 on the valu
len2swapcapital:
movq (%r10),%rbx
addb $32,%bl
movb %bl,(%r10)
addq $1,%r10
addq $1,%rdx
jmp forr2
len2loop2: #curr > 96
cmpb $123,%bl  
js len2swapsmall   #96 < curr <123
addq $1,%r10
addq $1,%rdx
jmp forr2
### swap letter from small to capital curr-32
len2swapsmall:
movq (%r10),%rbx
subb $32,%bl
movb %bl,(%r10)
addq $1,%r10
addq $1,%rdx
jmp forr2

done2:
jmp print2

print2:
movq $len,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq %r13,%rsi         #move the len value to the rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf
call printf   
movq $cstring,%rdi
movq $0,%rax
call printf
movq $cstring,%rsi
movq %r12,%rdi
movq $0,%rax
call printf
movq $enter1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf 
movq $len,%rdi
movq $0,%rax
call printf
movq $cstring,%rdi
movq $0,%rax
call printf
movq $cstring,%rsi
movq %r14,%rdi
movq $0,%rax
call printf
;jmp  finishall
ret




.text
.global pstrijcpy
.type pstrijcpy @function
pstrijcpy:
### getting old char
subq $16,%rsp     #down one byte to scan char
movq $argu1,%rdi
movq %rsp,%rsi
addq $4,%rsi
movq $0,%rax
call scanf        # first int
### getting new char
movq %rsp,%rsi
movq $argu1,%rdi
movq $0,%rax
call scanf       # second int
movq (%rsp),%r9  # r9 = j
addq $4,%rsp
movq (%rsp),%r8  # r8 = i
#subq $1,%rsp
#movq %r9,%rsi
#movq $argu1,%rdi
#movq $0,%rax
#call printf
movq %r12,%r10  # save the first string location at %10
movq %r14,%r11  # save the second string location at %11
### dont forget to take care for the case with wrong int
### what if the second string is longer but the int fit perfect
cmpl %r9d,%r13d
js wrong1
cmpl %r8d,%r13d
js wrong1
cmpl %r9d,%r15d
js wrong1
cmpl %r8d,%r15d
js wrong1
movq $0,%rdx
movq $0,%rcx
addq $1,%r9
firstloop:
cmpq %rdx,%r13
je finish # if we finished 
cmpl %ecx,%r8d # if we at the first int now we need to change the first string
je cpy   # i == curr
addq $1,%r10
addq $1,%r11
addq $1,%rdx
addq $1,%rcx
jmp firstloop
cpy:   #start changing the string
cmpl %ecx,%r9d
je firstloop
movb (%r11),%bl
movb %bl,(%r10)   # curr char = new char
addq $1,%r10
addq $1,%r11
addq $1,%rdx
addq $1,%rcx
jmp cpy
finish:
movq $len,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq %r13,%rsi         #move the len value to the rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf
call printf   
movq $cstring,%rdi
movq $0,%rax
call printf
movq $cstring,%rsi
movq %r12,%rdi
movq $0,%rax
call printf
movq $enter1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf 
movq $len,%rdi
movq $0,%rax
call printf
movq %r15,%rsi         #move the len value to the rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf
call printf  
movq $cstring,%rdi
movq $0,%rax
call printf
movq $cstring,%rsi
movq %r14,%rdi
movq $0,%rax
call printf
jmp  finishall
wrong1:
movq $error2,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf
jmp  finishall


.text
.global pstrijcmp
.type pstrijcmp @function
pstrijcmp:
### getting old char
subq $16,%rsp     #down one byte to scan char
movq $argu1,%rdi
movq %rsp,%rsi
addq $4,%rsi
movq $0,%rax
call scanf        # first int
### getting new char
movq %rsp,%rsi
movq $argu1,%rdi
movq $0,%rax
call scanf       # second int
movq (%rsp),%r9  # r9 = j
addq $4,%rsp
movq (%rsp),%r8  # r8 = i
#subq $1,%rsp
#movq %r9,%rsi
#movq $argu1,%rdi
#movq $0,%rax
#call printf
movq %r12,%r10  # save the first string location at %10
movq %r14,%r11  # save the second string location at %11
### dont forget to take care for the case with wrong int
### what if the second string is longer but the int fit perfect
cmpl %r9d,%r13d
js wrong
cmpl %r8d,%r13d
js wrong
cmpl %r9d,%r15d
js wrong
cmpl %r8d,%r15d
js wrong
movq $0,%rdx
movq $0,%rcx
movq $0,%rbx
movq $0, %rsi
addq $1,%r9
cmploop:
cmpq %rdx,%r13
je finish2 # if we finished 
cmpl %ecx,%r8d # if we at the first int now we need to change the first string
je cpj   # i == curr
addq $1,%r10
addq $1,%r11
addq $1,%rdx
addq $1,%rcx
jmp cmploop
cpj:   #start changing the string
cmpl %ecx,%r9d
je finish2
addb (%r11),%bl #rbx += str[i,j] second string
addb (%r10),%sil   # rsi += str[i,j] first string
addq $1,%r10
addq $1,%r11
addq $1,%rdx
addq $1,%rcx
jmp cpj
wrong:
movq $error2,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf
movq $cmpr,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq $-2,%rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
jmp  finishall
finish2:
cmpq %rbx,%rsi
je finish3
js bigseconde
jns bigfirst
finish3:
movq $cmpr,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq $0,%rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
jmp  finishall 
bigseconde:
movq $cmpr,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq $-1,%rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
jmp  finishall
bigfirst:
movq $cmpr,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
movq $1,%rsi
movq $argu1,%rdi       # we want to print int so move the name to rdi
movq $0,%rax           # zeroing the rax before calling printf 
call printf  
jmp  finishall
