From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/9] KVM: s390: remove _bh locking from local_int.lock
Date: Mon, 21 Jul 2014 21:14:18 +0200
Message-ID: <1405970065-3740-3-git-send-email-borntraeger@de.ibm.com>
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

local_int.lock is not used in a bottom-half handler anymore, therefore we can
turn it into an ordinary spin_lock at all occurrences.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 32 ++++++++++++++++----------------
 arch/s390/kvm/kvm-s390.c  |  4 ++--
 arch/s390/kvm/sigp.c      | 20 ++++++++++----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5fd11ce..86575b4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -544,13 +544,13 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
 	int rc = 0;
 
 	if (atomic_read(&li->active)) {
-		spin_lock_bh(&li->lock);
+		spin_lock(&li->lock);
 		list_for_each_entry(inti, &li->list, list)
 			if (__interrupt_is_deliverable(vcpu, inti)) {
 				rc = 1;
 				break;
 			}
-		spin_unlock_bh(&li->lock);
+		spin_unlock(&li->lock);
 	}
 
 	if ((!rc) && atomic_read(&fi->active)) {
@@ -645,13 +645,13 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_interrupt_info  *n, *inti = NULL;
 
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	list_for_each_entry_safe(inti, n, &li->list, list) {
 		list_del(&inti->list);
 		kfree(inti);
 	}
 	atomic_set(&li->active, 0);
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 
 	/* clear pending external calls set by sigp interpretation facility */
 	atomic_clear_mask(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
@@ -670,7 +670,7 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	if (atomic_read(&li->active)) {
 		do {
 			deliver = 0;
-			spin_lock_bh(&li->lock);
+			spin_lock(&li->lock);
 			list_for_each_entry_safe(inti, n, &li->list, list) {
 				if (__interrupt_is_deliverable(vcpu, inti)) {
 					list_del(&inti->list);
@@ -681,7 +681,7 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 			}
 			if (list_empty(&li->list))
 				atomic_set(&li->active, 0);
-			spin_unlock_bh(&li->lock);
+			spin_unlock(&li->lock);
 			if (deliver) {
 				__do_deliver_interrupt(vcpu, inti);
 				kfree(inti);
@@ -727,7 +727,7 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
 	if (atomic_read(&li->active)) {
 		do {
 			deliver = 0;
-			spin_lock_bh(&li->lock);
+			spin_lock(&li->lock);
 			list_for_each_entry_safe(inti, n, &li->list, list) {
 				if ((inti->type == KVM_S390_MCHK) &&
 				    __interrupt_is_deliverable(vcpu, inti)) {
@@ -739,7 +739,7 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
 			}
 			if (list_empty(&li->list))
 				atomic_set(&li->active, 0);
-			spin_unlock_bh(&li->lock);
+			spin_unlock(&li->lock);
 			if (deliver) {
 				__do_deliver_interrupt(vcpu, inti);
 				kfree(inti);
@@ -786,11 +786,11 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 
 	VCPU_EVENT(vcpu, 3, "inject: program check %d (from kernel)", code);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, inti->type, code, 0, 1);
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
 	BUG_ON(waitqueue_active(li->wq));
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 	return 0;
 }
 
@@ -811,11 +811,11 @@ int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 
 	inti->type = KVM_S390_PROGRAM_INT;
 	memcpy(&inti->pgm, pgm_info, sizeof(inti->pgm));
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
 	BUG_ON(waitqueue_active(li->wq));
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 	return 0;
 }
 
@@ -903,12 +903,12 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	}
 	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
 	li = &dst_vcpu->arch.local_int;
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
 	kvm_get_vcpu(kvm, sigcpu)->preempted = true;
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 unlock_fi:
 	spin_unlock(&fi->lock);
 	mutex_unlock(&kvm->lock);
@@ -1050,7 +1050,7 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 
 	mutex_lock(&vcpu->kvm->lock);
 	li = &vcpu->arch.local_int;
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	if (inti->type == KVM_S390_PROGRAM_INT)
 		list_add(&inti->list, &li->list);
 	else
@@ -1062,7 +1062,7 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	if (waitqueue_active(&vcpu->wq))
 		wake_up_interruptible(&vcpu->wq);
 	vcpu->preempted = true;
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 	mutex_unlock(&vcpu->kvm->lock);
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ecb1357..a7bda18 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1522,13 +1522,13 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
 	/* Need to lock access to action_bits to avoid a SIGP race condition */
-	spin_lock_bh(&vcpu->arch.local_int.lock);
+	spin_lock(&vcpu->arch.local_int.lock);
 	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 
 	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
 	vcpu->arch.local_int.action_bits &=
 				 ~(ACTION_STOP_ON_STOP | ACTION_STORE_ON_STOP);
-	spin_unlock_bh(&vcpu->arch.local_int.lock);
+	spin_unlock(&vcpu->arch.local_int.lock);
 
 	__disable_ibs_on_vcpu(vcpu);
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index fd7fb5c..946992f 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -135,7 +135,7 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 		return -ENOMEM;
 	inti->type = KVM_S390_SIGP_STOP;
 
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP) {
 		/* another SIGP STOP is pending */
 		rc = SIGP_CC_BUSY;
@@ -154,7 +154,7 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
 out:
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 
 	return rc;
 }
@@ -243,7 +243,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	if (!inti)
 		return SIGP_CC_BUSY;
 
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	/* cpu must be in stopped state */
 	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
@@ -264,7 +264,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 
 	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", cpu_addr, address);
 out_li:
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 	return rc;
 }
 
@@ -280,9 +280,9 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu, u16 cpu_id,
 	if (!dst_vcpu)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	spin_lock_bh(&dst_vcpu->arch.local_int.lock);
+	spin_lock(&dst_vcpu->arch.local_int.lock);
 	flags = atomic_read(dst_vcpu->arch.local_int.cpuflags);
-	spin_unlock_bh(&dst_vcpu->arch.local_int.lock);
+	spin_unlock(&dst_vcpu->arch.local_int.lock);
 	if (!(flags & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
@@ -343,10 +343,10 @@ static int sigp_check_callable(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	if (!dst_vcpu)
 		return SIGP_CC_NOT_OPERATIONAL;
 	li = &dst_vcpu->arch.local_int;
-	spin_lock_bh(&li->lock);
+	spin_lock(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP)
 		rc = SIGP_CC_BUSY;
-	spin_unlock_bh(&li->lock);
+	spin_unlock(&li->lock);
 
 	return rc;
 }
@@ -466,11 +466,11 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu)
 		dest_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 		BUG_ON(dest_vcpu == NULL);
 
-		spin_lock_bh(&dest_vcpu->arch.local_int.lock);
+		spin_lock(&dest_vcpu->arch.local_int.lock);
 		if (waitqueue_active(&dest_vcpu->wq))
 			wake_up_interruptible(&dest_vcpu->wq);
 		dest_vcpu->preempted = true;
-		spin_unlock_bh(&dest_vcpu->arch.local_int.lock);
+		spin_unlock(&dest_vcpu->arch.local_int.lock);
 
 		kvm_s390_set_psw_cc(vcpu, SIGP_CC_ORDER_CODE_ACCEPTED);
 		return 0;
-- 
1.8.4.2
