From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 09/12] KVM: s390: make kvm_s390_get_io_int() aware of GISA
Date: Tue, 16 Jan 2018 21:02:14 +0100
Message-ID: <20180116200217.211897-10-borntraeger@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
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
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 71 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6c7a024c2554..2f1a5603c366 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1449,12 +1449,8 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
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
@@ -1466,6 +1462,69 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
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
+		isc = __flogr(active_mask);
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
