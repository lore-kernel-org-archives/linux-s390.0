Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729108AbfLKL7g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 06:59:36 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBBqAIK060724
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 06:59:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8kytag5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 06:59:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Dec 2019 11:59:32 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 1/2] s390x: smp: Use full PSW to bringup new cpu
Date: Wed, 11 Dec 2019 06:59:22 -0500
In-Reply-To: <20191211115923.9191-1-frankja@linux.ibm.com>
References: <20191211115923.9191-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191211115923.9191-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, linux-s390@vger.kernel.org

Up to now we ignored the psw mask and only used the psw address when
bringing up a new cpu. For DAT we need to also load the mask, so let's
do that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/smp.c  | 2 ++
 s390x/cstart64.S | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index f57f420..e17751a 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -185,6 +185,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
 	cpu->stack = (uint64_t *)alloc_pages(2);
 
 	/* Start without DAT and any other mask bits. */
+	cpu->lowcore->sw_int_psw.mask = psw.mask;
+	cpu->lowcore->sw_int_psw.addr = psw.addr;
 	cpu->lowcore->sw_int_grs[14] = psw.addr;
 	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
 	lc->restart_new_psw.mask = 0x0000000180000000UL;
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 86dd4c4..e6a6bdb 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -159,7 +159,7 @@ smp_cpu_setup_state:
 	xgr	%r1, %r1
 	lmg     %r0, %r15, GEN_LC_SW_INT_GRS
 	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
-	br	%r14
+	lpswe	GEN_LC_SW_INT_PSW
 
 pgm_int:
 	SAVE_REGS
-- 
2.20.1
