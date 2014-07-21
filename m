From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/9] KVM: s390: remove the tasklet used by the hrtimer
Date: Mon, 21 Jul 2014 21:14:21 +0200
Message-ID: <1405970065-3740-6-git-send-email-borntraeger@de.ibm.com>
References: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We can get rid of the tasklet used for waking up a VCPU in the hrtimer
code but wakeup the VCPU directly.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 -
 arch/s390/kvm/interrupt.c        | 13 +------------
 arch/s390/kvm/kvm-s390.c         |  2 --
 arch/s390/kvm/kvm-s390.h         |  1 -
 4 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b3acf28..773bef7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -366,7 +366,6 @@ struct kvm_vcpu_arch {
 	s390_fp_regs      guest_fpregs;
 	struct kvm_s390_local_interrupt local_int;
 	struct hrtimer    ckc_timer;
-	struct tasklet_struct tasklet;
 	struct kvm_s390_pgm_info pgm;
 	union  {
 		struct cpuid	cpu_id;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 65396e1..1be3d8d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -629,23 +629,12 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 	}
 }
 
-void kvm_s390_tasklet(unsigned long parm)
-{
-	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) parm;
-	kvm_s390_vcpu_wakeup(vcpu);
-}
-
-/*
- * low level hrtimer wake routine. Because this runs in hardirq context
- * we schedule a tasklet to do the real work.
- */
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 {
 	struct kvm_vcpu *vcpu;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.ckc_timer);
-	vcpu->preempted = true;
-	tasklet_schedule(&vcpu->arch.tasklet);
+	kvm_s390_vcpu_wakeup(vcpu);
 
 	return HRTIMER_NORESTART;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b29a031..dd902e6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -649,8 +649,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 			return rc;
 	}
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	tasklet_init(&vcpu->arch.tasklet, kvm_s390_tasklet,
-		     (unsigned long) vcpu);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 	get_cpu_id(&vcpu->arch.cpu_id);
 	vcpu->arch.cpu_id.version = 0xff;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 665eacc..3862fa2 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -138,7 +138,6 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
-void kvm_s390_tasklet(unsigned long parm);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
-- 
1.8.4.2
