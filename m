Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728478AbgAJSlA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 13:41:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AIbKTC074689
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 13:40:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe6ywvaps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 13:40:58 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 10 Jan 2020 18:40:56 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v7 3/4] s390x: lib: add SPX and STPX instruction wrapper
Date: Fri, 10 Jan 2020 19:40:49 +0100
In-Reply-To: <20200110184050.191506-1-imbrenda@linux.ibm.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200110184050.191506-4-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
use it instead of using inline assembly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/arch_def.h | 13 +++++++++++++
 s390x/intercept.c        | 23 ++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 1a5e3c6..15a4d49 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -284,4 +284,17 @@ static inline int servc(uint32_t command, unsigned long sccb)
 	return cc;
 }
 
+static inline void set_prefix(uint32_t new_prefix)
+{
+	asm volatile("	spx %0" : : "Q" (new_prefix) : "memory");
+}
+
+static inline uint32_t get_prefix(void)
+{
+	uint32_t current_prefix;
+
+	asm volatile("	stpx %0" : "=Q" (current_prefix));
+	return current_prefix;
+}
+
 #endif
diff --git a/s390x/intercept.c b/s390x/intercept.c
index 3696e33..cd96121 100644
--- a/s390x/intercept.c
+++ b/s390x/intercept.c
@@ -26,13 +26,10 @@ static void test_stpx(void)
 	uint32_t new_prefix = (uint32_t)(intptr_t)pagebuf;
 
 	/* Can we successfully change the prefix? */
-	asm volatile (
-		" stpx	%0\n"
-		" spx	%2\n"
-		" stpx	%1\n"
-		" spx	%0\n"
-		: "+Q"(old_prefix), "+Q"(tst_prefix)
-		: "Q"(new_prefix));
+	old_prefix = get_prefix();
+	set_prefix(new_prefix);
+	tst_prefix = get_prefix();
+	set_prefix(old_prefix);
 	report(old_prefix == 0 && tst_prefix == new_prefix, "store prefix");
 
 	expect_pgm_int();
@@ -63,14 +60,10 @@ static void test_spx(void)
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
+	old_prefix = get_prefix();
+	set_prefix(new_prefix);
+	asm volatile("	stfl 0" : : : "memory");
+	set_prefix(old_prefix);
 	report(pagebuf[GEN_LC_STFL] != 0, "stfl to new prefix");
 
 	expect_pgm_int();
-- 
2.24.1
