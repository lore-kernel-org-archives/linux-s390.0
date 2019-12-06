Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfLFQ0h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Dec 2019 11:26:37 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6GEJ6V048284
        for <linux-s390@vger.kernel.org>; Fri, 6 Dec 2019 11:26:36 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq905s86x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Dec 2019 11:26:35 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 6 Dec 2019 16:26:33 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 1/9] s390x: saving regs for interrupts
Date: Fri,  6 Dec 2019 17:26:20 +0100
In-Reply-To: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1575649588-6127-2-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

If we use multiple source of interrupts, for exemple, using SCLP
console to print information while using I/O interrupts, we need
to have a re-entrant register saving interruption handling.

Instead of saving at a static memory address, let's save the base
registers and the floating point registers on the stack.

Note that we keep the static register saving to recover from the
RESET tests.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/cstart64.S | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 86dd4c4..ff05f9b 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -118,6 +118,25 @@ memsetxc:
 	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
 	.endm
 
+	.macro SAVE_IRQ_REGS
+	slgfi   %r15, 15 * 8
+	stmg    %r0, %r14, 0(%r15)
+	slgfi   %r15, 16 * 8
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	std	\i, \i * 8(%r15)
+	.endr
+	lgr     %r2, %r15
+	.endm
+
+	.macro RESTORE_IRQ_REGS
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	ld	\i, \i * 8(%r15)
+	.endr
+	algfi   %r15, 16 * 8
+	lmg     %r0, %r14, 0(%r15)
+	algfi   %r15, 15 * 8
+	.endm
+
 .section .text
 /*
  * load_reset calling convention:
@@ -154,6 +173,8 @@ diag308_load_reset:
 	lpswe	GEN_LC_SW_INT_PSW
 1:	br	%r14
 
+
+
 .globl smp_cpu_setup_state
 smp_cpu_setup_state:
 	xgr	%r1, %r1
@@ -180,9 +201,9 @@ mcck_int:
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
2.17.0
