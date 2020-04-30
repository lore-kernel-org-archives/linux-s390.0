Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbgD3PYt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 11:24:49 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 05/17] s390x/smp: fix detection of "running"
Date: Thu, 30 Apr 2020 17:24:18 +0200
Message-Id: <20200430152430.40349-6-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

On s390x hosts with a single CPU, the smp test case hangs (loops).
The check if our restart has finished is wrong.
Sigp sense running status checks if the CPU is currently backed by a
real CPU. This means that on single CPU hosts a sigp sense running
will never claim that a target is running. We need to check for not
being stopped instead.

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200330084911.34248-2-borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/s390x/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 3f86243..203792a 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -128,7 +128,7 @@ static int smp_cpu_restart_nolock(uint16_t addr, stru=
ct psw *psw)
 	 * The order has been accepted, but the actual restart may not
 	 * have been performed yet, so wait until the cpu is running.
 	 */
-	while (!smp_cpu_running(addr))
+	while (smp_cpu_stopped(addr))
 		mb();
 	cpu->active =3D true;
 	return 0;
--=20
2.25.3
