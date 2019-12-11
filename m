Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388738AbfLKPqT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 10:46:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBFhPCn085246
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 10:46:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtdp4hw5g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 10:46:17 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 11 Dec 2019 15:46:15 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 4/9] s390x: export the clock get_clock_ms() utility
Date: Wed, 11 Dec 2019 16:46:05 +0100
In-Reply-To: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1576079170-7244-5-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

To serve multiple times, the function get_clock_ms() is moved
from intercept.c test to the new file asm/time.h.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/time.h | 26 ++++++++++++++++++++++++++
 s390x/intercept.c    | 11 +----------
 2 files changed, 27 insertions(+), 10 deletions(-)
 create mode 100644 lib/s390x/asm/time.h

diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
new file mode 100644
index 0000000..25c7a3c
--- /dev/null
+++ b/lib/s390x/asm/time.h
@@ -0,0 +1,26 @@
+/*
+ * Clock utilities for s390
+ *
+ * Authors:
+ *  Thomas Huth <thuth@redhat.com>
+ *
+ * Copied from the s390/intercept test by:
+ *  Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ */
+#ifndef _ASM_S390X_TIME_H_
+#define _ASM_S390X_TIME_H_
+
+static inline uint64_t get_clock_ms(void)
+{
+	uint64_t clk;
+
+	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
+
+	/* Bit 51 is incrememented each microsecond */
+	return (clk >> (63 - 51)) / 1000;
+}
+
+#endif
diff --git a/s390x/intercept.c b/s390x/intercept.c
index 3696e33..80e9606 100644
--- a/s390x/intercept.c
+++ b/s390x/intercept.c
@@ -13,6 +13,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/interrupt.h>
 #include <asm/page.h>
+#include <asm/time.h>
 
 static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
 
@@ -159,16 +160,6 @@ static void test_testblock(void)
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
-static uint64_t get_clock_ms(void)
-{
-	uint64_t clk;
-
-	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
-
-	/* Bit 51 is incrememented each microsecond */
-	return (clk >> (63 - 51)) / 1000;
-}
-
 struct {
 	const char *name;
 	void (*func)(void);
-- 
2.17.0
