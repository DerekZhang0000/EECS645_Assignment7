
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
# $v0 - fibonacci value buffer
# $s0 - fibonacci value buffer 2
# $t0 - temporary register
# $t1 - working address buffer
# $t2 - address offset
		li 	$a1, 0x100100A0		# initializes base address
		addi	$a1, $a1, 4		# adds offset to preserve 0
		addi 	$a0, $a0, -1		# reduces n by 1 to prevent overloopin
		j 	fib
	fib:
		addi 	$sp, $sp, -12		# make room on stack
		sw 	$ra, 8($sp) 		# push $ra
		sw 	$s0, 4($sp) 		# push $s0
		sw 	$a0, 0($sp) 		# push $a0 (n)
		bgt 	$a0, $zero, test2	# if n>0, test if n=1
		add 	$v0, $zero, $zero	# else fib(0) = 0
		
		addi	$t3, $a0, 1		# sets offset to (n + 1) * 4
		mul	$t2, $t3, 4		
		add	$t1, $t2, $a1		# adds base to offset
		sw	$v0, ($t1)		# stores fibonacci value at working address
		
		j 	rtn			#
		
	test2: 	addi 	$t0, $zero, 1 		#
		bne 	$t0, $a0, gen 		# if n>1, gen
		add 	$v0, $zero, $t0 	# else fib(1) = 1

		mul	$t2, $t3, 4		# sets offset to n * 4
		add	$t1, $t2, $a1		# adds base to offset
		sw	$v0, ($t1)		# stores fibonacci value at working address

		j 	rtn
		
	gen: 	addi 	$a0, $a0, -1 		# n-1
		jal 	fib			# call fib(n-1)
		add 	$s0, $v0, $0 		# copy fib(n-1)
		
		addi 	$t3, $a0, 0
		mul	$t2, $t3, 4		# sets offset to n * 4
		add	$t1, $t2, $a1		# adds base to offset
		sw	$s0, ($t1)		# stores fibonacci value at working address
		
		addi 	$a0, $a0, -1 		# n-2
		jal 	fib			# call fib(n-2)
		add 	$v0, $v0, $s0 		# fib(n-1)+fib(n-2)
		
		addi 	$t3, $a0, 1		# sets offset to (n + 1) * 4
		mul	$t2, $t3, 4		
		add	$t1, $t2, $a1		# adds base to offset
		sw	$v0, ($t1)		# stores fibonacci value at working address
		
	rtn: 	lw 	$a0, 0($sp) 		# pop $a0
		lw 	$s0, 4($sp) 		# pop $s0
		lw 	$ra, 8($sp) 		# pop $ra
		addi 	$sp, $sp, 12 		# restore sp
		jr 	$ra


##############################################################################

exit:		
