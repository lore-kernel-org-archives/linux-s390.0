From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/9] KVM: s390: optimize interrupt handling round trip time
Date: Mon, 11 May 2015 10:44:35 +0200
Message-ID: <1431333877-28700-8-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

We can avoid checking guest control registers and guest PSW as well
as all the masking and calculations on the interrupt masks when
no interrupts are pending.

Also, the check for IRQ_PEND_COUNT can be removed, because we won't
enter the while loop if no interrupts are pending and invalid interrupt
types can't be injected.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2836b25..acf4a4e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -134,6 +134,8 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 
 	active_mask = pending_local_irqs(vcpu);
 	active_mask |= pending_floating_irqs(vcpu);
+	if (!active_mask)
+		return 0;
 
 	if (psw_extint_disabled(vcpu))
 		active_mask &= ~IRQ_PEND_EXT_MASK;
@@ -941,12 +943,9 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	if (cpu_timer_irq_pending(vcpu))
 		set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
 
-	do {
-		irqs = deliverable_irqs(vcpu);
+	while ((irqs = deliverable_irqs(vcpu)) && !rc) {
 		/* bits are in the order of interrupt priority */
 		irq_type = find_first_bit(&irqs, IRQ_PEND_COUNT);
-		if (irq_type == IRQ_PEND_COUNT)
-			break;
 		if (is_ioirq(irq_type)) {
 			rc = __deliver_io(vcpu, irq_type);
 		} else {
@@ -958,9 +957,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 			}
 			rc = func(vcpu);
 		}
-		if (rc)
-			break;
-	} while (!rc);
+	}
 
 	set_intercept_indicators(vcpu);
 
-- 
2.3.0
