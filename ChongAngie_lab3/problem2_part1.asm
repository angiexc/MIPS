# Student: Chong, Angie
# Description: problem2_part1 - This will have a function called AddSub that will perform the equation
#that X is Y + Z if the flag is equal to zero and Y - Z if flag is equal to one. We need to implement stacks
#to pass the five parameters and need to show the data sets of array Y and Z first, then X for set values.

.data
newline: .asciiz "\n"
ARRY: .asciiz "Y Array: "
ARRZ: .asciiz "Z Array: "
ARRX: .asciiz "X Array: "
arrX: .space 100
arrY: .word 1, 2, 3, 4, 5
arrZ: .word -5, -4, -3, -2, -1

.text
.globl main

main:				# the main function

	
 la $t1, arrX			# This will load the address of array x to $t0		
 sw $t1, 0($sp)			# This will store the address of array x into a stack
 la $t2, arrY			# This will load the address of array x to $t2
 sw $t2, 4($sp)			# This will store the address of array x to the stack again

 la $t3, arrZ			# This will load the address of array z to $t3
 sw $t3, 8($sp)			# This will store the address of array z to the stack
 li $t4, 5			# This will load the size of the different arrays to $t4
 sw $t4, 12($sp)		# This will store the size of the arrays to the stack

 li $t5, 0			# This will load the flag integer, which is zero, to $t5
 sw $t5, 16($sp)		# This will store the flag intger to the stack

 jal AddSub			# This will call to the function of AddSub

 				## ARRAY Y 
 li $t6, 0
 la $t2, arrY
	
 la $a0, ARRY			# this will write array y message
 li $v0, 4			# this is the system call code for Print String
 syscall
	
LOOPY:	
 slt $t7, $t6, $t4		# this is the onditions for the loop
 beq $t7, $zero, BEGINZ		# this will go back to return if the integer is not less than

 lw $t8, 0($t2)
	
 addi $t6, $t6, 1		# This will add 1
 addi $t2, $t2, 4		# This will add 4

 li $v0, 1
 move $a0, $t8
 syscall

 li $a0, 32			#this is to create print space between integers
 li $v0, 11  			#syscall number for printing character
 syscall

 j LOOPY

 li $v0, 4       		# to create a new line 
 la $a0, newline       		# load address of the string
 syscall

 				## ARRAY Z 
BEGINZ:	
 li $t6, 0
la $t3, arrZ

 li $v0, 4       		# to create a new line 
 la $a0, newline       		# load address of the string
 syscall
	
 la $a0, ARRZ			#write array z
 li $v0, 4			#system call code for Print String
 syscall
	
	
LOOPZ:	
 slt $t7, $t6, $t4		
 beq $t7, $zero, BEGINX		

 lw $t8, 0($t3)
	
 addi $t6, $t6, 1
 addi $t3, $t3, 4

 li $v0, 1
 move $a0, $t8
 syscall

 li $a0, 32
 li $v0, 11  				
 syscall

 j LOOPZ

 			## ARRAY X 
BEGINX:	
 li $t6, 0
 la $t1, arrX

 li $v0, 4       	# to create a new line 
 la $a0, newline       # load address of the string
 syscall
	
 la $a0, ARRX		# this will write array x
 li $v0, 4		#system call code for Print String
 syscall
	
	
LOOPX:	
 slt $t7, $t6, $t4		
 beq $t7, $zero, EXIT		

 lw $t8, 0($t1)
	
 addi $t6, $t6, 1
 addi $t1, $t1, 4

 li $v0, 1
 move $a0, $t8
 syscall

 li $a0, 32
 li $v0, 11  			
 syscall

 j LOOPX

EXIT:	
 addi $sp, $sp, 20		# this will pop out all the data inside the stack
 li $v0, 10
 syscall
 
 
.text

Sub:
 lw $t8, 0($t2)			
 lw $t9, 0($t3)			

 sub $t8, $t8, $t9		# this will subtracts $t8 and $t9
 sw $t8, 0($t1)			

 addi $t2, $t2, 4		
 addi $t3, $t3, 4		
 addi $t1, $t1, 4		
 addi $t6, $t6, 1		# this will increments loop counter by one

 j AddSubloop

Add:
 lw $t8, 0($t2)			
 lw $t9, 0($t3)			

 add $t8, $t8, $t9		
 sw $t8, 0($t1)			# this will save to Array X

 addi $t2, $t2, 4		# this will point to the following word in address to array Z
 addi $t3, $t3, 4		# this will point to the following word in address to array Y
 addi $t1, $t1, 4		# this will point to the following word in address to array X
 addi $t6, $t6, 1		# this will Increment th loop counter by one	

 j AddSubloop

 
 AddSub:
 lw $t1, 0($sp)			# this is the address for x
 lw $t2, 4($sp)			# this is the address for y
 lw $t3, 8($sp)			# this is the address for z
 lw $t4, 12($sp)		# this is the number of integers
 lw $t5, 16($sp)		# this is the flag number
 li $t6, 0			# this will help Initialize $t6 = 0

AddSubloop:	
 slt $t7, $t6, $t4		# this is the condition for loop
 beq $t7, $zero, return		# Goes to return if not less than
 beq $zero, $t5, Add		# this will do the operation If flag = 0 go to Add
 bne $zero, $t5, Sub		# this will do the operation If flag = 1 go to Sub

return: jr $ra

