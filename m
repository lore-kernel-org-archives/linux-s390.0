From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 45/47] KVM: s390: Drop pending interrupts on guest exit
Date: Tue, 15 Apr 2014 14:00:48 +0200
Message-ID: <1397563250-3089-46-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On hard exits (abort, sigkill) we have have some kvm_s390_interrupt_info
structures hanging around. Delete those on exit to avoid memory leaks.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: stable@vger.kernel.org
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 arch/s390/kvm/kvm-s390.c  | 2 ++
 arch/s390/kvm/kvm-s390.h  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d020c5f..077e473 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1045,7 +1045,7 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static void clear_floating_interrupts(struct kvm *kvm)
+void kvm_s390_clear_float_irqs(struct kvm *kvm)
 {
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_interrupt_info	*n, *inti = NULL;
@@ -1391,7 +1391,7 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		break;
 	case KVM_DEV_FLIC_CLEAR_IRQS:
 		r = 0;
-		clear_floating_interrupts(dev->kvm);
+		kvm_s390_clear_float_irqs(dev->kvm);
 		break;
 	case KVM_DEV_FLIC_APF_ENABLE:
 		dev->kvm->arch.gmap->pfault_enabled = 1;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e6bbfe1..b32c42c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -471,6 +471,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
 	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
+	kvm_s390_clear_local_irqs(vcpu);
 	kvm_clear_async_pf_completion_queue(vcpu);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		clear_bit(63 - vcpu->vcpu_id,
@@ -520,6 +521,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (!kvm_is_ucontrol(kvm))
 		gmap_free(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
+	kvm_s390_clear_float_irqs(kvm);
 }
 
 /* Section: vcpu related */
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index be8ae0d..c93ed5f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -130,6 +130,7 @@ void kvm_s390_tasklet(unsigned long parm);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
+void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int);
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
-- 
1.8.4.2
