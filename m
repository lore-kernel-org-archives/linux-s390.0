From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/9] KVM: s390: protect VCPU cpu timer with a seqcount
Date: Thu, 10 Mar 2016 16:36:55 +0100
Message-ID: <1457624219-110920-6-git-send-email-borntraeger@de.ibm.com>
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

For now, only the owning VCPU thread (that has loaded the VCPU) can get a
consistent cpu timer value when calculating the delta. However, other
threads might also be interested in a more recent, consistent value. Of
special interest will be the timer callback of a VCPU that executes without
having the VCPU loaded and could run in parallel with the VCPU thread.

The cpu timer has a nice property: it is only updated by the owning VCPU
thread. And speaking about accounting, a consistent value can only be
calculated by looking at cputm_start and the cpu timer itself in
one shot, otherwise the result might be wrong.

As we only have one writing thread at a time (owning VCPU thread), we can
use a seqcount instead of a seqlock and retry if the VCPU refreshed its
cpu timer. This avoids any heavy locking and only introduces a counter
update/check plus a handful of smp_wmb().

The owning VCPU thread should never have to retry on reads, and also for
other threads this might be a very rare scenario.

Please note that we have to use the raw_* variants for locking the seqcount
as lockdep will produce false warnings otherwise. The rq->lock held during
vcpu_load/put is also acquired from hardirq context. Lockdep cannot know
that we avoid potential deadlocks by disabling preemption and thereby
disable concurrent write locking attempts (via vcpu_put/load).

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  8 ++++++++
 arch/s390/kvm/kvm-s390.c         | 30 ++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 91796dd..d61e645 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -20,6 +20,7 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
+#include <linux/seqlock.h>
 #include <asm/debug.h>
 #include <asm/cpu.h>
 #include <asm/fpu/api.h>
@@ -553,6 +554,13 @@ struct kvm_vcpu_arch {
 	unsigned long pfault_select;
 	unsigned long pfault_compare;
 	bool cputm_enabled;
+	/*
+	 * The seqcount protects updates to cputm_start and sie_block.cputm,
+	 * this way we can have non-blocking reads with consistent values.
+	 * Only the owning VCPU thread (vcpu->cpu) is allowed to change these
+	 * values and to start/stop/enable/disable cpu timer accounting.
+	 */
+	seqcount_t cputm_seqcount;
 	__u64 cputm_start;
 };
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 76b9914..38223c4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1435,15 +1435,19 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 static void __start_cpu_timer_accounting(struct kvm_vcpu *vcpu)
 {
 	WARN_ON_ONCE(vcpu->arch.cputm_start != 0);
+	raw_write_seqcount_begin(&vcpu->arch.cputm_seqcount);
 	vcpu->arch.cputm_start = get_tod_clock_fast();
+	raw_write_seqcount_end(&vcpu->arch.cputm_seqcount);
 }
 
 /* needs disabled preemption to protect from TOD sync and vcpu_load/put */
 static void __stop_cpu_timer_accounting(struct kvm_vcpu *vcpu)
 {
 	WARN_ON_ONCE(vcpu->arch.cputm_start == 0);
+	raw_write_seqcount_begin(&vcpu->arch.cputm_seqcount);
 	vcpu->arch.sie_block->cputm -= get_tod_clock_fast() - vcpu->arch.cputm_start;
 	vcpu->arch.cputm_start = 0;
+	raw_write_seqcount_end(&vcpu->arch.cputm_seqcount);
 }
 
 /* needs disabled preemption to protect from TOD sync and vcpu_load/put */
@@ -1480,28 +1484,37 @@ static void disable_cpu_timer_accounting(struct kvm_vcpu *vcpu)
 void kvm_s390_set_cpu_timer(struct kvm_vcpu *vcpu, __u64 cputm)
 {
 	preempt_disable(); /* protect from TOD sync and vcpu_load/put */
+	raw_write_seqcount_begin(&vcpu->arch.cputm_seqcount);
 	if (vcpu->arch.cputm_enabled)
 		vcpu->arch.cputm_start = get_tod_clock_fast();
 	vcpu->arch.sie_block->cputm = cputm;
+	raw_write_seqcount_end(&vcpu->arch.cputm_seqcount);
 	preempt_enable();
 }
 
 /* update and get the cpu timer - can also be called from other VCPU threads */
 __u64 kvm_s390_get_cpu_timer(struct kvm_vcpu *vcpu)
 {
+	unsigned int seq;
 	__u64 value;
-	int me;
 
 	if (unlikely(!vcpu->arch.cputm_enabled))
 		return vcpu->arch.sie_block->cputm;
 
-	me = get_cpu(); /* also protects from TOD sync and vcpu_load/put */
-	value = vcpu->arch.sie_block->cputm;
-	if (likely(me == vcpu->cpu)) {
-		/* the VCPU itself will always read consistent values */
-		value -= get_tod_clock_fast() - vcpu->arch.cputm_start;
-	}
-	put_cpu();
+	preempt_disable(); /* protect from TOD sync and vcpu_load/put */
+	do {
+		seq = raw_read_seqcount(&vcpu->arch.cputm_seqcount);
+		/*
+		 * If the writer would ever execute a read in the critical
+		 * section, e.g. in irq context, we have a deadlock.
+		 */
+		WARN_ON_ONCE((seq & 1) && smp_processor_id() == vcpu->cpu);
+		value = vcpu->arch.sie_block->cputm;
+		/* if cputm_start is 0, accounting is being started/stopped */
+		if (likely(vcpu->arch.cputm_start))
+			value -= get_tod_clock_fast() - vcpu->arch.cputm_start;
+	} while (read_seqcount_retry(&vcpu->arch.cputm_seqcount, seq & ~1));
+	preempt_enable();
 	return value;
 }
 
@@ -1704,6 +1717,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
 	vcpu->arch.local_int.wq = &vcpu->wq;
 	vcpu->arch.local_int.cpuflags = &vcpu->arch.sie_block->cpuflags;
+	seqcount_init(&vcpu->arch.cputm_seqcount);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
 	if (rc)
-- 
2.5.0
