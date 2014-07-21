From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/9] KVM: s390: cleanup handle_wait by reusing kvm_vcpu_block
Date: Mon, 21 Jul 2014 21:14:17 +0200
Message-ID: <1405970065-3740-2-git-send-email-borntraeger@de.ibm.com>
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

This patch cleans up the code in handle_wait by reusing the common code
function kvm_vcpu_block.

signal_pending(), kvm_cpu_has_pending_timer() and kvm_arch_vcpu_runnable() are
sufficient for checking if we need to wake-up that VCPU. kvm_vcpu_block
uses these functions, so no checks are lost.

The flag "timer_due" can be removed - kvm_cpu_has_pending_timer() tests whether
the timer is pending, thus the vcpu is correctly woken up.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 -
 arch/s390/kvm/interrupt.c        | 41 +++++-----------------------------------
 arch/s390/kvm/kvm-s390.c         |  3 +++
 3 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c2ba020..b3acf28 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -305,7 +305,6 @@ struct kvm_s390_local_interrupt {
 	struct list_head list;
 	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
-	int timer_due; /* event indicator for waitqueue below */
 	wait_queue_head_t *wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 90c8de2..5fd11ce 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -585,60 +585,32 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 {
 	u64 now, sltime;
-	DECLARE_WAITQUEUE(wait, current);
 
 	vcpu->stat.exit_wait_state++;
-	if (kvm_cpu_has_interrupt(vcpu))
-		return 0;
 
-	__set_cpu_idle(vcpu);
-	spin_lock_bh(&vcpu->arch.local_int.lock);
-	vcpu->arch.local_int.timer_due = 0;
-	spin_unlock_bh(&vcpu->arch.local_int.lock);
+	/* fast path */
+	if (kvm_cpu_has_pending_timer(vcpu) || kvm_arch_vcpu_runnable(vcpu))
+		return 0;
 
 	if (psw_interrupts_disabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "disabled wait");
-		__unset_cpu_idle(vcpu);
 		return -EOPNOTSUPP; /* disabled wait */
 	}
 
+	__set_cpu_idle(vcpu);
 	if (!ckc_interrupts_enabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "enabled wait w/o timer");
 		goto no_timer;
 	}
 
 	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
-	if (vcpu->arch.sie_block->ckc < now) {
-		__unset_cpu_idle(vcpu);
-		return 0;
-	}
-
 	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
-
 	hrtimer_start(&vcpu->arch.ckc_timer, ktime_set (0, sltime) , HRTIMER_MODE_REL);
 	VCPU_EVENT(vcpu, 5, "enabled wait via clock comparator: %llx ns", sltime);
 no_timer:
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
-	spin_lock(&vcpu->arch.local_int.float_int->lock);
-	spin_lock_bh(&vcpu->arch.local_int.lock);
-	add_wait_queue(&vcpu->wq, &wait);
-	while (list_empty(&vcpu->arch.local_int.list) &&
-		list_empty(&vcpu->arch.local_int.float_int->list) &&
-		(!vcpu->arch.local_int.timer_due) &&
-		!signal_pending(current) &&
-		!kvm_s390_si_ext_call_pending(vcpu)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock_bh(&vcpu->arch.local_int.lock);
-		spin_unlock(&vcpu->arch.local_int.float_int->lock);
-		schedule();
-		spin_lock(&vcpu->arch.local_int.float_int->lock);
-		spin_lock_bh(&vcpu->arch.local_int.lock);
-	}
+	kvm_vcpu_block(vcpu);
 	__unset_cpu_idle(vcpu);
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&vcpu->wq, &wait);
-	spin_unlock_bh(&vcpu->arch.local_int.lock);
-	spin_unlock(&vcpu->arch.local_int.float_int->lock);
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	hrtimer_try_to_cancel(&vcpu->arch.ckc_timer);
@@ -649,11 +621,8 @@ void kvm_s390_tasklet(unsigned long parm)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) parm;
 
-	spin_lock(&vcpu->arch.local_int.lock);
-	vcpu->arch.local_int.timer_due = 1;
 	if (waitqueue_active(&vcpu->wq))
 		wake_up_interruptible(&vcpu->wq);
-	spin_unlock(&vcpu->arch.local_int.lock);
 }
 
 /*
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fdf88f7..ecb1357 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1068,6 +1068,9 @@ retry:
 		goto retry;
 	}
 
+	/* nothing to do, just clear the request */
+	clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
+
 	return 0;
 }
 
-- 
1.8.4.2
