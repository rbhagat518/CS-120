#### Ram Bhagat
.data
str: 
	.asciiz "This HAS UPPER and lower CASE letters."

.text
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $a0, str
	jal lowercase
	# Now we print the string, which lowercase has modified
	la $a0, str
	li $v0, 4
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

lowercase:
	li $s0, 65
	li $s1, 90
	lb $t0, ($a0)
	beq $t0, $zero, exit
	blt $t0, 'A', skip
	bgt $t0, 'Z', skip
	add $t0, $t0, 32
	sb $t0, ($a0)
	addi $t0, $t0, 1
	j lowercase
skip:
	addi $a0, $a0, 1
	j lowercase

exit:
	jr, $ra
	nop

