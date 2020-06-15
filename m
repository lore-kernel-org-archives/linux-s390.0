Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45266 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729352AbgFOJcS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 05:32:18 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v9 01/12] s390x: Use PSW bits definitions in cstart
Date: Mon, 15 Jun 2020 11:31:50 +0200
Message-Id: <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This patch defines the PSW bits EA/BA used to initialize the PSW masks
for exceptions.

Since some PSW mask definitions exist already in arch_def.h we add these
definitions there.
We move all PSW definitions together and protect assembler code against
C syntax.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h | 15 +++++++++++----
 s390x/cstart64.S         | 15 ++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 1b3bb0c..b5d7aca 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -10,15 +10,21 @@
 #ifndef _ASM_S390X_ARCH_DEF_H_
 #define _ASM_S390X_ARCH_DEF_H_
 
+#define PSW_MASK_EXT			0x0100000000000000UL
+#define PSW_MASK_DAT			0x0400000000000000UL
+#define PSW_MASK_SHORT_PSW		0x0008000000000000UL
+#define PSW_MASK_PSTATE			0x0001000000000000UL
+#define PSW_MASK_BA			0x0000000080000000UL
+#define PSW_MASK_EA			0x0000000100000000UL
+
+#define PSW_MASK_ON_EXCEPTION	(PSW_MASK_EA | PSW_MASK_BA)
+
+#ifndef __ASSEMBLER__
 struct psw {
 	uint64_t	mask;
 	uint64_t	addr;
 };
 
-#define PSW_MASK_EXT			0x0100000000000000UL
-#define PSW_MASK_DAT			0x0400000000000000UL
-#define PSW_MASK_PSTATE			0x0001000000000000UL
-
 #define CR0_EXTM_SCLP			0x0000000000000200UL
 #define CR0_EXTM_EXTC			0x0000000000002000UL
 #define CR0_EXTM_EMGC			0x0000000000004000UL
@@ -297,4 +303,5 @@ static inline uint32_t get_prefix(void)
 	return current_prefix;
 }
 
+#endif /* __ASSEMBLER */
 #endif
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index e084f13..d386f35 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -12,6 +12,7 @@
  */
 #include <asm/asm-offsets.h>
 #include <asm/sigp.h>
+#include <asm/arch_def.h>
 
 .section .init
 
@@ -198,19 +199,19 @@ svc_int:
 
 	.align	8
 reset_psw:
-	.quad	0x0008000180000000
+	.quad	PSW_MASK_ON_EXCEPTION | PSW_MASK_SHORT_PSW
 initial_psw:
-	.quad	0x0000000180000000, clear_bss_start
+	.quad	PSW_MASK_ON_EXCEPTION, clear_bss_start
 pgm_int_psw:
-	.quad	0x0000000180000000, pgm_int
+	.quad	PSW_MASK_ON_EXCEPTION, pgm_int
 ext_int_psw:
-	.quad	0x0000000180000000, ext_int
+	.quad	PSW_MASK_ON_EXCEPTION, ext_int
 mcck_int_psw:
-	.quad	0x0000000180000000, mcck_int
+	.quad	PSW_MASK_ON_EXCEPTION, mcck_int
 io_int_psw:
-	.quad	0x0000000180000000, io_int
+	.quad	PSW_MASK_ON_EXCEPTION, io_int
 svc_int_psw:
-	.quad	0x0000000180000000, svc_int
+	.quad	PSW_MASK_ON_EXCEPTION, svc_int
 initial_cr0:
 	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
 	.quad	0x0000000000040000
-- 
2.25.1
