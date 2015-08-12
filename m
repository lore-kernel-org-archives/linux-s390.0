From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: host STP toleration for VMs
Date: Wed, 12 Aug 2015 20:49:28 +0200
Message-ID: <1439405369-60552-2-git-send-email-borntraeger@de.ibm.com>
References: <1439405369-60552-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1439405369-60552-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Fan Zhang <zhangfan@linux.vnet.ibm.com>

If the host has STP enabled, the TOD of the host will be changed during
synchronization phases. These are performed during a stop_machine() call.

As the guest TOD is based on the host TOD, we have to make sure that:
- no VCPU is in the SIE (implicitly guaranteed via stop_machine())
- manual guest TOD calculations are not affected

"Epoch" is the guest TOD clock delta to the host TOD clock. We have to
adjust that value during the STP synchronization and make sure that code
that accesses the epoch won't get interrupted in between (via disabling
preemption).

Signed-off-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/etr.h |  3 +++
 arch/s390/kernel/time.c     | 16 +++++++++++++---
 arch/s390/kvm/interrupt.c   | 10 +++++++++-
 arch/s390/kvm/kvm-s390.c    | 38 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/priv.c        |  2 ++
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/etr.h b/arch/s390/include/asm/etr.h
index 629b79a..f7e5c36 100644
--- a/arch/s390/include/asm/etr.h
+++ b/arch/s390/include/asm/etr.h
@@ -214,6 +214,9 @@ static inline int etr_ptff(void *ptff_block, unsigned int func)
 void etr_switch_to_local(void);
 void etr_sync_check(void);
 
+/* notifier for syncs */
+extern struct atomic_notifier_head s390_epoch_delta_notifier;
+
 /* STP interruption parameter */
 struct stp_irq_parm {
 	unsigned int _pad0	: 14;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 9e733d9..627887b 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -58,6 +58,9 @@ EXPORT_SYMBOL_GPL(sched_clock_base_cc);
 
 static DEFINE_PER_CPU(struct clock_event_device, comparators);
 
+ATOMIC_NOTIFIER_HEAD(s390_epoch_delta_notifier);
+EXPORT_SYMBOL(s390_epoch_delta_notifier);
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -752,7 +755,7 @@ static void clock_sync_cpu(struct clock_sync_data *sync)
 static int etr_sync_clock(void *data)
 {
 	static int first;
-	unsigned long long clock, old_clock, delay, delta;
+	unsigned long long clock, old_clock, clock_delta, delay, delta;
 	struct clock_sync_data *etr_sync;
 	struct etr_aib *sync_port, *aib;
 	int port;
@@ -789,6 +792,9 @@ static int etr_sync_clock(void *data)
 		delay = (unsigned long long)
 			(aib->edf2.etv - sync_port->edf2.etv) << 32;
 		delta = adjust_time(old_clock, clock, delay);
+		clock_delta = clock - old_clock;
+		atomic_notifier_call_chain(&s390_epoch_delta_notifier, 0,
+					   &clock_delta);
 		etr_sync->fixup_cc = delta;
 		fixup_clock_comparator(delta);
 		/* Verify that the clock is properly set. */
@@ -1526,7 +1532,7 @@ void stp_island_check(void)
 static int stp_sync_clock(void *data)
 {
 	static int first;
-	unsigned long long old_clock, delta;
+	unsigned long long old_clock, delta, new_clock, clock_delta;
 	struct clock_sync_data *stp_sync;
 	int rc;
 
@@ -1551,7 +1557,11 @@ static int stp_sync_clock(void *data)
 		old_clock = get_tod_clock();
 		rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0);
 		if (rc == 0) {
-			delta = adjust_time(old_clock, get_tod_clock(), 0);
+			new_clock = get_tod_clock();
+			delta = adjust_time(old_clock, new_clock, 0);
+			clock_delta = new_clock - old_clock;
+			atomic_notifier_call_chain(&s390_epoch_delta_notifier,
+						   0, &clock_delta);
 			fixup_clock_comparator(delta);
 			rc = chsc_sstpi(stp_page, &stp_info,
 					sizeof(struct stp_sstpi));
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a578140..b277d50 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -71,9 +71,13 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 
 static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 {
+	preempt_disable();
 	if (!(vcpu->arch.sie_block->ckc <
-	      get_tod_clock_fast() + vcpu->arch.sie_block->epoch))
+	      get_tod_clock_fast() + vcpu->arch.sie_block->epoch)) {
+		preempt_enable();
 		return 0;
+	}
+	preempt_enable();
 	return ckc_interrupts_enabled(vcpu);
 }
 
@@ -856,7 +860,9 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 		goto no_timer;
 	}
 
+	preempt_disable();
 	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
+	preempt_enable();
 	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
 
 	/* underflow */
@@ -895,7 +901,9 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 	u64 now, sltime;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.ckc_timer);
+	preempt_disable();
 	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
+	preempt_enable();
 	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
 
 	/*
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 924b1ae..4bdb860 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -28,6 +28,7 @@
 #include <linux/vmalloc.h>
 #include <asm/asm-offsets.h>
 #include <asm/lowcore.h>
+#include <asm/etr.h>
 #include <asm/pgtable.h>
 #include <asm/nmi.h>
 #include <asm/switch_to.h>
@@ -138,16 +139,47 @@ int kvm_arch_hardware_enable(void)
 
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address);
 
+/*
+ * This callback is executed during stop_machine(). All CPUs are therefore
+ * temporarily stopped. In order not to change guest behavior, we have to
+ * disable preemption whenever we touch the epoch of kvm and the VCPUs,
+ * so a CPU won't be stopped while calculating with the epoch.
+ */
+static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
+			  void *v)
+{
+	struct kvm *kvm;
+	struct kvm_vcpu *vcpu;
+	int i;
+	unsigned long long *delta = v;
+
+	list_for_each_entry(kvm, &vm_list, vm_list) {
+		kvm->arch.epoch -= *delta;
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			vcpu->arch.sie_block->epoch -= *delta;
+		}
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kvm_clock_notifier = {
+	.notifier_call = kvm_clock_sync,
+};
+
 int kvm_arch_hardware_setup(void)
 {
 	gmap_notifier.notifier_call = kvm_gmap_notifier;
 	gmap_register_ipte_notifier(&gmap_notifier);
+	atomic_notifier_chain_register(&s390_epoch_delta_notifier,
+				       &kvm_clock_notifier);
 	return 0;
 }
 
 void kvm_arch_hardware_unsetup(void)
 {
 	gmap_unregister_ipte_notifier(&gmap_notifier);
+	atomic_notifier_chain_unregister(&s390_epoch_delta_notifier,
+					 &kvm_clock_notifier);
 }
 
 int kvm_arch_init(void *opaque)
@@ -501,11 +533,13 @@ static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 		return r;
 
 	mutex_lock(&kvm->lock);
+	preempt_disable();
 	kvm->arch.epoch = gtod - host_tod;
 	kvm_s390_vcpu_block_all(kvm);
 	kvm_for_each_vcpu(vcpu_idx, cur_vcpu, kvm)
 		cur_vcpu->arch.sie_block->epoch = kvm->arch.epoch;
 	kvm_s390_vcpu_unblock_all(kvm);
+	preempt_enable();
 	mutex_unlock(&kvm->lock);
 	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx\n", gtod);
 	return 0;
@@ -553,7 +587,9 @@ static int kvm_s390_get_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (r)
 		return r;
 
+	preempt_disable();
 	gtod = host_tod + kvm->arch.epoch;
+	preempt_enable();
 	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
 		return -EFAULT;
 	VM_EVENT(kvm, 3, "QUERY: TOD base: 0x%llx\n", gtod);
@@ -1314,7 +1350,9 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
 	mutex_lock(&vcpu->kvm->lock);
+	preempt_disable();
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
+	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm))
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index afefa3b..4d21dc4 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -57,8 +57,10 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 	val = (val - hostclk) & ~0x3fUL;
 
 	mutex_lock(&vcpu->kvm->lock);
+	preempt_disable();
 	kvm_for_each_vcpu(i, cpup, vcpu->kvm)
 		cpup->arch.sie_block->epoch = val;
+	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
 
 	kvm_s390_set_psw_cc(vcpu, 0);
-- 
2.3.0
