Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730066AbgK0NJK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 08:09:10 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 1/7] s390x: Add test_bit to library
Date: Fri, 27 Nov 2020 08:06:23 -0500
Message-Id: <20201127130629.120469-2-frankja@linux.ibm.com>
In-Reply-To: <20201127130629.120469-1-frankja@linux.ibm.com>
References: <20201127130629.120469-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Query/feature bits are commonly tested via MSB bit numbers on
s390. Let's add test bit functions, so we don't need to copy code to
test query bits.

The test_bit code has been taken from the kernel since most s390x KVM unit
test developers are used to them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/bitops.h   | 26 ++++++++++++++++++++++++++
 lib/s390x/asm/facility.h |  3 ++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/asm/bitops.h b/lib/s390x/asm/bitops.h
index e7cdda9..792881e 100644
--- a/lib/s390x/asm/bitops.h
+++ b/lib/s390x/asm/bitops.h
@@ -1,3 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *    Bitops taken from the kernel as most developers are already used
+ *    to them.
+ *
+ *    Copyright IBM Corp. 1999,2013
+ *
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *
+ */
 #ifndef _ASMS390X_BITOPS_H_
 #define _ASMS390X_BITOPS_H_
 
@@ -7,4 +17,20 @@
 
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
