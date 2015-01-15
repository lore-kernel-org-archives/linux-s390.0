From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 11/21] KVM: s390: SIGP SET PREFIX cleanup
Date: Thu, 15 Jan 2015 14:43:24 +0100
Message-ID: <1421329414-76826-12-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch cleanes up the the SIGP SET PREFIX code.

A SIGP SET PREFIX irq may only be injected if the target vcpu is
stopped. Let's move the checking code into the injection code and
return -EBUSY if the target vcpu is not stopped.

Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c |  3 +++
 arch/s390/kvm/sigp.c      | 30 +++++++++++-------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f753c0b..1ba9176 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1026,6 +1026,9 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_SET_PREFIX,
 				   prefix->address, 0, 2);
 
+	if (!is_vcpu_stopped(vcpu))
+		return -EBUSY;
+
 	*prefix = irq->u.prefix;
 	set_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
 	return 0;
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index a251854..8ae4495 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -176,41 +176,33 @@ static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 			     u32 address, u64 *reg)
 {
-	struct kvm_s390_local_interrupt *li;
+	struct kvm_s390_irq irq = {
+		.type = KVM_S390_SIGP_SET_PREFIX,
+		.u.prefix.address = address & 0x7fffe000u,
+	};
 	int rc;
 
-	li = &dst_vcpu->arch.local_int;
-
 	/*
 	 * Make sure the new value is valid memory. We only need to check the
 	 * first page, since address is 8k aligned and memory pieces are always
 	 * at least 1MB aligned and have at least a size of 1MB.
 	 */
-	address &= 0x7fffe000u;
-	if (kvm_is_error_gpa(vcpu->kvm, address)) {
+	if (kvm_is_error_gpa(vcpu->kvm, irq.u.prefix.address)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INVALID_PARAMETER;
 		return SIGP_CC_STATUS_STORED;
 	}
 
-	spin_lock(&li->lock);
-	/* cpu must be in stopped state */
-	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &irq);
+	if (rc == -EBUSY) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
-		rc = SIGP_CC_STATUS_STORED;
-		goto out_li;
+		return SIGP_CC_STATUS_STORED;
+	} else if (rc == 0) {
+		VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x",
+			   dst_vcpu->vcpu_id, irq.u.prefix.address);
 	}
 
-	li->irq.prefix.address = address;
-	set_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
-	kvm_s390_vcpu_wakeup(dst_vcpu);
-	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
-
-	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", dst_vcpu->vcpu_id,
-		   address);
-out_li:
-	spin_unlock(&li->lock);
 	return rc;
 }
 
-- 
1.9.3
