From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/8] KVM: s390: Helper for converting real addresses to absolute
Date: Thu, 12 Sep 2013 10:33:47 +0200
Message-ID: <1378974829-46578-7-git-send-email-borntraeger@de.ibm.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Added a separate helper function that translates guest real addresses
to guest absolute addresses by applying the prefix of the guest CPU.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 99d789e..374a439 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -18,20 +18,27 @@
 #include <asm/uaccess.h>
 #include "kvm-s390.h"
 
+/* Convert real to absolute address by applying the prefix of the CPU */
+static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
+						 unsigned long gaddr)
+{
+	unsigned long prefix  = vcpu->arch.sie_block->prefix;
+	if (gaddr < 2 * PAGE_SIZE)
+		gaddr += prefix;
+	else if (gaddr >= prefix && gaddr < prefix + 2 * PAGE_SIZE)
+		gaddr -= prefix;
+	return gaddr;
+}
+
 static inline void __user *__gptr_to_uptr(struct kvm_vcpu *vcpu,
 					  void __user *gptr,
 					  int prefixing)
 {
-	unsigned long prefix  = vcpu->arch.sie_block->prefix;
 	unsigned long gaddr = (unsigned long) gptr;
 	unsigned long uaddr;
 
-	if (prefixing) {
-		if (gaddr < 2 * PAGE_SIZE)
-			gaddr += prefix;
-		else if ((gaddr >= prefix) && (gaddr < prefix + 2 * PAGE_SIZE))
-			gaddr -= prefix;
-	}
+	if (prefixing)
+		gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
 	uaddr = gmap_fault(gaddr, vcpu->arch.gmap);
 	if (IS_ERR_VALUE(uaddr))
 		uaddr = -EFAULT;
-- 
1.8.3.1
