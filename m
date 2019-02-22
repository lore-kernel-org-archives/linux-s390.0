From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:18 +0000
Subject: [GIT PULL 07/18] KVM: s390: remove kvm_s390_ from gisa static inline functions
Message-Id: <1550835749-26436-8-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

This will shorten the length of code lines. All GISA related
static inline functions are local to interrupt.c.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-7-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index cb48736..942cc7d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -217,22 +217,22 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
-static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
+static inline u8 gisa_get_ipm(struct kvm_s390_gisa *gisa)
 {
 	return READ_ONCE(gisa->ipm);
 }
 
-static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline int gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
@@ -246,7 +246,7 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
 	return pending_irqs_no_gisa(vcpu) |
-		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
+		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
@@ -999,7 +999,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	}
 
 	if (vcpu->kvm->arch.gisa &&
-	    kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+	    gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
 		/*
 		 * in case an adapter interrupt was not delivered
 		 * in SIE context KVM will handle the delivery
@@ -1541,10 +1541,10 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 	if (!kvm->arch.gisa)
 		goto out;
 
-	active_mask = (isc_mask & kvm_s390_gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
-		if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+		if (gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
 			return isc;
 		clear_bit_inv(isc, &active_mask);
 	}
@@ -1584,7 +1584,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	/* both types of interrupts present */
 	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
 		/* classical IO int with higher priority */
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
 		goto out;
 	}
 gisa_out:
@@ -1596,7 +1596,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 			kvm_s390_reinject_io_int(kvm, inti);
 		inti = tmp_inti;
 	} else
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
 out:
 	return inti;
 }
@@ -1694,7 +1694,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 
 	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
 		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
 		kfree(inti);
 		return 0;
 	}
@@ -2025,15 +2025,14 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
-	if (kvm->arch.gisa &&
-	    kvm_s390_gisa_get_ipm(kvm->arch.gisa)) {
+	if (kvm->arch.gisa && gisa_get_ipm(kvm->arch.gisa)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+			if (gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
-- 
2.7.4
