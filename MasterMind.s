.global __start
.data
    Message: .asciz "Welcome to the Master Mind Game!!!! \nInstructions:\n1: You will have 10 trials to complete the game \n2: In each trial, a player must guess the each color in the correct position and correct color \n3: A player win by having the less guess for the trials \nAuthors: Kiet Vo and Emanuel Cintron \n"
    Message1: .asciz "Player 1: Enter 1 to input your secret code\n"
    Message2: .asciz "Player 2: Enter 2 to start the game\n"
    Message3: .asciz "Your input is wrong!!! \nPlease enter again!!!\n"
    array: .byte 0, 0, 0, 0
    array1: .byte 0, 0, 0, 0
    P1: .byte 0
    P2: .byte 0
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
    
    addi a0, x0, 4
    la a1, Message1
    ecall

    addi a0, x0, 4
    la a1, Message2
    ecall

player1_input:
    
    addi a0, x0, 5
    ecall 
    la t0, P1
    sb a0, 0(t0)
    la t0, P1
    lb t0, 0(t0)

    addi t1, x0, 1
    bne t0, t1, player1_input_case1
    beq t0, t1, player1_input_case2

    player1_input_case1:
        addi a0, x0, 4
        la a1, Message3
        ecall
        add t1, x0, x0
        beq x0, x0, player1_input

    player1_input_case2:

        add t0, x0, x0
        add t1, x0, x0

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

        lb a2, 16(a3)
        add t4, a2, t2
        addi a0, x0, 1
        add a1, x0, t4
        ecall

        lb a2, 32(a3)
        add t4, a2, t3
        addi a0, x0, 1
        add a1, x0, t4
        ecall
        
end_program:
    # Exit program 
    addi a0, x0, 10
    ecall