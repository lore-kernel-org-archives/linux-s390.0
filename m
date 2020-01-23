Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53310 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgAWJOu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 04:14:50 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9CZld034959
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 04:14:48 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkwqa0cse-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 04:14:47 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Jan 2020 09:14:40 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: smp: Rework cpu start and active tracking
Date: Thu, 23 Jan 2020 04:14:21 -0500
In-Reply-To: <bf356a2c-702e-0ecd-d24c-f7a1b7c18d2a@redhat.com>
References: <bf356a2c-702e-0ecd-d24c-f7a1b7c18d2a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200123091421.3409-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

The architecture specifies that processing sigp orders may be
asynchronous, and this is indeed the case on some hypervisors, so we
need to wait until the cpu runs before we return from the setup/start
function.

As there was a lot of duplicate code, a common function for cpu
restarts has been introduced.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 lib/s390x/smp.c | 56 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index f57f420..4578003 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -104,35 +104,52 @@ int smp_cpu_stop_store_status(uint16_t addr)
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
+	/*
+	 * Stop the cpu, so we don't have a race between a running cpu
+	 * and the restart in the test that checks if the cpu is
+	 * running after the restart.
+	 */
+	smp_cpu_stop_nolock(addr, false);
+	rc = sigp(addr, SIGP_RESTART, 0, NULL);
+	if (rc)
+		return rc;
+	/*
+	 * The order has been accepted, but the actual restart may not
+	 * have been performed yet, so wait until the cpu is running.
+	 */
+	while (!smp_cpu_running(addr))
+		mb();
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
@@ -192,10 +209,7 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
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
