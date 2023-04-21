
caller:		addi 	$a0, $zero, 18		# initialize argument register $a0 with n = 18
#######		#addi 	$a1, $zero, 0x100100A0	# this instruction is treated as a pseudo instruction, replace it with the proper basic MIPS instructions
		jal	fib_seq			# call fib_seq
next:		j	exit

##############################################################################
# This routine generates Fibonacci sequence fib(0), fib(1), fib(2), ... fib(n)
# and stores it into the data segment starting at memory address 0x100100A0
# which is pointed at by register $a1

fib_seq:	
####################### Insert Your Code Here ################################
# $a0 - n
# $a1 - base address of output
# $t0 - counter variable
# $t1 - less-than-2 flag
# $t2 - fibonacci value buffer
# $t3 - address offset
# $t4 - first addend value buffer
# $t5 - second addend value buffer
# $t6 - working address buffer

		li 	$a1, 0x100100A0		# initializes base address
		li  	$t2, 0			# sets fib(0) to 0
		sw  	$t2, ($a1)
		beq  	$a0, $zero, exit	# exits fib_seq if n is 0
		li   	$t2, 1			# sets fib(1) to 1
		sw   	$t2, 4($a1)		
		slti 	$t1, $a0, 2		# exits fib_seq if n is less than 2
		bne  	$t1, $zero, exit
		addi 	$t0, $zero, 3		# sets counter to 3
		j  	loop			# starts main loop

loop:		add 	$t6, $a1, $t3	# adds offset to base address (offset is initialized as 0)
		lw 	$t4, ($t6)	# loads two previous fibonacci numbers
		addi 	$t6, $t6, 4
		lw	$t5, ($t6)
		add	$t2, $t4, $t5	# adds both addends and saves it to fibonacci value buffer
		addi 	$t6, $t6, 4	# updates working address to next memory location
		sw 	$t2, ($t6)	# saves the value in the fibonacci buffer to its respective memory location
		beq 	$a0, $t0, end	# breaks if the counter is equal to n
		addi 	$t0, $t0, 1	# otherwise adds 1 to the counter and repeats
		addi	$t3, $t3, 4	# increases address offset by 4
		j 	loop

end:		jr 	$ra

##############################################################################

exit:		
