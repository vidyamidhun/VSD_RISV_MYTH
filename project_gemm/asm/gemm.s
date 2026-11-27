	.file	"gemm.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.type	soft_mul, @function
soft_mul:
	mv	a4,a0
	mv	a5,a1
	beq	a1,zero,.L5
	li	a0,0
	j	.L4
.L3:
	slli	a4,a4,1
	srli	a5,a5,1
	beq	a5,zero,.L7
.L4:
	andi	a3,a5,1
	beq	a3,zero,.L3
	add	a0,a0,a4
	j	.L3
.L7:
	ret
.L5:
	mv	a0,a1
	ret
	.size	soft_mul, .-soft_mul
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	s5,20(sp)
	sw	s6,16(sp)
	sw	s7,12(sp)
	li	a4,0
	li	a5,0
	li	a1,10
	li	a2,9
.L9:
	addi	a5,a5,1
	sw	a5,0(a4)
	sub	a3,a1,a5
	sw	a3,36(a4)
	addi	a4,a4,4
	bne	a5,a2,.L9
	li	s5,0
	li	s6,3
	li	s7,36
	j	.L10
.L18:
	add	a5,s3,s5
	sw	s2,0(a5)
	addi	s4,s4,1
	addi	s3,s3,4
	beq	s4,s6,.L12
.L14:
	addi	s0,s3,-36
	mv	s1,s5
	li	s2,0
.L11:
	lw	a0,0(s1)
	lw	a1,0(s0)
	call	soft_mul
	add	s2,s2,a0
	addi	s1,s1,4
	addi	s0,s0,12
	bne	s0,s3,.L11
	j	.L18
.L12:
	addi	s5,s5,12
	beq	s5,s7,.L13
.L10:
	li	s3,72
	li	s4,0
	j	.L14
.L13:
	li	a0,0
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	lw	s6,16(sp)
	lw	s7,12(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
