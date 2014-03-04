From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 5/8] KVM: s390: get rid of local_int array
Date: Tue,  4 Mar 2014 12:27:15 +0100
Message-ID: <1393932438-58848-6-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

We can use kvm_get_vcpu() now and don't need the
local_int array in the floating_int struct anymore.
This also means we don't have to hold the float_int.lock
in some places.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   1 -
 arch/s390/kvm/interrupt.c        |   6 +-
 arch/s390/kvm/kvm-s390.c         |   5 +-
 arch/s390/kvm/sigp.c             | 124 ++++++++++++++++-----------------------
 4 files changed, 56 insertions(+), 80 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 062b78c..734d302 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -215,7 +215,6 @@ struct kvm_s390_float_interrupt {
 	int next_rr_cpu;
 	unsigned long idle_mask[(KVM_MAX_VCPUS + sizeof(long) - 1)
 				/ sizeof(long)];
-	struct kvm_s390_local_interrupt *local_int[KVM_MAX_VCPUS];
 	unsigned int irq_count;
 };
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fff070b..1d0f9d5 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -692,6 +692,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	struct kvm_s390_local_interrupt *li;
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_interrupt_info *iter;
+	struct kvm_vcpu *dst_vcpu = NULL;
 	int sigcpu;
 	int rc = 0;
 
@@ -726,9 +727,10 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 			sigcpu = fi->next_rr_cpu++;
 			if (sigcpu == KVM_MAX_VCPUS)
 				sigcpu = fi->next_rr_cpu = 0;
-		} while (fi->local_int[sigcpu] == NULL);
+		} while (kvm_get_vcpu(kvm, sigcpu) == NULL);
 	}
-	li = fi->local_int[sigcpu];
+	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
+	li = &dst_vcpu->arch.local_int;
 	spin_lock_bh(&li->lock);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	if (waitqueue_active(li->wq))
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a3e4c07..9136f8d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -460,11 +460,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	INIT_LIST_HEAD(&vcpu->arch.local_int.list);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
-	spin_lock(&kvm->arch.float_int.lock);
-	kvm->arch.float_int.local_int[id] = &vcpu->arch.local_int;
 	vcpu->arch.local_int.wq = &vcpu->wq;
 	vcpu->arch.local_int.cpuflags = &vcpu->arch.sie_block->cpuflags;
-	spin_unlock(&kvm->arch.float_int.lock);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
 	if (rc)
@@ -952,7 +949,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 	atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 
-	BUG_ON(vcpu->kvm->arch.float_int.local_int[vcpu->vcpu_id] == NULL);
+	BUG_ON(kvm_get_vcpu(vcpu->kvm, vcpu->vcpu_id) == NULL);
 
 	switch (kvm_run->exit_reason) {
 	case KVM_EXIT_S390_SIEIC:
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 466eefa..3fe44c4 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -23,29 +23,30 @@
 static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 			u64 *reg)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
+	struct kvm_s390_local_interrupt *li;
+	struct kvm_vcpu *dst_vcpu = NULL;
+	int cpuflags;
 	int rc;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	spin_lock(&fi->lock);
-	if (fi->local_int[cpu_addr] == NULL)
-		rc = SIGP_CC_NOT_OPERATIONAL;
-	else if (!(atomic_read(fi->local_int[cpu_addr]->cpuflags)
-		   & (CPUSTAT_ECALL_PEND | CPUSTAT_STOPPED)))
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
+
+	cpuflags = atomic_read(li->cpuflags);
+	if (!(cpuflags & (CPUSTAT_ECALL_PEND | CPUSTAT_STOPPED)))
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	else {
 		*reg &= 0xffffffff00000000UL;
-		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
-		    & CPUSTAT_ECALL_PEND)
+		if (cpuflags & CPUSTAT_ECALL_PEND)
 			*reg |= SIGP_STATUS_EXT_CALL_PENDING;
-		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
-		    & CPUSTAT_STOPPED)
+		if (cpuflags & CPUSTAT_STOPPED)
 			*reg |= SIGP_STATUS_STOPPED;
 		rc = SIGP_CC_STATUS_STORED;
 	}
-	spin_unlock(&fi->lock);
 
 	VCPU_EVENT(vcpu, 4, "sensed status of cpu %x rc %x", cpu_addr, rc);
 	return rc;
@@ -53,10 +54,9 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 
 static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
 	struct kvm_s390_interrupt_info *inti;
-	int rc;
+	struct kvm_vcpu *dst_vcpu = NULL;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
 		return SIGP_CC_NOT_OPERATIONAL;
@@ -68,13 +68,10 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	inti->type = KVM_S390_INT_EMERGENCY;
 	inti->emerg.code = vcpu->vcpu_id;
 
-	spin_lock(&fi->lock);
-	li = fi->local_int[cpu_addr];
-	if (li == NULL) {
-		rc = SIGP_CC_NOT_OPERATIONAL;
-		kfree(inti);
-		goto unlock;
-	}
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
 	spin_lock_bh(&li->lock);
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
@@ -82,11 +79,9 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
 	spin_unlock_bh(&li->lock);
-	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x", cpu_addr);
-unlock:
-	spin_unlock(&fi->lock);
-	return rc;
+
+	return SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
@@ -122,10 +117,9 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
 
 static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
 	struct kvm_s390_interrupt_info *inti;
-	int rc;
+	struct kvm_vcpu *dst_vcpu = NULL;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
 		return SIGP_CC_NOT_OPERATIONAL;
@@ -137,13 +131,10 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	inti->type = KVM_S390_INT_EXTERNAL_CALL;
 	inti->extcall.code = vcpu->vcpu_id;
 
-	spin_lock(&fi->lock);
-	li = fi->local_int[cpu_addr];
-	if (li == NULL) {
-		rc = SIGP_CC_NOT_OPERATIONAL;
-		kfree(inti);
-		goto unlock;
-	}
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
 	spin_lock_bh(&li->lock);
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
@@ -151,11 +142,9 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
 	spin_unlock_bh(&li->lock);
-	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x", cpu_addr);
-unlock:
-	spin_unlock(&fi->lock);
-	return rc;
+
+	return SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
@@ -189,31 +178,26 @@ out:
 
 static int __sigp_stop(struct kvm_vcpu *vcpu, u16 cpu_addr, int action)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
+	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	spin_lock(&fi->lock);
-	li = fi->local_int[cpu_addr];
-	if (li == NULL) {
-		rc = SIGP_CC_NOT_OPERATIONAL;
-		goto unlock;
-	}
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
 
 	rc = __inject_sigp_stop(li, action);
 
-unlock:
-	spin_unlock(&fi->lock);
 	VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x", cpu_addr);
 
 	if ((action & ACTION_STORE_ON_STOP) != 0 && rc == -ESHUTDOWN) {
 		/* If the CPU has already been stopped, we still have
 		 * to save the status when doing stop-and-store. This
 		 * has to be done after unlocking all spinlocks. */
-		struct kvm_vcpu *dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 		rc = kvm_s390_store_status_unloaded(dst_vcpu,
 						KVM_S390_STORE_STATUS_NOADDR);
 	}
@@ -333,28 +317,26 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu, u16 cpu_id,
 static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 				u64 *reg)
 {
+	struct kvm_s390_local_interrupt *li;
+	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc;
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	spin_lock(&fi->lock);
-	if (fi->local_int[cpu_addr] == NULL)
-		rc = SIGP_CC_NOT_OPERATIONAL;
-	else {
-		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
-		    & CPUSTAT_RUNNING) {
-			/* running */
-			rc = SIGP_CC_ORDER_CODE_ACCEPTED;
-		} else {
-			/* not running */
-			*reg &= 0xffffffff00000000UL;
-			*reg |= SIGP_STATUS_NOT_RUNNING;
-			rc = SIGP_CC_STATUS_STORED;
-		}
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
+	if (atomic_read(li->cpuflags) & CPUSTAT_RUNNING) {
+		/* running */
+		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
+	} else {
+		/* not running */
+		*reg &= 0xffffffff00000000UL;
+		*reg |= SIGP_STATUS_NOT_RUNNING;
+		rc = SIGP_CC_STATUS_STORED;
 	}
-	spin_unlock(&fi->lock);
 
 	VCPU_EVENT(vcpu, 4, "sensed running status of cpu %x rc %x", cpu_addr,
 		   rc);
@@ -365,26 +347,22 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 /* Test whether the destination CPU is available and not busy */
 static int sigp_check_callable(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
 	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
+	struct kvm_vcpu *dst_vcpu = NULL;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	spin_lock(&fi->lock);
-	li = fi->local_int[cpu_addr];
-	if (li == NULL) {
-		rc = SIGP_CC_NOT_OPERATIONAL;
-		goto out;
-	}
-
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
 	spin_lock_bh(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP)
 		rc = SIGP_CC_BUSY;
 	spin_unlock_bh(&li->lock);
-out:
-	spin_unlock(&fi->lock);
+
 	return rc;
 }
 
-- 
1.8.4.2
