.global __start
.data
    Message: .asciz "Welcome to the Master Mind Game!!!! \nInstructions:\n1: You will have 10 trials to complete the game \n2: In each trial, a player must guess the each color in the correct position and correct color \n3: A player win by having the less guess for the trials \nAuthors: Kiet Vo and Emanuel Cintron \n"
    Message1: .asciz "Player 1: Enter 1 to input your secret code\n"
    Message2: .asciz "Player 2: Enter 2 to start the game\n"
    Message3: .asciz "Your input is wrong!!!\nPlease enter again!!!\n"
    Message4: .asciz "Your input "
    Message4.1: .asciz " is invalid\nPlease Enter again!!!! \n "
    Message5: .asciz "Your input is wrong!!!\nPlease enter again!!!\n\n"   
    Message6: .asciz "\n"
    Message7: .asciz "Enter your secret code\n"
    Message8: .asciz "Player 1 secret code: "
    Message9: .asciz "Your Trial "
    Message10: .asciz "Player 2 guess is: "
    Message11: .asciz " "
    Message12: .asciz ": "
    Message12.1: .asciz ": \n"
    Message13: .asciz "Testing the consistency of the array: "
    Message14: .asciz "Wrong Position: "
    Message15: .asciz "Correct Position: "
    Message16: .asciz "Enter your secret code in position "
    Message17: .asciz "Enter your guess in position "
    
    ReplacementSymbol: .asciz "*"
    array: .byte 0, 0, 0, 0
    array1: .byte 0, 0, 0, 0
    P1: .byte 0
    num: .byte 0
    num1: .byte 0

.text
__start:
    addi a0, x0, 4
    la a1, Message
    ecall
    
    addi a0, x0, 4
    la a1, Message1
    ecall

    addi a0, x0, 4
    la a1, Message2
    ecall

    addi a0, x0, 4
    la a1, Message7
    ecall

    li t1, 4
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 1
    

# Loop to store the value in the array
player1_input:
    beq t1, x0, player2

    # lreset the value of register t0
    li t0, 0

    # Message
    addi a0, x0, 4
    la a1, Message16
    ecall

    # Position number 
    addi a0, x0, 1
    add a1, x0, t5
    ecall

    # Print out input from player 1
    addi a0, x0, 4
    la a1, Message12
    ecall

    # Ask input from player 1
    addi a0, x0, 5
    ecall 
    la t0, num
    sb a0, 0(t0)
    la t0, num 
    lb t0, 0(t0)

    # Checking the condition from Player 1
    player1_condition:
        li t6, 5
        bge t0, t6, player1_invalid_value
        beq t0, x0, player1_invalid_value
        jal x0, player1_store_value
        player1_invalid_value:
            addi a0, x0, 4
            la a1, Message4
            ecall
            addi a0, x0, 1
            add a1, x0, t0
            ecall
            addi a0, x0, 4
            la a1, Message4.1
            ecall
            beq x0, x0, player1_input

    # Store input in the array
    player1_store_value:
        la s1, array
        slli t2, t3, 6
        add t4, s1, t2
        lb a2, 0(t4)
        add a2, a2, t0
        sb a2, 0(t4)

        addi t3, t3, 1
        addi t1, t1, -1
        # Increment position
        addi t5, t5, 1
        jal x0, player1_input

player2:
    li a3, 3
    li a4, 1
    count_trial:
        beq a3, x0, end_program 
        addi a0, x0, 4
        la a1, Message9
        ecall

        addi a0, x0, 1
        add a1, x0, a4
        ecall

        addi a0, x0, 4
        la a1, Message12.1
        ecall

        li t1, 4
        li t5, 1
        li t6, 5
        li t2, 0
        li t3, 0
        li t4, 0
    player2_input:
        beq t1, x0, compare

        # lreset the value of register t0
        li t0, 0

        # Message
        addi a0, x0, 4
        la a1, Message17
        ecall

        # Position number 
        addi a0, x0, 1
        add a1, x0, t5
        ecall

        # Print out input from player 2
        addi a0, x0, 4
        la a1, Message12
        ecall

        # Ask input from player 2
        addi a0, x0, 5
        ecall 
        la t0, num1
        sb a0, 0(t0)
        la t0, num1 
        lb t0, 0(t0)

        # Checking the condition from Player 1
        player2_condition:
            bge t0, t6, player2_invalid_value
            beq t0, x0, player2_invalid_value
            jal x0, player2_store_value
            player2_invalid_value:
                addi a0, x0, 4
                la a1, Message4
                ecall
                addi a0, x0, 1
                add a1, x0, t0
                ecall
                addi a0, x0, 4
                la a1, Message4.1
                ecall
                beq x0, x0, player2_input
        # Store input in the array
        player2_store_value:
            la s2, array1
            slli t2, t3, 6
            add t4, s2, t2
            lb a2, 0(t4)
            li a2, 0
            add a2, a2, t0
            sb a2, 0(t4)

            addi t3, t3, 1
            addi t1, t1, -1
            # Increment position
            addi t5, t5, 1
            jal x0, player2_input

compare:
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 4
    li a5, 0
    li a6, 0
    li s4, 0
    li s3, 0
    li s5, 4
    li x24, 4

load_value_array1:
    beq x24, x0, print_result

    la s1, array
    slli t2, t1, 6
    add t3, s1, t2
    lb a5, 0(t3)

    la s2, array1
    slli t2, t4, 6
    add  t5, s2, t2
    lb a6, 0(t5)

    beq a5, a6, compare_case1
    bne a5, a6, compare_case2

    compare_case1:
        beq t1, t4, compare_case1_1
        bne t1, t4, compare_case1_2
        compare_case1_1:
            addi s3, s3, 1
            addi t1, t1, 1
            addi t4, t4, 1
            addi x24, x24, -1
            jal x0, load_value_array1
        compare_case1_2:
            addi s4, s4, 1
            addi t1, t1, 1
            addi x24, x24, -1
            jal x0, load_value_array1
    compare_case2:
        beq t1, s5, compare_case2_1
        addi t1, t1, 1
        jal x0, load_value_array1 
        compare_case2_1:
            addi t4, t4, 1
            li t1, 0
            jal x0, load_value_array1


print_result:
    li s5, 4

    addi a0, x0, 4
    la a1, Message14
    ecall

    addi a0, x0, 1
    add a1, x0, s4
    ecall

    addi a0, x0, 4
    la a1, Message6
    ecall                

    addi a0, x0, 4
    la a1, Message15
    ecall

    addi a0, x0, 1
    add a1, x0, s3
    ecall

    beq s5, s3, end_program
return_function:
    addi a0, x0, 4
    la a1, Message6
    ecall

    addi a3, a3, -1
    addi a4, a4, 1
    beq x0, x0, count_trial

end_program:
    addi a0, x0, 10
    ecall
    
