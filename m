Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387544AbgAIQQi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 11:16:38 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009GA0KF165849
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 11:16:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe00wrvq0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 11:16:33 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 9 Jan 2020 16:16:30 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v6 3/4] s390x: lib: add SPX and STPX instruction wrapper
Date: Thu,  9 Jan 2020 17:16:24 +0100
In-Reply-To: <20200109161625.154894-1-imbrenda@linux.ibm.com>
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200109161625.154894-4-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
use it instead of using inline assembly everywhere.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h | 10 ++++++++++
 s390x/intercept.c        | 33 +++++++++++++--------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 1a5e3c6..465fe0f 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -284,4 +284,14 @@ static inline int servc(uint32_t command, unsigned long sccb)
 	return cc;
 }
 
+static inline void spx(uint32_t *new_prefix)
+{
+	asm volatile("spx %0" : : "Q" (*new_prefix) : "memory");
+}
+
+static inline void stpx(uint32_t *current_prefix)
+{
+	asm volatile("stpx %0" : "=Q" (*current_prefix));
+}
+
 #endif
diff --git a/s390x/intercept.c b/s390x/intercept.c
index 3696e33..3b53633 100644
--- a/s390x/intercept.c
+++ b/s390x/intercept.c
@@ -26,27 +26,24 @@ static void test_stpx(void)
 	uint32_t new_prefix = (uint32_t)(intptr_t)pagebuf;
 
 	/* Can we successfully change the prefix? */
-	asm volatile (
-		" stpx	%0\n"
-		" spx	%2\n"
-		" stpx	%1\n"
-		" spx	%0\n"
-		: "+Q"(old_prefix), "+Q"(tst_prefix)
-		: "Q"(new_prefix));
+	stpx(&old_prefix);
+	spx(&new_prefix);
+	stpx(&tst_prefix);
+	spx(&old_prefix);
 	report(old_prefix == 0 && tst_prefix == new_prefix, "store prefix");
 
 	expect_pgm_int();
 	low_prot_enable();
-	asm volatile(" stpx 0(%0) " : : "r"(8));
+	stpx((void *)8L);
 	low_prot_disable();
 	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
 
 	expect_pgm_int();
-	asm volatile(" stpx 0(%0) " : : "r"(1));
+	stpx((void *)1L);
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 
 	expect_pgm_int();
-	asm volatile(" stpx 0(%0) " : : "r"(-8L));
+	stpx((void *)-8L);
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
@@ -63,22 +60,18 @@ static void test_spx(void)
 	 * some facility bits there ... at least some of them should be
 	 * set in our buffer afterwards.
 	 */
-	asm volatile (
-		" stpx	%0\n"
-		" spx	%1\n"
-		" stfl	0\n"
-		" spx	%0\n"
-		: "+Q"(old_prefix)
-		: "Q"(new_prefix)
-		: "memory");
+	stpx(&old_prefix);
+	spx(&new_prefix);
+	asm volatile (" stfl 0" : : : "memory");
+	spx(&old_prefix);
 	report(pagebuf[GEN_LC_STFL] != 0, "stfl to new prefix");
 
 	expect_pgm_int();
-	asm volatile(" spx 0(%0) " : : "r"(1));
+	spx((void *)1L);
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 
 	expect_pgm_int();
-	asm volatile(" spx 0(%0) " : : "r"(-8L));
+	spx((void *)-8L);
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
-- 
2.24.1
