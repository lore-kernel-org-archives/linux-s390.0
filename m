From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 12/15] KVM: s390: do not restore IAM immediately before SIE entry
Date: Wed, 19 Dec 2018 20:17:53 +0100
Message-ID: <20181219191756.57973-13-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The IAM shall no be restored when deliverable interruptions are
delivered to vcpus by means of the PSW swap mechanism. That would
trigger the GIB alert millicode although we know that SIE will be
able to handle the pending interruption on entry.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8307717e3caf..48a93f5e5333 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -328,11 +328,11 @@ static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
 	return active_mask;
 }
 
-static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
+static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
 {
 	unsigned long active_mask;
 
-	active_mask = pending_irqs(vcpu, IRQ_MASK_ALL);
+	active_mask = pending_irqs(vcpu, irq_flags);
 	if (!active_mask)
 		return 0;
 
@@ -1090,7 +1090,7 @@ int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 
 int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 {
-	if (deliverable_irqs(vcpu))
+	if (deliverable_irqs(vcpu, IRQ_MASK_ALL | IRQ_FLAG_IAM))
 		return 1;
 
 	if (kvm_cpu_has_pending_timer(vcpu))
@@ -1262,7 +1262,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	if (cpu_timer_irq_pending(vcpu))
 		set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
 
-	while ((irqs = deliverable_irqs(vcpu)) && !rc) {
+	while ((irqs = deliverable_irqs(vcpu, IRQ_MASK_ALL)) && !rc) {
 		/* bits are in the reverse order of interrupt priority */
 		irq_type = find_last_bit(&irqs, IRQ_PEND_COUNT);
 		switch (irq_type) {
-- 
2.13.4
