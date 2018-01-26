From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 19/22] KVM: s390: make kvm_s390_get_io_int() aware of GISA
Date: Fri, 26 Jan 2018 16:53:31 +0100
Message-ID: <20180126155334.52956-20-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The function returns a pending I/O interrupt with the highest
priority defined by its ISC.

Together with AIV activation, pending adapter interrupts are
managed by the GISA IPM. Thus kvm_s390_get_io_int() needs to
inspect the IPM as well when the interrupt with the highest
priority has to be identified.

In case classic and adapter interrupts with the same ISC are
pending, the classic interrupt will be returned first.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 78 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index dd4c50b82a532..f2dc86884ea42 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1471,12 +1471,8 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
 	return NULL;
 }
 
-/*
- * Dequeue and return an I/O interrupt matching any of the interruption
- * subclasses as designated by the isc mask in cr6 and the schid (if != 0).
- */
-struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
-						    u64 isc_mask, u32 schid)
+static struct kvm_s390_interrupt_info *get_top_io_int(struct kvm *kvm,
+						      u64 isc_mask, u32 schid)
 {
 	struct kvm_s390_interrupt_info *inti = NULL;
 	int isc;
@@ -1488,6 +1484,76 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	return inti;
 }
 
+static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
+{
+	unsigned long active_mask;
+	int isc;
+
+	if (schid)
+		goto out;
+	if (!kvm->arch.gisa)
+		goto out;
+
+	active_mask = (isc_mask & kvm_s390_gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	while (active_mask) {
+		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
+		if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+			return isc;
+		clear_bit_inv(isc, &active_mask);
+	}
+out:
+	return -EINVAL;
+}
+
+/*
+ * Dequeue and return an I/O interrupt matching any of the interruption
+ * subclasses as designated by the isc mask in cr6 and the schid (if != 0).
+ * Take into account the interrupts pending in the interrupt list and in GISA.
+ *
+ * Note that for a guest that does not enable I/O interrupts
+ * but relies on TPI, a flood of classic interrupts may starve
+ * out adapter interrupts on the same isc. Linux does not do
+ * that, and it is possible to work around the issue by configuring
+ * different iscs for classic and adapter interrupts in the guest,
+ * but we may want to revisit this in the future.
+ */
+struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
+						    u64 isc_mask, u32 schid)
+{
+	struct kvm_s390_interrupt_info *inti, *tmp_inti;
+	int isc;
+
+	inti = get_top_io_int(kvm, isc_mask, schid);
+
+	isc = get_top_gisa_isc(kvm, isc_mask, schid);
+	if (isc < 0)
+		/* no AI in GISA */
+		goto out;
+
+	if (!inti)
+		/* AI in GISA but no classical IO int */
+		goto gisa_out;
+
+	/* both types of interrupts present */
+	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
+		/* classical IO int with higher priority */
+		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		goto out;
+	}
+gisa_out:
+	tmp_inti = kzalloc(sizeof(*inti), GFP_KERNEL);
+	if (tmp_inti) {
+		tmp_inti->type = KVM_S390_INT_IO(1, 0, 0, 0);
+		tmp_inti->io.io_int_word = isc_to_int_word(isc);
+		if (inti)
+			kvm_s390_reinject_io_int(kvm, inti);
+		inti = tmp_inti;
+	} else
+		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+out:
+	return inti;
+}
+
 #define SCCB_MASK 0xFFFFFFF8
 #define SCCB_EVENT_PENDING 0x3
 
-- 
2.13.4
