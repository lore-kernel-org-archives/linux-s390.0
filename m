Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732885AbfLKPqU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 10:46:20 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBFhQU0043092
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 10:46:19 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2fdhc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 10:46:18 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 11 Dec 2019 15:46:17 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 7/9] s390x: css: msch, enable test
Date: Wed, 11 Dec 2019 16:46:08 +0100
In-Reply-To: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1576079170-7244-8-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

A second step when testing the channel subsystem is to prepare a channel
for use.
This includes:
- Get the current SubCHannel Information Block (SCHIB) using STSCH
- Update it in memory to set the ENABLE bit
- Tell the CSS that the SCHIB has been modified using MSCH
- Get the SCHIB from the CSS again to verify that the subchannel is
  enabled.

This tests the success of the MSCH instruction by enabling a channel.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/css.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index dfab35f..b8824ad 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -19,12 +19,24 @@
 #include <asm/time.h>
 
 #include <css.h>
+#include <asm/time.h>
 
 #define SID_ONE		0x00010000
 
 static struct schib schib;
 static int test_device_sid;
 
+static inline void delay(unsigned long ms)
+{
+	unsigned long startclk;
+
+	startclk = get_clock_ms();
+	for (;;) {
+		if (get_clock_ms() - startclk > ms)
+			break;
+	}
+}
+
 static void test_enumerate(void)
 {
 	struct pmcw *pmcw = &schib.pmcw;
@@ -64,11 +76,64 @@ out:
 	report(1, "Devices, tested: %d, I/O type: %d", scn, scn_found);
 }
 
+static void test_enable(void)
+{
+	struct pmcw *pmcw = &schib.pmcw;
+		int count = 0;
+	int cc;
+
+	if (!test_device_sid) {
+		report_skip("No device");
+		return;
+	}
+	/* Read the SCHIB for this subchannel */
+	cc = stsch(test_device_sid, &schib);
+	if (cc) {
+		report(0, "stsch cc=%d", cc);
+		return;
+	}
+
+	/* Update the SCHIB to enable the channel */
+	pmcw->flags |= PMCW_ENABLE;
+
+	/* Tell the CSS we want to modify the subchannel */
+	cc = msch(test_device_sid, &schib);
+	if (cc) {
+		/*
+		 * If the subchannel is status pending or
+		 * if a function is in progress,
+		 * we consider both cases as errors.
+		 */
+		report(0, "msch cc=%d", cc);
+		return;
+	}
+
+	/*
+	 * Read the SCHIB again to verify the enablement
+	 * insert a little delay and try 5 times.
+	 */
+	do {
+		cc = stsch(test_device_sid, &schib);
+		if (cc) {
+			report(0, "stsch cc=%d", cc);
+			return;
+		}
+		delay(10);
+	} while (!(pmcw->flags & PMCW_ENABLE) && count++ < 5);
+
+	if (!(pmcw->flags & PMCW_ENABLE)) {
+		report(0, "Enable failed. pmcw: %x", pmcw->flags);
+		return;
+	}
+	report(1, "Tested");
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
 } tests[] = {
 	{ "enumerate (stsch)", test_enumerate },
+	{ "enable (msch)", test_enable },
 	{ NULL, NULL }
 };
 
-- 
2.17.0
