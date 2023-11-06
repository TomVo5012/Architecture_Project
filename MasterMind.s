.global __start
.data
    Message: .asciz "Welcome to the Master Mind Game!!!! \nInstructions: \n1: You will have 10 trials to complete the game \n2: In each trial, a player must guess the each color in the correct position and correct color \n3: A player win by having the less guess for the trials \nAuthors: Kiet Vo and Emanual Cintron"

.text
__start:
    #Message on 
    addi a0, x0, 4
    la a1, Message
    ecall

    # Exit program 
    addi a0, x0, 10
    ecall