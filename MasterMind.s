.global __start
.data
    Message: .asciz "Welcome to the Master Mind Game!!!! \nInstructions:\n1: You will have 10 trials to complete the game \n2: In each trial, a player must guess the each color in the correct position and correct color \n3: A player win by having the less guess for the trials \nAuthors: Kiet Vo and Emanuel Cintron \n"
    Message1: .asciz "Player 1: Enter 1 to input your secret code\n"
    Message2: .asciz "Player 2: Enter 2 to start the game\n"
    Message3: .asciz "Your input is wrong!!! \nPlease enter again!!!\n"
    Message4: .asciz "Your input for color is invalid\n Please input again\n"
    Message5: .asciz "Your input is wrong!!!\nPlease enter again!!!\n\n"   
    Message6: .asciz "\n"
    Message7: .asciz "Enter your secret code\n"
    Message8: .asciz "Player 1 secret code: "
    Message9: .asciz "Player 2 guess number "
    Message10: .asciz "Player 2 guess is: "
    Message11: .asciz " "
    Message12: .asciz ":\n"
    ReplacementSymbol: .asciz "*"
    array: .byte 0, 0, 0, 0
    array1: .byte 0, 0, 0, 0
    P1: .byte 0
    num: .byte 0
    num1: .byte 0
    num2: .byte 0
    num3: .byte 0
    num4: .byte 0
    num5: .byte 0
    num6: .byte 0
    num7: .byte 0


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

    game_start:
        addi a0, x0, 5
        ecall 
        la t0, P1
        sb a0, 0(t0)
        la t0, P1
        lb t0, 0(t0)

        addi t1, x0, 1
        addi t2, x0, 2
        beq t0, t1, player1_input
        #beq t0, t2, player2_input 
        
        addi a0, x0, 4
        la a1, Message5
        ecall
        beq x0, x0, game_start

#######################################  This is the secret code from player1 #######################################


player1_input:

    addi a0, x0, 4
    la a1, Message7
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

    ######Add condition for the each index in the array###############
    player1_input_condition:
        addi t6, x0, 5
        bge t1, t6, player1_input_condition1
        beq t1, x0, player1_input_condition1
        bge t2, t6, player1_input_condition1
        beq t2, x0, player1_input_condition1
        bge t3, t6, player1_input_condition1
        beq t3, x0, player1_input_condition1
        bge t0, t6, player1_input_condition1
        beq t0, x0, player1_input_condition1
        beq x0, x0, player1_print 
        player1_input_condition1:
            addi a0, x0, 4
            la a1, Message4
            ecall
            beq x0, x0, player1_input

    ############## Print out the array ##############################
    player1_print:

        addi a0, x0, 4
        la a1, Message8
        ecall
    

        #load the base address of the array into a register 
        la a3, array


        #load the value in each index into register 
        #Print value each index 
        sb a2, 0(a3)
        add s0, a2, t0
        addi a0, x0, 1
        add a1, x0, s0
        ecall 

        addi a0, x0, 4
        la a1, Message11
        ecall

        sb a2, 16(a3) 
        add s1, a2, t1
        addi a0, x0, 1
        add a1, x0, s1
        ecall

        addi a0, x0, 4
        la a1, Message11
        ecall

        sb a2, 32(a3)
        add s2, a2, t2
        addi a0, x0, 1
        add a1, x0, s2
        ecall

        addi a0, x0, 4
        la a1, Message11
        ecall

        sb a2, 64(a3)
        add s3, a2, t3
        addi a0, x0, 1
        add a1, x0, s3
        ecall

        addi a0, x0, 4
        la a1, Message6
        ecall


player2_input:    

    addi t0, x0, 3
    add t1, x0, x0
    add t2, x0, x0
    add t3, x0, x0
    add t4, x0, x0 
    addi a4, x0, 1

    player2_input_loop:
        beq t0, x0, end_program

        addi a0, x0, 4
        la a1, Message9
        ecall

        addi a0, x0, 1
        add a1, x0, a4
        ecall

        addi a0, x0, 4
        la a1, Message12
        ecall
        
        addi a0, x0, 5
        ecall
        la t1, num4
        sb a0, 0(t1)
        
        addi a0, x0, 5
        ecall
        la t2, num5
        sb a0, 0(t2)

        addi a0, x0, 5
        ecall 
        la t3, num6
        sb a0, 0(t3)

        addi a0, x0, 5
        ecall 
        la t4, num7
        sb a0, 0(t4)

        # Load num1 and num2 into registers
        la t1, num4 
        lb t1, 0(t1)

        la t2, num5 
        lb t2, 0(t2)

        la t3, num6
        lb t3, 0(t3)

        la t4, num7
        lb t4, 0(t4)

        ######Add condition for the each index in the array###############
        player2_input_condition:
            addi t6, x0, 5
            bge t1, t6, player2_input_condition1
            beq t1, x0, player2_input_condition1
            bge t2, t6, player2_input_condition1
            beq t2, x0, player2_input_condition1
            bge t3, t6, player2_input_condition1
            beq t3, x0, player2_input_condition1
            bge t4, t6, player2_input_condition1
            beq t4, x0, player2_input_condition1
            beq x0, x0, player2_print 
            player2_input_condition1:
                addi a0, x0, 4
                la a1, Message4
                ecall
                beq x0, x0, player2_input_loop

        ############## Print out the array ##############################
        player2_print:

            addi a0, x0, 4
            la a1, Message10
            ecall
    

            #load the base address of the array into a register 
            la a2, array1

            #load the value in each index into register 
            #Print value each index 
            lb a5, 0(a2)
            add t1, a5, t1
            addi a0, x0, 1
            add a1, x0, t1
            ecall  

            addi a0, x0, 4
            la a1, Message11
            ecall 

            lb a5, 16(a2) 
            add t2, a5, t2
            addi a0, x0, 1
            add a1, x0, t2
            ecall

            addi a0, x0, 4
            la a1, Message11
            ecall

            lb a5, 32(a2)
            add t3, a5, t3
            addi a0, x0, 1
            add a1, x0, t3
            ecall

            addi a0, x0, 4
            la a1, Message11
            ecall

            lb a5, 64(a2)
            add t4, a5, t4
            addi a0, x0, 1
            add a1, x0, t4
            ecall

            addi a0, x0, 4
            la a1, Message6
            ecall
            
            addi t0, t0, -1
            addi a4, a4, 1
            beq x0, x0, player2_input_loop
 
################ Start constructing player2 game ################################     
end_program:
    # Exit program 
    addi a0, x0, 10
    ecall