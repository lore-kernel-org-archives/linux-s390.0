Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhBINvf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:35 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 8/8] s390x: Remove SAVE/RESTORE_stack
Date: Tue,  9 Feb 2021 08:49:25 -0500
Message-Id: <20210209134925.22248-9-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

There are no more users.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/macros.S | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/s390x/macros.S b/s390x/macros.S
index 1678c821..90a842d9 100644
--- a/s390x/macros.S
+++ b/s390x/macros.S
@@ -28,35 +28,6 @@
 	lpswe	\old_psw
 	.endm
 
-	.macro SAVE_REGS
-	/* save grs 0-15 */
-	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
-	/* save crs 0-15 */
-	stctg	%c0, %c15, GEN_LC_SW_INT_CRS
-	/* load a cr0 that has the AFP control bit which enables all FPRs */
-	larl	%r1, initial_cr0
-	lctlg	%c0, %c0, 0(%r1)
-	/* save fprs 0-15 + fpc */
-	la	%r1, GEN_LC_SW_INT_FPRS
-	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
-	std	\i, \i * 8(%r1)
-	.endr
-	stfpc	GEN_LC_SW_INT_FPC
-	.endm
-
-	.macro RESTORE_REGS
-	/* restore fprs 0-15 + fpc */
-	la	%r1, GEN_LC_SW_INT_FPRS
-	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
-	ld	\i, \i * 8(%r1)
-	.endr
-	lfpc	GEN_LC_SW_INT_FPC
-	/* restore crs 0-15 */
-	lctlg	%c0, %c15, GEN_LC_SW_INT_CRS
-	/* restore grs 0-15 */
-	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
-	.endm
-
 /* Save registers on the stack (r15), so we can have stacked interrupts. */
 	.macro SAVE_REGS_STACK
 	/* Allocate a full stack frame */
-- 
2.25.1
