	.file	"problem_5_11.c"
	.text
	.globl	psum
	.type	psum, @function
psum:
.LFB38:
	.cfi_startproc
	movss	(%rdi), %xmm0
	movss	%xmm0, (%rsi)
	movl	$0, %eax
.L2:
	movss	(%rsi,%rax), %xmm0
	addss	4(%rdi,%rax), %xmm0
	movss	%xmm0, 4(%rsi,%rax)
	addq	$4, %rax
	cmpq	$8188, %rax
	jne	.L2
	rep ret
	.cfi_endproc
.LFE38:
	.size	psum, .-psum
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Time used by minmax2: %f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	subq	$16440, %rsp
	.cfi_def_cfa_offset 16448
	movq	%fs:40, %rax
	movq	%rax, 16424(%rsp)
	xorl	%eax, %eax
	movsd	.LC0(%rip), %xmm1
.L5:
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm2
	movss	%xmm2, 32(%rsp,%rax,4)
	addq	$1, %rax
	cmpq	$2048, %rax
	jne	.L5
	movl	$0, %esi
	movq	%rsp, %rdi
	call	gettimeofday
	leaq	8224(%rsp), %rsi
	leaq	32(%rsp), %rdi
	call	psum
	movl	$0, %esi
	leaq	16(%rsp), %rdi
	call	gettimeofday
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC1(%rip), %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	$.LC2, %esi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk
	movl	$0, %eax
	movq	16424(%rsp), %rdx
	xorq	%fs:40, %rdx
	je	.L6
	call	__stack_chk_fail
.L6:
	addq	$16440, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1076101120
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
