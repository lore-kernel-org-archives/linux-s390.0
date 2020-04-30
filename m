Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgD3PZF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 11:25:05 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 10/17] s390x: smp: Dirty fpc before initial reset test
Date: Thu, 30 Apr 2020 17:24:23 +0200
Message-Id: <20200430152430.40349-11-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Let's dirty the fpc, before we test if the initial reset sets it to 0.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200429143518.1360468-3-frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 08fa770..bf082d1 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -198,6 +198,7 @@ static void test_sense_running(void)
 /* Used to dirty registers of cpu #1 before it is reset */
 static void test_func_initial(void)
 {
+	asm volatile("sfpc %0" :: "d" (0x11));
 	lctlg(1, 0x42000UL);
 	lctlg(7, 0x43000UL);
 	lctlg(13, 0x44000UL);
--=20
2.25.3
