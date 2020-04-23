Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726766AbgDWJKc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 05:10:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N98ox2066238
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30k7rkrshx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Apr 2020 10:09:52 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
Date: Thu, 23 Apr 2020 05:10:11 -0400
In-Reply-To: <20200423091013.11587-1-frankja@linux.ibm.com>
References: <20200423091013.11587-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200423091013.11587-9-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Sigp orders are not necessarily finished when the processor finished
the sigp instruction. We need to poll if the order has been finished
before we continue.

For (re)start and stop we already use sigp sense running and sigp
sense loops. But we still lack completion checks for stop and store
status, as well as the cpu resets.

Let's add them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 lib/s390x/smp.c | 8 ++++++++
 lib/s390x/smp.h | 1 +
 s390x/smp.c     | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 6ef0335..2555bf4 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw psw)
 	return rc;
 }
 
+void smp_cpu_wait_for_completion(uint16_t addr)
+{
+	uint32_t status;
+
+	/* Loops when cc == 2, i.e. when the cpu is busy with a sigp order */
+	sigp_retry(1, SIGP_SENSE, 0, &status);
+}
+
 int smp_cpu_destroy(uint16_t addr)
 {
 	struct cpu *cpu;
diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
index ce63a89..a8b98c0 100644
--- a/lib/s390x/smp.h
+++ b/lib/s390x/smp.h
@@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
 int smp_cpu_start(uint16_t addr, struct psw psw);
 int smp_cpu_stop(uint16_t addr);
 int smp_cpu_stop_store_status(uint16_t addr);
+void smp_cpu_wait_for_completion(uint16_t addr);
 int smp_cpu_destroy(uint16_t addr);
 int smp_cpu_setup(uint16_t addr, struct psw psw);
 void smp_teardown(void);
diff --git a/s390x/smp.c b/s390x/smp.c
index 7462211..48321f4 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -75,6 +75,7 @@ static void test_stop_store_status(void)
 	lc->prefix_sa = 0;
 	lc->grs_sa[15] = 0;
 	smp_cpu_stop_store_status(1);
+	smp_cpu_wait_for_completion(1);
 	mb();
 	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
 	report(lc->grs_sa[15], "stack");
@@ -85,6 +86,7 @@ static void test_stop_store_status(void)
 	lc->prefix_sa = 0;
 	lc->grs_sa[15] = 0;
 	smp_cpu_stop_store_status(1);
+	smp_cpu_wait_for_completion(1);
 	mb();
 	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
 	report(lc->grs_sa[15], "stack");
@@ -215,6 +217,7 @@ static void test_reset_initial(void)
 	wait_for_flag();
 
 	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
+	smp_cpu_wait_for_completion(1);
 	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
 
 	report_prefix_push("clear");
@@ -264,6 +267,7 @@ static void test_reset(void)
 	smp_cpu_start(1, psw);
 
 	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
+	smp_cpu_wait_for_completion(1);
 	report(smp_cpu_stopped(1), "cpu stopped");
 
 	set_flag(0);
-- 
2.25.1
