Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729130AbgAUNnU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 08:43:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LDgW5C093554
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmghb2bbr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:19 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 13:43:16 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 2/9] s390x: smp: Only use smp_cpu_setup once
Date: Tue, 21 Jan 2020 08:42:47 -0500
In-Reply-To: <20200121134254.4570-1-frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200121134254.4570-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Let's stop and start instead of using setup to run a function on a
cpu.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index e37eb56..3e8cf3e 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -53,7 +53,7 @@ static void test_start(void)
 	psw.addr = (unsigned long)test_func;
 
 	set_flag(0);
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 	wait_for_flag();
 	report(1, "start");
 }
@@ -109,6 +109,7 @@ static void test_store_status(void)
 	report(1, "status written");
 	free_pages(status, PAGE_SIZE * 2);
 	report_prefix_pop();
+	smp_cpu_stop(1);
 
 	report_prefix_pop();
 }
@@ -137,9 +138,8 @@ static void test_ecall(void)
 
 	report_prefix_push("ecall");
 	set_flag(0);
-	smp_cpu_destroy(1);
 
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 	wait_for_flag();
 	set_flag(0);
 	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
@@ -172,9 +172,8 @@ static void test_emcall(void)
 
 	report_prefix_push("emcall");
 	set_flag(0);
-	smp_cpu_destroy(1);
 
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 	wait_for_flag();
 	set_flag(0);
 	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
@@ -192,7 +191,7 @@ static void test_reset_initial(void)
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("reset initial");
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 
 	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
 	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
@@ -223,7 +222,7 @@ static void test_reset(void)
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("cpu reset");
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 
 	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
 	report(smp_cpu_stopped(1), "cpu stopped");
@@ -232,6 +231,7 @@ static void test_reset(void)
 
 int main(void)
 {
+	struct psw psw;
 	report_prefix_push("smp");
 
 	if (smp_query_num_cpus() == 1) {
@@ -239,6 +239,12 @@ int main(void)
 		goto done;
 	}
 
+	/* Setting up the cpu to give it a stack and lowcore */
+	psw.mask = extract_psw_mask();
+	psw.addr = (unsigned long)cpu_loop;
+	smp_cpu_setup(1, psw);
+	smp_cpu_stop(1);
+
 	test_start();
 	test_stop();
 	test_stop_store_status();
@@ -247,6 +253,7 @@ int main(void)
 	test_emcall();
 	test_reset();
 	test_reset_initial();
+	smp_cpu_destroy(1);
 
 done:
 	report_prefix_pop();
-- 
2.20.1
