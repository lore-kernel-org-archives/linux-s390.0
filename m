Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgD3PZE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 11:25:04 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 11/17] s390x: smp: Test stop and store status on a running and stopped cpu
Date: Thu, 30 Apr 2020 17:24:24 +0200
Message-Id: <20200430152430.40349-12-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Let's also test the stop portion of the "stop and store status" sigp
order.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200429143518.1360468-4-frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index bf082d1..57eacb2 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -76,6 +76,18 @@ static void test_stop_store_status(void)
 	struct lowcore *lc =3D (void *)0x0;
=20
 	report_prefix_push("stop store status");
+	report_prefix_push("running");
+	smp_cpu_restart(1);
+	lc->prefix_sa =3D 0;
+	lc->grs_sa[15] =3D 0;
+	smp_cpu_stop_store_status(1);
+	mb();
+	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "prefix"=
);
+	report(lc->grs_sa[15], "stack");
+	report(smp_cpu_stopped(1), "cpu stopped");
+	report_prefix_pop();
+
+	report_prefix_push("stopped");
 	lc->prefix_sa =3D 0;
 	lc->grs_sa[15] =3D 0;
 	smp_cpu_stop_store_status(1);
@@ -83,6 +95,8 @@ static void test_stop_store_status(void)
 	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "prefix"=
);
 	report(lc->grs_sa[15], "stack");
 	report_prefix_pop();
+
+	report_prefix_pop();
 }
=20
 static void test_store_status(void)
--=20
2.25.3
