From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 18/21] KVM: s390: fix bug in sigp emergency signal injection
Date: Thu, 15 Jan 2015 14:43:31 +0100
Message-ID: <1421329414-76826-19-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Currently we are always setting the wrong bit in the
bitmap for pending emergency signals. Instead of using
emerg.code from the passed in irq parameter, we use the
value in our per-vcpu local_int structure, which is always zero.
That means all emergency signals will have address 0 as parameter.
If two CPUs send a SIGP to the same target, one might be lost.

Let's fix this by using the value from the parameter and
also trace the correct value.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8ebae29..eb5fb66 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1103,14 +1103,13 @@ static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 				   struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_emerg_info *emerg = &li->irq.emerg;
 
 	VCPU_EVENT(vcpu, 3, "inject: emergency %u\n",
 		   irq->u.emerg.code);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EMERGENCY,
-				   emerg->code, 0, 2);
+				   irq->u.emerg.code, 0, 2);
 
-	set_bit(emerg->code, li->sigp_emerg_pending);
+	set_bit(irq->u.emerg.code, li->sigp_emerg_pending);
 	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
-- 
1.9.3
