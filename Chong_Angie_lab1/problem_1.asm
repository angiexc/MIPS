# Student : Chong, Angie
# Description: problem_1.asm - This program will print out "Hello World"

.data	#declaring data

out_string: .asciiz "\nHello World \n"	#This is the string that will be printed

.text		# Assembly language instrunctions go in this section

main:		# Start of code

	li $v0, 4	# this is the system call code for printing the string = 4
	la $a0, out_string	# this will load address of string to be printed into $a0
	syscall		# call operation system that will perform specified in $v0
	
	li $v0, 10	#this will terminate the program
	syscall
	
	
	
