Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729118AbfLKL7i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 06:59:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBBqIQ3014306
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 06:59:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtdp48us9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 06:59:36 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Dec 2019 11:59:35 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/2] s390x: smp: Setup CRs from cpu 0
Date: Wed, 11 Dec 2019 06:59:23 -0500
In-Reply-To: <20191211115923.9191-1-frankja@linux.ibm.com>
References: <20191211115923.9191-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191211115923.9191-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, linux-s390@vger.kernel.org

Grab the CRs (currently only 0, 1, 7, 13) from cpu 0, so we can
bringup the new cpu in DAT mode or set other control options.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/smp.c  | 5 ++++-
 s390x/cstart64.S | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index e17751a..4dfe7c6 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -191,7 +191,10 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
 	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
 	lc->restart_new_psw.mask = 0x0000000180000000UL;
 	lc->restart_new_psw.addr = (uint64_t)smp_cpu_setup_state;
-	lc->sw_int_crs[0] = 0x0000000000040000UL;
+	lc->sw_int_crs[0] = stctg(0);
+	lc->sw_int_crs[1] = stctg(1);
+	lc->sw_int_crs[7] = stctg(7);
+	lc->sw_int_crs[13] = stctg(13);
 
 	/* Start processing */
 	rc = sigp_retry(cpu->addr, SIGP_RESTART, 0, NULL);
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index e6a6bdb..399ae9b 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -158,7 +158,7 @@ diag308_load_reset:
 smp_cpu_setup_state:
 	xgr	%r1, %r1
 	lmg     %r0, %r15, GEN_LC_SW_INT_GRS
-	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
+	lctlg   %c0, %c15, GEN_LC_SW_INT_CRS
 	lpswe	GEN_LC_SW_INT_PSW
 
 pgm_int:
-- 
2.20.1
