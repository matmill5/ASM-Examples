#############################################################################
#This progam allows a user to enter an integer number that represents a number of floating-point-numbers to be averaged
#It conducts a loop that prompts the user-specified floating point numbers
#After collection, it conducts an average operation and prints the results to-screen
############################################################################
#Author: Matthew Miller
#Date: 4/9/2019
#Course Title: Computer Arch.
#Assign: Project 3
###########################################################################
.data
prompt1: .asciiz "This is Matthew Miller presenting average.asm\n"
prompt2: .asciiz "How many numbers would you like to average? "
prompt3: .asciiz "Please enter a 3 digit decimal d.dd: "
prompt4: .asciiz "The average is: "
newline: .asciiz "\n" #for formatting

               .text #start code section
          .globl main
main:
        la $a0, prompt1	# prints prompt: "Matthew Miller's Floating Point Average Calculator\n"
        li $v0, 4
        syscall

        la $a0, prompt2	# prints prompt: "How many numbers would you like to average? "
        li $v0, 4
        syscall

        li $v0, 5		# reads in integer, number of floating point numbers to average
        syscall
      
        add $s0, $v0, $zero   # loads number of floating point numbers into $s0
      
        mtc1 $v0, $f1		# puts user input, $v0 into $f1
        cvt.s.w $f1, $f1	# convert from integer into single precision float point
      
        jal collectUserFloats
      
        jal averageFloats

   	# to exit
        li $v0, 10
        syscall

collectUserFloats:
   bge $t0, $s0, exit
   
   	la $a0, prompt3		# prints prompt: "Please enter a 3 digit decimal d.dd: "
       	li $v0, 4
	syscall
	
        li $v0, 6		# read float from user input
        syscall
  
   add.s $f2, $f2, $f0		# add floats
   addi $t0, $t0, 1
   j collectUserFloats
exit:
   jr $ra
averageFloats:
   div.s $f3, $f2, $f1
  
   	la $a0, newline    # prints newline for formatting
   	li $v0, 4
        
        la $a0, prompt4    # prints prompt: "The average is: "
        li $v0, 4
        syscall

   mov.s $f12, $f3     # loads float average for printing
   li $v0, 2
   syscall
  
   jr $ra	#returns
