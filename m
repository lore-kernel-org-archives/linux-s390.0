Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbgCXINP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 04:13:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O846ek008239
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 04:13:14 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywfe85vja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 04:13:14 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 24 Mar 2020 08:13:11 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 07/10] s390x: smp: Use full PSW to bringup new cpu
Date: Tue, 24 Mar 2020 04:12:48 -0400
In-Reply-To: <20200324081251.28810-1-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200324081251.28810-8-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

Up to now we ignored the psw mask and only used the psw address when
bringing up a new cpu. For DAT we need to also load the mask, so let's
do that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/smp.c  | 2 ++
 s390x/cstart64.S | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 3f8624318f1aa5a1..6ef0335954fd4832 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -202,6 +202,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
 	cpu->stack = (uint64_t *)alloc_pages(2);
 
 	/* Start without DAT and any other mask bits. */
+	cpu->lowcore->sw_int_psw.mask = psw.mask;
+	cpu->lowcore->sw_int_psw.addr = psw.addr;
 	cpu->lowcore->sw_int_grs[14] = psw.addr;
 	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
 	lc->restart_new_psw.mask = 0x0000000180000000UL;
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index ecffbe05c707fd7c..e084f1305aa90e45 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -161,7 +161,8 @@ smp_cpu_setup_state:
 	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
 	/* We should only go once through cpu setup and not for every restart */
 	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
-	brasl	%r14, %r14
+	larl	%r14, 0f
+	lpswe	GEN_LC_SW_INT_PSW
 	/* If the function returns, just loop here */
 0:	j	0
 
-- 
2.25.1
