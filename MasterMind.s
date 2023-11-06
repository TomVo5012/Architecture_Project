.global __start
.data
    Message: .asciz "Welcome to the Master Mind Game!!!! \nInstructions:\n1: You will have 10 trials to complete the game \n2: In each trial, a player must guess the each color in the correct position and correct color \n3: A player win by having the less guess for the trials \nAuthors: Kiet Vo and Emanuel Cintron \n"
    array: .byte 0, 0, 0, 0
    num: .byte 0
    num1: .byte 0
    num2: .byte 0
    num3: .byte 0

.text
__start:
    # Write a syscall to print the menu
    addi a0, x0, 4
    la a1, Message
    ecall
    

    addi a0, x0, 5
    ecall
    la t0, num
    sb a0, 0(t0)

    addi a0, x0, 5
    ecall
    la t0, num1
    sb a0, 0(t0)

    addi a0, x0, 5
    ecall 
    la t0, num2
    sb a0, 0(t0)

    addi a0, x0, 5
    ecall 
    la t0, num3
    sb a0, 0(t0)

    # Load num1 and num2 into registers
    la t0, num 
    lb t0, 0(t0)

    la t1, num1 
    lb t1, 0(t1)

    la t2, num2
    lb t2, 0(t2)

    la t3, num3
    lb t3, 0(t3)

    #load the base address of the array into a register 
    la a3, array

    #load the value in each index into register 
    #Print value each index 
    lb a2, 0(a3)
    add t4, a2, t0
    addi a0, x0, 1
    add a1, x0, t4
    ecall 

    lb a2, 8(a3) 
    add t4, a2, t1
    addi a0, x0, 1
    add a1, x0, t4
    ecall

    lb a4, 16(a3)
    add t4, a4, t2
    addi a0, x0, 1
    add a1, x0, t4
    ecall

    lb a4, 32(a3)
    add t4, a4, t3
    addi a0, x0, 1
    add a1, x0, t4
    ecall

    # Exit program 
    addi a0, x0, 10
    ecall