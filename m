Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388084AbfHVLLT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Aug 2019 07:11:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MBADps071944
        for <linux-s390@vger.kernel.org>; Thu, 22 Aug 2019 07:11:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uhs8nhq4g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 22 Aug 2019 07:11:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 22 Aug 2019 12:11:15 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
Date: Thu, 22 Aug 2019 13:11:00 +0200
In-Reply-To: <20190821104736.1470-1-frankja@linux.ibm.com>
References: <20190821104736.1470-1-frankja@linux.ibm.com>
Message-Id: <20190822111100.4444-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

By adding a load reset routine to cstart.S we can also test the clear
reset done by subcode 0, as we now can restore our registers again.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
I managed to extract this from another bigger test, so let's add it to the bunch.
I'd be very happy about assembly review :-)
---
 s390x/cstart64.S | 27 +++++++++++++++++++++++++++
 s390x/diag308.c  | 31 ++++++++++---------------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index dedfe80..47045e1 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -145,6 +145,33 @@ memsetxc:
 	.endm
 
 .section .text
+/*
+ * load_reset calling convention:
+ * %r2 subcode (0 or 1)
+ */
+.globl load_reset
+load_reset:
+	SAVE_REGS
+	/* Save the first PSW word to the IPL PSW */
+	epsw	%r0, %r1
+	st	%r0, 0
+	/* Store the address and the bit for 31 bit addressing */
+	larl    %r0, 0f
+	oilh    %r0, 0x8000
+	st      %r0, 0x4
+	/* Do the reset */
+	diag    %r0,%r2,0x308
+	/* Failure path */
+	xgr	%r2, %r2
+	br	%r14
+	/* Success path */
+	/* We lost cr0 due to the reset */
+0:	larl	%r1, initial_cr0
+	lctlg	%c0, %c0, 0(%r1)
+	RESTORE_REGS
+	lhi	%r2, 1
+	br	%r14
+
 pgm_int:
 	SAVE_REGS
 	brasl	%r14, handle_pgm_int
diff --git a/s390x/diag308.c b/s390x/diag308.c
index f085b1a..baf9fd3 100644
--- a/s390x/diag308.c
+++ b/s390x/diag308.c
@@ -21,32 +21,20 @@ static void test_priv(void)
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 }
 
+
 /*
- * Check that diag308 with subcode 1 loads the PSW at address 0, i.e.
+ * Check that diag308 with subcode 0 and 1 loads the PSW at address 0, i.e.
  * that we can put a pointer into address 4 which then gets executed.
  */
+extern int load_reset(u64);
+static void test_subcode0(void)
+{
+	report("load modified clear done", load_reset(0));
+}
+
 static void test_subcode1(void)
 {
-	uint64_t saved_psw = *(uint64_t *)0;
-	long subcode = 1;
-	long ret, tmp;
-
-	asm volatile (
-		"	epsw	%0,%1\n"
-		"	st	%0,0\n"
-		"	larl	%0,0f\n"
-		"	oilh	%0,0x8000\n"
-		"	st	%0,4\n"
-		"	diag	0,%2,0x308\n"
-		"	lghi	%0,0\n"
-		"	j	1f\n"
-		"0:	lghi	%0,1\n"
-		"1:"
-		: "=&d"(ret), "=&d"(tmp) : "d"(subcode) : "memory");
-
-	*(uint64_t *)0 = saved_psw;
-
-	report("load normal reset done", ret == 1);
+	report("load normal reset done", load_reset(1));
 }
 
 /* Expect a specification exception when using an uneven register */
@@ -107,6 +95,7 @@ static struct {
 	void (*func)(void);
 } tests[] = {
 	{ "privileged", test_priv },
+	{ "subcode 0", test_subcode0 },
 	{ "subcode 1", test_subcode1 },
 	{ "subcode 5", test_subcode5 },
 	{ "subcode 6", test_subcode6 },
-- 
2.17.0
