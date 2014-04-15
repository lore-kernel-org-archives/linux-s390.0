From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 09/47] KVM: s390: add kvm_s390_logical_to_effective() helper
Date: Tue, 15 Apr 2014 14:00:12 +0200
Message-ID: <1397563250-3089-10-git-send-email-borntraeger@de.ibm.com>
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

Add kvm_s390_logical_to_effective() helper which converts a guest vcpu's
logical storage address to a guest vcpu effective address by applying the
rules of the vcpu's addressing mode defined by PSW bits 31 and 32
(extendended and basic addressing mode).
Depending on the vcpu's addressing mode the upper 40 bits (24 bit addressing
mode), 33 bits (31 bit addressing mode) or no bits (64 bit addressing mode)
will be zeroed and the remaining bits will be returned.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 374a439..ae3cb63 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -30,6 +30,31 @@ static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
 	return gaddr;
 }
 
+/**
+ * kvm_s390_logical_to_effective - convert guest logical to effective address
+ * @vcpu: guest virtual cpu
+ * @ga: guest logical address
+ *
+ * Convert a guest vcpu logical address to a guest vcpu effective address by
+ * applying the rules of the vcpu's addressing mode defined by PSW bits 31
+ * and 32 (extendended/basic addressing mode).
+ *
+ * Depending on the vcpu's addressing mode the upper 40 bits (24 bit addressing
+ * mode), 33 bits (31 bit addressing mode) or no bits (64 bit addressing mode)
+ * of @ga will be zeroed and the remaining bits will be returned.
+ */
+static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
+							  unsigned long ga)
+{
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+
+	if (psw_bits(*psw).eaba == PSW_AMODE_64BIT)
+		return ga;
+	if (psw_bits(*psw).eaba == PSW_AMODE_31BIT)
+		return ga & ((1UL << 31) - 1);
+	return ga & ((1UL << 24) - 1);
+}
+
 static inline void __user *__gptr_to_uptr(struct kvm_vcpu *vcpu,
 					  void __user *gptr,
 					  int prefixing)
-- 
1.8.4.2
