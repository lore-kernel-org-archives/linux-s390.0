From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/10] KVM: s390: set interception requests for all floating irqs
Date: Tue, 13 Oct 2015 16:06:01 +0200
Message-ID: <1444745168-21479-4-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

No need to separate pending and floating irqs when setting interception
requests. Let's do it for all equally.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1058240..4f05520 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -107,14 +107,10 @@ static inline u8 int_word_to_isc(u32 int_word)
 	return (int_word & 0x38000000) >> 27;
 }
 
-static inline unsigned long pending_floating_irqs(struct kvm_vcpu *vcpu)
+static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
-	return vcpu->kvm->arch.float_int.pending_irqs;
-}
-
-static inline unsigned long pending_local_irqs(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.local_int.pending_irqs;
+	return vcpu->kvm->arch.float_int.pending_irqs |
+	       vcpu->arch.local_int.pending_irqs;
 }
 
 static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
@@ -133,8 +129,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 {
 	unsigned long active_mask;
 
-	active_mask = pending_local_irqs(vcpu);
-	active_mask |= pending_floating_irqs(vcpu);
+	active_mask = pending_irqs(vcpu);
 	if (!active_mask)
 		return 0;
 
@@ -202,7 +197,7 @@ static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
 
 static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_floating_irqs(vcpu) & IRQ_PEND_IO_MASK))
+	if (!(pending_irqs(vcpu) & IRQ_PEND_IO_MASK))
 		return;
 	else if (psw_ioint_disabled(vcpu))
 		__set_cpuflag(vcpu, CPUSTAT_IO_INT);
@@ -212,7 +207,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_local_irqs(vcpu) & IRQ_PEND_EXT_MASK))
+	if (!(pending_irqs(vcpu) & IRQ_PEND_EXT_MASK))
 		return;
 	if (psw_extint_disabled(vcpu))
 		__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
@@ -222,7 +217,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_local_irqs(vcpu) & IRQ_PEND_MCHK_MASK))
+	if (!(pending_irqs(vcpu) & IRQ_PEND_MCHK_MASK))
 		return;
 	if (psw_mchk_disabled(vcpu))
 		vcpu->arch.sie_block->ictl |= ICTL_LPSW;
-- 
2.4.3
