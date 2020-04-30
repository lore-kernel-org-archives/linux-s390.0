Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40905 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgD3PYy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 11:24:54 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 07/17] s390x/smp: add minimal test for sigp sense running status
Date: Thu, 30 Apr 2020 17:24:20 +0200
Message-Id: <20200430152430.40349-8-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Two minimal tests:
- our own CPU should be running when we check ourselves
- a CPU should at least have some times with a not running
indication. To speed things up we stop CPU1

Also rename smp_cpu_running to smp_sense_running_status.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200402154441.13063-1-borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/s390x/smp.c |  2 +-
 lib/s390x/smp.h |  2 +-
 s390x/smp.c     | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 203792a..df8dcd9 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -58,7 +58,7 @@ bool smp_cpu_stopped(uint16_t addr)
 	return !!(status & (SIGP_STATUS_CHECK_STOP|SIGP_STATUS_STOPPED));
 }
=20
-bool smp_cpu_running(uint16_t addr)
+bool smp_sense_running_status(uint16_t addr)
 {
 	if (sigp(addr, SIGP_SENSE_RUNNING, 0, NULL) !=3D SIGP_CC_STATUS_STORED)
 		return true;
diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
index ce63a89..d66e39a 100644
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
index fa40753..1641979 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -182,6 +182,19 @@ static void test_emcall(void)
 	report_prefix_pop();
 }
=20
+static void test_sense_running(void)
+{
+	report_prefix_push("sense_running");
+	/* we (CPU0) are running */
+	report(smp_sense_running_status(0), "CPU0 sense claims running");
+	/* stop the target CPU (CPU1) to speed up the not running case */
+	smp_cpu_stop(1);
+	/* Make sure to have at least one time with a not running indication */
+	while(smp_sense_running_status(1));
+	report(true, "CPU1 sense claims not running");
+	report_prefix_pop();
+}
+
 static void test_reset_initial(void)
 {
 	struct cpu_status *status =3D alloc_pages(0);
@@ -251,6 +264,7 @@ int main(void)
 	test_store_status();
 	test_ecall();
 	test_emcall();
+	test_sense_running();
 	test_reset();
 	test_reset_initial();
 	smp_cpu_destroy(1);
--=20
2.25.3
