From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 07/21] KVM: s390: forward hrtimer if guest ckc not pending yet
Date: Thu, 15 Jan 2015 14:43:20 +0100
Message-ID: <1421329414-76826-8-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Patch 0759d0681cae ("KVM: s390: cleanup handle_wait by reusing
kvm_vcpu_block") changed the way pending guest clock comparator
interrupts are detected. It was assumed that as soon as the hrtimer
wakes up, the condition for the guest ckc is satisfied.

This is however only true as long as adjclock() doesn't speed
up the monotonic clock. Reason is that the hrtimer is based on
CLOCK_MONOTONIC, the guest clock comparator detection is based
on the raw TOD clock. If CLOCK_MONOTONIC runs faster than the
TOD clock, the hrtimer wakes the target VCPU up too early and
the target VCPU will not detect any pending interrupts, therefore
going back to sleep. It will never be woken up again because the
hrtimer has finished. The VCPU is stuck.

As a quick fix, we have to forward the hrtimer until the guest
clock comparator is really due, to guarantee properly timed wake
ups.

As the hrtimer callback might be triggered on another cpu, we
have to make sure that the timer is really stopped and not currently
executing the callback on another cpu. This can happen if the vcpu
thread is scheduled onto another physical cpu, but the timer base
is not migrated. So lets use hrtimer_cancel instead of try_to_cancel.

A proper fix might be to introduce a RAW based hrtimer.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5744303..7fbbcbc 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -826,7 +826,7 @@ no_timer:
 	__unset_cpu_idle(vcpu);
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
-	hrtimer_try_to_cancel(&vcpu->arch.ckc_timer);
+	hrtimer_cancel(&vcpu->arch.ckc_timer);
 	return 0;
 }
 
@@ -846,10 +846,20 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 {
 	struct kvm_vcpu *vcpu;
+	u64 now, sltime;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.ckc_timer);
-	kvm_s390_vcpu_wakeup(vcpu);
+	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
+	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
 
+	/*
+	 * If the monotonic clock runs faster than the tod clock we might be
+	 * woken up too early and have to go back to sleep to avoid deadlocks.
+	 */
+	if (vcpu->arch.sie_block->ckc > now &&
+	    hrtimer_forward_now(timer, ns_to_ktime(sltime)))
+		return HRTIMER_RESTART;
+	kvm_s390_vcpu_wakeup(vcpu);
 	return HRTIMER_NORESTART;
 }
 
-- 
1.9.3
