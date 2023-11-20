.globl __start
.data
msg: .asciiz "5"

.text

__start:
  li a0, 5
  la a1, msg # ecall code
  ecall
  li a0, 10
  ecall