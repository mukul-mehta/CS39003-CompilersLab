####################################
#### Mukul Mehta               	####   
#### 18CS10033 					####
#### CS39003 -> Assignment 1    ####
####################################
	.file	"ass1b.c"				# Filename of the input (source) C program
	.text							# Section where code is stored. Read and execute bit permissions (rx). Loaded into memory only once since code doesn't change
	.section	.rodata				# Section containing readonly initialized data (r permission bit only)
	.align 8						# Set 8 byte memory alignmen
.LC0:
	.string	"\nGCD of %d, %d, %d and %d is: %d"	# First string label for printing GCD of all 4 numbers
	.text							# Type of the section below, containing code
	.globl	main					# Assembler directive defining main. It is then made visible to the linker
	.type	main, @function			# Defines the type of main symbol to be a function
main:								# Label indicating begin of main
.LFB0:
	pushq	%rbp					# Push base pointer (rbp) in stack
	movq	%rsp, %rbp				# Set rbp to be equal to rsp (rbp = rsp)
	subq	$32, %rsp				# Allocate memory for stack. In this, it is going to be 32 bytes depending on the number of variables we use
	movl	$45, -20(%rbp)			# Move the constant 45 into the memory that lies 20 bytes below the base pointer. In our case, since each variable takes 4 bytes (int type), we're setting the value of num1 to be 45. Memory is the memory array, we are setting Memory[rbp - 20] to 45, which is num2
	movl	$99, -16(%rbp)			# Similar to above, the constant 99 is moved to memory lying 16 bytes below base pointer. That is Memory[rbp - 16] = 99, which is b
	movl	$18, -12(%rbp)			# Similar to above, the constant 18 is moved to memory lying 12 bytes below base pointer. That is Memory[rbp - 12] = 18, which is c
	movl	$180, -8(%rbp)			# Similar to above, the constant 180 is moved to memory lying 8 bytes below base pointer. That is Memory[rbp - 8] = 180, which is d
	movl	-8(%rbp), %ecx			# We load our register ecx with value at memory 8 bytes below base pointer -> ecx = Memory[rbp - 8]
	movl	-12(%rbp), %edx			# We load our register edx with value at memory 12 bytes below base pointer -> edx = Memory[rbp - 12]
	movl	-16(%rbp), %esi			# We load our register esi with value at memory 16 bytes below base pointer -> esi = Memory[rbp - 16]
	movl	-20(%rbp), %eax			# We load our register eax with value at memory 20 bytes below base pointer -> eax = Memory[rbp - 20]
	movl	%eax, %edi				# Load value of edi to be eax, being the first argument of GCD4 function
	call	GCD4					# Call the GCD4 function
	movl	%eax, -4(%rbp)			# Load Memory[rbp-4] to be eax which is the result of GCD4 (a,b,c,d) (Since the default return value is in register eax)
	movl	-4(%rbp), %edi			# Load edi to be Memory[rbp - 4], which is our result
	movl	-8(%rbp), %esi			# Load esi to Memory[rbp - 8], which is variable d
	movl	-12(%rbp), %ecx			# Load ecx to Memory[rbp - 12], which is variable c
	movl	-16(%rbp), %edx			# Load edx to Memory[rbp - 16], which is variable b
	movl	-20(%rbp), %eax			# Load eax to Memory[rbp - 20], which is variable a
	movl	%edi, %r9d				# Load register r9d to edi, which is our result variable (5th argument to printf call)
	movl	%esi, %r8d				# Load register r8d to esi, which is our variable d (4th argument to printf call)
	movl	%eax, %esi				# Load register esi to easx, which is our variable a (1st argument to printf call)
	leaq	.LC0(%rip), %rdi		# Load the Effective Address of .LC0(%rip), which loads the string into printf
	movl	$0, %eax				# Zero the return value register to 0 before calling printf
	call	printf@PLT				# Call the printf function
	movl	$10, %edi				# Set the value of register edi to 10 
	call	putchar@PLT				# Print the newline character
	movl	$0, %eax				# Set the return value to 0 (Register eax)
	leave							# Put ebp to esp and restore state of esp to the original state
	ret								# Pop return address from stack and move there
.LFE0:
	.size	main, .-main			
	.globl	GCD4					# Assembler directive defining GCD4 as a global
	.type	GCD4, @function			# Defines the type of GCD4 symbol to be a function
GCD4:								# Label indicating begin of GCD4
.LFB1:
	pushq	%rbp					# Push base pointer (rbp) in stack
	movq	%rsp, %rbp				# Set rbp to be equal to rsp (rbp = rsp)
	subq	$32, %rsp				# Allocate memory for stack. In this, it is going to be 32 bytes depending on the number of variables we use
	movl	%edi, -20(%rbp)			# Load Memory[rbp - 20] to be edi, which is the first argument (n1) to the function call
	movl	%esi, -24(%rbp)			# Load Memory[rbp - 24] to be esi, which is the second argument (n2) to the function call
	movl	%edx, -28(%rbp)			# Load Memory[rbp - 28] to be edx, which is the third argument (n3) to the function call
	movl	%ecx, -32(%rbp)			# Load Memory[rbp - 32] to be ecx, which is the fourth argument (n4) to the function call
	movl	-24(%rbp), %edx			# Load register edx with Memory[rbp - 24], which is n2, for the first call to GCD
	movl	-20(%rbp), %eax			# Load register eax with Memory[rbp - 20], which is n1, for the first call to GCD
	movl	%edx, %esi				# Set register esi to be edx, which sets the 2nd argument to the first GCD call
	movl	%eax, %edi				# Set register esi to be eax, which sets the 1st argument to the first GCD call
	call	GCD						# Make the first GCD call with n1 and n2
	movl	%eax, -12(%rbp)			# Move the result of first GCD call to Memory[rbp - 12], which is t1
	movl	-32(%rbp), %edx			# Load register edx with Memory[rbp - 32], which is n4, for the second call to GCD
	movl	-28(%rbp), %eax			# Load register eax with Memory[rbp - 28], which is n3, for the second call to GCD
	movl	%edx, %esi				# Set register esi to be edx, which sets the 2nd argument to the second GCD call
	movl	%eax, %edi				# Set register edi to be eax, which sets the 1st argument to the second GCD call
	call	GCD						# Make the second GCD call with n3 and n4
	movl	%eax, -8(%rbp)			# Save result of second call in t2, Memory[rbp - 8] = eax = t2
	movl	-8(%rbp), %edx			# Load register edx with Memory[rbp - 8], which is t2, for the third call to GCD
	movl	-12(%rbp), %eax			# Load register eax with Memory[rbp - 12], which is t1, for the third call to GCD
	movl	%edx, %esi				# Set register esi to be edx, which sets the 2nd argument to the third GCD call
	movl	%eax, %edi				# Set register edi to be eax, which sets the 1st argument to the third GCD call
	call	GCD						# Make the third GCD call with t1 and t2
	movl	%eax, -4(%rbp)			# Save the result of call (register eax) in Memory[rbp - 4] which is variable t3
	movl	-4(%rbp), %eax			# Set the value of eax to be Memory[rbp - 4], that is make sure t3 is returned
	leave							# Put ebp to esp and restore state of esp to the original state
	ret								# Pop return address from stack and move there
.LFE1:
	.size	GCD4, .-GCD4
	.globl	GCD						# Assembler directive defining GCD as a global
	.type	GCD, @function			# Defines the type of GCD symbol to be a function
GCD:								# Label indicating begin of GCD
.LFB2:
	pushq	%rbp					# Push base pointer (rbp) in stack
	movq	%rsp, %rbp				# Set rbp to be equal to rsp (rbp = rsp)
	movl	%edi, -20(%rbp)			# Load Memory[rbp - 20] to edi, which is num1, that is first argument for while loop
	movl	%esi, -24(%rbp)			# Load Memory[rbp - 24] to esi, which is num2, that is second argument for while loop
	jmp	.L6							# Jump to label L6
.L7:
	movl	-20(%rbp), %eax			# Load eax to be Memory[rbp - 20] , that is eax = num1
	cltd							# Converts signed long in eax to signed double long in edx:eax by extending the most significant bit (sign bit) of eax into all bits of edx
	idivl	-24(%rbp)				# Divide %edx : %eax (num1) by Mem[rbp - 24] (num2) and store quotient in eax and remainder in edx
	movl	%edx, -4(%rbp)			# Set Memory[rbp - 4] to be edx ,i.e, temp = num1 % num2
	movl	-24(%rbp), %eax			# Set eax to be Memory[rbp - 24], that is eax = num2
	movl	%eax, -20(%rbp)			# Memory[rbp - 20] = eax, that is num1 = num2
	movl	-4(%rbp), %eax			# eax = Memory [rbp - 4] -> eax = temp
	movl	%eax, -24(%rbp)			# Memory[rbp - 24] = eax -> num2 = temp
.L6:
	movl	-20(%rbp), %eax			# Set eax to Memory[rbp - 20] -> eax = num1
	cltd							# Converts signed long in eax to signed double long in edx:eax by extending the most significant bit (sign bit) of eax into all bits of edx
	idivl	-24(%rbp)				# Divide %edx : %eax (num1) by Memory[rbp - 24] (num2) and store quotient in eax and remainder in edx
	movl	%edx, %eax				# eax = edx ,i.e , eax = remainder 
	testl	%eax, %eax				# Performs bitwise AND between eax and eax to test if eax (remainder) is 0
	jne	.L7							# Jump to .L7 if eax (remainder) is not 0
	movl	-24(%rbp), %eax			# eax = Memory[rbp - 24],i.e, return value of the function is set to num2
	popq	%rbp					# Pops rbp from stack
	ret								# Return from function
.LFE2:
	.size	GCD, .-GCD
	.ident	"GCC: (GNU) 10.2.0"			# Show system and compiler information. In my case, the program was compiled with GNU GCC version 10.2 running on a Linux machine
	.section	.note.GNU-stack,"",@progbits
