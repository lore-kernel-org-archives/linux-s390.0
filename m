Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgDWJKa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 05:10:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N9369I114937
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu8uyqm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Apr 2020 10:09:50 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 03/10] s390x: smp: Test stop and store status on a running and stopped cpu
Date: Thu, 23 Apr 2020 05:10:06 -0400
In-Reply-To: <20200423091013.11587-1-frankja@linux.ibm.com>
References: <20200423091013.11587-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200423091013.11587-4-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Let's also test the stop portion of the "stop and store status" sigp
order.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 s390x/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 95df8c4..8a6cd1d 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -76,12 +76,26 @@ static void test_stop_store_status(void)
 	struct lowcore *lc = (void *)0x0;
 
 	report_prefix_push("stop store status");
+	report_prefix_push("running");
+	smp_cpu_restart(1);
 	lc->prefix_sa = 0;
 	lc->grs_sa[15] = 0;
 	smp_cpu_stop_store_status(1);
 	mb();
 	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
 	report(lc->grs_sa[15], "stack");
+	report(smp_cpu_stopped(1), "cpu stopped");
+	report_prefix_pop();
+
+	report_prefix_push("stopped");
+	lc->prefix_sa = 0;
+	lc->grs_sa[15] = 0;
+	smp_cpu_stop_store_status(1);
+	mb();
+	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
+	report(lc->grs_sa[15], "stack");
+	report_prefix_pop();
+
 	report_prefix_pop();
 }
 
-- 
2.25.1
