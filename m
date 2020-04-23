Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbgDWJKd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 05:10:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N91uLD036055
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmvk2qwb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:33 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Apr 2020 10:09:42 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 09/10] s390x: smp: Add restart when running test
Date: Thu, 23 Apr 2020 05:10:12 -0400
In-Reply-To: <20200423091013.11587-1-frankja@linux.ibm.com>
References: <20200423091013.11587-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200423091013.11587-10-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Let's make sure we can restart a cpu that is already running.
Restarting it if it is stopped is implicitely tested by the the other
restart calls in the smp test.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 s390x/smp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 48321f4..35ca9c7 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -52,6 +52,34 @@ static void test_start(void)
 	report(1, "start");
 }
 
+/*
+ * Does only test restart when the target is running.
+ * The other tests do restarts when stopped multiple times already.
+ */
+static void test_restart(void)
+{
+	struct cpu *cpu = smp_cpu_from_addr(1);
+	struct lowcore *lc = cpu->lowcore;
+
+	lc->restart_new_psw.mask = extract_psw_mask();
+	lc->restart_new_psw.addr = (unsigned long)test_func;
+
+	/* Make sure cpu is running */
+	smp_cpu_stop(0);
+	set_flag(0);
+	smp_cpu_restart(1);
+	wait_for_flag();
+
+	/*
+	 * Wait until cpu 1 has set the flag because it executed the
+	 * restart function.
+	 */
+	set_flag(0);
+	smp_cpu_restart(1);
+	wait_for_flag();
+	report(1, "restart while running");
+}
+
 static void test_stop(void)
 {
 	smp_cpu_stop(1);
@@ -295,6 +323,7 @@ int main(void)
 	smp_cpu_stop(1);
 
 	test_start();
+	test_restart();
 	test_stop();
 	test_stop_store_status();
 	test_store_status();
-- 
2.25.1
