Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727807AbgD3PZU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:25:20 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 16/17] s390x: smp: Add restart when running test
Date: Thu, 30 Apr 2020 17:24:29 +0200
Message-Id: <20200430152430.40349-17-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Let's make sure we can restart a cpu that is already running.
Restarting it if it is stopped is implicitely tested by the the other
restart calls in the smp test.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200429143518.1360468-10-frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index f2319c4..ad30e3c 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -52,6 +52,34 @@ static void test_start(void)
 	report(1, "start");
 }
=20
+/*
+ * Does only test restart when the target is running.
+ * The other tests do restarts when stopped multiple times already.
+ */
+static void test_restart(void)
+{
+	struct cpu *cpu =3D smp_cpu_from_addr(1);
+	struct lowcore *lc =3D cpu->lowcore;
+
+	lc->restart_new_psw.mask =3D extract_psw_mask();
+	lc->restart_new_psw.addr =3D (unsigned long)test_func;
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
@@ -305,6 +333,7 @@ int main(void)
 	smp_cpu_stop(1);
=20
 	test_start();
+	test_restart();
 	test_stop();
 	test_stop_store_status();
 	test_store_status();
--=20
2.25.3
