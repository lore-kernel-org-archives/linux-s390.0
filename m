From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 06/15] KVM: s390: remove prefix kvm_s390_gisa_ from static inline functions
Date: Wed, 19 Dec 2018 20:17:47 +0100
Message-ID: <20181219191756.57973-7-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This will shorten the length of code lines.
All GISA related static inline functions are local to interrupt.c

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4ab20d2eb180..9b1fa39b6f90 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -224,22 +224,22 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
-static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
+static inline u8 get_ipm(struct kvm_s390_gisa *gisa)
 {
 	return READ_ONCE(gisa->ipm);
 }
 
-static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline int tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
@@ -253,7 +253,7 @@ static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
 	if (irq_flags & IRQ_FLAG_FLOATING)
 		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
 	if (irq_flags & IRQ_FLAG_GISA)
-		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
+		pending_irqs |= get_ipm(vcpu->kvm->arch.gisa) <<
 			IRQ_PEND_IO_ISC_7;
 	return pending_irqs;
 }
@@ -1008,7 +1008,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	}
 
 	if (vcpu->kvm->arch.gisa &&
-	    kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+	    tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
 		/*
 		 * in case an adapter interrupt was not delivered
 		 * in SIE context KVM will handle the delivery
@@ -1550,10 +1550,10 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 	if (!kvm->arch.gisa)
 		goto out;
 
-	active_mask = (isc_mask & kvm_s390_gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & get_ipm(kvm->arch.gisa) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
-		if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+		if (tac_ipm_gisc(kvm->arch.gisa, isc))
 			return isc;
 		clear_bit_inv(isc, &active_mask);
 	}
@@ -1593,7 +1593,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	/* both types of interrupts present */
 	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
 		/* classical IO int with higher priority */
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		set_ipm_gisc(kvm->arch.gisa, isc);
 		goto out;
 	}
 gisa_out:
@@ -1605,7 +1605,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 			kvm_s390_reinject_io_int(kvm, inti);
 		inti = tmp_inti;
 	} else
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		set_ipm_gisc(kvm->arch.gisa, isc);
 out:
 	return inti;
 }
@@ -1703,7 +1703,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 
 	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
 		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		set_ipm_gisc(kvm->arch.gisa, isc);
 		kfree(inti);
 		return 0;
 	}
@@ -2036,14 +2036,14 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
 	if (kvm->arch.gisa &&
-	    kvm_s390_gisa_get_ipm(kvm->arch.gisa)) {
+	    get_ipm(kvm->arch.gisa)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+			if (tac_ipm_gisc(kvm->arch.gisa, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
-- 
2.13.4
