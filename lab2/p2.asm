# Student: Chong, Angie

.data
arrSet: .word 13, -3, 12, -4, 15, 14, 8, 17, 16, 5
prompt: .asciiz	"Resulting Array: \n"
newline: .asciiz "\n"

.text
.globl main

main:
	li $v0, 4
	la $a0, prompt		#load address into $a0		#system call code for Print String
	syscall			#print the prompt message

	la $t0, arrSet  	#array starting address
	li $t1, 0      		# $t1 is counter 
	lw $t2, 0($t0)  	#get array[i] (first index)
	li $t5, 0      		#used for storing new numbers

LOOP:

	slti $t7, $t1, 10       #this checks if there is ten values
	beq $t7, $zero, printOUT   #this exits the loop if it reaches the end of the array
	addi $t1,$t1, 1	        #this increments the counter by one

	and $t3, $t2, 1	        #this checks if the value is even or odd and if odd it will be 1
	beq $t3, $zero, evenNUMBER    #this makes it that if it is even, it will jump and if odd it will continue on
	sll $t4, $t2, 1	        #this will multiply it by two
	beq $t5, $zero, SWAP   	#this is used to store in the new numbers
	sw $t6, 0($t0)      	#this is used to store in the new current index
	addi $t6, $t4, 0        #this stores new number into $t6
	j Next                  #this makes you jump thus skipping even

evenNUMBER:	

	sra $t4, $t2, 1	        #if an even number it will divide it by 2
	beq $t5, $zero, SWAP    #this is sued to store the new value into $t5
	sw $t6, 0($t0)      	#this stores it into the current index of the array
	addi $t6, $t4, 0        #this stores the new value into $t6

Next:

	add $t0,$t0, 4    	#update array address
	lw $t2, 0($t0)     	#holds next element number in array
	addi $t6, $t4, 0  	#$t6 holds new number
	j LOOP

printOUT:

	addi $t3, $zero, 0 	#this resets $t3 into zero
	la $t3, arrSet      	#this has the array start the address
	addi $t1, $zero, 0 	#this lets use the counter again
	 
arrPRINT:

	slti $t7, $t1, 10     	#this will see if we have ten numbers
	beq $t7, $zero, EXIT  	#this will end the loop if it reaches the end of the array
	addi $t1,$t1, 1       	#this will increment the counter by one
	lw $t5, 0($t3)         	#this has $t5 having the element
	addi $t3, $t3, 4        #this will update the array
	
	li $v0, 1             	#this will print out whatever is in t5
	move $a0, $t5
	syscall

	li $v0, 4		#this creates a new line
	la $a0, newline
	syscall
	j arrPRINT

EXIT:				

	li $v0, 10		#this exits the program
	syscall

SWAP:

	addi  $t6, $t4, 0  	#this will store the new value to $t6
	add $t0,$t0, 4     	#this will update the array
	lw $t2, 0($t0)      	#this will hold the new element value into the array
	addi $t5, $t5, 1   	#this is here so the swapping would not happen again after the first time
	j LOOP
