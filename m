Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbfK1MqT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 07:46:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASCh9Se024607
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wje2hgyam-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 12:46:15 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 6/9] s390x: css: stsch, enumeration test
Date: Thu, 28 Nov 2019 13:46:04 +0100
In-Reply-To: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1574945167-29677-7-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

First step by testing the channel subsystem is to enumerate the css and
retrieve the css devices.

This test the success of STSCH I/O instruction.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/Makefile      |  4 ++-
 s390x/css.c         | 86 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  4 +++
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 s390x/css.c

diff --git a/s390x/Makefile b/s390x/Makefile
index e9da618..167ba05 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -1,4 +1,4 @@
-tests = $(TEST_DIR)/selftest.elf
+#tests = $(TEST_DIR)/selftest.elf
 tests += $(TEST_DIR)/intercept.elf
 tests += $(TEST_DIR)/emulator.elf
 tests += $(TEST_DIR)/sieve.elf
@@ -19,6 +19,7 @@ tests += $(TEST_DIR)/smp.elf
 tests += $(TEST_DIR)/uv-guest.elf
 tests += $(TEST_DIR)/uv-host.elf
 tests += $(TEST_DIR)/uv-limit.elf
+tests += $(TEST_DIR)/css.elf
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 tests_img = $(patsubst %.elf,%.img,$(tests))
 
@@ -56,6 +57,7 @@ cflatobjs += lib/s390x/sclp-console.o
 cflatobjs += lib/s390x/interrupt.o
 cflatobjs += lib/s390x/mmu.o
 cflatobjs += lib/s390x/smp.o
+cflatobjs += lib/s390x/css_dump.o
 
 OBJDIRS += lib/s390x
 
diff --git a/s390x/css.c b/s390x/css.c
new file mode 100644
index 0000000..8186f55
--- /dev/null
+++ b/s390x/css.c
@@ -0,0 +1,86 @@
+/*
+ * Channel Sub-System tests
+ *
+ * Copyright (c) 2019 IBM Corp
+ *
+ * Authors:
+ *  Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ */
+
+#include <libcflat.h>
+
+#include <css.h>
+
+#define SID_ONE		0x00010000
+
+static struct schib schib;
+
+static const char *Channel_type[3] = {
+	"I/O", "CHSC", "MSG"
+};
+
+static int test_device_sid;
+
+static void test_enumerate(void)
+{
+	struct pmcw *pmcw = &schib.pmcw;
+	int sid;
+	int ret, i;
+	int found = 0;
+
+	for (sid = 0; sid < 0xffff; sid++) {
+		ret = stsch(sid|SID_ONE, &schib);
+		if (!ret && (pmcw->flags & PMCW_DNV)) {
+			report_info("SID %04x Type %s PIM %x", sid,
+				     Channel_type[pmcw->st], pmcw->pim);
+			for (i = 0; i < 8; i++)  {
+				if ((pmcw->pim << i) & 0x80) {
+					report_info("CHPID[%d]: %02x", i,
+						    pmcw->chpid[i]);
+					break;
+				}
+			}
+			found++;
+	
+		}
+		if (found && !test_device_sid)
+			test_device_sid = sid|SID_ONE;
+	}
+	if (!found) {
+		report("Found %d devices", 0, found);
+		return;
+	}
+	ret = stsch(test_device_sid, &schib);
+	if (ret) {
+		report("Err %d on stsch on sid %08x", 0, ret, test_device_sid);
+		return;
+	}
+	report("Tested", 1);
+	return;
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
+	report_prefix_push("Channel Sub-System");
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
index ff4c088..efdf954 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -78,3 +78,7 @@ extra_params =-smp 2
 
 [uv-guest]
 file = uv-guest.elf
+
+[css]
+file = css.elf
+extra_params =-device ccw-pong
-- 
2.17.0
