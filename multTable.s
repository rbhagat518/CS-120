#### Ram Bhagat

.data

nl:	.asciiz "\n"
space:	.asciiz " "


.text
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a1, 3
	li $a2, 4
	jal multtable
	# Now we print the mutliplication table

	li $a1, 5
	li $a2, 7
	jal multtable
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

multtable:
	li $t0, 1 # i = 1
	li $t1, 1 # j = 1

outer_loop:
	bgt $t0, $a1, exit
	li $t1, 1
	j inner_loop

else:
	la $a0, nl # j starting
	li $v0, 4
	syscall
	addi $t0, $t0, 1
	j outer_loop

inner_loop:
	bgt $t1, $a2, else
	
	mul $a0, $t0, $t1
	addi $t1, $t1, 1
	
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall 
	j inner_loop

exit:
	jr, $ra




