.globl __start
.data
message:
    .asciz "Choose operation : \n1:Add \n2:Sub \n3:multiply \n4:divide \n5:power \n6:exponetial \n" 
message1:
    .asciz "Cannot divide by 0"
choice:    .byte 0
num1:      .byte 0
num2:      .byte 0
result:    .byte 0

.text
__start:
    # Write a syscall to print the menu
    #instruction 1: this instruction will add the value in register x0 to 4 and store the result in a0
    addi a0, x0, 4
    la a1, message
    ecall

    # Read the choice into 'choice'
    addi a0, x0, 5
    ecall
    la t0, choice
    sb a0, 0(t0)

    addi a0, x0, 5 #loading the value to the address, System code to read integer 
    ecall
    la t0, num1
    sb a0, 0(t0)
    

    addi a0, x0, 5 #system code to read integer 
    ecall
    la t0, num2 
    sb a0, 0(t0)

    # Load choice, num1, and num2 into registers
    # instruction 2: This instruction loads the address of memory location labeled with choice into t0
    la t0, choice 
    # instruction 3: This instruction loads the byte value (4 bytes) from the memory address stored in t0 into t0
    lb t0, 0(t0)

    la t1, num1 
    lb t1, 0(t1)

    la t2, num2 
    lb t2, 0(t2)




    # Check choice and jump to the corresponding label
    # instruction 3: This instruction compares the values at t0 and x0 and jump to the function end
    beq t0, x0, end        # if choice == 0, end program 
    # instruction 4: This instruction will add the value in register x0 to 1 and store the result at t5
    addi t5,x0,1
    beq t0, t5, perform_add # if choice == 1, go to perform_add
    addi t5,x0,2
    beq t0, t5, perform_sub # if choice == 2, go to perform_sub
    addi t5, x0, 3
    beq t0, t5, perform_mul
    addi t5, x0, 4
    beq t0, t5, perform_div
    addi t5 x0, 5
    beq t0, t5, power
    addi t5, x0, 6
    beq t0, t5, perform_exp
# remaining cases here

perform_add:
    # instruction 4: This instruction adding values at t1 and t2 together and store at t3	
    add t3, t1, t2         # t3 = t1 + t2
    # instruction 5: This instruction loads result into the address t0 and store the result at the address t3
    la t0, result
    sb t3, 0(t0)          # store the result back to memory
    # instruction 6: This instruction jump and link to the end function and not saving the return address
    jal x0, end

perform_sub:
    #finish sub and the remaining operations here
    #instruction 7: This instruction takes value at t1 subtract t2 and store the value at the address t3
    sub t3, t1, t2
    	        
    la t0, result
    sb t3, 0(t0)

    jal x0, end

perform_mul:
    # instruction 8: This instruction compares the value t2 and t4 together and jump to the end function if the requirement meets
    beq t2, t4, end
    # instruction 9: This instruction increments value at t3 by value at t1
    add t3, t3, t1
    # instruction 10: This instruction increments value at t4 by 1
    addi t4, t4, 1
    la t0, result
    sb t3, 0(t0)
    #instruction 11: This instruction returns back to the multiplication function 
    beq x0, x0, perform_mul
		
perform_div:
    #instruction 12: This instruction compare the value t2 to 0 and jump to the function div_case1 if the value is 0
    beq t2, x0, div_case1
    #instruction 13: This instruction compare the value t2 to 0 and jump to the function div_case2 if the value isn't 0
    bne t2, x0, div_case2
    div_case1:
       addi a0, x0, 4
       la a1, message1
       ecall
       jal x0, end
    div_case2:
       #instruction 14: This instruction compare t1 and t2 if t1 is less than t2, then jump directly to the end function
       blt t1, t2, end
       #instruction 15: This instruction substracts value at t1 by value t2
       sub t1, t1, t2
       #instruction 16: This instruction increments value at t4 by 1
       addi t4, t4, 1
       la t0, result
       sb t4, 0(t0)
       #instruction 17: This instruction compares x0 and x0 and return back to the function div_case2
       beq x0, x0, div_case2

power: 
    #instruction 18: This instruction add 1 to x0 and store at t3
    addi t3, x0, 1

perform_power:
    #instruction 19: This instruction compare t2 to x0 and if t2 is equal to x0, then jump to the function mul_case1
    beq t2, x0, mul_case1
    #instruction 20: This instruction compare t2 to x0 and if t2 isn't equal to x0, then jump to the function mul_case2
    bne t2, x0, mul_case2
    mul_case1:
 	addi t3, x0, 1
        la t0, result
        sb t3, 0(t0)
        #instruction 21: This instruction jumps to the end function 
        jal x0, end
    mul_case2:
        #instruction 22: This instruction compares value t2 and t4 if t2 is equal to t4 then jump to the end function 
        beq t2, t4, end
        #instruction 23: This instruction muptiply t1 to t3 and store in t3
        mul t3, t3, t1
        addi t4, t4, 1
        la t0, result
        sb t3, 0(t0)
        beq x0, x0, mul_case2

perform_exp:
    beq t1, x0, exp_1
    bne t1, x0, exp_2 
    exp_1:
	addi t3, x0, 1
        la t0, result
        sb t3, 0(t0)
        jal x0, end
    exp_2:
	beq t6, t2, end
	addi t0, x0, 1
    	addi t2, x0, 1
    	add t3, t2, t1
	addi t4, x0, 2
	addi t6, x0, 1
		loop_pow:
			beq t5, t4, factorial
			mul t2, t2, t1
			addi t5, t5, 1
			beq x0, x0, loop_pow
		factorial:
			beq t5, x0, div1
			mul t0, t0, t5
			sub t5, t5, t2
			beq x0, x0, factorial
		div1:
			div t3, t2, t6
			la t0, result
        		sb t3, 0(t0)
			addi t6, t6, 1
			beq x0, x0, exp_2
				
	    	
	    
end:
    # write a syscall is available to print result 
    la t0, result
    lb t3, 0(t0)
    
    addi a0, x0, 1
    add  a1, x0, t3
    ecall

    # Exit program 
    addi a0, x0, 10
    ecall
