Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728049AbgBTMB5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 07:01:57 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KC1Pjx061336
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 07:01:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8xdpqaqh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 07:01:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 20 Feb 2020 12:00:52 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 10/10] s390x: css: ping pong
Date: Thu, 20 Feb 2020 13:00:43 +0100
In-Reply-To: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1582200043-21760-11-git-send-email-pmorel@linux.ibm.com>
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
 s390x/css.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index b9805a9..c1616d4 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -25,6 +25,12 @@
 #define PSW_PRG_MASK (PSW_MASK_IO | PSW_MASK_EA | PSW_MASK_BA)
 
 #define PONG_CU_TYPE		0xc0ca
+/* Channel Commands for PONG device */
+#define PONG_WRITE	0x21 /* Write */
+#define PONG_READ	0x22 /* Read buffer */
+
+#define BUFSZ	9
+static char buffer[BUFSZ];
 
 struct lowcore *lowcore = (void *)0x0;
 
@@ -266,6 +272,48 @@ unreg_cb:
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
+		report(0, "Could not register IRQ handler");
+		return;
+	}
+
+	while (cnt++ < max) {
+		snprintf(buffer, BUFSZ, "%08x\n", cnt);
+		success = start_subchannel(PONG_WRITE, buffer, BUFSZ);
+		if (!success) {
+			report(0, "start_subchannel failed");
+			goto unreg_cb;
+		}
+		delay(100);
+		success = start_subchannel(PONG_READ, buffer, BUFSZ);
+		if (!success) {
+			report(0, "start_subchannel failed");
+			goto unreg_cb;
+		}
+		result = atol(buffer);
+		if (result != (cnt + 1)) {
+			report(0, "Bad answer from pong: %08x - %08x",
+			       cnt, result);
+			goto unreg_cb;
+		}
+	}
+	report(1, "ping-pong count 0x%08x", cnt);
+
+unreg_cb:
+	unregister_io_int_func(irq_io);
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
@@ -273,6 +321,7 @@ static struct {
 	{ "enumerate (stsch)", test_enumerate },
 	{ "enable (msch)", test_enable },
 	{ "sense (ssch/tsch)", test_sense },
+	{ "ping-pong (ssch/tsch)", test_ping },
 	{ NULL, NULL }
 };
 
-- 
2.17.0
