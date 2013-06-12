From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 4/6] KVM: s390: Use common waitqueue
Date: Wed, 12 Jun 2013 13:54:55 +0200
Message-ID: <1371038097-28577-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Lets use the common waitqueue for kvm cpus on s390. By itself it is
just a cleanup, but it should also improve the accuracy of diag 0x44
which is implemented via kvm_vcpu_on_spin. kvm_vcpu_on_spin has
an explicit check for waiting on the waitqueue to optimize the
yielding.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/interrupt.c        | 18 +++++++++---------
 arch/s390/kvm/kvm-s390.c         |  2 +-
 arch/s390/kvm/sigp.c             | 16 ++++++++--------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 43207dd..d3ffd7e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -228,7 +228,7 @@ struct kvm_s390_local_interrupt {
 	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
 	int timer_due; /* event indicator for waitqueue below */
-	wait_queue_head_t wq;
+	wait_queue_head_t *wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
 };
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5c94817..7f35cb3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -438,7 +438,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 no_timer:
 	spin_lock(&vcpu->arch.local_int.float_int->lock);
 	spin_lock_bh(&vcpu->arch.local_int.lock);
-	add_wait_queue(&vcpu->arch.local_int.wq, &wait);
+	add_wait_queue(&vcpu->wq, &wait);
 	while (list_empty(&vcpu->arch.local_int.list) &&
 		list_empty(&vcpu->arch.local_int.float_int->list) &&
 		(!vcpu->arch.local_int.timer_due) &&
@@ -452,7 +452,7 @@ no_timer:
 	}
 	__unset_cpu_idle(vcpu);
 	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&vcpu->arch.local_int.wq, &wait);
+	remove_wait_queue(&vcpu->wq, &wait);
 	spin_unlock_bh(&vcpu->arch.local_int.lock);
 	spin_unlock(&vcpu->arch.local_int.float_int->lock);
 	hrtimer_try_to_cancel(&vcpu->arch.ckc_timer);
@@ -465,8 +465,8 @@ void kvm_s390_tasklet(unsigned long parm)
 
 	spin_lock(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.timer_due = 1;
-	if (waitqueue_active(&vcpu->arch.local_int.wq))
-		wake_up_interruptible(&vcpu->arch.local_int.wq);
+	if (waitqueue_active(&vcpu->wq))
+		wake_up_interruptible(&vcpu->wq);
 	spin_unlock(&vcpu->arch.local_int.lock);
 }
 
@@ -613,7 +613,7 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 	spin_lock_bh(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	BUG_ON(waitqueue_active(&li->wq));
+	BUG_ON(waitqueue_active(li->wq));
 	spin_unlock_bh(&li->lock);
 	return 0;
 }
@@ -746,8 +746,8 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	li = fi->local_int[sigcpu];
 	spin_lock_bh(&li->lock);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(&li->wq))
-		wake_up_interruptible(&li->wq);
+	if (waitqueue_active(li->wq))
+		wake_up_interruptible(li->wq);
 	spin_unlock_bh(&li->lock);
 	spin_unlock(&fi->lock);
 	mutex_unlock(&kvm->lock);
@@ -832,8 +832,8 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	if (inti->type == KVM_S390_SIGP_STOP)
 		li->action_bits |= ACTION_STOP_ON_STOP;
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(&li->wq))
-		wake_up_interruptible(&vcpu->arch.local_int.wq);
+	if (waitqueue_active(&vcpu->wq))
+		wake_up_interruptible(&vcpu->wq);
 	spin_unlock_bh(&li->lock);
 	mutex_unlock(&vcpu->kvm->lock);
 	return 0;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 757e1c6..22e8ace 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -438,7 +438,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
 	spin_lock(&kvm->arch.float_int.lock);
 	kvm->arch.float_int.local_int[id] = &vcpu->arch.local_int;
-	init_waitqueue_head(&vcpu->arch.local_int.wq);
+	vcpu->arch.local_int.wq = &vcpu->wq;
 	vcpu->arch.local_int.cpuflags = &vcpu->arch.sie_block->cpuflags;
 	spin_unlock(&kvm->arch.float_int.lock);
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 1c48ab2..033c864 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -79,8 +79,8 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(&li->wq))
-		wake_up_interruptible(&li->wq);
+	if (waitqueue_active(li->wq))
+		wake_up_interruptible(li->wq);
 	spin_unlock_bh(&li->lock);
 	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x", cpu_addr);
@@ -117,8 +117,8 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(&li->wq))
-		wake_up_interruptible(&li->wq);
+	if (waitqueue_active(li->wq))
+		wake_up_interruptible(li->wq);
 	spin_unlock_bh(&li->lock);
 	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x", cpu_addr);
@@ -145,8 +145,8 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 	atomic_set(&li->active, 1);
 	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
 	li->action_bits |= action;
-	if (waitqueue_active(&li->wq))
-		wake_up_interruptible(&li->wq);
+	if (waitqueue_active(li->wq))
+		wake_up_interruptible(li->wq);
 out:
 	spin_unlock_bh(&li->lock);
 
@@ -250,8 +250,8 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	if (waitqueue_active(&li->wq))
-		wake_up_interruptible(&li->wq);
+	if (waitqueue_active(li->wq))
+		wake_up_interruptible(li->wq);
 	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
 	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", cpu_addr, address);
-- 
1.8.1.6
