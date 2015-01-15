From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 10/21] KVM: s390: a VCPU may only stop when no interrupts are left pending
Date: Thu, 15 Jan 2015 14:43:23 +0100
Message-ID: <1421329414-76826-11-git-send-email-borntraeger@de.ibm.com>
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

As a SIGP STOP is an interrupt with the least priority, it may only result
in stop of the vcpu when no other interrupts are left pending.

To detect whether a non-stop irq is pending, we need a way to mask out
stop irqs from the general kvm_cpu_has_interrupt() function. For this
reason, the existing function (with an outdated name) is replaced by
kvm_s390_vcpu_has_irq() which allows to mask out pending stop irqs.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 4 ++++
 arch/s390/kvm/interrupt.c | 4 ++--
 arch/s390/kvm/kvm-s390.c  | 4 ++--
 arch/s390/kvm/kvm-s390.h  | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 08e01ac..8976694 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -74,6 +74,10 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.exit_stop_request++;
 
+	/* delay the stop if any non-stop irq is pending */
+	if (kvm_s390_vcpu_has_irq(vcpu, 1))
+		return 0;
+
 	/* avoid races with the injection/SIGP STOP code */
 	spin_lock(&li->lock);
 	flags = li->irq.stop.flags;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1872188..f753c0b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -749,7 +749,7 @@ int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
+int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 {
 	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
 	struct kvm_s390_interrupt_info  *inti;
@@ -773,7 +773,7 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
 	if (!rc && kvm_s390_si_ext_call_pending(vcpu))
 		rc = 1;
 
-	if (!rc && kvm_s390_is_stop_irq_pending(vcpu))
+	if (!rc && !exclude_stop && kvm_s390_is_stop_irq_pending(vcpu))
 		rc = 1;
 
 	return rc;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b987b56..6a5ed33 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -806,7 +806,7 @@ out:
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
-	return kvm_cpu_has_interrupt(vcpu);
+	return kvm_s390_vcpu_has_irq(vcpu, 0);
 }
 
 void s390_vcpu_block(struct kvm_vcpu *vcpu)
@@ -1241,7 +1241,7 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
 		return 0;
 	if (psw_extint_disabled(vcpu))
 		return 0;
-	if (kvm_cpu_has_interrupt(vcpu))
+	if (kvm_s390_vcpu_has_irq(vcpu, 0))
 		return 0;
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x200ul))
 		return 0;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index d72ff62..2becffe 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -228,7 +228,7 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
 			struct kvm_s390_irq *s390irq);
 
 /* implemented in interrupt.c */
-int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
+int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
 void kvm_s390_destroy_adapters(struct kvm *kvm);
 int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu);
-- 
1.9.3
