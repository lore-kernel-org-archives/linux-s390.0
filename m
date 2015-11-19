From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/5] KVM: s390: avoid memory overwrites on emergency signal injection
Date: Thu, 19 Nov 2015 15:09:25 +0100
Message-ID: <1447942166-66514-5-git-send-email-borntraeger@de.ibm.com>
References: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Commit 383d0b050106 ("KVM: s390: handle pending local interrupts via
bitmap") introduced a possible memory overwrite from user space.

User space could pass an invalid emergency signal code (sending VCPU)
and therefore exceed the bitmap. Let's take care of this case and
check that the id is in the valid range.

Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v3.19+ db27a7a KVM: Provide function for VCPU lookup by id
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 373e323..7242c2d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1110,6 +1110,10 @@ static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EMERGENCY,
 				   irq->u.emerg.code, 0);
 
+	/* sending vcpu invalid */
+	if (kvm_get_vcpu_by_id(vcpu->kvm, irq->u.emerg.code) == NULL)
+		return -EINVAL;
+
 	set_bit(irq->u.emerg.code, li->sigp_emerg_pending);
 	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
 	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
-- 
2.3.0
