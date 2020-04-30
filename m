Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59598 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbgD3PZJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 11:25:09 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 12/17] s390x: smp: Test local interrupts after cpu reset
Date: Thu, 30 Apr 2020 17:24:25 +0200
Message-Id: <20200430152430.40349-13-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Local interrupts (external and emergency call) should be cleared after
any cpu reset.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200429143518.1360468-5-frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 57eacb2..447b998 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -258,6 +258,19 @@ static void test_reset_initial(void)
 	report_prefix_pop();
 }
=20
+static void test_local_ints(void)
+{
+	unsigned long mask;
+
+	/* Open masks for ecall and emcall */
+	ctl_set_bit(0, 13);
+	ctl_set_bit(0, 14);
+	mask =3D extract_psw_mask();
+	mask |=3D PSW_MASK_EXT;
+	load_psw_mask(mask);
+	set_flag(1);
+}
+
 static void test_reset(void)
 {
 	struct psw psw;
@@ -266,10 +279,18 @@ static void test_reset(void)
 	psw.addr =3D (unsigned long)test_func;
=20
 	report_prefix_push("cpu reset");
+	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
+	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
 	smp_cpu_start(1, psw);
=20
 	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
 	report(smp_cpu_stopped(1), "cpu stopped");
+
+	set_flag(0);
+	psw.addr =3D (unsigned long)test_local_ints;
+	smp_cpu_start(1, psw);
+	wait_for_flag();
+	report(true, "local interrupts cleared");
 	report_prefix_pop();
 }
=20
--=20
2.25.3
