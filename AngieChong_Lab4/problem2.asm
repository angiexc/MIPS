# Student: Chong, Angie
# Description: problem2 - In problem2.asm, the task was to write a recursive function that would compute the smalles integer in a given
#array of integers and would follow the following algorithm shown on the lab instructions. We would then
#also create a Min function that would print out the result with the given array.

.data
Arr:	.word 	5, 2, -9, 10, -23, 43, 2, 1, 3, 5, 10
vlow:	.word	0
vhigh:	.word	10
	
.text
.globl main
	
main:
	sub	$sp, $sp, 4		# this will push the stack to save the registers
	sw	$ra, 0($sp)		# this will save the return address
	
	la	$a0, Arr
	lw	$a1, vlow
	lw	$a2, vhigh
	jal	MIN
	
	add	$a0, $v0, $zero		# this will print min(A, low, high)
	jal	PRINT

	lw	$ra, 0($sp)		# this will restore the return address
	add	$sp, $sp, 4		# this will pop the current stack
	jr	$ra			# return to system
MIN:
	sub	$sp, $sp, 20		# this will push the stack to save registers
	sw	$ra, 0($sp)		# this will save the return address
	sw	$a1, 4($sp)		# this will save low
	sw	$a2, 8($sp)		# save high
	sw	$s0, 12($sp)		# save mid
	sw	$s1, 16($sp)		# save min1

	bne	$a1, $a2, SKIP		# if low != high goto skip
	sll	$t0, $a1, 2		# t0 = low * 4
	add	$t0, $t0, $a0		# t0 = A + low * 4
	lw	$v0, 0($t0)		# this will return A[low]
	j	minExit
SKIP:
	add	$s0, $a1, $a2		# mid = low + high
	sra	$s0, $s0, 1		# mid = mid / 2
	add	$a2, $s0, $zero		# a2 = mid
	jal	MIN
	add	$s1, $v0, $zero		# min1 = min(A, low, mid)
	
	addi	$a1, $s0, 1		# a1 = mid + 1
	lw	$a2, 8($sp)		# a2 = high
	jal	MIN
	add	$s2, $v0, $zero		# min2 = min(A, mid+1, high)

	sub	$t0, $s1, $s2		# t0 = min1 - min2
	blez	$t0, LE
	add	$v0, $s2, $zero		# this will return min2
	j	minExit
LE:
	add	$v0, $s1, $zero		# this will return min1

minExit:	
	lw	$ra, 0($sp)		# this will restore the return address
	lw	$a1, 4($sp)		# restore low
	lw	$a2, 8($sp)		# restore high
	lw	$s0, 12($sp)		# restore mid
	lw	$s1, 16($sp)		# restore min1
	add	$sp, $sp, 20		# pop the stack
	jr	$ra			# return to calling procedure
PRINT:
	li $v0, 1 			# will print out the int
	syscall
	jr $ra
	