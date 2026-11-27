	.file	"gemm.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	li	a4,1
	sw	a4,64(zero)
	li	a5,2
	sw	a5,68(zero)
	li	a3,3
	sw	a3,72(zero)
	li	a3,4
	sw	a3,76(zero)
	sw	a5,80(zero)
	sw	a4,84(zero)
	sw	a4,88(zero)
	sw	a5,92(zero)
	li	a2,0
	li	a0,0
	li	t1,88
	li	t3,4
.L2:
	li	a4,80
	addi	a7,a2,16
	j	.L12
.L4:
	andi	t4,a3,1
	beq	t4,zero,.L3
	add	a5,a5,a1
.L3:
	slli	a1,a1,1
	srli	a3,a3,1
.L10:
	bne	a3,zero,.L4
	add	a3,a7,a4
	add	a5,a5,a6
	sw	a5,0(a3)
	addi	a4,a4,4
	beq	a4,t1,.L5
.L12:
	lw	a3,64(a2)
	lw	a5,0(a4)
	li	a6,0
.L8:
	beq	a5,zero,.L6
	andi	a1,a5,1
	bne	a1,zero,.L7
.L9:
	slli	a3,a3,1
	srli	a5,a5,1
	j	.L8
.L7:
	add	a6,a6,a3
	j	.L9
.L6:
	lw	a1,68(a2)
	lw	a3,8(a4)
	j	.L10
.L5:
	addi	a0,a0,2
	addi	a2,a2,8
	bne	a0,t3,.L2
	li	a0,0
	ret
	.size	main, .-main
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
