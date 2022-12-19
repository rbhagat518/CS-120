.data
str1: .asciiz "The number is # and here is a string $ that gets spliced in"
str2: .asciiz "WHEEE!"

.text
main:  addi $sp, $sp, -4
    sw $ra, 0($sp)

    # Push all the arguments on the stack
    addi $sp, $sp, -12
    la $t0, str2
    sw $t0, 8($sp)
    li $t0, 999
    sw $t0, 4($sp)
    la $t0, str1
    sw $t0, 0($sp)
    jal printf
    addi $sp, $sp, 12

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# Your Modified Printf Here!
# Add support for $ to insert a string!
printf:
	# Store ra, s0, s1
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	# The arguments to the function are now at
	# 12($sp) and above
	lw $s0, 12($sp)
	addi $s1, $sp, 16

	# $s0 is now the POINTER to the original string
	# $s1 is a pointer to the first argument after the string

	# Get one letter at a time and print
loop:	lb $a0, 0($s0)
	
	# Exit if it's zero
	beq $a0, $0, done

	# if statement -- check against '#'
	li $t0, '#'
	beq $a0, $t0, else
	# "If" part -- if it's not #
	li $t0, '$'
	beq $a0, $t0, str_else
	#if statement -- check against '$'

	li $v0, 11
	syscall
	b if_done
	
else:	# print the number pointed to by s1, then move the pointer
	lw $a0, 0($s1)
	li $v0, 1
	syscall

	addi $s1, $s1, 4
	j if_done

str_else:
	lw $a0, 0($s1)
	li $v0, 4
	syscall


if_done:
	addi $s0, $s0, 1
	b loop

done:	# Restore registers, return
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12

	jr $ra