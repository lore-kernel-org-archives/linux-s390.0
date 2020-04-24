Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbgDXKqC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:46:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OAUr66069668
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2020 06:46:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30jrj7ut6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2020 06:46:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 24 Apr 2020 11:45:21 +0100
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v6 03/10] s390x: Move control register bit definitions and add AFP to them
Date: Fri, 24 Apr 2020 12:45:45 +0200
In-Reply-To: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1587725152-25569-4-git-send-email-pmorel@linux.ibm.com>
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
---
 lib/s390x/asm/arch_def.h | 11 ++++++-----
 s390x/cstart64.S         |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index c54409a..a0d2362 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -20,17 +20,18 @@
 #define PSW_EXCEPTION_MASK	(PSW_MASK_EA | PSW_MASK_BA)
 #define PSW_RESET_MASK		(PSW_EXCEPTION_MASK | PSW_MASK_SHORT_PSW)
 
+#define CR0_EXTM_SCLP			0X0000000000000200UL
+#define CR0_EXTM_EXTC			0X0000000000002000UL
+#define CR0_EXTM_EMGC			0X0000000000004000UL
+#define CR0_EXTM_MASK			0X0000000000006200UL
+#define CR0_AFP_REG_CRTL		0x0000000000040000UL
+
 #ifndef __ASSEMBLER__
 struct psw {
 	uint64_t	mask;
 	uint64_t	addr;
 };
 
-#define CR0_EXTM_SCLP			0X0000000000000200UL
-#define CR0_EXTM_EXTC			0X0000000000002000UL
-#define CR0_EXTM_EMGC			0X0000000000004000UL
-#define CR0_EXTM_MASK			0X0000000000006200UL
-
 struct lowcore {
 	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
 	uint32_t	ext_int_param;			/* 0x0080 */
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index e394b3a..2906e39 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -241,4 +241,4 @@ svc_int_psw:
 	.quad	PSW_EXCEPTION_MASK, svc_int
 initial_cr0:
 	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
-	.quad	0x0000000000040000
+	.quad	CR0_AFP_REG_CRTL
-- 
2.25.1
