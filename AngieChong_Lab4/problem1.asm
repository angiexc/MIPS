# Student: Chong, Angie
# Description: problem1 - In problem1.asm, the task was to write a nested function call from the given information on the lab instructions
#and to also write a main program that calls to the Func function on the given data and prints out the results.

.data
Va:	.word 0
Vb:	.word 2
Vc:	.word 8
Vd:	.word 3
	
.text
.globl main
	
main:
	sub	$sp, $sp, 4		# this will push the stack to save the registers
	sw	$ra, 0($sp)		# this will save the return address
	
	lw	$a0, Va
	lw	$a1, Vb
	lw	$a2, Vc
	lw	$a3, Vd
	
	jal	FUNC
	add	$a0, $v0, $zero
	jal	PRINT

	lw	$ra, 0($sp)		# this will save the return address
	add	$sp, $sp, 4		# pops the stack
	jr	$ra			# this will return to the system
	
FUNC:
	sub	$sp, $sp, 4		# push the stack to save a register
	sw	$ra, 0($sp)		# save the return address
	
	add	$a0, $a0, $a1		# a + b
	sub	$a1, $a2, $a3		# c - d
	jal	MAX

	lw	$ra, 0($sp)		# restore the return address
	add	$sp, $sp, 4		# pops the stack
	jr	$ra			# this will return to the caller
	
MAX:
	sub	$t0, $a0, $a1		# t0 = m - n
	blez	$t0, LE			# if m <= n go to le
	add	$v0, $a0, $zero		# return m
	jr	$ra
	
LE:
	add	$v0, $a1, $zero		# return n
	jr	$ra
	
PRINT:
	li $v0, 1 			# this will print the int
	syscall
	jr $ra
	