Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727812AbgD3PZL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:25:11 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 14/17] s390x: smp: Remove unneeded cpu loops
Date: Thu, 30 Apr 2020 17:24:27 +0200
Message-Id: <20200430152430.40349-15-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Now that we have a loop which is executed after we return from the
main function of a secondary cpu, we can remove the surplus loops.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200429143518.1360468-7-frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index 447b998..f2319c4 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -35,15 +35,9 @@ static void set_flag(int val)
 	mb();
 }
=20
-static void cpu_loop(void)
-{
-	for (;;) {}
-}
-
 static void test_func(void)
 {
 	set_flag(1);
-	cpu_loop();
 }
=20
 static void test_start(void)
@@ -306,7 +300,7 @@ int main(void)
=20
 	/* Setting up the cpu to give it a stack and lowcore */
 	psw.mask =3D extract_psw_mask();
-	psw.addr =3D (unsigned long)cpu_loop;
+	psw.addr =3D (unsigned long)test_func;
 	smp_cpu_setup(1, psw);
 	smp_cpu_stop(1);
=20
--=20
2.25.3
