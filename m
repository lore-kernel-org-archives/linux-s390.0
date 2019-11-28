Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbfK1MqU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 07:46:20 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASCgwDT058356
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxrk0st-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 12:46:16 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 9/9] s390x: css: ping pong
Date: Thu, 28 Nov 2019 13:46:07 +0100
In-Reply-To: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1574945167-29677-10-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

To test a write command with the SSCH instruction we need a QEMU device,
with control unit type 0xC0CA. The PONG device is such a device.

This type of device respond to PONG_WRITE requests by incrementing an
integer, stored as a string at offset 0 of the CCW data.

This is only a success test, no error expected.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/css.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/s390x/css.c b/s390x/css.c
index 534864f..0761e70 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -23,6 +23,10 @@
 #define SID_ONE		0x00010000
 #define PSW_PRG_MASK (PSW_MASK_IO | PSW_MASK_EA | PSW_MASK_BA)
 
+/* Local Channel Commands */
+#define PONG_WRITE	0x21 /* Write */
+#define PONG_READ	0x22 /* Read buffer */
+
 struct lowcore *lowcore = (void *)0x0;
 
 static struct schib schib;
@@ -31,7 +35,8 @@ static struct ccw ccw[NB_CCW];
 #define NB_ORB  100
 static struct orb orb[NB_ORB];
 static struct irb irb;
-static char buffer[0x1000] __attribute__ ((aligned(8)));
+#define BUF_SZ	0x1000
+static char buffer[BUF_SZ] __attribute__ ((aligned(8)));
 static struct senseid senseid;
 
 static const char *Channel_type[3] = {
@@ -224,6 +229,44 @@ static void test_sense(void)
 		report("cu_type: expect c0ca, got %04x", 0, senseid.cu_type);
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
+	enable_io_irq();
+
+	while (cnt++ < max) {
+report_info("cnt..: %08x", cnt);
+		snprintf(buffer, BUF_SZ, "%08x\n", cnt);
+		success = start_subchannel(PONG_WRITE, buffer, 8);
+		if (!success) {
+			report("start_subchannel failed", 0);
+			return;
+		}
+		delay(100);
+		success = start_subchannel(PONG_READ, buffer, 8);
+		if (!success) {
+			report("start_subchannel failed", 0);
+			return;
+		}
+		result = atol(buffer);
+		if (result != (cnt + 1)) {
+			report("Bad answer from pong: %08x - %08x", 0, cnt, result);
+			return;
+		} else 
+			report_info("%08x - %08x", cnt, result);
+
+		delay(100);
+	}
+	report("ping-pong count 0x%08x", 1, cnt);
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
@@ -231,6 +274,7 @@ static struct {
 	{ "enumerate (stsch)", test_enumerate },
 	{ "enable (msch)", test_enable },
 	{ "sense (ssch/tsch)", test_sense },
+	{ "ping-pong (ssch/tsch)", test_ping },
 	{ NULL, NULL }
 };
 
-- 
2.17.0
