####################################
#### Mukul Mehta               	####   
#### 18CS10033 					####
#### CS39003 -> Assignment 1    ####
####################################	

	.file	"ass1a.c"				# Filename of the input (source) C program
	.text							# Section where code is stored. Read and execute bit permissions (rx). Loaded into memory only once since code doesn't change
	.section	.rodata				# Section containing readonly initialized data (r permission bit only)
.LC0:
	.string	"\nThe greater number is: %d"	# First string label for printing greater number among two 
	.text							# Type of the section below, containing code
	.globl	main					# Assembler directive defining main. It is then made visible to the linker
	.type	main, @function			# Defines the type of main symbol to be a function

main:								# Label indicating begin of main
.LFB0:
	pushq	%rbp					# Push base pointer (rbp) in stack
	movq	%rsp, %rbp				# Set rbp to be equal to rsp (rbp = rsp)
	subq	$16, %rsp				# Allocate memory for stack. In this, it is going to be 16 bytes depending on the number of variables we use
	movl	$45, -8(%rbp)			# Move the constant 45 into the memory that lies 8 bytes below the base pointer. In our case, since each variable takes 4 bytes (int type), we're setting the value of num1 to be 45. Memory is the memory array, we are setting Memory[rbp - 8] to45, which is num1
	movl	$68, -4(%rbp)			# Similar to above, the constant 68 is moved to memory lying 4 bytes below base pointer. That is Memory[rbp - 4] = 68, which is num2
	movl	-8(%rbp), %eax			# We load our register eax with value at memory 8 bytes below base pointer -> eax = Memory[rbp - 8]
	cmpl	-4(%rbp), %eax			# Do a signed comparision between the values present at 4 bytes below base pointer and 8 bytes below. That is between Memory[rbp - 4] and Memory[rbp - 8] (Which is in register eax). Essentially, compare num1 and num2
	jle	.L2							# If num1 <= num2 -> Jump to label L2
	movl	-8(%rbp), %eax			# Set the value of register eax to be the value at 8 bytes below base pointer (That is set eax to be Memory[rbp-8], which is eax has num1 loaded)
	movl	%eax, -12(%rbp)			# Move the value of eax to the location 12 bytes below bp. That is store eax in our greater variable. greater = eax = num1
	jmp	.L3							# Jump to Label L3
.L2:
	movl	-4(%rbp), %eax			# Set the value of register eax to be the value at 4 bytes below base pointer (That is set eax to be Memory[rbp - 4], which is eax has num2 loaded)
	movl	%eax, -12(%rbp)			# Move the value of eax to the location 12 bytes below bp. That is store eax in our greater variable. greater = eax = num2
.L3:
	movl	-12(%rbp), %eax			# Set the value of register eax to be the value at 12 bytes below base pointer (That is set eax = greater)
	movl	%eax, %esi				# Set the value of esi to be eax. esi is the 1st argument of the printf call to be made (esi in this case is set to greater, since we print the greater value)
	leaq	.LC0(%rip), %rdi		# Loads the Effective Address (LEA quad) of LC0 inside of rdi (We load the memory address and not the value and the destination is a register)
	movl	$0, %eax				# Load the value 0 into the register eax. eax is zeroed before calling printf
	call	printf@PLT				# Calls the system printf function (Which takes greater as an argument as it is set in esi)
	movl	$0, %eax				# Load the value 0 into the register eax
	leave							# Put ebp to esp and restore state of esp to the original state
	ret								# Pop return address from stack and move there
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.2.0"		# Show system and compiler information. In my case, the program was compiled with GNU GCC version 10.2 running on a Linux machine
	.section	.note.GNU-stack,"",@progbits
