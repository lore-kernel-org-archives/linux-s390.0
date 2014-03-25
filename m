From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 4/4] KVM: s390: clear local interrupts at cpu initial reset
Date: Tue, 25 Mar 2014 14:35:23 +0100
Message-ID: <1395754523-43697-5-git-send-email-borntraeger@de.ibm.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Empty list of local interrupts when vcpu goes through initial reset
to provide a clean state

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 14 ++++++++++++++
 arch/s390/kvm/kvm-s390.c  |  1 +
 arch/s390/kvm/kvm-s390.h  |  1 +
 3 files changed, 16 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 79d2e4f..05bffd7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -509,6 +509,20 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_interrupt_info  *n, *inti = NULL;
+
+	spin_lock_bh(&li->lock);
+	list_for_each_entry_safe(inti, n, &li->list, list) {
+		list_del(&inti->list);
+		kfree(inti);
+	}
+	atomic_set(&li->active, 0);
+	spin_unlock_bh(&li->lock);
+}
+
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a02979f..83b7944 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -395,6 +395,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
 	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_local_irqs(vcpu);
 }
 
 int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index ed4750a..6311170 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -129,6 +129,7 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu);
+void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int);
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
-- 
1.8.4.2
