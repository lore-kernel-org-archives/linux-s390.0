Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbgERQHm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 May 2020 12:07:42 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v7 08/12] s390x: css: stsch, enumeration test
Date: Mon, 18 May 2020 18:07:27 +0200
Message-Id: <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

First step for testing the channel subsystem is to enumerate the css and
retrieve the css devices.

This tests the success of STSCH I/O instruction, we do not test the
reaction of the VM for an instruction with wrong parameters.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/Makefile      |  1 +
 s390x/css.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  4 ++
 3 files changed, 94 insertions(+)
 create mode 100644 s390x/css.c

diff --git a/s390x/Makefile b/s390x/Makefile
index 050c40b..baebf18 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -17,6 +17,7 @@ tests += $(TEST_DIR)/stsi.elf
 tests += $(TEST_DIR)/skrf.elf
 tests += $(TEST_DIR)/smp.elf
 tests += $(TEST_DIR)/sclp.elf
+tests += $(TEST_DIR)/css.elf
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 
 all: directories test_cases test_cases_binary
diff --git a/s390x/css.c b/s390x/css.c
new file mode 100644
index 0000000..d7989d8
--- /dev/null
+++ b/s390x/css.c
@@ -0,0 +1,89 @@
+/*
+ * Channel Subsystem tests
+ *
+ * Copyright (c) 2020 IBM Corp
+ *
+ * Authors:
+ *  Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ */
+
+#include <libcflat.h>
+#include <alloc_phys.h>
+#include <asm/page.h>
+#include <string.h>
+#include <interrupt.h>
+#include <asm/arch_def.h>
+
+#include <css.h>
+
+static struct schib schib;
+static int test_device_sid;
+
+static void test_enumerate(void)
+{
+	struct pmcw *pmcw = &schib.pmcw;
+	int cc;
+	int scn;
+	int scn_found = 0;
+	int dev_found = 0;
+
+	for (scn = 0; scn < 0xffff; scn++) {
+		cc = stsch(scn|SID_ONE, &schib);
+		switch (cc) {
+		case 0:		/* 0 means SCHIB stored */
+			break;
+		case 3:		/* 3 means no more channels */
+			goto out;
+		default:	/* 1 or 2 should never happened for STSCH */
+			report(0, "Unexpected cc=%d on subchannel number 0x%x",
+			       cc, scn);
+			return;
+		}
+
+		/* We currently only support type 0, a.k.a. I/O channels */
+		if (PMCW_CHANNEL_TYPE(pmcw) != 0)
+			continue;
+
+		/* We ignore I/O channels without valid devices */
+		scn_found++;
+		if (!(pmcw->flags & PMCW_DNV))
+			continue;
+
+		/* We keep track of the first device as our test device */
+		if (!test_device_sid)
+			test_device_sid = scn | SID_ONE;
+
+		dev_found++;
+	}
+
+out:
+	report(dev_found,
+	       "Tested subchannels: %d, I/O subchannels: %d, I/O devices: %d",
+	       scn, scn_found, dev_found);
+}
+
+static struct {
+	const char *name;
+	void (*func)(void);
+} tests[] = {
+	{ "enumerate (stsch)", test_enumerate },
+	{ NULL, NULL }
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	report_prefix_push("Channel Subsystem");
+	for (i = 0; tests[i].name; i++) {
+		report_prefix_push(tests[i].name);
+		tests[i].func();
+		report_prefix_pop();
+	}
+	report_prefix_pop();
+
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 07013b2..a436ec0 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -83,3 +83,7 @@ extra_params = -m 1G
 [sclp-3g]
 file = sclp.elf
 extra_params = -m 3G
+
+[css]
+file = css.elf
+extra_params =-device ccw-pong
-- 
2.25.1
