###################################################
# CS 264 Lab 4
# Student: Chong, Angie
# email: achong@cpp.edu
####################################################

problem1.asm
================================================
In problem1.asm, the task was to write a nested function call from the given information on the lab instructions
and to also write a main program that calls to the Func function on the given data and prints out the results.
For this problem, I first created 4 words that hold the integers 0, 2, 8, and 3. I then created the print
function which would print out a value that would print whatever is in $a0. After this, I made a way for the
program to exit and was able to do this by saving the registers that were before the main was called to
to do this, the stack was needed to be used. 
sub $sp, $sp, 4 # pushes the stack to save registers
sw $ra, 0($sp) # saves return address
These two lines would do the trick. Then at the end of the main I had to restore it and return to main from the
print function.
lw $ra, 0($sp) # restores the return address
add $sp, $sp, 4 # pops the stack
jr $ra # return to the system
After all this, if I run the program, 0 would be printed out. I created the max function fiirst and also a less
then or equal function. After creating those two, lastly I created the Func function. For this, you would 
need to add and subtract then call the max while saving the return address.

=================================================
problem1.asm ouput in console window
=================================================

5

=================================================
SPIM Message Window 
=================================================

Memory and registers cleared

SPIM Version 9.1.17 of January 1, 2016
Copyright 1990-2016, James R. Larus.
All Rights Reserved.
SPIM is distributed under a BSD license.
See the file README for a full copyright notice.
QtSPIM is linked to the Qt library, which is distributed under the GNU Lesser General Public License version 3 and version 2.1.

====================================================
problem2.asm
====================================================
In problem2.asm, the task was to write a recursive function that would compute the smalles integer in a given
array of integers and would follow the following algorithm shown on the lab instructions. We would then
also create a Min function that would print out the result with the given array.
First thing we need to do is th create the array with the given integers and also create low and high variables.
Then we need to create the min function, whhich is recursive, so we need to keep saving in to the stack.
We would need to save the low, high, and return address to the stack and we would need to push stack by 12 since
3 * 4 is 12. We would then need to label the stack popping so we could be able to jump to the return. Also
created an exit for the min. We then need to use bne to skip the return if the high is equal to the low and use another label. I used s0 and s1 for pushing and popping the code to save the mid and min1. I then created
the last if statement and subtract min2 from min2 by using blez.
=================================================
problem2.asm ouput in console window
=================================================

-23

=================================================
SPIM Message Window 
=================================================
 

Memory and registers cleared

SPIM Version 9.1.17 of January 1, 2016
Copyright 1990-2016, James R. Larus.
All Rights Reserved.
SPIM is distributed under a BSD license.
See the file README for a full copyright notice.
QtSPIM is linked to the Qt library, which is distributed under the GNU Lesser General Public License version 3 and version 2.1.

