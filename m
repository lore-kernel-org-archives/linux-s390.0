Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726495AbgANPbK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 10:31:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFRPMf123245
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvvc56rn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:09 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 14 Jan 2020 15:31:07 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 1/4] s390x: smp: Cleanup smp.c
Date: Tue, 14 Jan 2020 10:30:50 -0500
In-Reply-To: <20200114153054.77082-1-frankja@linux.ibm.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200114153054.77082-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Let's remove a lot of badly formatted code by introducing the
wait_for_flag() function.

Also let's remove some stray spaces.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/smp.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index ab7e46c..4dee43e 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -22,6 +22,13 @@
 
 static int testflag = 0;
 
+static void wait_for_flag(void)
+{
+	while (!testflag) {
+		mb();
+	}
+}
+
 static void cpu_loop(void)
 {
 	for (;;) {}
@@ -37,13 +44,11 @@ static void test_func(void)
 static void test_start(void)
 {
 	struct psw psw;
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
 	smp_cpu_setup(1, psw);
-	while (!testflag) {
-		mb();
-	}
+	wait_for_flag();
 	report(1, "start");
 }
 
@@ -115,24 +120,24 @@ static void ecall(void)
 	testflag = 1;
 	while (lc->ext_int_code != 0x1202) { mb(); }
 	report(1, "ecall");
-	testflag= 1;
+	testflag = 1;
 }
 
 static void test_ecall(void)
 {
 	struct psw psw;
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)ecall;
 
 	report_prefix_push("ecall");
-	testflag= 0;
+	testflag = 0;
 	smp_cpu_destroy(1);
 
 	smp_cpu_setup(1, psw);
-	while (!testflag) { mb(); }
-	testflag= 0;
+	wait_for_flag();
+	testflag = 0;
 	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
-	while(!testflag) {mb();}
+	wait_for_flag();
 	smp_cpu_stop(1);
 	report_prefix_pop();
 }
@@ -147,7 +152,7 @@ static void emcall(void)
 	mask = extract_psw_mask();
 	mask |= PSW_MASK_EXT;
 	load_psw_mask(mask);
-	testflag= 1;
+	testflag = 1;
 	while (lc->ext_int_code != 0x1201) { mb(); }
 	report(1, "ecall");
 	testflag = 1;
@@ -156,18 +161,18 @@ static void emcall(void)
 static void test_emcall(void)
 {
 	struct psw psw;
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)emcall;
 
 	report_prefix_push("emcall");
-	testflag= 0;
+	testflag = 0;
 	smp_cpu_destroy(1);
 
 	smp_cpu_setup(1, psw);
-	while (!testflag) { mb(); }
-	testflag= 0;
+	wait_for_flag();
+	testflag = 0;
 	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
-	while(!testflag) { mb(); }
+	wait_for_flag();
 	smp_cpu_stop(1);
 	report_prefix_pop();
 }
@@ -177,7 +182,7 @@ static void test_reset_initial(void)
 	struct cpu_status *status = alloc_pages(0);
 	struct psw psw;
 
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("reset initial");
@@ -208,7 +213,7 @@ static void test_reset(void)
 {
 	struct psw psw;
 
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("cpu reset");
-- 
2.20.1
