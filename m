Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbfK1MqT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 07:46:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASCguxA010227
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjaegh6ms-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 12:46:16 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 7/9] s390x: css: msch, enable test
Date: Thu, 28 Nov 2019 13:46:05 +0100
In-Reply-To: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1574945167-29677-8-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

A second step when testing the channel subsystem is to prepare a channel
for use.

This tests the success of the MSCH instruction by enabling a channel.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/css.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index 8186f55..e42dc2f 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -62,11 +62,38 @@ static void test_enumerate(void)
 	return;
 }
 
+static void set_schib(void)
+{
+	struct pmcw *p = &schib.pmcw;
+
+	p->intparm = 0xdeadbeef;
+	p->flags |= PMCW_ENABLE;
+}
+
+static void test_enable(void)
+{
+	int ret;
+
+	if (!test_device_sid) {
+		report_skip("No device");
+		return;
+	}
+	set_schib();
+	dump_schib(&schib);
+
+	ret = msch(test_device_sid, &schib);
+	if (ret)
+		report("msch cc=%d", 0, ret);
+	else
+		report("Tested", 1);
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
