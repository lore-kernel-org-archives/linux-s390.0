From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 04/12] KVM: s390: implement GISA IPM related primitives
Date: Thu, 25 Jan 2018 14:28:40 +0100
Message-ID: <20180125132848.175942-5-borntraeger@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The patch implements routines to access the GISA to test and modify
its Interruption Pending Mask (IPM) from the host side.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index b7b2865..d559776 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -203,6 +203,28 @@ static inline u8 int_word_to_isc(u32 int_word)
 	return (int_word & 0x38000000) >> 27;
 }
 
+#define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
+
+static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+{
+	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
+}
+
+static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
+{
+	return (u8) READ_ONCE(gisa->ipm);
+}
+
+static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+{
+	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
+}
+
+static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+{
+	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
+}
+
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.float_int.pending_irqs |
@@ -2682,3 +2704,4 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
 	return n;
 }
+
-- 
2.9.4
