Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgD2Ofe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 10:35:34 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v3 03/10] s390x: smp: Test stop and store status on a running and stopped cpu
Date: Wed, 29 Apr 2020 10:35:11 -0400
Message-Id: <20200429143518.1360468-4-frankja@linux.ibm.com>
In-Reply-To: <20200429143518.1360468-1-frankja@linux.ibm.com>
References: <20200429143518.1360468-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Let's also test the stop portion of the "stop and store status" sigp
order.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index b07cb66..4c50183 100644
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
