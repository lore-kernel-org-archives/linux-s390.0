From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/9] KVM: s390: step VCPU cpu timer during kvm_run ioctl
Date: Thu, 10 Mar 2016 16:36:54 +0100
Message-ID: <1457624219-110920-5-git-send-email-borntraeger@de.ibm.com>
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

Architecturally we should only provide steal time if we are scheduled
away, and not if the host interprets a guest exit. We have to step
the guest CPU timer in these cases.

In the first shot, we will step the VCPU timer only during the kvm_run
ioctl. Therefore all time spent e.g. in interception handlers or on irq
delivery will be accounted for that VCPU.

We have to take care of a few special cases:
- Other VCPUs can test for pending irqs. We can only report a consistent
  value for the VCPU thread itself when adding the delta.
- We have to take care of STP sync, therefore we have to extend
  kvm_clock_sync() and disable preemption accordingly
- During any call to disable/enable/start/stop we could get premeempted
  and therefore get start/stop calls. Therefore we have to make sure we
  don't get into an inconsistent state.

Whenever a VCPU is scheduled out, sleeping, in user space or just about
to enter the SIE, the guest cpu timer isn't stepped.

Please note that all primitives are prepared to be called from both
environments (cpu timer accounting enabled or not), although not completely
used in this patch yet (e.g. kvm_s390_set_cpu_timer() will never be called
while cpu timer accounting is enabled).

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/kvm-s390.c         | 76 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 727e7f7..91796dd 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -552,6 +552,8 @@ struct kvm_vcpu_arch {
 	unsigned long pfault_token;
 	unsigned long pfault_select;
 	unsigned long pfault_compare;
+	bool cputm_enabled;
+	__u64 cputm_start;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2118a22..76b9914 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -158,6 +158,8 @@ static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
 		kvm->arch.epoch -= *delta;
 		kvm_for_each_vcpu(i, vcpu, kvm) {
 			vcpu->arch.sie_block->epoch -= *delta;
+			if (vcpu->arch.cputm_enabled)
+				vcpu->arch.cputm_start += *delta;
 		}
 	}
 	return NOTIFY_OK;
@@ -1429,16 +1431,78 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+/* needs disabled preemption to protect from TOD sync and vcpu_load/put */
+static void __start_cpu_timer_accounting(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(vcpu->arch.cputm_start != 0);
+	vcpu->arch.cputm_start = get_tod_clock_fast();
+}
+
+/* needs disabled preemption to protect from TOD sync and vcpu_load/put */
+static void __stop_cpu_timer_accounting(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(vcpu->arch.cputm_start == 0);
+	vcpu->arch.sie_block->cputm -= get_tod_clock_fast() - vcpu->arch.cputm_start;
+	vcpu->arch.cputm_start = 0;
+}
+
+/* needs disabled preemption to protect from TOD sync and vcpu_load/put */
+static void __enable_cpu_timer_accounting(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(vcpu->arch.cputm_enabled);
+	vcpu->arch.cputm_enabled = true;
+	__start_cpu_timer_accounting(vcpu);
+}
+
+/* needs disabled preemption to protect from TOD sync and vcpu_load/put */
+static void __disable_cpu_timer_accounting(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(!vcpu->arch.cputm_enabled);
+	__stop_cpu_timer_accounting(vcpu);
+	vcpu->arch.cputm_enabled = false;
+}
+
+static void enable_cpu_timer_accounting(struct kvm_vcpu *vcpu)
+{
+	preempt_disable(); /* protect from TOD sync and vcpu_load/put */
+	__enable_cpu_timer_accounting(vcpu);
+	preempt_enable();
+}
+
+static void disable_cpu_timer_accounting(struct kvm_vcpu *vcpu)
+{
+	preempt_disable(); /* protect from TOD sync and vcpu_load/put */
+	__disable_cpu_timer_accounting(vcpu);
+	preempt_enable();
+}
+
 /* set the cpu timer - may only be called from the VCPU thread itself */
 void kvm_s390_set_cpu_timer(struct kvm_vcpu *vcpu, __u64 cputm)
 {
+	preempt_disable(); /* protect from TOD sync and vcpu_load/put */
+	if (vcpu->arch.cputm_enabled)
+		vcpu->arch.cputm_start = get_tod_clock_fast();
 	vcpu->arch.sie_block->cputm = cputm;
+	preempt_enable();
 }
 
-/* get the cpu timer - can also be called from other VCPU threads */
+/* update and get the cpu timer - can also be called from other VCPU threads */
 __u64 kvm_s390_get_cpu_timer(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.sie_block->cputm;
+	__u64 value;
+	int me;
+
+	if (unlikely(!vcpu->arch.cputm_enabled))
+		return vcpu->arch.sie_block->cputm;
+
+	me = get_cpu(); /* also protects from TOD sync and vcpu_load/put */
+	value = vcpu->arch.sie_block->cputm;
+	if (likely(me == vcpu->cpu)) {
+		/* the VCPU itself will always read consistent values */
+		value -= get_tod_clock_fast() - vcpu->arch.cputm_start;
+	}
+	put_cpu();
+	return value;
 }
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
@@ -1461,12 +1525,16 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.gmap);
 	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	if (vcpu->arch.cputm_enabled)
+		__start_cpu_timer_accounting(vcpu);
 	vcpu->cpu = cpu;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	vcpu->cpu = -1;
+	if (vcpu->arch.cputm_enabled)
+		__stop_cpu_timer_accounting(vcpu);
 	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	gmap_disable(vcpu->arch.gmap);
 
@@ -2277,10 +2345,12 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		 */
 		local_irq_disable();
 		__kvm_guest_enter();
+		__disable_cpu_timer_accounting(vcpu);
 		local_irq_enable();
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
 		local_irq_disable();
+		__enable_cpu_timer_accounting(vcpu);
 		__kvm_guest_exit();
 		local_irq_enable();
 		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
@@ -2358,6 +2428,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	}
 
 	sync_regs(vcpu, kvm_run);
+	enable_cpu_timer_accounting(vcpu);
 
 	might_fault();
 	rc = __vcpu_run(vcpu);
@@ -2377,6 +2448,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		rc = 0;
 	}
 
+	disable_cpu_timer_accounting(vcpu);
 	store_regs(vcpu, kvm_run);
 
 	if (vcpu->sigset_active)
-- 
2.5.0
