Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfKKPd7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 10:33:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABFUOGF019092
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 10:33:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7a7wgn5f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 10:33:58 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 11 Nov 2019 15:33:56 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 1/3] s390x: Fix initial cr0 load comments
Date: Mon, 11 Nov 2019 10:33:43 -0500
In-Reply-To: <20191111153345.22505-1-frankja@linux.ibm.com>
References: <20191111153345.22505-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191111153345.22505-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

We need to load cr0 to have access to all fprs during save and restore
of fprs. Saving conditionally on basis of the CR0 AFP bit would be a
pain.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/cstart64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 8e2b21e..043e34a 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -94,7 +94,7 @@ memsetxc:
 	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
 	/* save cr0 */
 	stctg	%c0, %c0, GEN_LC_SW_INT_CR0
-	/* load initial cr0 again */
+	/* load a cr0 that has the AFP control bit which enables all FPRs */
 	larl	%r1, initial_cr0
 	lctlg	%c0, %c0, 0(%r1)
 	/* save fprs 0-15 + fpc */
@@ -139,7 +139,7 @@ diag308_load_reset:
 	xgr	%r2, %r2
 	br	%r14
 	/* Success path */
-	/* We lost cr0 due to the reset */
+	/* load a cr0 that has the AFP control bit which enables all FPRs */
 0:	larl	%r1, initial_cr0
 	lctlg	%c0, %c0, 0(%r1)
 	RESTORE_REGS
-- 
2.20.1
