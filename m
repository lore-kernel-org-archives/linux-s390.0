Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6070 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231838AbhBINvc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:32 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 4/8] s390x: Introduce and use CALL_INT_HANDLER macro
Date: Tue,  9 Feb 2021 08:49:21 -0500
Message-Id: <20210209134925.22248-5-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

The ELF ABI dictates that we need to allocate 160 bytes of stack space
for the C functions we're calling. Since we would need to do that for
every interruption handler which, combined with the new stack argument
being saved in GR2, makes cstart64.S look a bit messy.

So let's introduce the CALL_INT_HANDLER macro that handles all of
that, calls the C interrupt handler and handles cleanup afterwards.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/cstart64.S | 28 +++++-----------------------
 s390x/macros.S   | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 35d20293..666a9567 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -92,37 +92,19 @@ memsetxc:
 
 .section .text
 pgm_int:
-	SAVE_REGS_STACK
-	lgr     %r2, %r15
-	brasl	%r14, handle_pgm_int
-	RESTORE_REGS_STACK
-	lpswe	GEN_LC_PGM_OLD_PSW
+	CALL_INT_HANDLER handle_pgm_int, GEN_LC_PGM_OLD_PSW
 
 ext_int:
-	SAVE_REGS_STACK
-	lgr     %r2, %r15
-	brasl	%r14, handle_ext_int
-	RESTORE_REGS_STACK
-	lpswe	GEN_LC_EXT_OLD_PSW
+	CALL_INT_HANDLER handle_ext_int, GEN_LC_EXT_OLD_PSW
 
 mcck_int:
-	SAVE_REGS_STACK
-	brasl	%r14, handle_mcck_int
-	RESTORE_REGS_STACK
-	lpswe	GEN_LC_MCCK_OLD_PSW
+	CALL_INT_HANDLER handle_mcck_int, GEN_LC_MCCK_OLD_PSW
 
 io_int:
-	SAVE_REGS_STACK
-	lgr     %r2, %r15
-	brasl	%r14, handle_io_int
-	RESTORE_REGS_STACK
-	lpswe	GEN_LC_IO_OLD_PSW
+	CALL_INT_HANDLER handle_io_int, GEN_LC_IO_OLD_PSW
 
 svc_int:
-	SAVE_REGS_STACK
-	brasl	%r14, handle_svc_int
-	RESTORE_REGS_STACK
-	lpswe	GEN_LC_SVC_OLD_PSW
+	CALL_INT_HANDLER handle_svc_int, GEN_LC_SVC_OLD_PSW
 
 	.align	8
 initial_psw:
diff --git a/s390x/macros.S b/s390x/macros.S
index 9810d2ff..1678c821 100644
--- a/s390x/macros.S
+++ b/s390x/macros.S
@@ -11,6 +11,23 @@
  *  David Hildenbrand <david@redhat.com>
  */
 #include <asm/asm-offsets.h>
+/*
+ * Exception handler macro that saves registers on the stack,
+ * allocates stack space and calls the C handler function. Afterwards
+ * we re-load the registers and load the old PSW.
+ */
+	.macro CALL_INT_HANDLER c_func, old_psw
+	SAVE_REGS_STACK
+	/* Save the stack address in GR2 which is the first function argument */
+	lgr     %r2, %r15
+	/* Allocate stack pace for called C function, as specified in s390 ELF ABI */
+	slgfi   %r15, 160
+	brasl	%r14, \c_func
+	algfi   %r15, 160
+	RESTORE_REGS_STACK
+	lpswe	\old_psw
+	.endm
+
 	.macro SAVE_REGS
 	/* save grs 0-15 */
 	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
-- 
2.25.1
