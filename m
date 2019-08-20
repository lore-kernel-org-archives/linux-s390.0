Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729696AbfHTK4O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 06:56:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KAqwpi080519
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 06:56:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugfc7rfqy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 06:56:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 20 Aug 2019 11:56:10 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/3] s390x: Diag288 test
Date: Tue, 20 Aug 2019 12:55:49 +0200
In-Reply-To: <20190820105550.4991-1-frankja@linux.ibm.com>
References: <20190820105550.4991-1-frankja@linux.ibm.com>
Message-Id: <20190820105550.4991-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

A small test for the watchdog via diag288.

Minimum timer value is 15 (seconds) and the only supported action with
QEMU is restart.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/Makefile      |   1 +
 s390x/diag288.c     | 111 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   4 ++
 3 files changed, 116 insertions(+)
 create mode 100644 s390x/diag288.c

diff --git a/s390x/Makefile b/s390x/Makefile
index 1f21ddb..b654c56 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -11,6 +11,7 @@ tests += $(TEST_DIR)/cmm.elf
 tests += $(TEST_DIR)/vector.elf
 tests += $(TEST_DIR)/gs.elf
 tests += $(TEST_DIR)/iep.elf
+tests += $(TEST_DIR)/diag288.elf
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 
 all: directories test_cases test_cases_binary
diff --git a/s390x/diag288.c b/s390x/diag288.c
new file mode 100644
index 0000000..5abcec4
--- /dev/null
+++ b/s390x/diag288.c
@@ -0,0 +1,111 @@
+/*
+ * Timer Event DIAG288 test
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
+#include <asm/asm-offsets.h>
+#include <asm/interrupt.h>
+
+struct lowcore *lc = (void *)0x0;
+
+#define CODE_INIT	0
+#define CODE_CHANGE	1
+#define CODE_CANCEL	2
+
+#define ACTION_RESTART	0
+
+static inline void diag288(unsigned long code, unsigned long time,
+			   unsigned long action)
+{
+	register unsigned long fc asm("0") = code;
+	register unsigned long tm asm("1") = time;
+	register unsigned long ac asm("2") = action;
+
+	asm volatile("diag %0,%2,0x288"
+		     : : "d" (fc), "d" (tm), "d" (ac));
+}
+
+static inline void diag288_uneven(void)
+{
+	register unsigned long fc asm("1") = 0;
+	register unsigned long time asm("1") = 15;
+	register unsigned long action asm("2") = 0;
+
+	asm volatile("diag %0,%2,0x288"
+		     : : "d" (fc), "d" (time), "d" (action));
+}
+
+static void test_specs(void)
+{
+	report_prefix_push("spec ex");
+
+	report_prefix_push("uneven");
+	expect_pgm_int();
+	diag288_uneven();
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_push("unsup act");
+	expect_pgm_int();
+	diag288(CODE_INIT, 15, 42);
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_push("unsup fctn");
+	expect_pgm_int();
+	diag288(42, 15, ACTION_RESTART);
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_push("no init");
+	expect_pgm_int();
+	diag288(CODE_CANCEL, 15, ACTION_RESTART);
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	report_prefix_pop();
+
+	report_prefix_push("min timer");
+	expect_pgm_int();
+	diag288(CODE_INIT, 14, ACTION_RESTART);
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
+	diag288(0, 15, 0);
+	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
+	report_prefix_pop();
+}
+
+static void test_bite(void)
+{
+	if (lc->restart_old_psw.addr) {
+		report("restart", true);
+		return;
+	}
+	lc->restart_new_psw.addr = (uint64_t)test_bite;
+	diag288(CODE_INIT, 15, ACTION_RESTART);
+	while(1) {};
+}
+
+int main(void)
+{
+	report_prefix_push("diag288");
+	test_priv();
+	test_specs();
+	test_bite();
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 546b1f2..ca10f38 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -61,3 +61,7 @@ file = gs.elf
 
 [iep]
 file = iep.elf
+
+[diag288]
+file = diag288.elf
+extra_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
\ No newline at end of file
-- 
2.17.0
