.global __start
.data
    Message: .asciiz "\nWelcome to the Master Mind Game!!!!\nAuthors: Kiet Vo and Emanuel Cintron\n\n"
    Message4: .asciiz "Your input "
    Message4.1: .asciiz " is invalid\nPlease Enter again!!!!\n " 
    Message6: .asciiz "\n"
    Message7: .asciiz "Enter your secret code\n"
    Message9: .asciiz "Your Trial "
    Message10: .asciiz "Your guess is: "
    Message11: .asciiz " "
    Message12: .asciiz ": "
    Message12.1: .asciiz ": \n"
    Message14: .asciiz "Correct Colors But Wrong Positions: "
    Message15: .asciiz "Correct Colors and Correct Positions: "
    Message16: .asciiz "Enter your secret code in position "
    Message17: .asciiz "Enter your guess in position "
    Message18: .asciiz "CONGRATULATION!!!!!!\nYOU SUCCESSFULLY BROKE THE CODE\n"
    Message19: .asciiz "YOUR GUESS IS INCORRECT\n"
    Message19.1: .asciiz "PLEASE ENTER YOUR GUESS AGAIN\n"
    Message20: .asciiz "You have "
    Message21: .asciiz "trials left\n\n"
    Message22: .asciiz "Would you like to restart the game? (Type 6 to restart the game/Press Enter or any number to exit the game)\nEnter your choice here: "
    Message23: .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    Message24: .asciiz "The Secret Code is: "
    Message25: .asciiz "GAME OVER!!!!!\nYou have used 10 trials\n\n"
    Message26: .asciiz "Enter Your Choice Here: "
    Message27: .asciiz "Type 1: Start The Game\nType 2: Rules of The Game\nType 3: Exit The Game\n"
    Message28: .asciiz "\nYour input is invalid\nPlease Enter Again!!!\n"
    Message29: .asciiz "\nMasterMind rules:\nRule 1: There are two players, who are Codemaker and Codebreaker\nRule 2: Codemaker will create the secrete code which contains four colors and the colors can be repeated\n         1: RED\n         2: YELLOW\n         3: GREEN\n         4: PURPLE\nRule 3: Codebreaker must guess what the secrete code is\nRule 4: Codebreaker will have 10 trials to guess the secrete code before losing\nRule 5: Codebreak can only win after successfully guessing the secrete code under 10 trials\n\n"
    array: .byte 0, 0, 0, 0
    array1: .byte 0, 0, 0, 0
    num: .byte 0
    num1: .byte 0
    num2: .byte 0
    num3: .byte 0

.text
__start:
    li t1, 1
    li t2, 2
    li t3, 3
    # Welcome message  
    addi a0, x0, 4
    la a1, Message
    ecall
    
    # Display options for players to choose 
    instruction1:
        # Display instructions how to play the game 
        addi a0, x0, 4
        la a1, Message27
        ecall

        # Display enter the choice  
        addi a0, x0, 4
        la a1, Message26
        ecall

        # Take input from player 1
        addi a0, x0, 5
        ecall 
        la t0, num3      # load address of num into t0
        sb a0, 0(t0)    # store the base address of t0 into a0
        la t0, num3      # load address of num into t0
        lb t0, 0(t0)    # load value at base address of t0 into t0

        beq t0, t1, game_start
        beq t0, t2, instructions
        beq t0, t3, exit_program
        beq t0, x0, invalid
        bge t0, t3, invalid
# This will check whether the inputs are invalid or not
invalid:
    # Message to start the game 
    addi a0, x0, 4
    la a1, Message28
    ecall
    jal x0, instruction1   

# This will display the rules of the game 
instructions:
    # Message to start the game 
    addi a0, x0, 4
    la a1, Message29
    ecall
    jal x0, instruction1    

# This function will start the game
game_start:
    # Message to start the game 
    addi a0, x0, 4
    la a1, Message7
    ecall

    # Reset all the values 
    li t0, 0
    li t1, 4
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 1
    add a2, x0, x0
    add a3, x0, x0
    
# Taking the inputs from player1
player1_input:
    # Checking if the player 1 has entered all values for the array
    # When player 1 completed the input for the array 
    # Go to the function player2 
    beq t1, x0, player2

    # Reset the value of register t0
    li t0, 0

    # Ask the player to enter the secret code 
    addi a0, x0, 4
    la a1, Message16
    ecall

    # Checking the index of the array 
    # Display on the screen for player to keep track     
    addi a0, x0, 1
    add a1, x0, t5
    ecall

    # Go to the next line
    addi a0, x0, 4
    la a1, Message12
    ecall

    # Take input from player 1
    addi a0, x0, 5
    ecall 
    la t0, num      # load address of num into t0
    sb a0, 0(t0)    # store the base address of t0 into a0
    la t0, num      # load address of num into t0
    lb t0, 0(t0)    # load value at base address of t0 into t0

    # Checking the invalid value from player 1
    player1_condition:
        # Set the value t6 to be 5
        li t6, 5

        # If the input value is greater than 6 or equal 0
        # Jump to the player1_invalid_value function
        bge t0, t6, player1_invalid_value
        beq t0, x0, player1_invalid_value

        # If the value is valid, then go to player1_store_value 
        jal x0, player1_store_value

        # function to ask player 1 to input the value again
        player1_invalid_value:
            # Message to tell player 1 that their input is incorrect
            addi a0, x0, 4
            la a1, Message4
            ecall

            # Display the invalid value 
            addi a0, x0, 1
            add a1, x0, t0
            ecall

            # Message to ask player 1 enter the value again
            addi a0, x0, 4
            la a1, Message4.1
            ecall

            # return to function player1_input 
            # So that player 1 can enter the value again
            beq x0, x0, player1_input

    # Store input in the array
    player1_store_value:
        la s1, array    # load address of the array to s1
        slli t2, t3, 6  # shift left value t3 by 6
        add t4, s1, t2  # add value of t2 to the base address 
        lb a2, 0(t4)    # load the value in each index to a2
        li a2, 0        # reset the value a2 
        add a2, a2, t0  # add the input value from player 1 to a2
        sb a2, 0(t4)    # store the value back to the index 

        addi t3, t3, 1  # increment value t3 to move to the next index 
        addi t1, t1, -1 # decrement value t1 
        addi t5, t5, 1  # increment value t5 to let player now what position of the value now
        
        # return back to function player1_input 
        # Asking for the next input from the player 1
        jal x0, player1_input   

# Start the game for player 2
# This is the entire gameplay for player 2 
player2:
    # This message is used to skip line 
    # The purpose is to hide the input from player 1
    li a0, 4
    la a1, Message23
    ecall

    li a3, 10   # set the value a3 to 10, which is the numbers of trials 
    li a4, 1    # set the value a4 to 1, which is used to count how many trials player 2 has used
    count_trial:
        # If the a3 is 0
        # Jump to the end_program function when a3 is 0
        beq a3, x0, end_program 

        # The message tells player 2 how many trials how many trials they have left
        addi a0, x0, 4
        la a1, Message9
        ecall

        # Display number of trials of the player 2
        addi a0, x0, 1
        add a1, x0, a4
        ecall

        # The message goes to the next line 
        addi a0, x0, 4
        la a1, Message12.1
        ecall


        # reset all the values for the game 
        li t1, 4
        li t5, 1
        li t6, 5
        li t2, 0
        li t3, 0
        li t4, 0

    # Take the inputs from player 2 
    # Store the inputs in the array1
    # This is the loop
    player2_input:
        # checking how many values player 2 has entered 
        beq t1, x0, display_guess

        # reset the value of register t0
        li t0, 0

        # Message to display the position of the guesses from player 2
        addi a0, x0, 4
        la a1, Message17
        ecall

        # Display position of the guesses from player 2
        addi a0, x0, 1
        add a1, x0, t5
        ecall

        # The message give space to enter the value 
        addi a0, x0, 4
        la a1, Message12
        ecall

        # Ask input from player 2
        addi a0, x0, 5
        ecall 
        la t0, num1     # load address of num1 to t0
        sb a0, 0(t0)    # store the address of t0 into a0
        la t0, num1     # load address of num1 into t0
        lb t0, 0(t0)    # load the value at the memory address to t0

        # Checking if the input from player 2 is invalid or not
        player2_condition:
            # Compare the input value
            # If it is larger than 5 or equal 0 
            # Go to player2_invalid_value to ask user input again 
            bge t0, t6, player2_invalid_value
            beq t0, x0, player2_invalid_value

            # If the input value is valid, then to store value function
            jal x0, player2_store_value

            # invalid value function
            # This function will display message tell player 2 
            # Their input is invalid and enter again
            player2_invalid_value:
                # The message will display "Your input"
                addi a0, x0, 4
                la a1, Message4
                ecall

                # Display the invalid input from player 2
                addi a0, x0, 1
                add a1, x0, t0
                ecall

                # The message let player 2 know 
                # The input is invalid and need to enter again
                addi a0, x0, 4
                la a1, Message4.1
                ecall

                # return to the function player2_input
                # player 2 will enter the value again 
                beq x0, x0, player2_input
                
        # Store input in the array
        player2_store_value:
            la s2, array1   # load the address of array1 into s2
            slli t2, t3, 6  # shift left immediate t3 by 6 and store in t2
            add t4, s2, t2  # add t2 to the base address of the array1 and store in t4
            lb a2, 0(t4)    # load byte the value in each index at a2 
            li a2, 0        # reset the value a2 to 0 
            add a2, a2, t0  # add the value t0, player2's input, to a2
            sb a2, 0(t4)    # store the value of a2 in the index of the array1 

            addi t3, t3, 1  # Increment t3 by 1 to move to the next index of the array1
            addi t1, t1, -1 # Decrement the count of t1 for the loop
            addi t5, t5, 1  # Increment t5 by 1 to tell the player 2 which position they are in now

            # return to the function player2_input 
            jal x0, player2_input

# Display the input from player 2 function
# This will help player 2 to keep track on what they have input so far
display_guess:
    # The message moves to the next line
    addi a0, x0, 4
    la a1, Message6
    ecall

    # The message displays "Your guess is: "
    addi a0, x0, 4
    la a1, Message10
    ecall

    # reset all the values 
    li t4, 0
    li t2, 0
    li t5, 0
    li a6, 0
    li t6, 4
    # This is the loop to print out what numbers player 2 have entered 
    display_guess_code:
        # when t6 is equal 0, jump to the compare function
        beq t6, x0, compare 
        la s2, array1   # load the base address array1 to s2 
        slli t2, t4, 6  # shift left immediate t4 by 6  
        add  t5, s2, t2 # add s2 and t2 together 
        lb a6, 0(t5)    # load the byte from the base address to retrieve the value at each index

        # Display the number in each index 
        addi a0, x0, 1
        add a1, x0, a6
        ecall

        # Give space to each number 
        addi a0, x0, 4
        la a1, Message11
        ecall
        
        addi t4, t4, 1  # Increment t4 by 1 to move to the next index of the array1
        addi t6, t6, -1 # Decrement t6 by 1 for the loop

        # return back to the display_guess_code function
        jal x0, display_guess_code

# This function will compare the guess code and secret code 
compare:
    # reset all values 
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li a5, 0
    li a6, 0
    li s4, 0
    li s3, 0
    li s5, 4
    li x24, 4

    # The message will move to the next line  
    addi a0, x0, 4
    la a1, Message6
    ecall

# This function will load the value from both arrays
# Start comparing the values    
load_value_array1:
    # when t4 is equal to x24, jump to the print_result function
    # This will check all the values in the guess array 
    beq t4, x24, print_result
    
    la s1, array    # load the base address of array into s1
    slli t2, t1, 6  # shift left immediate t1 by 6 and store in t2
    add t3, s1, t2  # add t1 to the base address s1 and store in t3
    lb a5, 0(t3)    # load the value at the base address to a5

    la s2, array1   # load the base address of array1 into s2
    slli t2, t4, 6  # shift left immediate t4 by 6 and store in t2
    add  t5, s2, t2 # add t2 to the base address s2 and store in t5
    lb a6, 0(t5)    # load the value at the base address to a6 

    # When both values a5 and a6 are equal, jump to compare_case1 function
    beq a5, a6, compare_case1
    # when both values a5 and a6 are unequal, jump to compare_case2 function
    bne a5, a6, compare_case2

    # compare_case1 function will compare the index from both array
    compare_case1:
        # when the indexes are equal, jump to compare_case1_1 function
        beq t1, t4, compare_case1_1
        # when the indexes are unequal, jumo to compare_case1_2 function
        bne t1, t4, compare_case1_2

        # compare_case1_1 function will keep track on 
        # If the guess code and secret code values are in correct color and position
        compare_case1_1:
            addi s3, s3, 1  # increment s3 by 1 to count how many correct colors and position from the guess code
            addi t1, t1, 1  # increment t1 by 1 to move to the next index of the secret code
            addi t4, t4, 1  # increment t4 by 1 to move to the next index of the guess code
            # return to load_value_array1 function to compare next value
            jal x0, load_value_array1

        # compare_case1_1 function will keep track on 
        # If the guess code and secret code values are in correct color but wrong position   
        compare_case1_2:
            addi s4, s4, 1  # increment s4 by 1 to count how many correct colors but wrong position from the guess code
            li t1, 0        # reset the value of t1 to refresh the index of guess code to 0
            addi t4, t4, 1  # increment t4 by 1 to move to the next index of the guess code
            # return back to the load_value_array1 function 
            jal x0, load_value_array1

    # compare_case2 function is used when the values are not equal        
    compare_case2:
        # If t1 is equal s5, jump to compare_case2_1 function
        beq t1, s5, compare_case2_1
        # increment t1 by 1, move to the next index of the secret code array
        addi t1, t1, 1
        # return back to the load_value_array1 function
        jal x0, load_value_array1

        # compare_case2_1 function will be executed 
        # when the pointer reaches the end of the array
        # reset the pointer back to the beginning 
        compare_case2_1:
            addi t4, t4, 1  # increment t4 by 1, this will move guess code array to the next index
            li t1, 0        # reset t1 to 0, this will move the pointer back to the beginning

            # return back to the load_value_array1 function
            jal x0, load_value_array1

# print_result function will print out the result after comparing both arrays
# The function will let the player 2 know if their guesses are correct or not
print_result:
    # The message will display "Correct Colors But Wrong Position: "
    addi a0, x0, 4
    la a1, Message14
    ecall

    # This will display the number of correct colors but wrong position
    addi a0, x0, 1
    add a1, x0, s4
    ecall

    # The message will fo to the next line 
    addi a0, x0, 4
    la a1, Message6
    ecall                

    # The message will display "Correct Colors and Correct Position: "
    addi a0, x0, 4
    la a1, Message15
    ecall

    # This will display number of correct colors and positions
    addi a0, x0, 1
    add a1, x0, s3
    ecall

    # The message will go to the next line 
    addi a0, x0, 4
    la a1, Message6
    ecall    

    # If the number of correct colors and positions is equal to 4
    # Jump to the break_code function
    beq s5, s3, break_code

# the return_function will let player 2 play until the player 2 runs out of trials 
return_function:
    # This message will go to the next line 
    addi a0, x0, 4
    la a1, Message6
    ecall

    # This will display "YOUR GUESS IS INCORRECT\n"
    addi a0, x0, 4
    la a1, Message19
    ecall

    # Decrement a3 by 1 
    # This instructions to decrease how many trials the player 2 has used 
    addi a3, a3, -1

    # When a3 is equal to 0
    # Jump to end_program function
    beq a3, x0, end_program

    # This message will display "PLEASE ENTER YOUR GUESS AGAIN\n"
    addi a0, x0, 4
    la a1, Message19.1
    ecall

    # This message will display "You have "
    addi a0, x0, 4
    la a1, Message20
    ecall

    # This message will display how many trials the player2 has left
    addi a0, x0, 1
    add a1, x0, a3
    ecall

    # This message will give the space 
    addi a0, x0, 4
    la a1, Message11
    ecall

    # This message will display "trials left\n\n"
    addi a0, x0, 4
    la a1, Message21
    ecall

    # Increment a4 by 1 
    addi a4, a4, 1
    # return back to the count_trial function
    # This will ask player 2 to enter the guesses again
    beq x0, x0, count_trial

# The end_program function will announce player 2 that they fail to guess the secret code
# The end_program function will ask players if they want to restart the new game 
end_program:
    # set the value of a2 to 6
    li a7, 6
    # reset the value of t0
    add t0, x0, x0

    # This message will display "GAME OVER!!!!!\nYou have used 10 trials\n\n"
    addi a0, x0, 4
    la a1, Message25
    ecall

    # This message will display "The Secret Code is: "
    addi a0, x0, 4
    la a1, Message24
    ecall

    # reset all the values
    li t2, 0
    li t3, 0
    li t4, 0
    li a2, 0
    li t1, 4

    # The secret_code1 function will reveal the secret code from player1
    secret_code1:
        beq t1, x0, end_program1
        la s1, array
        slli t2, t3, 6
        add t4, s1, t2
        lb a2, 0(t4)

        addi a0, x0, 1
        add a1, x0, a2 
        ecall

        addi a0, x0, 4
        la a1, Message11
        ecall

        addi t3, t3, 1
        addi t1, t1, -1
        jal x0, secret_code1

    # The function end_program1 will ask whether players want to restart the new game
    # They want to exit the game
    end_program1:
        addi a0, x0, 4
        la a1, Message6
        ecall

        addi a0, x0, 4
        la a1, Message22
        ecall

        addi a0, x0, 5
        ecall 
        la t0, num2
        sb a0, 0(t0)
        la t0, num2
        lb t0, 0(t0)

        beq t0, a7, __start
        addi a0, x0, 10
        ecall

# break_code function is similar to end_program
# But the break_code function will announce that the player 2 has successfully broken the code
break_code:
    li a7, 6
    add t0, x0, x0

    addi a0, x0, 4
    la a1, Message6
    ecall

    addi a0, x0, 4
    la a1, Message24
    ecall

    li t2, 0
    li t3, 0
    li t4, 0
    li a2, 0
    li t1, 4
    secret_code:
        beq t1, x0, break_code1
        la s1, array
        slli t2, t3, 6
        add t4, s1, t2
        lb a2, 0(t4)

        addi a0, x0, 1
        add a1, x0, a2 
        ecall

        addi a0, x0, 4
        la a1, Message11
        ecall

        addi t3, t3, 1
        addi t1, t1, -1
        jal x0, secret_code

    break_code1:
        addi a0, x0, 4
        la a1, Message6
        ecall

        addi a0, x0, 4
        la a1, Message18
        ecall

        addi a0, x0, 4
        la a1, Message22
        ecall

        addi a0, x0, 5
        ecall 
        la t0, num2
        sb a0, 0(t0)
        la t0, num2
        lb t0, 0(t0)

        beq t0, a7, __start
        addi a0, x0, 10
        ecall

exit_program:
    li a0, 10
    ecall