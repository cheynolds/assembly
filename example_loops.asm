# Filename: example_loops.asm
# Author: CHEYNOLDS
# Date: 11/27/22
# Purpose: Print every other capital letter 
#          of the alphabet, starting with A (e.g A C E G I....)
# Reference: Khan - 1.3 | 7.8.4 / MIPS Instruction Set reference
#
# ACSCII 'A'  Ox41

.text
.globl main

main:	
	# set start value in $s0 register with ASCII hex value for immediate
	#  ADDI $destination register's address, $source register's address, immediate data.
	addi $s0, $zero, 0x41


BeginForLoop:
	# set max value of for-loop conditional
	addi $t0, $zero, 0x5A
	# set on less than -> if($2<$3)$1=1; else $1=0
	# Test if less than. If true, set $1 to 1. Otherwise, set $1 to 0.
	slt $t0, $s0, $t0
	# branch on equal (to zero), index equal to max value, loop breaks
	beqz $t0, EndForLoop
	# set $t0 to 2
	addi $t0, $zero, 2
	# divide $s0 by $t0 -> remainder stored in $hi
	div $s0,$t0
	# move division remainder from $hi to $t0 
	mfhi $t0
	# set $t0 to 1 if initial value of $t0 is 0
	# if hex value is odd, the value of $t0 will be 0
	seq $t0, $t0, 0
	# branch on equal (to zero) for odd hex value 
	beqz $t0, Odd
	# add one to index
	addi $s0, $s0, 1
	# branch to label
	b BeginForLoop

Odd:
	# move the current odd hex value to $a1
	move $a1, $s0
	# print the individual character
	jal PrintASCII
	# print a blank space
	jal PrintSpace
	# add one to index
	addi $s0, $s0, 1
	# branch to label 
	b BeginForLoop

PrintASCII:
	# print ASCII character, the hex value is in $a1, move to $a0
	move $a0, $a1
	# load immediate value '11' to $v0,  op-code to print ASCII character from hex
	li $v0, 11
	# system call to print value in $a0 as ASCII character to console
	syscall
	# return
	jr $ra

PrintSpace:
	# load immediate value '4' to $v0
	li $v0, 4
	# load data value to $a0
	la $a0, __PS__space
	# system call to print space to console
	syscall 
	# return    
	jr $ra

EndForLoop:
	jal Exit

.data
	__PS__space: .asciiz " " 

.include "utils.asm"
