	#Ram Bhagat
main: 
	li $t0, 0
	li $a0, 0
	li $t1, 10

loop:
	beq $t0, $t1, end
	add, $a0, $a0, $t0
	addi, $t0, $t0, 1
	j	loop

end:
	li $v0, 1
	syscall
	# This system call stops the machine
	li $v0, 10
	syscall

