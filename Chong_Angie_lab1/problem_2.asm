# Student: Chong, Angie
# Description: problem_2.asm - This will ask the user to input the values 4, -4, 64679, -64679 and load them into the registers $s0 - $s3. It
# will then proceed to peform the operations of printing the user input, printing the sum of $s2 and $s3, printing the result of logical OR
# on constant 4 and $s3, and printing out the result of shift $s3 one bit left.
.data

prompt: .asciiz "Please enter 4, -4, 64679, -64679: \n"
outcome_input: .asciiz "Entered values : "
outcome_add: .asciiz "The add outcome is : "
outcome_ori: .asciiz "The OR outcome is : "
outcome_shift: .asciiz  "The shift outcome is : "
newline: .asciiz "\n"

.text
.globl main
main:
la $a0, prompt		#load address into $a0
li $v0, 4		#system call code for Print String
syscall			#print the prompt message

li $v0,5		#read 1st integer into $s0
syscall
move $s0, $v0		#move $s0 onto $v0

li $v0, 5		#read 2nd int into $s1
syscall
move $s1, $v0		#move $s1 onto $v0

li $v0, 5		#read 3rd into $s2
syscall
move $s2, $v0		#move $s2 onto $v0

li $v0, 5		#read 4rd into $s3
syscall
move $s3, $v0		#move $s3 onto $v0


la $a0, outcome_input	#write outcome_input
li $v0, 4		#system call code for Print String
syscall

li $v0,1		#system call code for Print Integer
move $a0, $s0		# print user input of $s0
syscall

li $a0, 32	#this is to create print space between integers
li $v0, 11  	#syscall number for printing character
syscall

li $v0,1	#system call code for Print Integer
move $a0, $s1	# print user input of $s1
syscall

li $a0, 32	#this is to create print space between integers
li $v0, 11  	#syscall number for printing character
syscall

li $v0,1	#system call code for Print Integer
move $a0, $s2	# print user input of $s2
syscall

li $a0, 32	#this is to create print space between integers
li $v0, 11  	#syscall number for printing character
syscall

li $v0,1	#system call code for Print Integer
move $a0, $s3	# print user input of $s3
syscall



li $v0, 4       # to create a new line 
la $a0, newline       # load address of the string
syscall




addu $t0,$s2, $s3	#accumalate the slum

la $a0, outcome_add	#write sum message
li $v0, 4		#system call code for Print String
syscall

move $a0, $t0		#output sum
li $v0, 1		#system call code for Print Integer
syscall



li $v0, 4       # to create a new line  
la $a0, newline       # load address of the string
syscall



ori $t1, $s3, 4		#OR immediate 

la $a0, outcome_ori	# write outcome ori
li $v0, 4		#system call code for Print String
syscall

move $a0, $t1		# output ori
li $v0, 1		#system call code for Print Integer
syscall



li $v0, 4       # to create a new line 
la $a0, newline       # load address of the string
syscall



sll $t2, $s3, 1		#Shift left one bit

la $a0,outcome_shift	# write outcome_shift
li $v0, 4		#system call code for Print String
syscall

 move $a0, $t2 		# output shift
 li $v0, 1		#system call code for Print Integer
 syscall


li $v0, 10		#exit
syscall
