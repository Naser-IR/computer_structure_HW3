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

.section .rodata

.align 8 # Align address to multiple of 8 
switch:
.quad .L0 # Case 50: loc_A 
.quad .default # Case 51: loc_B 
.quad .L2 # Case 52: loc_C 
.quad .L3 # Case 53: loc_D 
.quad .L4 # Case 54: loc_def 
.quad .L5 # Case 55: loc_D 
.quad .default # Case 56: loc_E
.quad .default # Case 57: loc_E
.quad .default # Case 58: loc_E 
.quad .default # Case 59: loc_E 
.quad .L0 # Case 60: loc_A


.text
.global func_select
.type   func_select @function
func_select:
movl  8(%rsp), %edx
subq $50,%rdx #x = x-50
cmpq $10,%rdx   #compare x:10
ja .default    #if > go to default case
jmp   *switch(,%rdx,8)     #goto jt[x]

#case 50
.L0:
 call pstrlen
jmp finishNsr
.L2:
call replaceChar
jmp finishNsr
.L3:
call pstrijcpy
jmp finishNsr
.L4:
call swapCase
jmp finishNsr
.L5:
call pstrijcmp
jmp finishNsr
.default:
movq $error, %rdi
movq $0,%rax
call printf 
jmp finishNsr

finishNsr:
    ret
