From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/8] KVM: s390: cpu timer irq priority
Date: Tue, 31 Mar 2015 15:02:00 +0200
Message-ID: <1427806923-21910-6-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We now have a mechanism for delivering interrupts according to their priority.

Let's inject them using our new infrastructure (instead of letting only hardware
handle them), so we can be sure that the irq priorities are satisfied.

For s390, the cpu timer and the clock comparator are to be checked for common
code kvm_cpu_has_pending_timer(), although the cpu timer is only stepped when
the guest is being executed.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 298d63b..bc13194 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -70,6 +70,26 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int ckc_irq_pending(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.sie_block->ckc <
+	      get_tod_clock_fast() + vcpu->arch.sie_block->epoch))
+		return 0;
+	return ckc_interrupts_enabled(vcpu);
+}
+
+static int cpu_timer_interrupts_enabled(struct kvm_vcpu *vcpu)
+{
+	return !psw_extint_disabled(vcpu) &&
+	       (vcpu->arch.sie_block->gcr[0] & 0x400ul);
+}
+
+static int cpu_timer_irq_pending(struct kvm_vcpu *vcpu)
+{
+	return (vcpu->arch.sie_block->cputm >> 63) &&
+	       cpu_timer_interrupts_enabled(vcpu);
+}
+
 static inline int is_ioirq(unsigned long irq_type)
 {
 	return ((irq_type >= IRQ_PEND_IO_ISC_0) &&
@@ -809,12 +829,7 @@ int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	if (!(vcpu->arch.sie_block->ckc <
-	      get_tod_clock_fast() + vcpu->arch.sie_block->epoch))
-		return 0;
-	if (!ckc_interrupts_enabled(vcpu))
-		return 0;
-	return 1;
+	return ckc_irq_pending(vcpu) || cpu_timer_irq_pending(vcpu);
 }
 
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
@@ -918,9 +933,14 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 
 	/* pending ckc conditions might have been invalidated */
 	clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
-	if (kvm_cpu_has_pending_timer(vcpu))
+	if (ckc_irq_pending(vcpu))
 		set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
 
+	/* pending cpu timer conditions might have been invalidated */
+	clear_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
+	if (cpu_timer_irq_pending(vcpu))
+		set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
+
 	do {
 		irqs = deliverable_irqs(vcpu);
 		/* bits are in the order of interrupt priority */
-- 
2.3.0
