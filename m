From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/9] KVM: s390: wake up when the VCPU cpu timer expires
Date: Thu, 10 Mar 2016 16:36:57 +0100
Message-ID: <1457624219-110920-8-git-send-email-borntraeger@de.ibm.com>
References: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

When the VCPU cpu timer expires, we have to wake up just like when the ckc
triggers. For now, setting up a cpu timer in the guest and going into
enabled wait will never lead to a wakeup. This patch fixes this problem.
Just as for the ckc, we have to take care of waking up too early. We
have to recalculate the sleep time and go back to sleep.

Please note that the timer callback calls kvm_s390_get_cpu_timer() from
interrupt context. As the timer is canceled when leaving handle_wait(),
and we don't do any VCPU cpu timer writes/updates in that function, we can
be sure that we will never try to read the VCPU cpu timer from the same cpu
that is currentyl updating the timer (deadlock).

Reported-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
Tested-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 48 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4604e9a..ef84a80 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -909,9 +909,35 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 	return ckc_irq_pending(vcpu) || cpu_timer_irq_pending(vcpu);
 }
 
+static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
+{
+	u64 now, cputm, sltime = 0;
+
+	if (ckc_interrupts_enabled(vcpu)) {
+		now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+		sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
+		/* already expired or overflow? */
+		if (!sltime || vcpu->arch.sie_block->ckc <= now)
+			return 0;
+		if (cpu_timer_interrupts_enabled(vcpu)) {
+			cputm = kvm_s390_get_cpu_timer(vcpu);
+			/* already expired? */
+			if (cputm >> 63)
+				return 0;
+			return min(sltime, tod_to_ns(cputm));
+		}
+	} else if (cpu_timer_interrupts_enabled(vcpu)) {
+		sltime = kvm_s390_get_cpu_timer(vcpu);
+		/* already expired? */
+		if (sltime >> 63)
+			return 0;
+	}
+	return sltime;
+}
+
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 {
-	u64 now, sltime;
+	u64 sltime;
 
 	vcpu->stat.exit_wait_state++;
 
@@ -924,22 +950,20 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP; /* disabled wait */
 	}
 
-	if (!ckc_interrupts_enabled(vcpu)) {
+	if (!ckc_interrupts_enabled(vcpu) &&
+	    !cpu_timer_interrupts_enabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "enabled wait w/o timer");
 		__set_cpu_idle(vcpu);
 		goto no_timer;
 	}
 
-	now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
-	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
-
-	/* underflow */
-	if (vcpu->arch.sie_block->ckc < now)
+	sltime = __calculate_sltime(vcpu);
+	if (!sltime)
 		return 0;
 
 	__set_cpu_idle(vcpu);
 	hrtimer_start(&vcpu->arch.ckc_timer, ktime_set (0, sltime) , HRTIMER_MODE_REL);
-	VCPU_EVENT(vcpu, 4, "enabled wait via clock comparator: %llu ns", sltime);
+	VCPU_EVENT(vcpu, 4, "enabled wait: %llu ns", sltime);
 no_timer:
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 	kvm_vcpu_block(vcpu);
@@ -966,18 +990,16 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 {
 	struct kvm_vcpu *vcpu;
-	u64 now, sltime;
+	u64 sltime;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.ckc_timer);
-	now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
-	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
+	sltime = __calculate_sltime(vcpu);
 
 	/*
 	 * If the monotonic clock runs faster than the tod clock we might be
 	 * woken up too early and have to go back to sleep to avoid deadlocks.
 	 */
-	if (vcpu->arch.sie_block->ckc > now &&
-	    hrtimer_forward_now(timer, ns_to_ktime(sltime)))
+	if (sltime && hrtimer_forward_now(timer, ns_to_ktime(sltime)))
 		return HRTIMER_RESTART;
 	kvm_s390_vcpu_wakeup(vcpu);
 	return HRTIMER_NORESTART;
-- 
2.5.0
