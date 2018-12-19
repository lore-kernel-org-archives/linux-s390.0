From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 11/15] KVM: s390: restore IAM in get_ipm() when IPM is clean
Date: Wed, 19 Dec 2018 20:17:52 +0100
Message-ID: <20181219191756.57973-12-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch adds the parameter irq_flags and allows to
restore the Interruption Alert Mask (IAM) in the GISA
atomically while guaranteeing the IPM is clean.

The function returns the IPM of the GISA. If the returned
value is 0x00 and the IRQ_FLAG_IAM was set, the IAM has
been restored.

New irq flag:
  IRQ_FLAG_IAM: When set, the IAM is restored if no ISC bit
  		is set in the IPM, i.e. no new airqs are
		pending. The test and restore operations
		are done atomically.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1cc3ad2e6c7e..8307717e3caf 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -37,6 +37,7 @@
 #define IRQ_FLAG_LOCAL    0x8000 /* include local interruption pending mask */
 #define IRQ_FLAG_FLOATING 0x4000 /* include float interruption pending mask */
 #define IRQ_FLAG_GISA     0x2000 /* include GISA interruption pending mask */
+#define IRQ_FLAG_IAM      0x0080 /* when set try to restore IAM */
 
 #define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
 #define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
@@ -253,9 +254,32 @@ static inline void set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline u8 get_ipm(struct kvm_s390_gisa *gisa)
+static inline u8 get_ipm(struct kvm_s390_gisa *gisa, u16 irq_flags)
 {
-	return READ_ONCE(gisa->ipm);
+	u64 word, _word;
+	u8 ipm;
+
+	if (!(irq_flags & IRQ_FLAG_IAM))
+		return READ_ONCE(gisa->ipm);
+
+	do {
+		word = READ_ONCE(gisa->u64.word[0]);
+		ipm = word >> 24;
+		/* If the GISA is in the alert list, return the IPM. */
+		if ((u64)gisa != word >> 32)
+			return ipm;
+		/* If the IPM is dirty, return the IPM. */
+		if (ipm)
+			return ipm;
+		/*
+		 * Try to restore the IAM or loop, if the IPM is dirty
+		 * again or the GISA has been inserted into the alert list.
+		 */
+		_word = (word & ~0xffUL) |
+			container_of(gisa, struct sie_page2, gisa)->kvm->arch.iam;
+	} while (cmpxchg(&gisa->u64.word[0], word, _word) != _word);
+
+	return 0;
 }
 
 static inline void clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
@@ -277,7 +301,7 @@ static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
 	if (irq_flags & IRQ_FLAG_FLOATING)
 		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
 	if (irq_flags & IRQ_FLAG_GISA)
-		pending_irqs |= get_ipm(vcpu->kvm->arch.gisa) <<
+		pending_irqs |= get_ipm(vcpu->kvm->arch.gisa, irq_flags) <<
 			IRQ_PEND_IO_ISC_7;
 	return pending_irqs;
 }
@@ -1574,7 +1598,7 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 	if (!kvm->arch.gisa)
 		goto out;
 
-	active_mask = (isc_mask & get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
 		if (tac_ipm_gisc(kvm->arch.gisa, isc))
@@ -2060,7 +2084,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
 	if (kvm->arch.gisa &&
-	    get_ipm(kvm->arch.gisa)) {
+	    get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
-- 
2.13.4
