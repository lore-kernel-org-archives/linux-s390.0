Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729674AbgC3ItY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 04:49:24 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [kvm-unit-tests 2/2] s390x/smp: add minimal test for sigp sense running status
Date: Mon, 30 Mar 2020 04:49:11 -0400
Message-Id: <20200330084911.34248-3-borntraeger@de.ibm.com>
In-Reply-To: <20200330084911.34248-1-borntraeger@de.ibm.com>
References: <20200330084911.34248-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

make sure that sigp sense running status returns a sane value for
stopped CPUs.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/s390x/smp.c |  2 +-
 lib/s390x/smp.h |  2 +-
 s390x/smp.c     | 11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 5ed8b7b..492cb05 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -58,7 +58,7 @@ bool smp_cpu_stopped(uint16_t addr)
 	return !!(status & (SIGP_STATUS_CHECK_STOP|SIGP_STATUS_STOPPED));
 }
 
-bool smp_cpu_running(uint16_t addr)
+bool smp_sense_running_status(uint16_t addr)
 {
 	if (sigp(addr, SIGP_SENSE_RUNNING, 0, NULL) != SIGP_CC_STATUS_STORED)
 		return true;
diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
index a8b98c0..639ec92 100644
--- a/lib/s390x/smp.h
+++ b/lib/s390x/smp.h
@@ -40,7 +40,7 @@ struct cpu_status {
 int smp_query_num_cpus(void);
 struct cpu *smp_cpu_from_addr(uint16_t addr);
 bool smp_cpu_stopped(uint16_t addr);
-bool smp_cpu_running(uint16_t addr);
+bool smp_sense_running_status(uint16_t addr);
 int smp_cpu_restart(uint16_t addr);
 int smp_cpu_start(uint16_t addr, struct psw psw);
 int smp_cpu_stop(uint16_t addr);
diff --git a/s390x/smp.c b/s390x/smp.c
index 79cdc1f..f9f143d 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -210,6 +210,16 @@ static void test_emcall(void)
 	report_prefix_pop();
 }
 
+static void test_sense_running(void)
+{
+	report_prefix_push("sense_running");
+	/* make sure CPU is stopped */
+	smp_cpu_stop(1);
+	report(!smp_sense_running_status(1), "CPU1 sense claims not running");
+	report_prefix_pop();
+}
+
+
 /* Used to dirty registers of cpu #1 before it is reset */
 static void test_func_initial(void)
 {
@@ -319,6 +329,7 @@ int main(void)
 	test_store_status();
 	test_ecall();
 	test_emcall();
+	test_sense_running();
 	test_reset();
 	test_reset_initial();
 	smp_cpu_destroy(1);
-- 
2.25.1
