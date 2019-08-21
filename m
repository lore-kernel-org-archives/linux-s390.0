Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbfHUKs1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 06:48:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LAmIMj003937
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 06:48:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uh35abmpn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 06:48:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 21 Aug 2019 11:48:21 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 3/4] s390x: Move stsi to library
Date: Wed, 21 Aug 2019 12:47:35 +0200
In-Reply-To: <20190821104736.1470-1-frankja@linux.ibm.com>
References: <20190821104736.1470-1-frankja@linux.ibm.com>
Message-Id: <20190821104736.1470-4-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

It's needed in multiple tests now.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h | 16 ++++++++++++++++
 s390x/skey.c             | 18 ------------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 4bbb428..5f8f45e 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -240,4 +240,20 @@ static inline void enter_pstate(void)
 	load_psw_mask(mask);
 }
 
+static inline int stsi(void *addr, int fc, int sel1, int sel2)
+{
+	register int r0 asm("0") = (fc << 28) | sel1;
+	register int r1 asm("1") = sel2;
+	int cc;
+
+	asm volatile(
+		"stsi	0(%3)\n"
+		"ipm	%[cc]\n"
+		"srl	%[cc],28\n"
+		: "+d" (r0), [cc] "=d" (cc)
+		: "d" (r1), "a" (addr)
+		: "cc", "memory");
+	return cc;
+}
+
 #endif
diff --git a/s390x/skey.c b/s390x/skey.c
index b1e11af..fd4fcc7 100644
--- a/s390x/skey.c
+++ b/s390x/skey.c
@@ -70,24 +70,6 @@ static void test_set(void)
 	       skey.str.acc == ret.str.acc && skey.str.fp == ret.str.fp);
 }
 
-static inline int stsi(void *addr, int fc, int sel1, int sel2)
-{
-	register int r0 asm("0") = (fc << 28) | sel1;
-	register int r1 asm("1") = sel2;
-	int rc = 0;
-
-	asm volatile(
-		"	stsi	0(%3)\n"
-		"	jz	0f\n"
-		"	lhi	%1,-1\n"
-		"0:\n"
-		: "+d" (r0), "+d" (rc)
-		: "d" (r1), "a" (addr)
-		: "cc", "memory");
-
-	return rc;
-}
-
 /* Returns true if we are running under z/VM 6.x */
 static bool check_for_zvm6(void)
 {
-- 
2.17.0
