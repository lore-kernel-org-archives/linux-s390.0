Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728695AbgANPbP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 10:31:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFRTgf115114
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xh8d3m2bn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:14 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 14 Jan 2020 15:31:12 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial reset
Date: Tue, 14 Jan 2020 10:30:52 -0500
In-Reply-To: <20200114153054.77082-1-frankja@linux.ibm.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200114153054.77082-4-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
so we also need to test 1-13 and 15 for 0.

And while we're at it, let's also set some values to cr 1, 7 and 13, so
we can actually be sure that they will be zeroed.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/smp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index 767d167..11ab425 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -175,16 +175,31 @@ static void test_emcall(void)
 	report_prefix_pop();
 }
 
+static void test_func_initial(void)
+{
+	lctlg(1, 0x42000UL);
+	lctlg(7, 0x43000UL);
+	lctlg(13, 0x44000UL);
+	testflag = 1;
+	mb();
+	cpu_loop();
+}
+
 static void test_reset_initial(void)
 {
 	struct cpu_status *status = alloc_pages(0);
+	uint8_t *nullp = alloc_pages(0);
 	struct psw psw;
 
+	memset(nullp, 0, PAGE_SIZE);
 	psw.mask = extract_psw_mask();
-	psw.addr = (unsigned long)test_func;
+	psw.addr = (unsigned long)test_func_initial;
 
 	report_prefix_push("reset initial");
+	testflag = 0;
+	mb();
 	smp_cpu_start(1, psw);
+	wait_for_flag();
 
 	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
 	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
@@ -195,6 +210,8 @@ static void test_reset_initial(void)
 	report(!status->fpc, "fpc");
 	report(!status->cputm, "cpu timer");
 	report(!status->todpr, "todpr");
+	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12), "cr1-13 == 0");
+	report(status->crs[15] == 0, "cr15 == 0");
 	report_prefix_pop();
 
 	report_prefix_push("initialized");
@@ -204,6 +221,7 @@ static void test_reset_initial(void)
 
 	report(smp_cpu_stopped(1), "cpu stopped");
 	free_pages(status, PAGE_SIZE);
+	free_pages(nullp, PAGE_SIZE);
 	report_prefix_pop();
 }
 
@@ -219,6 +237,7 @@ static void test_reset(void)
 
 	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
 	report(smp_cpu_stopped(1), "cpu stopped");
+	smp_cpu_destroy(1);
 	report_prefix_pop();
 }
 
-- 
2.20.1
