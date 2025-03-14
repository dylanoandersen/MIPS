        .data
welcome:    .asciiz "Welcome to my MIPS Array Program"
newline:    .asciiz "\n"
space:	.asciiz " "
arraytxt:	.asciiz "This is the original array: "
minn:	.asciiz "This is the minimum integer in the array (address and value): "
maxx:	.asciiz "This is the maximum integer in the array (address and value): "
swapp: 	.asciiz "After swaping the largest and smallest value's positions here is the new array: "
size:	    .word 9
myarray:     .word 94, 13, 3, 58, 19, 38, 28, 36, 74, 80


        .text
        .globl main

#print new line function
printnewline:
    addi $sp,$sp,-4     #Prepare the stack for use of a register
    sw $ra,($sp)        #Save current return address on the stack

    #print newline
    li $v0, 4           #syscall 4 to print string
    la $a0, newline     #pass newline string
    syscall             #print string

    lw $ra, ($sp)       #Restore return address
    addi $sp,$sp,4      #Restore stack pointer
    jr $ra              #Return

printspace:

    addi $sp,$sp,-4     #Prepare the stack for use of a register
    sw $ra,($sp)        #Save current return address on the stack

    #print newline
    li $v0, 4           	#syscall 4 to print string
    la $a0, space    		#pass space string
    syscall             	#print string

    lw $ra, ($sp)       	#restore return address
    addi $sp,$sp,4      	#restore stack pointer
    jr $ra              	#return

findMaxAddress:

    addi $sp,$sp,-4     	#Prepare the stack for register
    sw $ra, ($sp)        	#Save current return address on stack
    addi $t0, $a0, 0		#save parameter into temp register
    addi $t2, $a1, 0		#save parameter into temp register
    li $t1, 0			#save 0 into t1 as a counter
    li $t6, 1			#save 1 into t6 to compare
    lw $t7, 0($t0)		#load the first element as the starting max value

max:
    bgt $t1, $t2, exit_loop		#branch if greater than
    sll $t3, $t1, 2			#4*i to get address of element
    addu $t3, $t3, $t0			#add offset to address of array to get address of element
    lw $t4, 0($t3)			#load value of address into t4 to compare which is greater
    slt $t5, $t4, $t7			#set if less than
    beq $t5, $t6, sett			#branch if equal, new value is not larger if branch
    addi $t7, $t4, 0			#t7 equals larger number
    addi $v0, $t3, 0			#address of larger number saved into return address
    addi $t1, $t1, 1			#counter is incrimented by 1
    j max				#loops back
sett:
    addi $t1, $t1, 1			#counter is incrimented by 1
    j max				#loops back


findMinAddress:

    addi $sp,$sp,-4     	#Prepare the stack for register
    sw $ra, ($sp)        	#Save current return address on stack
    addi $t0, $a0, 0		#save parameter into temp register
    addi $t2, $a1, 0		#save parameter into temp register
    li $t1, 0			#save 0 into t1 as a counter
    li $t6, 1			#save 1 into t6 to compare
    lw $t7, 0($t0)		#load the first element as the starting min value

min:
    bgt $t1, $t2, exit_loop		#branch if greater than
    sll $t3, $t1, 2			#4*i to get address of element
    addu $t3, $t3, $t0			#add offset to address of array to get address of element
    lw $t4, 0($t3)			#load value of address into t4 to compare which is greater
    slt $t5, $t4, $t7			#set if less than
    bne $t5, $t6, set			#branch if not equal, new value is not smaller if branch
    addi $t7, $t4, 0			#t7 equals smaller number
    addi $v0, $t3, 0			#address of smaller number saved into return address
    addi $t1, $t1, 1			#counter is incrimented by 1
    j min				#loops back
set:
    addi $t1, $t1, 1			#counter is incrimented by 1
    j min				#loops back
	

printArray:

    addi $sp,$sp,-4     	#Prepare the stack for use of a register
    sw $ra, ($sp)        	#Save current return address on stack
    addi $t0, $a0, 0		#save array into t0	
    addi $t2, $a1, 0		#save size into t2
    li $t1, 0			#save 0 into t1 as an incrimentor 
   

begin_loop: 
 
    bgt $t1, $t2, exit_loop		#branch if greater than
    sll $t3, $t1, 2			#4*i to get address of element
    addu $t3, $t3, $t0			#adds address of array and offset 

    li $v0, 1				#1 is the syscall to print integers
    lw $a0, 0($t3)			#load address of t3 into a0
    syscall

    jal printspace			#call printspace function

    addi $t1, $t1, 1			#incriment by 1

    j begin_loop   			#loop back

printValueAtAddress:

    addi $sp,$sp,-4     	#Prepare the stack for use of a register
    sw $ra, ($sp)        	#Save current return address on stack

    addi $t0, $a0, 0		#save address into t0

    li $v0, 1			#1 is the syscall to print integers
    lw $a0, 0($t0)		#load address of t3 into a0
    syscall

    lw $ra, ($sp)       	#restore return address
    addi $sp,$sp,4      	#restore stack pointer
    jr $ra              	#return

swapValues:

    addi $sp,$sp,-4     	#Prepare the stack for use of a register
    sw $ra, ($sp)        	#Save current return address on stack

    addi $t0, $a0, 0		#save address 1 into t0
    addi $t1, $a1, 0		#save address 2 into t1

    lw $t2, 0($t0)		#load word from t0 address
    lw $t3, 0($t1)		#load word from t1 address

    sw $t2, 0($t1)		#save value into different address
    sw $t3, 0($t0)		#save value into different address


    lw $ra, ($sp)       	#restore return address
    addi $sp,$sp,4      	#restore stack pointer
    jr $ra              	#return
    


main:
    addi $sp,$sp,-12     	#Prepare the stack
    sw $ra, 8($sp) 		#Save current return address on the stack
    sw $s0, 4($sp)		#save s0 address on the stack
    sw $s1, ($sp)		#save s1 address on the stack
           			

    li $v0, 4          	 	#4 is the syscall to print strings
    la $a0, welcome     	#Load welcome string address into $a0
    syscall

    jal printnewline		#call new line function

    li $v0, 4           	#4 is the syscall to print strings
    la $a0, arraytxt      	#Load welcome string address into $a0
    syscall


    la $a0, myarray	 	#parameter 1 the array
    lw $a1, size		#parameter 2 the size
    jal printArray		#function to print array
    
    jal printnewline		#call new line function

    li $v0, 4          	 	#4 is the syscall to print strings
    la $a0, minn     		#Load minn string address into $a0
    syscall

    la $a0, myarray	 	#parameter 1 the array
    lw $a1, size		#parameter 2 the size
    jal findMinAddress		#function to find min

    addi $s0, $v0, 0		#saves return value into s0
    move $a0, $v0		#saves return value into a0
    li $v0, 1			#1 is the syscall to print integers
    syscall
  
    jal printspace		#function to print space

    move $a0, $s0		#save s0 into a0 as a parameter for function
    jal printValueAtAddress	#call function to print value at address
    
    jal printnewline		#call new line function

    li $v0, 4          	 	#4 is the syscall to print strings
    la $a0, maxx     		#Load maxx string address into $a0
    syscall

    la $a0, myarray	 	#parameter 1 the array
    lw $a1, size		#parameter 2 the size
    jal findMaxAddress		#function to find max
   
    
    addi $s1, $v0, 0		#saves return value into s1
    move $a0, $v0		#saves return value into a0
    li $v0, 1			#1 is the syscall to print integers
    syscall
  
    jal printspace		#print space

    move $a0, $s1		#saves s1 into a0 as a parameter for function
    jal printValueAtAddress	#call function to print value at address		

    jal printnewline		#call new line function

    li $v0, 4          	 	#4 is the syscall to print strings
    la $a0, swapp     		#Load swapp string address into $a0
    syscall

    addi $a0, $s0, 0		#saves s0 into a0 as a parameter
    addi $a1, $s1, 0		#saves s1 into a1 as a parameter
    jal swapValues		#call swap function

    la $a0, myarray	 	#parameter 1 the array
    lw $a1, size		#parameter 2 the size
    jal printArray		#function to print array

    lw $s1, ($sp)		#restore s1 address from stack
    lw $s0, 4($sp)		#restore s0 address from stack
    lw $ra, 8($sp)       	#Restore return address from stack
    addi $sp,$sp,12      	#Restore stack pointer
    jr $ra              	#End program

exit_loop:
    lw $ra, ($sp)       #Restore return address
    addi $sp,$sp,4      #Restore stack pointer
    jr $ra              #Return


	



