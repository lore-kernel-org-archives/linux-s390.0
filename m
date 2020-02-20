Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25188 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728086AbgBTMBe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 07:01:34 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KBvvh0083573
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 07:01:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xeahj8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 07:01:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 20 Feb 2020 12:00:50 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 08/10] s390x: css: msch, enable test
Date: Thu, 20 Feb 2020 13:00:41 +0100
In-Reply-To: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1582200043-21760-9-git-send-email-pmorel@linux.ibm.com>
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

This tests the MSCH instruction to enable a channel succesfuly.
This is NOT a routine to really enable the channel, no retry is done,
in case of error, a report is made.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/css.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index cb33e00..aeee951 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -19,6 +19,7 @@
 #include <asm/time.h>
 
 #include <css.h>
+#include <asm/time.h>
 
 #define SID_ONE		0x00010000
 
@@ -67,11 +68,59 @@ out:
 	       scn, scn_found, dev_found);
 }
 
+static void test_enable(void)
+{
+	struct pmcw *pmcw = &schib.pmcw;
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
+	 */
+	cc = stsch(test_device_sid, &schib);
+	if (cc) {
+		report(0, "stsch cc=%d", cc);
+		return;
+	}
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
