Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgDXKqA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:46:00 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v6 01/10] s390x: saving regs for interrupts
Date: Fri, 24 Apr 2020 12:45:43 +0200
Message-Id: <1587725152-25569-2-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

If we use multiple source of interrupts, for example, using SCLP
console to print information while using I/O interrupts, we need
to have a re-entrant register saving interruption handling.

Instead of saving at a static memory address, let's save the base
registers and the floating point registers on the stack.

Note that we keep the static register saving to recover from the
RESET tests.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/cstart64.S | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 9af6bb3..ba2e67c 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -118,6 +118,36 @@ memsetxc:
 	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
 	.endm
 
+/* Save registers on the stack (r15), so we can have stacked interrupts. */
+	.macro SAVE_IRQ_REGS
+	/* Allocate a stack frame for 15 integer registers */
+	slgfi   %r15, 15 * 8
+	/* Store all registers from r0 to r14 on the stack */
+	stmg    %r0, %r14, 0(%r15)
+	/* Allocate a stack frame for 16 floating point registers */
+	/* The size of a FP register is the size of an integer */
+	slgfi   %r15, 16 * 8
+	/* Save fp register on stack: offset to SP is multiple of reg number */
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	std	\i, \i * 8(%r15)
+	.endr
+	.endm
+
+/* Restore the register in reverse order */
+	.macro RESTORE_IRQ_REGS
+	/* Restore fp register from stack: SP still where it was left */
+	/* and offset to SP is a multile of reg number */
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	ld	\i, \i * 8(%r15)
+	.endr
+	/* Now it is done, rewind the stack pointer by 16 integers */
+	algfi   %r15, 16 * 8
+	/* Load the registers from stack */
+	lmg     %r0, %r14, 0(%r15)
+	/* Rewind the stack by 15 integers */
+	algfi   %r15, 15 * 8
+	.endm
+
 .section .text
 /*
  * load_reset calling convention:
@@ -182,9 +212,9 @@ mcck_int:
 	lpswe	GEN_LC_MCCK_OLD_PSW
 
 io_int:
-	SAVE_REGS
+	SAVE_IRQ_REGS
 	brasl	%r14, handle_io_int
-	RESTORE_REGS
+	RESTORE_IRQ_REGS
 	lpswe	GEN_LC_IO_OLD_PSW
 
 svc_int:
-- 
2.25.1
