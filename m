From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] KVM: s390: use atomic bitops to access pending_irqs bitmap
Date: Thu,  4 Dec 2014 17:14:04 +0100
Message-ID: <1417709645-63747-3-git-send-email-borntraeger@de.ibm.com>
References: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Currently we use a mixture of atomic/non-atomic bitops
and the local_int spin lock to protect the pending_irqs bitmap
and interrupt payload data.

We need to use atomic bitops for the pending_irqs bitmap everywhere
and in addition acquire the local_int lock where interrupt data needs
to be protected.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6c0d14b..86bc89a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -929,7 +929,7 @@ static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
 	li->irq.pgm = irq->u.pgm;
-	__set_bit(IRQ_PEND_PROG, &li->pending_irqs);
+	set_bit(IRQ_PEND_PROG, &li->pending_irqs);
 	return 0;
 }
 
@@ -995,7 +995,7 @@ int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 				   irq->u.extcall.code, 0, 2);
 
 	*extcall = irq->u.extcall;
-	__set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
+	set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
-- 
1.9.3
