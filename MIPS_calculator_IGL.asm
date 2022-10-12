# Purpose: Calculate Volume using Ideal Gas Law from user input.

.data
#splash
splashTitle: .asciiz "\n| Welcome to the Whole Number Ideal Gas Law Calculator " 
splashMeta: .asciiz "\n| By Chris Reynolds - IVC CS40A Version 0.001" 
splashFspace: .asciiz "\n|"
splashLine: .asciiz "\n--------------------------------------------------------"

#user input 
userinputN : .asciiz "\n\n\nHow many moles of gas? (e.g. 3)\n"
userinputT : .asciiz "What is the temperature measured in Celcius? (e.g. 33)\n"
userinputP : .asciiz "What is the preasure in atmospheres? (e.g. 1)\n"

#calculation output
outputPrepend : .asciiz "We calculate the value of V as...    "
outputUnits : .asciiz " L\n"

.text
main:
#system call to print initial splash 
#-----------------------------------
li $v0, 4
la $a0, splashLine
syscall
la $a0, splashFspace
syscall
la $a0, splashTitle
syscall
la $a0, splashMeta
syscall
la $a0, splashFspace
syscall
la $a0, splashLine
syscall

#system call to prompt user input
#--------------------------------
#print prompt for n
li $v0, 4
la $a0,userinputN
syscall
#get keyboard input
li $v0, 5
syscall 
#save input to t1
move $t1,$v0 

#print prompt for T
li $v0, 4
la $a0,userinputT 
syscall
#get keyboard input
li $v0, 5
syscall 
#save input to t2
move $t2,$v0 

#print prompt for P
li $v0, 4
la $a0, userinputP
syscall
#get keyboard input
li $v0, 5
syscall 
#save input to t3
move $t3,$v0 

#calculations
#------------
#multiply userinputN and userinputT
mul $s0, $t1, $t2 
#multiply previous value by 8314 (gas constant * 1000)
mul $s0, $s0, 8314 
#divide previous by userinputP
div $s0, $s0, $t3 
#divide by 1000 (workaround for integers)
div $s0, $s0, 1000 

#output
#------
#print prepend for output
li $v0, 4
la $a0, outputPrepend 
syscall
#print value of s0
li $v0, 1
move $a0, $s0
syscall
#print units for output
li $v0, 4
la $a0, outputUnits
syscall

#end program
li $v0, 10
syscall
