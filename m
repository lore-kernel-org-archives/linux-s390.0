From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 33/47] KVM: s390: cleanup kvm_s390_real_to_abs()
Date: Tue, 15 Apr 2014 14:00:36 +0200
Message-ID: <1397563250-3089-34-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add kerneldoc comment to kvm_s390_real_to_abs() and change the code
so it matches the coding style of the rest of gaccess.h.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index ed4749e..1079c8f 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -19,16 +19,24 @@
 #include <linux/ptrace.h>
 #include "kvm-s390.h"
 
-/* Convert real to absolute address by applying the prefix of the CPU */
+/**
+ * kvm_s390_real_to_abs - convert guest real address to guest absolute address
+ * @vcpu - guest virtual cpu
+ * @gra - guest real address
+ *
+ * Returns the guest absolute address that corresponds to the passed guest real
+ * address @gra of a virtual guest cpu by applying its prefix.
+ */
 static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
-						 unsigned long gaddr)
+						 unsigned long gra)
 {
-	unsigned long prefix  = vcpu->arch.sie_block->prefix;
-	if (gaddr < 2 * PAGE_SIZE)
-		gaddr += prefix;
-	else if (gaddr >= prefix && gaddr < prefix + 2 * PAGE_SIZE)
-		gaddr -= prefix;
-	return gaddr;
+	unsigned long prefix = vcpu->arch.sie_block->prefix;
+
+	if (gra < 2 * PAGE_SIZE)
+		gra += prefix;
+	else if (gra >= prefix && gra < prefix + 2 * PAGE_SIZE)
+		gra -= prefix;
+	return gra;
 }
 
 /**
-- 
1.8.4.2
