.data
msg: .asciiz "\Hi CHEYNOLDS!\n"

.text

main:
# load immediate number 4 in register v0
li $v0, 4
# load address of 'msg' into register a0
la $a0, msg

#system-call that does something based on v0 and a0; 
#in this case, “4” meant print, and it looks 
#for what to print using the memory address stored in a0

syscall

#load immmediate, set number 10 in register v0 to exit
li $v0, 10

#final system call to exit program
syscall
