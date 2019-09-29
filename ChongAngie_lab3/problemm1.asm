# Student: Chong, Angie
# Description: problemm1 - In this problem we are given the task to create a search function
# that takes in three parameters; the starting address, the array size, and the seed value.

.data
newline: .asciiz "\n"
ARR1_location: .asciiz "Array1 location: "
ARR1_count: .asciiz "Array1 # of occurances: "
ARR2_location: .asciiz "Array2 location: "
ARR2_count: .asciiz "Array2 # of occurances: "
ARR3_location: .asciiz "Array3 location: "
ARR3_count: .asciiz "Array3 # of occurances: "
ARR1: .word 1, 5, 4, 6, 4, 4, 9, 10
ARR2: .word 1, -1, 2, -2, 3, -3, 4, -4, 5, -5
ARR3: .word 28, -17, 0, 51, -12, 11, 5, 22, -2, -9, 13, 16, 2, 1, 36, -13, -32, -71, 101, 30, 130, -120, 13, 11, -901, 14, 48, 53, -50, 44
length:	.space 100

.text
.globl main

main:

				#array1

 la $a0, ARR1			# This will load the array to $a0
 li $a1, 8			# This will load the size of the array
 li $a2, 4			# This will load the seed
 jal srch			# this will call for the the srch function
 move $t1, $v0			# This will copy $v0 to $t1
 move $t2, $v1			# This will copy $v1 to $t2

 la $a0, ARR1_location		# this will array1 loacation sum message
 li $v0, 4			#system call code for Print String
 syscall
	
 li  $v0, 1			# this will print out the index of the seed
 move $a0, $t1
 syscall
	
 li $v0, 4       		# to create a new line 
 la $a0, newline       		# load address of the string
 syscall
	
 la $a0, ARR1_count		#write array count
 li $v0, 4			#system call code for Print String
 syscall

 li $v0, 1			# Prints the number of occurences
 move $a0, $t2
 syscall

				##array2

 li $v0, 4       		# to create a new line 
 la $a0, newline       		# load address of the string
 syscall

 la $a0, ARR2			# this will load the array to $a0
 li $a1, 10			# this will load the size of the array
 li $a2, 0			# this will load the seed
 jal srch			# this will call for the srch function
 move $t1, $v0			
 move $t2, $v1			

 la $a0, ARR2_location		# this will write array 2 location
 li $v0, 4			#system call code for Print String
 syscall
 
 li  $v0, 1			
 move $a0, $t1
 syscall
	
 li $v0, 4       # to create a new line 
 la $a0, newline       # load address of the string
 syscall
	
 la $a0, ARR2_count	#write array 2 count message
 li $v0, 4		#system call code for Print String
 syscall

 li $v0, 1			# this ill print out the number of occurences
 move $a0, $t2
 syscall

				#array3
 li $v0, 4       		# to create a new line 
 la $a0, newline       		# load address of the string
 syscall

 la $a0, ARR3			
 li $a1, 30			
 li $a2, 13			
 jal srch			
 move $t1, $v0			
 move $t2, $v1			

 la $a0, ARR3_location	#write the array 3 location message
 li $v0, 4		#system call code for Print String
 syscall

 li  $v0, 1			
 move $a0, $t1
 syscall
	
 li $v0, 4       # to create a new line 
 la $a0, newline       # load address of the string
 syscall
	

 la $a0, ARR3_count	#write the array 3 count
 li $v0, 4		#system call code for Print String
 syscall

 li $v0, 1			
 move $a0, $t2
 syscall

 Exit:	li $v0, 10			# this will exit the program
 syscall

.text
 srch:
 li $t0, 0			# this will initialize $t0 = 0
 li $t1, 0			# this will initialize $t1 = 0
 add $t2, $a0, $zero		
 li $v1, 0			
 li $t4, 1			
	
loop:	
 slt $t0, $t1, $a1		# in the loop it will do the operation If slt is false then return
 beq $t0, $zero, look		# this is the start of the loop
	
 lw $t3, 0($t2)			# this will load the word
 beq $a2, $t3, then		# this will make sure that it is not equal to the seed

ifnot:	
 addi $t1, $t1, 1
 addi $t2, $t2, 4		

 j loop

then:	
 addi $v1, $v1, 1		# this will increment the counter by one 
 beq $v1, $t4, idx		

 addi $t1, $t1, 1
 addi $t2, $t2, 4		

 j loop				# Jumps to loop

idx:
 add $v0, $t1, $zero		

 addi $t1, $t1, 1
 addi $t2, $t2, 4		

 j loop				# this will jump to the loop

look:	
 beq $v1, $zero,make
 bne $v1, $zero, return

make:	
 li $v0, -1			# this will change value to -1

return:
 jr $ra				# Returns from functions


