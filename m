Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727079AbgD3PZH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:25:07 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 13/17] s390x: smp: Loop if secondary cpu returns into cpu setup again
Date: Thu, 30 Apr 2020 17:24:26 +0200
Message-Id: <20200430152430.40349-14-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Up to now a secondary cpu could have returned from the function it was
executing and ending up somewhere in cstart64.S. This was mostly
circumvented by an endless loop in the function that it executed.

Let's add a loop to the end of the cpu setup, so we don't have to rely
on added loops in the tests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200429143518.1360468-6-frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/cstart64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 9af6bb3..ecffbe0 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -161,7 +161,9 @@ smp_cpu_setup_state:
 	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
 	/* We should only go once through cpu setup and not for every restart *=
/
 	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
-	br	%r14
+	brasl	%r14, %r14
+	/* If the function returns, just loop here */
+0:	j	0
=20
 pgm_int:
 	SAVE_REGS
--=20
2.25.3
