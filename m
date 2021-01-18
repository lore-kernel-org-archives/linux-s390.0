Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392619AbhAROEj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 09:04:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10IE3Roc060525
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:03:59 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3657y36r7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:03:59 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10IE3w9B065622
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:03:58 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: Fix uv_call() exception behavior
Date: Mon, 18 Jan 2021 09:03:44 -0500
Message-Id: <20210118140344.3074-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm390 mailing list <kvm390-list@tuxmaker.boeblingen.de.ibm.com>
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On a program exception we usually skip the instruction that caused the
exception and continue. That won't work for UV calls since a "brc 3,0b"
will retry the instruction if the CC is > 1.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

I know this isn't very pretty.
I'm open for suggestions.

---
 lib/s390x/asm/uv.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 4c2fc48..252f1a3 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -53,21 +53,23 @@ struct uv_cb_share {
 static inline int uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
+	struct lowcore *lc = 0x0;
 
 	/*
-	 * The brc instruction will take care of the cc 2/3 case where
-	 * we need to continue the execution because we were
-	 * interrupted. The inline assembly will only return on
-	 * success/error i.e. cc 0/1.
-	*/
+	 * CC 2 and 3 tell us to re-execute because the instruction
+	 * hasn't yet finished.
+	 */
+	lc->pgm_int_code = 0;
+retry:
 	asm volatile(
 		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
-		"		brc	3,0b\n"
 		"		ipm	%[cc]\n"
 		"		srl	%[cc],28\n"
 		: [cc] "=d" (cc)
 		: [r1] "a" (r1), [r2] "a" (r2)
 		: "memory", "cc");
+	if (!lc->pgm_int_code && cc > 1)
+		goto retry;
 	return cc;
 }
 
-- 
2.25.1
