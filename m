Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfHUKs1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 06:48:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LAmHTf003856
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 06:48:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uh35abmpe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 06:48:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 21 Aug 2019 11:48:21 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 4/4] s390x: STSI tests
Date: Wed, 21 Aug 2019 12:47:36 +0200
In-Reply-To: <20190821104736.1470-1-frankja@linux.ibm.com>
References: <20190821104736.1470-1-frankja@linux.ibm.com>
Message-Id: <20190821104736.1470-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

For now let's concentrate on the error conditions.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/Makefile      |  1 +
 s390x/stsi.c        | 84 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  3 ++
 3 files changed, 88 insertions(+)
 create mode 100644 s390x/stsi.c

diff --git a/s390x/Makefile b/s390x/Makefile
index 3453373..76db0bb 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -13,6 +13,7 @@ tests += $(TEST_DIR)/gs.elf
 tests += $(TEST_DIR)/iep.elf
 tests += $(TEST_DIR)/cpumodel.elf
 tests += $(TEST_DIR)/diag288.elf
+tests += $(TEST_DIR)/stsi.elf
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 
 all: directories test_cases test_cases_binary
diff --git a/s390x/stsi.c b/s390x/stsi.c
new file mode 100644
index 0000000..0f90c9a
--- /dev/null
+++ b/s390x/stsi.c
@@ -0,0 +1,84 @@
+/*
+ * Store System Information tests
+ *
+ * Copyright (c) 2019 IBM Corp
+ *
+ * Authors:
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Library General Public License version 2.
+ */
+
+#include <libcflat.h>
+#include <asm/page.h>
+#include <asm/asm-offsets.h>
+#include <asm/interrupt.h>
+
+static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
+
+static void test_specs(void)
+{
+	report_prefix_push("specification");
+
+	report_prefix_push("inv r0");
+	expect_pgm_int();
+	stsi(pagebuf, 0, 1 << 8, 0);
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_push("inv r1");
+	expect_pgm_int();
+	stsi(pagebuf, 1, 0, 1 << 16);
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_push("unaligned");
+	expect_pgm_int();
+	stsi(pagebuf + 42, 1, 0, 0);
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_pop();
+}
+
+static void test_priv(void)
+{
+	report_prefix_push("privileged");
+	expect_pgm_int();
+	enter_pstate();
+	stsi(pagebuf, 0, 0, 0);
+	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
+	report_prefix_pop();
+}
+
+static inline unsigned long stsi_get_fc(void *addr)
+{
+	register unsigned long r0 asm("0") = 0;
+	register unsigned long r1 asm("1") = 0;
+	int cc;
+
+	asm volatile("stsi	0(%2)\n"
+		     "ipm	%[cc]\n"
+		     "srl	%[cc],28\n"
+		     : "+d" (r0), [cc] "=d" (cc)
+		     : "d" (r1), "a" (addr)
+		     : "cc", "memory");
+	assert(!cc);
+	return r0 >> 28;
+}
+
+static void test_fc(void)
+{
+	report("cc == 3",  stsi(pagebuf, 7, 0, 0) == 3);
+	report("r0 == 3",  stsi_get_fc(pagebuf) >= 2);
+}
+
+int main(void)
+{
+	report_prefix_push("stsi");
+	test_priv();
+	test_specs();
+	test_fc();
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 9dd288a..cc79a4e 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -68,3 +68,6 @@ file = cpumodel.elf
 [diag288]
 file = diag288.elf
 extra_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
+
+[stsi]
+file = stsi.elf
-- 
2.17.0
