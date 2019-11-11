Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbfKKRUf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 12:20:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABHDN3Y027793
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 12:20:34 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7bq00qpq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 12:20:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 11 Nov 2019 17:20:31 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 1/2] s390x: sclp: add service call instruction wrapper
Date: Mon, 11 Nov 2019 18:20:25 +0100
In-Reply-To: <1573492826-24589-1-git-send-email-imbrenda@linux.ibm.com>
References: <1573492826-24589-1-git-send-email-imbrenda@linux.ibm.com>
Message-Id: <1573492826-24589-2-git-send-email-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Add a wrapper for the service call instruction, and use it for SCLP
interactions instead of using inline assembly everywhere.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h | 13 +++++++++++++
 lib/s390x/sclp.c         |  7 +------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 96cca2e..b3caff6 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -269,4 +269,17 @@ static inline int stsi(void *addr, int fc, int sel1, int sel2)
 	return cc;
 }
 
+static inline int servc(uint32_t command, unsigned long sccb)
+{
+	int cc;
+
+	asm volatile(
+		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
+		"       ipm     %0\n"
+		"       srl     %0,28"
+		: "=&d" (cc) : "d" (command), "a" (sccb)
+		: "cc", "memory");
+	return cc;
+}
+
 #endif
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 7798f04..e35c282 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -116,12 +116,7 @@ int sclp_service_call(unsigned int command, void *sccb)
 	int cc;
 
 	sclp_setup_int();
-	asm volatile(
-		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
-		"       ipm     %0\n"
-		"       srl     %0,28"
-		: "=&d" (cc) : "d" (command), "a" (__pa(sccb))
-		: "cc", "memory");
+	cc = servc(command, __pa(sccb));
 	sclp_wait_busy();
 	if (cc == 3)
 		return -1;
-- 
2.7.4
