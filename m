Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKDI45 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 03:56:57 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA48uE4A074562
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 03:56:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2dk56hve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 03:56:35 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 4 Nov 2019 08:54:44 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: Use loop to save and restore fprs
Date: Mon,  4 Nov 2019 03:55:33 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191104085533.2892-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, pmorel@linux.ibm.com

Let's save some lines in the assembly by using a loop to save and
restore the fprs.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/cstart64.S | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 5dc1577..8e2b21e 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -99,44 +99,18 @@ memsetxc:
 	lctlg	%c0, %c0, 0(%r1)
 	/* save fprs 0-15 + fpc */
 	la	%r1, GEN_LC_SW_INT_FPRS
-	std	%f0, 0(%r1)
-	std	%f1, 8(%r1)
-	std	%f2, 16(%r1)
-	std	%f3, 24(%r1)
-	std	%f4, 32(%r1)
-	std	%f5, 40(%r1)
-	std	%f6, 48(%r1)
-	std	%f7, 56(%r1)
-	std	%f8, 64(%r1)
-	std	%f9, 72(%r1)
-	std	%f10, 80(%r1)
-	std	%f11, 88(%r1)
-	std	%f12, 96(%r1)
-	std	%f13, 104(%r1)
-	std	%f14, 112(%r1)
-	std	%f15, 120(%r1)
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	std	\i, \i * 8(%r1)
+	.endr
 	stfpc	GEN_LC_SW_INT_FPC
 	.endm
 
 	.macro RESTORE_REGS
 	/* restore fprs 0-15 + fpc */
 	la	%r1, GEN_LC_SW_INT_FPRS
-	ld	%f0, 0(%r1)
-	ld	%f1, 8(%r1)
-	ld	%f2, 16(%r1)
-	ld	%f3, 24(%r1)
-	ld	%f4, 32(%r1)
-	ld	%f5, 40(%r1)
-	ld	%f6, 48(%r1)
-	ld	%f7, 56(%r1)
-	ld	%f8, 64(%r1)
-	ld	%f9, 72(%r1)
-	ld	%f10, 80(%r1)
-	ld	%f11, 88(%r1)
-	ld	%f12, 96(%r1)
-	ld	%f13, 104(%r1)
-	ld	%f14, 112(%r1)
-	ld	%f15, 120(%r1)
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	ld	\i, \i * 8(%r1)
+	.endr
 	lfpc	GEN_LC_SW_INT_FPC
 	/* restore cr0 */
 	lctlg	%c0, %c0, GEN_LC_SW_INT_CR0
-- 
2.20.1
