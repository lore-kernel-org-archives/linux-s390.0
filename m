From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/9] KVM: s390: abstract conversion between isc and enum irq_types
Date: Fri, 10 Nov 2017 09:00:11 +0100
Message-ID: <20171110080013.111004-8-borntraeger@de.ibm.com>
References: <20171110080013.111004-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171110080013.111004-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The abstraction of the conversion between an isc value and an irq_type
by means of functions isc_to_irq_type() and irq_type_to_isc() allows
to clarify the respective operations where used.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 23d8fb2..a3da4f3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -213,6 +213,16 @@ static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 	       vcpu->arch.local_int.pending_irqs;
 }
 
+static inline int isc_to_irq_type(unsigned long isc)
+{
+	return IRQ_PEND_IO_ISC_0 + isc;
+}
+
+static inline int irq_type_to_isc(unsigned long irq_type)
+{
+	return irq_type - IRQ_PEND_IO_ISC_0;
+}
+
 static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
 				   unsigned long active_mask)
 {
@@ -220,7 +230,7 @@ static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
 
 	for (i = 0; i <= MAX_ISC; i++)
 		if (!(vcpu->arch.sie_block->gcr[6] & isc_to_isc_bits(i)))
-			active_mask &= ~(1UL << (IRQ_PEND_IO_ISC_0 + i));
+			active_mask &= ~(1UL << (isc_to_irq_type(i)));
 
 	return active_mask;
 }
@@ -901,7 +911,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	fi = &vcpu->kvm->arch.float_int;
 
 	spin_lock(&fi->lock);
-	isc_list = &fi->lists[irq_type - IRQ_PEND_IO_ISC_0];
+	isc_list = &fi->lists[irq_type_to_isc(irq_type)];
 	inti = list_first_entry_or_null(isc_list,
 					struct kvm_s390_interrupt_info,
 					list);
@@ -1401,7 +1411,7 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
 		list_del_init(&iter->list);
 		fi->counters[FIRQ_CNTR_IO] -= 1;
 		if (list_empty(isc_list))
-			clear_bit(IRQ_PEND_IO_ISC_0 + isc, &fi->pending_irqs);
+			clear_bit(isc_to_irq_type(isc), &fi->pending_irqs);
 		spin_unlock(&fi->lock);
 		return iter;
 	}
@@ -1528,7 +1538,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	isc = int_word_to_isc(inti->io.io_int_word);
 	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
 	list_add_tail(&inti->list, list);
-	set_bit(IRQ_PEND_IO_ISC_0 + isc, &fi->pending_irqs);
+	set_bit(isc_to_irq_type(isc), &fi->pending_irqs);
 	spin_unlock(&fi->lock);
 	return 0;
 }
-- 
2.9.4
