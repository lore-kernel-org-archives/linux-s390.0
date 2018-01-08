From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] KVM: s390: cleanup struct kvm_s390_float_interrupt
Date: Mon,  8 Jan 2018 20:37:47 +0100
Message-ID: <20180108193747.10818-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

"wq" is not used at all. "cpuflags" can be access directly via the vcpu,
just as "float_int" via vcpu->kvm.

Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Properly make use of dst_vcpu instead of vcpu in sigp.c

 arch/s390/include/asm/kvm_host.h |  3 ---
 arch/s390/kvm/interrupt.c        | 25 +++++++++++--------------
 arch/s390/kvm/kvm-s390.c         |  3 ---
 arch/s390/kvm/kvm-s390.h         |  2 +-
 arch/s390/kvm/sigp.c             | 12 ++++--------
 5 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e14f381757f6..e16a9f2a44ad 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -515,9 +515,6 @@ struct kvm_s390_irq_payload {
 
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
-	struct kvm_s390_float_interrupt *float_int;
-	struct swait_queue_head *wq;
-	atomic_t *cpuflags;
 	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_irq_payload irq;
 	unsigned long pending_irqs;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 818aa4248b0f..f8eb2cfa763a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -107,12 +107,11 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 
 static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc, expect;
 
 	if (!kvm_s390_use_sca_entries())
 		return;
-	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
+	atomic_andnot(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -279,13 +278,13 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
-	set_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
+	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
 }
 
 static void __unset_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	atomic_andnot(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
-	clear_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
+	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
 }
 
 static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
@@ -1228,7 +1227,7 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 
 	li->irq.ext = irq->u.ext;
 	set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
-	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
+	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1253,7 +1252,7 @@ static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	if (test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
 		return -EBUSY;
 	*extcall = irq->u.extcall;
-	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
+	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1329,7 +1328,7 @@ static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 
 	set_bit(irq->u.emerg.code, li->sigp_emerg_pending);
 	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
-	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
+	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1373,7 +1372,7 @@ static int __inject_ckc(struct kvm_vcpu *vcpu)
 				   0, 0);
 
 	set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
-	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
+	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1386,7 +1385,7 @@ static int __inject_cpu_timer(struct kvm_vcpu *vcpu)
 				   0, 0);
 
 	set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
-	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
+	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1546,7 +1545,6 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 static void __floating_irq_kick(struct kvm *kvm, u64 type)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
-	struct kvm_s390_local_interrupt *li;
 	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
 
@@ -1568,16 +1566,15 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
 
 	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
-	li = &dst_vcpu->arch.local_int;
 	switch (type) {
 	case KVM_S390_MCHK:
-		atomic_or(CPUSTAT_STOP_INT, li->cpuflags);
+		__set_cpuflag(dst_vcpu, CPUSTAT_STOP_INT);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		atomic_or(CPUSTAT_IO_INT, li->cpuflags);
+		__set_cpuflag(dst_vcpu, CPUSTAT_IO_INT);
 		break;
 	default:
-		atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
+		__set_cpuflag(dst_vcpu, CPUSTAT_EXT_INT);
 		break;
 	}
 	kvm_s390_vcpu_wakeup(dst_vcpu);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2c93cbbcd15e..2f79ee31666c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2498,9 +2498,6 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
-	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
-	vcpu->arch.local_int.wq = &vcpu->wq;
-	vcpu->arch.local_int.cpuflags = &vcpu->arch.sie_block->cpuflags;
 	seqcount_init(&vcpu->arch.cputm_seqcount);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 5e46ba429bcb..8877116f0159 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -54,7 +54,7 @@ static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 
 static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
 {
-	return test_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
+	return test_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
 }
 
 static inline int kvm_is_ucontrol(struct kvm *kvm)
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index c1f5cde2c878..5cafd1e2651b 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -20,14 +20,11 @@
 static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 			u64 *reg)
 {
-	struct kvm_s390_local_interrupt *li;
 	int cpuflags;
 	int rc;
 	int ext_call_pending;
 
-	li = &dst_vcpu->arch.local_int;
-
-	cpuflags = atomic_read(li->cpuflags);
+	cpuflags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
 	ext_call_pending = kvm_s390_ext_call_pending(dst_vcpu);
 	if (!(cpuflags & CPUSTAT_STOPPED) && !ext_call_pending)
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -211,7 +208,7 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu,
 	int flags;
 	int rc;
 
-	flags = atomic_read(dst_vcpu->arch.local_int.cpuflags);
+	flags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
 	if (!(flags & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
@@ -231,7 +228,6 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu,
 static int __sigp_sense_running(struct kvm_vcpu *vcpu,
 				struct kvm_vcpu *dst_vcpu, u64 *reg)
 {
-	struct kvm_s390_local_interrupt *li;
 	int rc;
 
 	if (!test_kvm_facility(vcpu->kvm, 9)) {
@@ -240,8 +236,8 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu,
 		return SIGP_CC_STATUS_STORED;
 	}
 
-	li = &dst_vcpu->arch.local_int;
-	if (atomic_read(li->cpuflags) & CPUSTAT_RUNNING) {
+	if (atomic_read(&dst_vcpu->arch.sie_block->cpuflags) &
+	    CPUSTAT_RUNNING) {
 		/* running */
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	} else {
-- 
2.14.3
