Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgDXKqD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:46:03 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v6 07/10] s390x: css: msch, enable test
Date: Fri, 24 Apr 2020 12:45:49 +0200
Message-Id: <1587725152-25569-8-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
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
 s390x/css.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index cc97e79..fa068bf 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -68,11 +68,59 @@ out:
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
2.25.1
