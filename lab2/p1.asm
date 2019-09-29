# Student: Chong, Angie

 .data

 prompt: 	.asciiz "Enter 20 numbers one at a time and press enter each time.\n"
 arrExit:   .asciiz "Exit.\n"
 FRESH:		.space	80
 RAW:		.word	2, 17, 28, 20, 6, 51, 20, 48, 12, 54, 3, 31, 15, 22, 46, 72, 41, 39, 30, 55
 arrFresh_max:	.asciiz	"\nIn the Fresh array, the MAX value is: "
 arrFresh_min:	.asciiz	"\nIn the Fresh array, the MIN value is: "
 arrFresh_sum:	.asciiz "\nThe sum of the Fresh array is: "
 arrFresh_maxmin:.asciiz"\nThe MIN and MAX value added is: "
 arrRaw_sum:	.asciiz "\nThe sum of the Raw Array is: "
 arrRaw_max:	.asciiz	"\nIn the Raw Array, the MAX value is: "
 arrRaw_min:	.asciiz	"\nIn the Raw Array, the MIN value is: "
 arrRaw_maxmin:	.asciiz	"\nThe MIN and MAX value added is: "

 .text    
 
 MAX:
 
 addi $t7, $zero, 0 				#this means that in $t7 that the index is equal to 0
 addi $t2, $zero, 0 				#this means that in $t2 maxSoFar = 0  
 
 loopMAX:
 
 beq $t7, $a1, doneMAX 				
 lw $t3, 0($a0) 				#this means that in $t3, the array one is equal to the index
 slt $t1, $t3, $t2 				#if the array of index one is less than the current max, it will set $t1 to 1
 bne $t1, $zero, lessTHAN 			#this means that if $t1 is does not equal to zero, it will then jump to lessTHAN
								
 addi $t2, $t3, 0 					
 
 lessTHAN:
 
 addi $t7, $t7, 1			
 addi $a0, $a0, 4				#updates counter for each iteration
 j loopMAX
 
 doneMAX:
 
 move $t4, $t2				#this moves whatever is in $t2 to $t4
 jr $ra
 
 MIN:
 
 addi $t7, $zero, 0 			#this makes the index that is in $t7 be equal to zero  
 
 loopMIN:
 
 beq $t7, $a1, doneMIN 
 lw $t3, 0($a0) 			#this makes whatever that is in $t3 be equal to array1[index]
 slt $t1, $t3, $t2 			#if the array index is less than currMAX, it means that $t1 is equal to one		
 beq $t1, $zero, lessMIN		#if $t1 does not equal to zero then it will jump into lessMIN
								
 addi $t2, $t3, 0 					
 
 lessMIN:
 	addi $t7, $t7, 1
 	addi $a0, $a0, 4		#this means that it is iterating					
 	j loopMIN
 
 doneMIN:
 
 	jr $ra
 
 .globl main
 .text
 
 main:
	
 li $v0, 4						
 la $a0, prompt						#this will load the address of the prompt
 syscall	
	
 li $t0, 0						#this will load the counter
 la $t1, FRESH						#this will load the address of the first element that is in the FRESH array to $t1
 la $s0, RAW
	
inLOOP:

 slti $t2, $t0, 20					#this will check if the counter has hit twenty or not
 beq $t2, $zero, stopLOOP				#if it does not then it will go to stopLoop

 li $v0, 5						#this will hell it read all the intgers
 syscall
 add $t3, $t3, $v0 
 sw $v0, 0($t1)									
 addi $t1, $t1, 4					#this will refresh $t1 with an address of the upcoming element in the FRESH array
 addi $t0, $t0, 1					#this will update the counter
 j inLOOP						#this will loop again
								
stopLOOP:

 li $v0, 4
 la $a0, arrFresh_sum					# this will show the prompt for the sum of the fresh array
 syscall
 j sumFRESHLOOP
		
		
sumFRESHLOOP:

 li $v0, 1						
 move $a0, $t3				
 syscall						#this will print the sum of the array
 j exitsumofFRESHLOOP					#exit
		
exitsumofFRESHLOOP:

 li $v0, 4
 la $a0, arrFresh_max				#this will show the prompt for the max
 syscall
 j maxFRESHLOOP

maxFRESHLOOP:
 la $a0, FRESH					
 addi $a1, $zero, 20				#this will set the number of elements to $a1
 jal MAX
 li $v0, 1
 move $a0, $t4
 syscall
 j exitFreshMaxLoop				#exit the loop
	
exitFreshMaxLoop:

 li $v0, 4
 la $a0, arrFresh_min				
 syscall					# this will show the prompt for finding the MIN
 j minFRESHLOOP
	
minFRESHLOOP:

 la $a0, FRESH					
 addi $a1, $zero, 20				#this will set the number of elements to $a1
 jal MIN
 li $v0, 1
 move $a0, $t2					
 syscall
 j stopFreshMinLOOP
	
stopFreshMinLOOP:

 li $v0, 4
 la $a0, arrFresh_maxmin	
 syscall						
 j freshMaxMinLOOP
	
freshMaxMinLOOP:

 add $t5, $t2, $t4
 li $v0, 1
 move $a0, $t5
 syscall						
 j inRawLOOP

inRawLOOP:

 slti $t2, $t0, 20				#this will check if it hit twenty or not
 beq $t2, $zero, stopInputRawLOOP
 
 lw $t3, 0($s0)	
 addi $t4, $t3, 0
 addi $s0, $s0, 4			
 addi $t0, $t0, 1			#this will update the counter
 j inRawLOOP				#this will make it loop again

stopInputRawLOOP:

 li $v0, 4
 la $a0, arrRaw_sum				#this will show the prompt for summing the fresh array
 syscall
 j rawSumLOOP
	
rawSumLOOP:

 li $v0, 1						
 move $a0, $t4				
 syscall					#this will print the sum of the array
 j stopRawSumLOOP

stopRawSumLOOP:

 li $v0, 4
 la $a0, arrRaw_max				#this will show the prompt for finding the max of the fresh array
 syscall
 j rawMaxLOOP

rawMaxLOOP:

 la $a0, RAW				
 addi $a1, $zero, 20			#this will set the number of elements into $a1
 jal MAX
 li $v0, 1
 move $a0, $t4
 syscall
 j stopRawMaxLOOP
		
stopRawMaxLOOP:

 li $v0, 4
 la $a0, arrRaw_min				
 syscall				#this will show the prompt for finding the min of the fresh array
 j rawMinLOOP

rawMinLOOP:

 la $a0, RAW				
 addi $a1, $zero, 20			#this will set the number of elements to $a1
 jal MIN
 li $v0, 1
 move $a0, $t2				
 syscall
 j stopRawMinLOOP
	
stopRawMinLOOP:

 li $v0, 4
 la $a0, arrRaw_maxmin	
 syscall					
 j rawMaxMinLOOP

rawMaxMinLOOP:

 add $t5, $t2, $t4
 li $v0, 1
 move $a0, $t5
 syscall					# this will print out the sum of the max and min values
 j Exit	


Exit:

 li $v0, 4				#this exits the program
 la $a0, arrExit				
 syscall	

 li $v0, 10				
 syscall					
