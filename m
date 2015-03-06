From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/20] KVM: s390: Use insn_length() to calculate length of instruction
Date: Fri,  6 Mar 2015 14:16:43 +0100
Message-ID: <1425647812-61838-12-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The common s390 function insn_length() results in slightly smaller
(and thus hopefully faster) code than the calculation of the
instruction length via a lookup-table. So let's use that function
in the interrupt delivery code, too.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 98a3131..9561e1d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1,7 +1,7 @@
 /*
  * handling kvm guest interrupts
  *
- * Copyright IBM Corp. 2008,2014
+ * Copyright IBM Corp. 2008, 2015
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/bitmap.h>
 #include <asm/asm-offsets.h>
+#include <asm/dis.h>
 #include <asm/uaccess.h>
 #include <asm/sclp.h>
 #include "kvm-s390.h"
@@ -265,8 +266,6 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 
 static u16 get_ilc(struct kvm_vcpu *vcpu)
 {
-	const unsigned short table[] = { 2, 4, 4, 6 };
-
 	switch (vcpu->arch.sie_block->icptcode) {
 	case ICPT_INST:
 	case ICPT_INSTPROGI:
@@ -274,7 +273,7 @@ static u16 get_ilc(struct kvm_vcpu *vcpu)
 	case ICPT_PARTEXEC:
 	case ICPT_IOINST:
 		/* last instruction only stored for these icptcodes */
-		return table[vcpu->arch.sie_block->ipa >> 14];
+		return insn_length(vcpu->arch.sie_block->ipa >> 8);
 	case ICPT_PROGI:
 		return vcpu->arch.sie_block->pgmilc;
 	default:
-- 
2.3.0
