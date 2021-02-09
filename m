Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231627AbhBINvc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:32 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/8] s390x: Fully commit to stack save area for exceptions
Date: Tue,  9 Feb 2021 08:49:19 -0500
Message-Id: <20210209134925.22248-3-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

Having two sets of macros for saving registers on exceptions makes
maintaining harder. Also we have limited space in the lowcore to save
stuff and by using the stack as a save area, we can stack exceptions.

So let's use the SAVE/RESTORE_REGS_STACK as the default. When we also
move the diag308 macro over we can remove the old SAVE/RESTORE_REGS
macros.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/asm-offsets.c   | 14 ++++++++----
 lib/s390x/asm/arch_def.h  | 29 ++++++++++++++++++-----
 lib/s390x/asm/interrupt.h |  4 ++--
 lib/s390x/interrupt.c     | 14 ++++++------
 s390x/cstart64.S          | 19 +++++++++-------
 s390x/macros.S            | 48 +++++++++++++++++++++++----------------
 6 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
index a19f14b9..a8942395 100644
--- a/lib/s390x/asm-offsets.c
+++ b/lib/s390x/asm-offsets.c
@@ -70,16 +70,22 @@ int main(void)
 	OFFSET(GEN_LC_ARS_SA, lowcore, ars_sa);
 	OFFSET(GEN_LC_CRS_SA, lowcore, crs_sa);
 	OFFSET(GEN_LC_PGM_INT_TDB, lowcore, pgm_int_tdb);
-	OFFSET(__SF_SIE_CONTROL, stack_frame, empty1[0]);
-	OFFSET(__SF_SIE_SAVEAREA, stack_frame, empty1[1]);
-	OFFSET(__SF_SIE_REASON, stack_frame, empty1[2]);
-	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[3]);
+	OFFSET(__SF_SIE_CONTROL, stack_frame, argument_area[0]);
+	OFFSET(__SF_SIE_SAVEAREA, stack_frame, argument_area[1]);
+	OFFSET(__SF_SIE_REASON, stack_frame, argument_area[2]);
+	OFFSET(__SF_SIE_FLAGS, stack_frame, argument_area[3]);
 	OFFSET(SIE_SAVEAREA_HOST_GRS, vm_save_area, host.grs[0]);
 	OFFSET(SIE_SAVEAREA_HOST_FPRS, vm_save_area, host.fprs[0]);
 	OFFSET(SIE_SAVEAREA_HOST_FPC, vm_save_area, host.fpc);
 	OFFSET(SIE_SAVEAREA_GUEST_GRS, vm_save_area, guest.grs[0]);
 	OFFSET(SIE_SAVEAREA_GUEST_FPRS, vm_save_area, guest.fprs[0]);
 	OFFSET(SIE_SAVEAREA_GUEST_FPC, vm_save_area, guest.fpc);
+	OFFSET(STACK_FRAME_INT_BACKCHAIN, stack_frame_int, back_chain);
+	OFFSET(STACK_FRAME_INT_FPC, stack_frame_int, fpc);
+	OFFSET(STACK_FRAME_INT_FPRS, stack_frame_int, fprs);
+	OFFSET(STACK_FRAME_INT_CR0, stack_frame_int, cr0);
+	OFFSET(STACK_FRAME_INT_GRS0, stack_frame_int, grs0);
+	OFFSET(STACK_FRAME_INT_GRS1, stack_frame_int, grs1);
 
 	return 0;
 }
diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 9c4e330a..eb6a961f 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -8,13 +8,30 @@
 #ifndef _ASM_S390X_ARCH_DEF_H_
 #define _ASM_S390X_ARCH_DEF_H_
 
-/*
- * We currently only specify the stack frame members needed for the
- * SIE library code.
- */
 struct stack_frame {
-	unsigned long back_chain;
-	unsigned long empty1[5];
+	struct stack_frame *back_chain;
+	u64 reserved;
+	/* GRs 2 - 5 */
+	unsigned long argument_area[4];
+	/* GRs 6 - 15 */
+	unsigned long grs[10];
+	/* FPRs 0, 2, 4, 6 */
+	s64  fprs[4];
+};
+
+struct stack_frame_int {
+	struct stack_frame *back_chain;
+	u64 reserved;
+	/*
+	 * The GRs are offset compatible with struct stack_frame so we
+	 * can easily fetch GR14 for backtraces.
+	 */
+	u64 grs0[14];
+	u64 grs1[2];
+	u32 res;
+	u32 fpc;
+	u64 fprs[16];
+	u64 cr0;
 };
 
 struct psw {
diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
index 1a2e2cd8..31e4766d 100644
--- a/lib/s390x/asm/interrupt.h
+++ b/lib/s390x/asm/interrupt.h
@@ -14,8 +14,8 @@
 #define EXT_IRQ_SERVICE_SIG	0x2401
 
 void register_pgm_cleanup_func(void (*f)(void));
-void handle_pgm_int(void);
-void handle_ext_int(void);
+void handle_pgm_int(struct stack_frame_int *stack);
+void handle_ext_int(struct stack_frame_int *stack);
 void handle_mcck_int(void);
 void handle_io_int(void);
 void handle_svc_int(void);
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 1ce36073..94a2cf9c 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -56,7 +56,7 @@ void register_pgm_cleanup_func(void (*f)(void))
 	pgm_cleanup_func = f;
 }
 
-static void fixup_pgm_int(void)
+static void fixup_pgm_int(struct stack_frame_int *stack)
 {
 	/* If we have an error on SIE we directly move to sie_exit */
 	if (lc->pgm_old_psw.addr >= (uint64_t)&sie_entry &&
@@ -76,7 +76,7 @@ static void fixup_pgm_int(void)
 		/* Handling for iep.c test case. */
 		if (lc->trans_exc_id & 0x80UL && lc->trans_exc_id & 0x04UL &&
 		    !(lc->trans_exc_id & 0x08UL))
-			lc->pgm_old_psw.addr = lc->sw_int_grs[14];
+			lc->pgm_old_psw.addr = stack->grs0[12];
 		break;
 	case PGM_INT_CODE_SEGMENT_TRANSLATION:
 	case PGM_INT_CODE_PAGE_TRANSLATION:
@@ -115,7 +115,7 @@ static void fixup_pgm_int(void)
 	/* suppressed/terminated/completed point already at the next address */
 }
 
-void handle_pgm_int(void)
+void handle_pgm_int(struct stack_frame_int *stack)
 {
 	if (!pgm_int_expected) {
 		/* Force sclp_busy to false, otherwise we will loop forever */
@@ -130,10 +130,10 @@ void handle_pgm_int(void)
 	if (pgm_cleanup_func)
 		(*pgm_cleanup_func)();
 	else
-		fixup_pgm_int();
+		fixup_pgm_int(stack);
 }
 
-void handle_ext_int(void)
+void handle_ext_int(struct stack_frame_int *stack)
 {
 	if (!ext_int_expected &&
 	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
@@ -143,13 +143,13 @@ void handle_ext_int(void)
 	}
 
 	if (lc->ext_int_code == EXT_IRQ_SERVICE_SIG) {
-		lc->sw_int_crs[0] &= ~(1UL << 9);
+		stack->cr0 &= ~(1UL << 9);
 		sclp_handle_ext();
 	} else {
 		ext_int_expected = false;
 	}
 
-	if (!(lc->sw_int_crs[0] & CR0_EXTM_MASK))
+	if (!(stack->cr0 & CR0_EXTM_MASK))
 		lc->ext_old_psw.mask &= ~PSW_MASK_EXT;
 }
 
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index ace0c0d9..35d20293 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -92,33 +92,36 @@ memsetxc:
 
 .section .text
 pgm_int:
-	SAVE_REGS
+	SAVE_REGS_STACK
+	lgr     %r2, %r15
 	brasl	%r14, handle_pgm_int
-	RESTORE_REGS
+	RESTORE_REGS_STACK
 	lpswe	GEN_LC_PGM_OLD_PSW
 
 ext_int:
-	SAVE_REGS
+	SAVE_REGS_STACK
+	lgr     %r2, %r15
 	brasl	%r14, handle_ext_int
-	RESTORE_REGS
+	RESTORE_REGS_STACK
 	lpswe	GEN_LC_EXT_OLD_PSW
 
 mcck_int:
-	SAVE_REGS
+	SAVE_REGS_STACK
 	brasl	%r14, handle_mcck_int
-	RESTORE_REGS
+	RESTORE_REGS_STACK
 	lpswe	GEN_LC_MCCK_OLD_PSW
 
 io_int:
 	SAVE_REGS_STACK
+	lgr     %r2, %r15
 	brasl	%r14, handle_io_int
 	RESTORE_REGS_STACK
 	lpswe	GEN_LC_IO_OLD_PSW
 
 svc_int:
-	SAVE_REGS
+	SAVE_REGS_STACK
 	brasl	%r14, handle_svc_int
-	RESTORE_REGS
+	RESTORE_REGS_STACK
 	lpswe	GEN_LC_SVC_OLD_PSW
 
 	.align	8
diff --git a/s390x/macros.S b/s390x/macros.S
index e51a557a..1c8a0f7c 100644
--- a/s390x/macros.S
+++ b/s390x/macros.S
@@ -3,9 +3,10 @@
  * s390x assembly macros
  *
  * Copyright (c) 2017 Red Hat Inc
- * Copyright (c) 2020 IBM Corp.
+ * Copyright (c) 2020, 2021 IBM Corp.
  *
  * Authors:
+ *  Janosch Frank <frankja@linux.ibm.com>
  *  Pierre Morel <pmorel@linux.ibm.com>
  *  David Hildenbrand <david@redhat.com>
  */
@@ -41,36 +42,45 @@
 
 /* Save registers on the stack (r15), so we can have stacked interrupts. */
 	.macro SAVE_REGS_STACK
-	/* Allocate a stack frame for 15 general registers */
-	slgfi   %r15, 15 * 8
+	/* Allocate a full stack frame */
+	slgfi   %r15, 32 * 8 + 4 * 8
 	/* Store registers r0 to r14 on the stack */
-	stmg    %r0, %r14, 0(%r15)
-	/* Allocate a stack frame for 16 floating point registers */
-	/* The size of a FP register is the size of an double word */
-	slgfi   %r15, 16 * 8
+	stmg    %r2, %r15, STACK_FRAME_INT_GRS0(%r15)
+	stg     %r0, STACK_FRAME_INT_GRS1(%r15)
+	stg     %r1, STACK_FRAME_INT_GRS1 + 8(%r15)
+	/* Store the gr15 value before we allocated the new stack */
+	lgr     %r0, %r15
+	algfi   %r0, 32 * 8 + 4 * 8
+	stg     %r0, 13 * 8 + STACK_FRAME_INT_GRS0(%r15)
+	stg     %r0, STACK_FRAME_INT_BACKCHAIN(%r15)
+	/*
+	 * Store CR0 and load initial CR0 so AFP is active and we can
+	 * access all fprs to save them.
+	 */
+	stctg   %c0,%c0,STACK_FRAME_INT_CR0(%r15)
+	larl	%r1, initial_cr0
+	lctlg	%c0, %c0, 0(%r1)
 	/* Save fp register on stack: offset to SP is multiple of reg number */
 	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
-	std	\i, \i * 8(%r15)
+	std	\i, \i * 8 + STACK_FRAME_INT_FPRS(%r15)
 	.endr
-	/* Save fpc, but keep stack aligned on 64bits */
-	slgfi   %r15, 8
-	stfpc	0(%r15)
+	/* Save fpc */
+	stfpc	STACK_FRAME_INT_FPC(%r15)
 	.endm
 
 /* Restore the register in reverse order */
 	.macro RESTORE_REGS_STACK
 	/* Restore fpc */
-	lfpc	0(%r15)
-	algfi	%r15, 8
+	lfpc	STACK_FRAME_INT_FPC(%r15)
 	/* Restore fp register from stack: SP still where it was left */
 	/* and offset to SP is a multiple of reg number */
 	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
-	ld	\i, \i * 8(%r15)
+	ld	\i, \i * 8 + STACK_FRAME_INT_FPRS(%r15)
 	.endr
-	/* Now that we're done, rewind the stack pointer by 16 double word */
-	algfi   %r15, 16 * 8
+	/* Load CR0 back */
+	lctlg	%c0, %c0, STACK_FRAME_INT_CR0(%r15)
 	/* Load the registers from stack */
-	lmg     %r0, %r14, 0(%r15)
-	/* Rewind the stack by 15 double word */
-	algfi   %r15, 15 * 8
+	lg      %r0, STACK_FRAME_INT_GRS1(%r15)
+	lg      %r1, STACK_FRAME_INT_GRS1 + 8(%r15)
+	lmg     %r2, %r15, STACK_FRAME_INT_GRS0(%r15)
 	.endm
-- 
2.25.1
