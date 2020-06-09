	.file	"exam.c"
	.text
	.globl	absdiff
	.type	absdiff, @function
absdiff:
.LFB0:
	.cfi_startproc
	movl	%edi, %edx
	subl	%esi, %edx
	movl	%esi, %eax
	subl	%edi, %eax
	cmpl	%esi, %edi
	cmovg	%edx, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	absdiff, .-absdiff
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
