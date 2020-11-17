Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgKQPnA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:43:00 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 1/5] s390x: Add test_bit to library
Date: Tue, 17 Nov 2020 10:42:11 -0500
Message-Id: <20201117154215.45855-2-frankja@linux.ibm.com>
In-Reply-To: <20201117154215.45855-1-frankja@linux.ibm.com>
References: <20201117154215.45855-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

Query/feature bits are commonly tested via MSB bit numbers on
s390. Let's add test bit functions, so we don't need to copy code to
test query bits.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/bitops.h   | 16 ++++++++++++++++
 lib/s390x/asm/facility.h |  3 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/asm/bitops.h b/lib/s390x/asm/bitops.h
index e7cdda9..a272dd7 100644
--- a/lib/s390x/asm/bitops.h
+++ b/lib/s390x/asm/bitops.h
@@ -7,4 +7,20 @@
 
 #define BITS_PER_LONG	64
 
+static inline bool test_bit(unsigned long nr,
+			    const volatile unsigned long *ptr)
+{
+	const volatile unsigned char *addr;
+
+	addr = ((const volatile unsigned char *)ptr);
+	addr += (nr ^ (BITS_PER_LONG - 8)) >> 3;
+	return (*addr >> (nr & 7)) & 1;
+}
+
+static inline bool test_bit_inv(unsigned long nr,
+				const volatile unsigned long *ptr)
+{
+	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
+}
+
 #endif
diff --git a/lib/s390x/asm/facility.h b/lib/s390x/asm/facility.h
index def2705..5593c2d 100644
--- a/lib/s390x/asm/facility.h
+++ b/lib/s390x/asm/facility.h
@@ -13,13 +13,14 @@
 #include <libcflat.h>
 #include <asm/facility.h>
 #include <asm/arch_def.h>
+#include <bitops.h>
 
 #define NB_STFL_DOUBLEWORDS 32
 extern uint64_t stfl_doublewords[];
 
 static inline bool test_facility(int nr)
 {
-	return stfl_doublewords[nr / 64] & (0x8000000000000000UL >> (nr % 64));
+	return test_bit_inv(nr, stfl_doublewords);
 }
 
 static inline void stfl(void)
-- 
2.25.1
