Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729034AbgFOJcO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 05:32:14 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v9 02/12] s390x: Move control register bit definitions and add AFP to them
Date: Mon, 15 Jun 2020 11:31:51 +0200
Message-Id: <1592213521-19390-3-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

While adding the definition for the AFP-Register control bit, move all
existing definitions for CR0 out of the C zone to the assmbler zone to
keep the definitions concerning CR0 together.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/arch_def.h | 11 ++++++-----
 s390x/cstart64.S         |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index b5d7aca..fa71653 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -19,17 +19,18 @@
 
 #define PSW_MASK_ON_EXCEPTION	(PSW_MASK_EA | PSW_MASK_BA)
 
+#define CR0_EXTM_SCLP			0x0000000000000200UL
+#define CR0_EXTM_EXTC			0x0000000000002000UL
+#define CR0_EXTM_EMGC			0x0000000000004000UL
+#define CR0_EXTM_MASK			0x0000000000006200UL
+#define CR0_AFP_REG_CRTL		0x0000000000040000UL
+
 #ifndef __ASSEMBLER__
 struct psw {
 	uint64_t	mask;
 	uint64_t	addr;
 };
 
-#define CR0_EXTM_SCLP			0x0000000000000200UL
-#define CR0_EXTM_EXTC			0x0000000000002000UL
-#define CR0_EXTM_EMGC			0x0000000000004000UL
-#define CR0_EXTM_MASK			0x0000000000006200UL
-
 struct lowcore {
 	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
 	uint32_t	ext_int_param;			/* 0x0080 */
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index d386f35..e7327ea 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -214,4 +214,4 @@ svc_int_psw:
 	.quad	PSW_MASK_ON_EXCEPTION, svc_int
 initial_cr0:
 	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
-	.quad	0x0000000000040000
+	.quad	CR0_AFP_REG_CRTL
-- 
2.25.1
