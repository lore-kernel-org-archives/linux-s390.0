Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728733AbgANPbO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 10:31:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFTSAI080840
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbprku19-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:13 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 14 Jan 2020 15:31:11 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/4] s390x: smp: Only use smp_cpu_setup once
Date: Tue, 14 Jan 2020 10:30:51 -0500
In-Reply-To: <20200114153054.77082-1-frankja@linux.ibm.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200114153054.77082-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Let's stop and start instead of using setup to run a function on a
cpu.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/smp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index 4dee43e..767d167 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -47,7 +47,7 @@ static void test_start(void)
 	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 	wait_for_flag();
 	report(1, "start");
 }
@@ -131,9 +131,8 @@ static void test_ecall(void)
 
 	report_prefix_push("ecall");
 	testflag = 0;
-	smp_cpu_destroy(1);
 
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 	wait_for_flag();
 	testflag = 0;
 	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
@@ -166,9 +165,8 @@ static void test_emcall(void)
 
 	report_prefix_push("emcall");
 	testflag = 0;
-	smp_cpu_destroy(1);
 
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 	wait_for_flag();
 	testflag = 0;
 	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
@@ -186,7 +184,7 @@ static void test_reset_initial(void)
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("reset initial");
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 
 	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
 	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
@@ -217,7 +215,7 @@ static void test_reset(void)
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("cpu reset");
-	smp_cpu_setup(1, psw);
+	smp_cpu_start(1, psw);
 
 	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
 	report(smp_cpu_stopped(1), "cpu stopped");
@@ -226,6 +224,7 @@ static void test_reset(void)
 
 int main(void)
 {
+	struct psw psw;
 	report_prefix_push("smp");
 
 	if (smp_query_num_cpus() == 1) {
@@ -233,6 +232,12 @@ int main(void)
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
-- 
2.20.1
