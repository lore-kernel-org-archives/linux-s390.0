Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgDXKqD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:46:03 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v6 08/10] s390x: define wfi: wait for interrupt
Date: Fri, 24 Apr 2020 12:45:50 +0200
Message-Id: <1587725152-25569-9-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

wfi(irq_mask) allows the programm to wait for an interrupt.
The interrupt handler is in charge to remove the WAIT bit
when it finished handling interrupt.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index a0d2362..e04866c 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -13,6 +13,7 @@
 #define PSW_MASK_EXT			0x0100000000000000UL
 #define PSW_MASK_DAT			0x0400000000000000UL
 #define PSW_MASK_SHORT_PSW		0x0008000000000000UL
+#define PSW_MASK_WAIT			0x0002000000000000UL
 #define PSW_MASK_PSTATE			0x0001000000000000UL
 #define PSW_MASK_BA			0x0000000080000000UL
 #define PSW_MASK_EA			0x0000000100000000UL
@@ -254,6 +255,16 @@ static inline void load_psw_mask(uint64_t mask)
 		: "+r" (tmp) :  "a" (&psw) : "memory", "cc" );
 }
 
+static inline void wfi(uint64_t irq_mask)
+{
+	uint64_t psw_mask;
+
+	psw_mask = extract_psw_mask();
+	load_psw_mask(psw_mask | irq_mask | PSW_MASK_WAIT);
+	load_psw_mask(psw_mask);
+}
+
+
 static inline void enter_pstate(void)
 {
 	uint64_t mask;
-- 
2.25.1
