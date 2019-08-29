Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbfH2MP3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 08:15:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TC7AL9056862
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 08:15:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upcf0512x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 08:15:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 29 Aug 2019 13:15:26 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 5/6] s390x: Prepare for external calls
Date: Thu, 29 Aug 2019 14:14:58 +0200
In-Reply-To: <20190829121459.1708-1-frankja@linux.ibm.com>
References: <20190829121459.1708-1-frankja@linux.ibm.com>
Message-Id: <20190829121459.1708-6-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

With SMP we also get new external interrupts like external call and
emergency call. Let's make them known.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h  |  5 +++++
 lib/s390x/asm/interrupt.h |  3 +++
 lib/s390x/interrupt.c     | 24 ++++++++++++++++++++----
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index d5a7f51..5ece2ce 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -19,6 +19,11 @@ struct psw {
 #define PSW_MASK_DAT			0x0400000000000000UL
 #define PSW_MASK_PSTATE			0x0001000000000000UL
 
+#define CR0_EXTM_SCLP			0X0000000000000200UL
+#define CR0_EXTM_EXTC			0X0000000000004000UL
+#define CR0_EXTM_EMGC			0X0000000000008000UL
+#define CR0_EXTM_MASK			0X000000000001DD40UL
+
 struct lowcore {
 	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
 	uint32_t	ext_int_param;			/* 0x0080 */
diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
index f485e96..4cfade9 100644
--- a/lib/s390x/asm/interrupt.h
+++ b/lib/s390x/asm/interrupt.h
@@ -11,6 +11,8 @@
 #define _ASMS390X_IRQ_H_
 #include <asm/arch_def.h>
 
+#define EXT_IRQ_EMERGENCY_SIG	0x1201
+#define EXT_IRQ_EXTERNAL_CALL	0x1202
 #define EXT_IRQ_SERVICE_SIG	0x2401
 
 void handle_pgm_int(void);
@@ -19,6 +21,7 @@ void handle_mcck_int(void);
 void handle_io_int(void);
 void handle_svc_int(void);
 void expect_pgm_int(void);
+void expect_ext_int(void);
 uint16_t clear_pgm_int(void);
 void check_pgm_int_code(uint16_t code);
 
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 7832711..d4f279a 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -15,6 +15,7 @@
 #include <sclp.h>
 
 static bool pgm_int_expected;
+static bool ext_int_expected;
 static struct lowcore *lc;
 
 void expect_pgm_int(void)
@@ -24,6 +25,13 @@ void expect_pgm_int(void)
 	mb();
 }
 
+void expect_ext_int(void)
+{
+	ext_int_expected = true;
+	lc->ext_int_code = 0;
+	mb();
+}
+
 uint16_t clear_pgm_int(void)
 {
 	uint16_t code;
@@ -108,15 +116,23 @@ void handle_pgm_int(void)
 
 void handle_ext_int(void)
 {
-	if (lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
+	if (!ext_int_expected &&
+	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
 		report_abort("Unexpected external call interrupt: at %#lx",
 			     lc->ext_old_psw.addr);
-	} else {
-		lc->ext_old_psw.mask &= ~PSW_MASK_EXT;
+		return;
+	}
+
+	if (lc->ext_int_code == EXT_IRQ_SERVICE_SIG) {
 		lc->sw_int_cr0 &= ~(1UL << 9);
 		sclp_handle_ext();
-		lc->ext_int_code = 0;
 	}
+	if (lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
+		ext_int_expected = false;
+	}
+
+	if (!(lc->sw_int_cr0 & CR0_EXTM_MASK))
+		lc->ext_old_psw.mask &= ~PSW_MASK_EXT;
 }
 
 void handle_mcck_int(void)
-- 
2.17.0
