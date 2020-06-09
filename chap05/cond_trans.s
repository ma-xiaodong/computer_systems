	.file	"cond_trans.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	minmax1
	.type	minmax1, @function
minmax1:
.LFB38:
	.cfi_startproc
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movss	(%rdi,%rax), %xmm0
	movss	(%rsi,%rax), %xmm1
	ucomiss	%xmm1, %xmm0
	jbe	.L2
	movss	%xmm1, (%rdi,%rax)
	movss	%xmm0, (%rsi,%rax)
.L2:
	addq	$4, %rax
	cmpq	$16384, %rax
	jne	.L4
	rep ret
	.cfi_endproc
.LFE38:
	.size	minmax1, .-minmax1
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	minmax2
	.type	minmax2, @function
minmax2:
.LFB39:
	.cfi_startproc
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L10:
	movss	(%rdi,%rax), %xmm0
	movss	(%rsi,%rax), %xmm1
	ucomiss	%xmm1, %xmm0
	ja	.L9
	movaps	%xmm1, %xmm2
	movaps	%xmm0, %xmm1
	movaps	%xmm2, %xmm0
.L9:
	movss	%xmm1, (%rdi,%rax)
	movss	%xmm0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	$16384, %rax
	jne	.L10
	rep ret
	.cfi_endproc
.LFE39:
	.size	minmax2, .-minmax2
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	initial
	.type	initial, @function
initial:
.LFB40:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%edi, %edi
	movq	%rsi, %rbp
	xorl	%ebx, %ebx
	call	time
	movl	%eax, %edi
	call	srand
	.p2align 4,,10
	.p2align 3
.L14:
	call	rand
	pxor	%xmm0, %xmm0
	movss	.LC3(%rip), %xmm1
	cvtsi2sd	%eax, %xmm0
	divsd	.LC2(%rip), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	subss	%xmm0, %xmm1
	movss	%xmm0, (%r12,%rbx)
	movss	%xmm1, 0(%rbp,%rbx)
	addq	$4, %rbx
	cmpq	$16384, %rbx
	jne	.L14
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE40:
	.size	initial, .-initial
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC6:
	.string	"Time used by minmax1: %f\n"
.LC7:
	.string	"Time used by minmax2: %f\n"
	.section	.text.unlikely
.LCOLDB8:
	.section	.text.startup,"ax",@progbits
.LHOTB8:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	subq	$32824, %rsp
	.cfi_def_cfa_offset 32832
	leaq	16416(%rsp), %rsi
	leaq	32(%rsp), %rdi
	movq	%fs:40, %rax
	movq	%rax, 32808(%rsp)
	xorl	%eax, %eax
	call	initial
	xorl	%esi, %esi
	movq	%rsp, %rdi
	call	gettimeofday
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L20:
	movss	32(%rsp,%rax), %xmm0
	movss	16416(%rsp,%rax), %xmm1
	ucomiss	%xmm1, %xmm0
	jbe	.L18
	movss	%xmm1, 32(%rsp,%rax)
	movss	%xmm0, 16416(%rsp,%rax)
.L18:
	addq	$4, %rax
	cmpq	$16384, %rax
	jne	.L20
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	gettimeofday
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movl	$.LC6, %esi
	pxor	%xmm0, %xmm0
	movl	$1, %edi
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	divsd	.LC5(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	call	__printf_chk
	leaq	16416(%rsp), %rsi
	leaq	32(%rsp), %rdi
	call	initial
	xorl	%esi, %esi
	movq	%rsp, %rdi
	call	gettimeofday
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L22:
	movss	32(%rsp,%rax), %xmm0
	movss	16416(%rsp,%rax), %xmm1
	ucomiss	%xmm1, %xmm0
	ja	.L21
	movaps	%xmm1, %xmm2
	movaps	%xmm0, %xmm1
	movaps	%xmm2, %xmm0
.L21:
	movss	%xmm1, 32(%rsp,%rax)
	movss	%xmm0, 16416(%rsp,%rax)
	addq	$4, %rax
	cmpq	$16384, %rax
	jne	.L22
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	gettimeofday
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movl	$.LC7, %esi
	pxor	%xmm0, %xmm0
	movl	$1, %edi
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	divsd	.LC5(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	call	__printf_chk
	xorl	%eax, %eax
	movq	32808(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L29
	addq	$32824, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L29:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE8:
	.section	.text.startup
.LHOTE8:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	2573624934
	.long	1101633945
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC3:
	.long	1092616192
	.section	.rodata.cst8
	.align 8
.LC5:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
