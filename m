From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/9] KVM: s390: move vcpu wakeup code to a central point
Date: Mon, 21 Jul 2014 21:14:20 +0200
Message-ID: <1405970065-3740-5-git-send-email-borntraeger@de.ibm.com>
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

Let's move the vcpu wakeup code to a central point.

We should set the vcpu->preempted flag only if the target is actually sleeping
and before the real wakeup happens. Otherwise the preempted flag might be set,
when not necessary. This may result in immediate reschedules after schedule()
in some scenarios.

The wakeup code doesn't require the local_int.lock to be held.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 24 +++++++++++++++---------
 arch/s390/kvm/kvm-s390.h  |  1 +
 arch/s390/kvm/sigp.c      | 20 ++++++--------------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 86575b4..65396e1 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -617,12 +617,22 @@ no_timer:
 	return 0;
 }
 
+void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
+{
+	if (waitqueue_active(&vcpu->wq)) {
+		/*
+		 * The vcpu gave up the cpu voluntarily, mark it as a good
+		 * yield-candidate.
+		 */
+		vcpu->preempted = true;
+		wake_up_interruptible(&vcpu->wq);
+	}
+}
+
 void kvm_s390_tasklet(unsigned long parm)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) parm;
-
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	kvm_s390_vcpu_wakeup(vcpu);
 }
 
 /*
@@ -905,10 +915,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	li = &dst_vcpu->arch.local_int;
 	spin_lock(&li->lock);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(li->wq))
-		wake_up_interruptible(li->wq);
-	kvm_get_vcpu(kvm, sigcpu)->preempted = true;
 	spin_unlock(&li->lock);
+	kvm_s390_vcpu_wakeup(kvm_get_vcpu(kvm, sigcpu));
 unlock_fi:
 	spin_unlock(&fi->lock);
 	mutex_unlock(&kvm->lock);
@@ -1059,11 +1067,9 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	if (inti->type == KVM_S390_SIGP_STOP)
 		li->action_bits |= ACTION_STOP_ON_STOP;
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
-	vcpu->preempted = true;
 	spin_unlock(&li->lock);
 	mutex_unlock(&vcpu->kvm->lock);
+	kvm_s390_vcpu_wakeup(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 33a0e4b..665eacc 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -136,6 +136,7 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 }
 
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
+void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 946992f..c6f1c2b 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -125,8 +125,9 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
-static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
+static int __inject_sigp_stop(struct kvm_vcpu *dst_vcpu, int action)
 {
+	struct kvm_s390_local_interrupt *li = &dst_vcpu->arch.local_int;
 	struct kvm_s390_interrupt_info *inti;
 	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
@@ -151,8 +152,7 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 	atomic_set(&li->active, 1);
 	li->action_bits |= action;
 	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
-	if (waitqueue_active(li->wq))
-		wake_up_interruptible(li->wq);
+	kvm_s390_vcpu_wakeup(dst_vcpu);
 out:
 	spin_unlock(&li->lock);
 
@@ -161,7 +161,6 @@ out:
 
 static int __sigp_stop(struct kvm_vcpu *vcpu, u16 cpu_addr, int action)
 {
-	struct kvm_s390_local_interrupt *li;
 	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc;
 
@@ -171,9 +170,8 @@ static int __sigp_stop(struct kvm_vcpu *vcpu, u16 cpu_addr, int action)
 	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 	if (!dst_vcpu)
 		return SIGP_CC_NOT_OPERATIONAL;
-	li = &dst_vcpu->arch.local_int;
 
-	rc = __inject_sigp_stop(li, action);
+	rc = __inject_sigp_stop(dst_vcpu, action);
 
 	VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x", cpu_addr);
 
@@ -258,8 +256,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	if (waitqueue_active(li->wq))
-		wake_up_interruptible(li->wq);
+	kvm_s390_vcpu_wakeup(dst_vcpu);
 	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
 	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", cpu_addr, address);
@@ -466,12 +463,7 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu)
 		dest_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 		BUG_ON(dest_vcpu == NULL);
 
-		spin_lock(&dest_vcpu->arch.local_int.lock);
-		if (waitqueue_active(&dest_vcpu->wq))
-			wake_up_interruptible(&dest_vcpu->wq);
-		dest_vcpu->preempted = true;
-		spin_unlock(&dest_vcpu->arch.local_int.lock);
-
+		kvm_s390_vcpu_wakeup(dest_vcpu);
 		kvm_s390_set_psw_cc(vcpu, SIGP_CC_ORDER_CODE_ACCEPTED);
 		return 0;
 	}
-- 
1.8.4.2
