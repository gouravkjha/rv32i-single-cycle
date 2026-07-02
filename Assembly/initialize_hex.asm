.text
.globl _start

_start:

    lui    x1, 0x12345
    auipc  x2, 0

    addi   x3, x0, 5
    addi   x4, x0, 10

    add    x5, x3, x4
    sub    x6, x4, x3

    sll    x7, x3, x3
    slt    x8, x3, x4
    sltu   x9, x3, x4

    xor    x10, x3, x4
    srl    x11, x4, x3
    sra    x12, x4, x3
    or     x13, x3, x4
    and    x14, x3, x4

    slli   x15, x3, 2
    srli   x16, x4, 1
    srai   x17, x4, 1

    slti   x18, x3, 8
    sltiu  x19, x3, 8

    xori   x20, x3, 15
    ori    x21, x3, 8
    andi   x22, x4, 7

    beq    x3, x3, L1
    addi   x23, x0, 1

L1:
    bne    x3, x4, L2
    addi   x24, x0, 2

L2:
    blt    x3, x4, L3
    addi   x25, x0, 3

L3:
    bge    x4, x3, L4
    addi   x26, x0, 4

L4:
    bltu   x3, x4, L5
    addi   x27, x0, 5

L5:
    bgeu   x4, x3, L6
    addi   x28, x0, 6

L6:
    jal    x29, L7

L7:
    jal    x0, L7