Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728347AbgERQHo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 May 2020 12:07:44 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v7 12/12] s390x: css: ping pong
Date: Mon, 18 May 2020 18:07:31 +0200
Message-Id: <1589818051-20549-13-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
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
 s390x/css.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index c94a916..da80574 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -21,6 +21,12 @@
 #include <css.h>
 
 #define PONG_CU_TYPE		0xc0ca
+/* Channel Commands for PONG device */
+#define PONG_WRITE	0x21 /* Write */
+#define PONG_READ	0x22 /* Read buffer */
+
+#define BUFSZ	9
+static char buffer[BUFSZ];
 
 struct lowcore *lowcore = (void *)0x0;
 
@@ -274,6 +280,53 @@ unreg_cb:
 	unregister_io_int_func(irq_io);
 }
 
+static void test_ping(void)
+{
+	int success, result;
+	int cnt = 0, max = 4;
+
+	if (senseid.cu_type != PONG_CU) {
+		report_skip("Device is not a pong device.");
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
+		success = start_subchannel(PONG_WRITE, buffer, BUFSZ, 0);
+		if (!success) {
+			report(0, "start_subchannel failed");
+			goto unreg_cb;
+		}
+
+		wait_for_interrupt(PSW_MASK_IO);
+
+		success = start_subchannel(PONG_READ, buffer, BUFSZ, 0);
+		if (!success) {
+			report(0, "start_subchannel failed");
+			goto unreg_cb;
+		}
+
+		wait_for_interrupt(PSW_MASK_IO);
+
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
@@ -281,6 +334,7 @@ static struct {
 	{ "enumerate (stsch)", test_enumerate },
 	{ "enable (msch)", test_enable },
 	{ "sense (ssch/tsch)", test_sense },
+	{ "ping-pong (ssch/tsch)", test_ping },
 	{ NULL, NULL }
 };
 
-- 
2.25.1
