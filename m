Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfLFQ0m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Dec 2019 11:26:42 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6GEIVB048254
        for <linux-s390@vger.kernel.org>; Fri, 6 Dec 2019 11:26:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq905s8a0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Dec 2019 11:26:40 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 6 Dec 2019 16:26:38 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 9/9] s390x: css: ping pong
Date: Fri,  6 Dec 2019 17:26:28 +0100
In-Reply-To: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1575649588-6127-10-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

To test a write command with the SSCH instruction we need a QEMU device,
with control unit type 0xC0CA. The PONG device is such a device.

This type of device responds to PONG_WRITE requests by incrementing an
integer, stored as a string at offset 0 of the CCW data.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/css.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index 54a7b38..3b5ce9d 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -23,6 +23,10 @@
 #define SID_ONE		0x00010000
 #define PSW_PRG_MASK (PSW_MASK_IO | PSW_MASK_EA | PSW_MASK_BA)
 
+/* Channel Commands for PONG device */
+#define PONG_WRITE	0x21 /* Write */
+#define PONG_READ	0x22 /* Read buffer */
+
 struct lowcore *lowcore = (void *)0x0;
 
 static struct schib schib;
@@ -259,6 +263,51 @@ unreg_cb:
 	unregister_io_int_func(irq_io);
 }
 
+static void test_ping(void)
+{
+	int success, result;
+	int cnt = 0, max = 4;
+
+	if (senseid.cu_type != PONG_CU) {
+		report_skip("No PONG, no ping-pong");
+		return;
+	}
+
+	result = register_io_int_func(irq_io);
+	if (result) {
+		report("Could not register IRQ handler", 0);
+		return;
+	}
+
+	while (cnt++ < max) {
+		snprintf(buffer, BUF_SZ, "%08x\n", cnt);
+		success = start_subchannel(PONG_WRITE, buffer, 8);
+		if (!success) {
+			report("start_subchannel failed", 0);
+			goto unreg_cb;
+		}
+		delay(100);
+		success = start_subchannel(PONG_READ, buffer, 8);
+		if (!success) {
+			report("start_subchannel failed", 0);
+			goto unreg_cb;
+		}
+		result = atol(buffer);
+		if (result != (cnt + 1)) {
+			report("Bad answer from pong: %08x - %08x",
+				0, cnt, result);
+			goto unreg_cb;
+		} else
+			report_info("%08x - %08x", cnt, result);
+
+		delay(100);
+	}
+	report("ping-pong count 0x%08x", 1, cnt);
+
+unreg_cb:
+	unregister_io_int_func(irq_io);
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
@@ -266,6 +315,7 @@ static struct {
 	{ "enumerate (stsch)", test_enumerate },
 	{ "enable (msch)", test_enable },
 	{ "sense (ssch/tsch)", test_sense },
+	{ "ping-pong (ssch/tsch)", test_ping },
 	{ NULL, NULL }
 };
 
-- 
2.17.0
