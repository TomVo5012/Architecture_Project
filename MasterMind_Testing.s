.global __start
.data
    array: .byte 0,0,0,0
    array1: .byte 0,0,0,0
    num: .byte 0
    num1: .byte 0
    num2: .byte 0
    num3: .byte 0

.text
__start:
    
    f_array: 
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

        la a3, array


        #load the value in each index into register 
        #Print value each index 
        sb a2, 0(a3)
        add s0, a2, t0
        addi a0, x0, 1
        add a1, x0, s0
        ecall 

        sb a2, 16(a3)
        add s1, a2, t1
        addi a0, x0, 1
        add a1, x0, s1
        ecall 

        sb a2, 32(a3)
        add s2, a2, t2
        addi a0, x0, 1
        add a1, x0, s2
        ecall 

        sb a2, 64(a3)
        add s3, a2, t3
        addi a0, x0, 1
        add a1, x0, s3
        ecall 
    s_array:
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

        la a4, array1

        #load the value in each index into register 
        #Print value each index 
        lb a2, 0(a4)
        add t5, a2, t0
        addi a0, x0, 1
        add a1, x0, t5
        ecall 

        lb a2, 16(a4)
        add t1, a2, t1
        addi a0, x0, 1
        add a1, x0, s1
        ecall 

        lb a2, 32(a4)
        add t5, a2, t2
        addi a0, x0, 1
        add a1, x0, t5
        ecall 

        lb a2, 64(a4)
        add t5, a2, t3
        addi a0, x0, 1
        add a1, x0, t5
        ecall 

        beq s0, t0, add_function
        add_function:
            addi a0, x0, 1
            add a1, x0, t0
            ecall
            addi a0, x0, 1
            add a1, x0, s0
            ecall
    addi a0, x0, 10
    ecall