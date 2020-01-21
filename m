Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729009AbgAUNnR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 08:43:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LDgWhJ116306
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgdkygba-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 13:43:15 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 1/9] s390x: smp: Cleanup smp.c
Date: Tue, 21 Jan 2020 08:42:46 -0500
In-Reply-To: <20200121134254.4570-1-frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200121134254.4570-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Let's remove a lot of badly formatted code by introducing the
wait_for_flag() and set_flag functions.

Also let's remove some stray spaces and always set the tesflag before
using it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 55 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index ab7e46c..e37eb56 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -22,6 +22,19 @@
 
 static int testflag = 0;
 
+static void wait_for_flag(void)
+{
+	while (!testflag)
+		mb();
+}
+
+static void set_flag(int val)
+{
+	mb();
+	testflag = val;
+	mb();
+}
+
 static void cpu_loop(void)
 {
 	for (;;) {}
@@ -29,21 +42,19 @@ static void cpu_loop(void)
 
 static void test_func(void)
 {
-	testflag = 1;
-	mb();
+	set_flag(1);
 	cpu_loop();
 }
 
 static void test_start(void)
 {
 	struct psw psw;
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
+	set_flag(0);
 	smp_cpu_setup(1, psw);
-	while (!testflag) {
-		mb();
-	}
+	wait_for_flag();
 	report(1, "start");
 }
 
@@ -112,27 +123,27 @@ static void ecall(void)
 	mask = extract_psw_mask();
 	mask |= PSW_MASK_EXT;
 	load_psw_mask(mask);
-	testflag = 1;
+	set_flag(1);
 	while (lc->ext_int_code != 0x1202) { mb(); }
 	report(1, "ecall");
-	testflag= 1;
+	set_flag(1);
 }
 
 static void test_ecall(void)
 {
 	struct psw psw;
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)ecall;
 
 	report_prefix_push("ecall");
-	testflag= 0;
+	set_flag(0);
 	smp_cpu_destroy(1);
 
 	smp_cpu_setup(1, psw);
-	while (!testflag) { mb(); }
-	testflag= 0;
+	wait_for_flag();
+	set_flag(0);
 	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
-	while(!testflag) {mb();}
+	wait_for_flag();
 	smp_cpu_stop(1);
 	report_prefix_pop();
 }
@@ -147,27 +158,27 @@ static void emcall(void)
 	mask = extract_psw_mask();
 	mask |= PSW_MASK_EXT;
 	load_psw_mask(mask);
-	testflag= 1;
+	set_flag(1);
 	while (lc->ext_int_code != 0x1201) { mb(); }
 	report(1, "ecall");
-	testflag = 1;
+	set_flag(1);
 }
 
 static void test_emcall(void)
 {
 	struct psw psw;
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)emcall;
 
 	report_prefix_push("emcall");
-	testflag= 0;
+	set_flag(0);
 	smp_cpu_destroy(1);
 
 	smp_cpu_setup(1, psw);
-	while (!testflag) { mb(); }
-	testflag= 0;
+	wait_for_flag();
+	set_flag(0);
 	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
-	while(!testflag) { mb(); }
+	wait_for_flag();
 	smp_cpu_stop(1);
 	report_prefix_pop();
 }
@@ -177,7 +188,7 @@ static void test_reset_initial(void)
 	struct cpu_status *status = alloc_pages(0);
 	struct psw psw;
 
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("reset initial");
@@ -208,7 +219,7 @@ static void test_reset(void)
 {
 	struct psw psw;
 
-	psw.mask =  extract_psw_mask();
+	psw.mask = extract_psw_mask();
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("cpu reset");
-- 
2.20.1
