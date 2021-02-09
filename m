Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15938 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231845AbhBINvd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:33 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 7/8] s390x: Move diag308_load_reset to stack saving
Date: Tue,  9 Feb 2021 08:49:24 -0500
Message-Id: <20210209134925.22248-8-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

By moving the last user of SAVE/RESTORE_REGS to the macros that use
the stack we can finally remove these macros.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/cpu.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/s390x/cpu.S b/s390x/cpu.S
index 5267f029..e2ad56c8 100644
--- a/s390x/cpu.S
+++ b/s390x/cpu.S
@@ -18,7 +18,7 @@
  */
 .globl diag308_load_reset
 diag308_load_reset:
-	SAVE_REGS
+	SAVE_REGS_STACK
 	/* Backup current PSW mask, as we have to restore it on success */
 	epsw	%r0, %r1
 	st	%r0, GEN_LC_SW_INT_PSW
@@ -31,6 +31,7 @@ diag308_load_reset:
 	ogr	%r0, %r1
 	/* Store it at the reset PSW location (real 0x0) */
 	stg	%r0, 0
+	stg     %r15, GEN_LC_SW_INT_GRS + 15 * 8
 	/* Do the reset */
 	diag    %r0,%r2,0x308
 	/* Failure path */
@@ -40,7 +41,8 @@ diag308_load_reset:
 	/* load a cr0 that has the AFP control bit which enables all FPRs */
 0:	larl	%r1, initial_cr0
 	lctlg	%c0, %c0, 0(%r1)
-	RESTORE_REGS
+	lg      %r15, GEN_LC_SW_INT_GRS + 15 * 8
+	RESTORE_REGS_STACK
 	lhi	%r2, 1
 	larl	%r0, 1f
 	stg	%r0, GEN_LC_SW_INT_PSW + 8
-- 
2.25.1
