Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgDWJKa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 05:10:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N922Mp097395
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30k7rbrt6g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Apr 2020 10:09:39 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 04/10] s390x: smp: Test local interrupts after cpu reset
Date: Thu, 23 Apr 2020 05:10:07 -0400
In-Reply-To: <20200423091013.11587-1-frankja@linux.ibm.com>
References: <20200423091013.11587-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200423091013.11587-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Local interrupts (external and emergency call) should be cleared after
any cpu reset.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 s390x/smp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 8a6cd1d..a8e3dd7 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -243,6 +243,20 @@ static void test_reset_initial(void)
 	report_prefix_pop();
 }
 
+static void test_local_ints(void)
+{
+	unsigned long mask;
+
+	expect_ext_int();
+	/* Open masks for ecall and emcall */
+	ctl_set_bit(0, 13);
+	ctl_set_bit(0, 14);
+	mask = extract_psw_mask();
+	mask |= PSW_MASK_EXT;
+	load_psw_mask(mask);
+	set_flag(1);
+}
+
 static void test_reset(void)
 {
 	struct psw psw;
@@ -251,10 +265,18 @@ static void test_reset(void)
 	psw.addr = (unsigned long)test_func;
 
 	report_prefix_push("cpu reset");
+	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
+	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
 	smp_cpu_start(1, psw);
 
 	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
 	report(smp_cpu_stopped(1), "cpu stopped");
+
+	set_flag(0);
+	psw.addr = (unsigned long)test_local_ints;
+	smp_cpu_start(1, psw);
+	wait_for_flag();
+	report(true, "local interrupts cleared");
 	report_prefix_pop();
 }
 
-- 
2.25.1
