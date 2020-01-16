Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgAPMFg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 07:05:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GBwA9W031666
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 07:05:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xh7h9sw9u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 07:05:34 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 12:05:33 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 4/7] s390x: smp: Rework cpu start and active tracking
Date: Thu, 16 Jan 2020 07:05:10 -0500
In-Reply-To: <20200116120513.2244-1-frankja@linux.ibm.com>
References: <20200116120513.2244-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200116120513.2244-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

sigp is not synchronous on all hypervisors, so we need to wait until
the cpu runs until we return from the setup/start function.

As there was a lot of duplicate code a common function for cpu
restarts has been intropduced.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/smp.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index f57f420..f984a34 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -104,35 +104,41 @@ int smp_cpu_stop_store_status(uint16_t addr)
 	return rc;
 }
 
+static int smp_cpu_restart_nolock(uint16_t addr, struct psw *psw)
+{
+	int rc;
+	struct cpu *cpu = smp_cpu_from_addr(addr);
+
+	if (!cpu)
+		return -1;
+	if (psw) {
+		cpu->lowcore->restart_new_psw.mask = psw->mask;
+		cpu->lowcore->restart_new_psw.addr = psw->addr;
+	}
+	rc = sigp(addr, SIGP_RESTART, 0, NULL);
+	if (rc)
+		return rc;
+	while (!smp_cpu_running(addr)) { mb(); }
+	cpu->active = true;
+	return 0;
+}
+
 int smp_cpu_restart(uint16_t addr)
 {
-	int rc = -1;
-	struct cpu *cpu;
+	int rc;
 
 	spin_lock(&lock);
-	cpu = smp_cpu_from_addr(addr);
-	if (cpu) {
-		rc = sigp(addr, SIGP_RESTART, 0, NULL);
-		cpu->active = true;
-	}
+	rc = smp_cpu_restart_nolock(addr, NULL);
 	spin_unlock(&lock);
 	return rc;
 }
 
 int smp_cpu_start(uint16_t addr, struct psw psw)
 {
-	int rc = -1;
-	struct cpu *cpu;
-	struct lowcore *lc;
+	int rc;
 
 	spin_lock(&lock);
-	cpu = smp_cpu_from_addr(addr);
-	if (cpu) {
-		lc = cpu->lowcore;
-		lc->restart_new_psw.mask = psw.mask;
-		lc->restart_new_psw.addr = psw.addr;
-		rc = sigp(addr, SIGP_RESTART, 0, NULL);
-	}
+	rc = smp_cpu_restart_nolock(addr, &psw);
 	spin_unlock(&lock);
 	return rc;
 }
@@ -192,10 +198,7 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
 	lc->sw_int_crs[0] = 0x0000000000040000UL;
 
 	/* Start processing */
-	rc = sigp_retry(cpu->addr, SIGP_RESTART, 0, NULL);
-	if (!rc)
-		cpu->active = true;
-
+	smp_cpu_restart_nolock(addr, NULL);
 out:
 	spin_unlock(&lock);
 	return rc;
-- 
2.20.1
