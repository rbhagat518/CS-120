	#Ram Bhagat
	#Sum Under 10
	.data
x:	.word 3
	.word 4
	.word 25
	.word 33
	.word 6
	.word 2
	.word 0
prompt:	.asciiz "The total of things less than 10 is "

	.text
main:	la $s0, x
	li $s1, 0
	li $s2, 10
	li, $s3, 0
while:	lw $s4, 0($s0)
	beq $s4, $0, done

	ble $s2, $s4, skip
	add $s1, $s1, $s4
skip:
	# Move the pointer
	addi $s0, $s0, 4

	j while
done:
	# SPIM can print ASCII strings...
	li $v0, 4
	la $a0, prompt
	syscall
	# SPIM has code to print numbers as
	# part of the operating system.  
	li $v0, 1
	move $a0, $s1
	syscall
	# This system call stops the machine
	li $v0, 10
	syscall

	
