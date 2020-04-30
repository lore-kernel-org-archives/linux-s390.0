Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727071AbgD3PYw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:24:52 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 06/17] s390x: STFLE operates on doublewords
Date: Thu, 30 Apr 2020 17:24:19 +0200
Message-Id: <20200430152430.40349-7-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

STFLE operates on doublewords, not bytes. Passing in "256" resulted in
some ignored bits getting set. Not bad, but also not clean.

Let's just convert our stfle handling code to operate on doublewords.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20200401163305.31550-1-david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/s390x/asm/facility.h | 14 +++++++-------
 lib/s390x/io.c           |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/asm/facility.h b/lib/s390x/asm/facility.h
index e34dc2c..def2705 100644
--- a/lib/s390x/asm/facility.h
+++ b/lib/s390x/asm/facility.h
@@ -14,12 +14,12 @@
 #include <asm/facility.h>
 #include <asm/arch_def.h>
=20
-#define NR_STFL_BYTES 256
-extern uint8_t stfl_bytes[];
+#define NB_STFL_DOUBLEWORDS 32
+extern uint64_t stfl_doublewords[];
=20
 static inline bool test_facility(int nr)
 {
-	return stfl_bytes[nr / 8] & (0x80U >> (nr % 8));
+	return stfl_doublewords[nr / 64] & (0x8000000000000000UL >> (nr % 64));
 }
=20
 static inline void stfl(void)
@@ -27,9 +27,9 @@ static inline void stfl(void)
 	asm volatile("	stfl	0(0)\n" : : : "memory");
 }
=20
-static inline void stfle(uint8_t *fac, unsigned int len)
+static inline void stfle(uint64_t *fac, unsigned int nb_doublewords)
 {
-	register unsigned long r0 asm("0") =3D len - 1;
+	register unsigned long r0 asm("0") =3D nb_doublewords - 1;
=20
 	asm volatile("	.insn	s,0xb2b00000,0(%1)\n"
 		     : "+d" (r0) : "a" (fac) : "memory", "cc");
@@ -40,9 +40,9 @@ static inline void setup_facilities(void)
 	struct lowcore *lc =3D NULL;
=20
 	stfl();
-	memcpy(stfl_bytes, &lc->stfl, sizeof(lc->stfl));
+	memcpy(stfl_doublewords, &lc->stfl, sizeof(lc->stfl));
 	if (test_facility(7))
-		stfle(stfl_bytes, NR_STFL_BYTES);
+		stfle(stfl_doublewords, NB_STFL_DOUBLEWORDS);
 }
=20
 #endif
diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index e091c37..c0f0bf7 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -19,7 +19,7 @@
 #include "smp.h"
=20
 extern char ipl_args[];
-uint8_t stfl_bytes[NR_STFL_BYTES] __attribute__((aligned(8)));
+uint64_t stfl_doublewords[NB_STFL_DOUBLEWORDS];
=20
 static struct spinlock lock;
=20
--=20
2.25.3
