From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/4] KVM: s390: reuse kvm_s390_set_cpuflags()
Date: Tue, 23 Jan 2018 18:05:29 +0100
Message-ID: <20180123170531.13687-3-david@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Use it in all places where we set cpuflags.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c |  4 ++--
 arch/s390/kvm/kvm-s390.c  | 17 ++++++++---------
 arch/s390/kvm/vsie.c      |  2 +-
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 96ea3b80b67a..404a127b1921 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -101,7 +101,7 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 		/* another external call is pending */
 		return -EBUSY;
 	}
-	atomic_or(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 	return 0;
 }
 
@@ -277,7 +277,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
-	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
 	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index de16c224319c..5680b12add68 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2316,7 +2316,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 
 	gmap_enable(vcpu->arch.enabled_gmap);
-	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_RUNNING);
 	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__start_cpu_timer_accounting(vcpu);
 	vcpu->cpu = cpu;
@@ -2423,9 +2423,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 						    CPUSTAT_STOPPED);
 
 	if (test_kvm_facility(vcpu->kvm, 78))
-		atomic_or(CPUSTAT_GED2, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_GED2);
 	else if (test_kvm_facility(vcpu->kvm, 8))
-		atomic_or(CPUSTAT_GED, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_GED);
 
 	kvm_s390_vcpu_setup_model(vcpu);
 
@@ -2462,7 +2462,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
 
 	if (sclp.has_kss)
-		atomic_or(CPUSTAT_KSS, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_KSS);
 	else
 		vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
@@ -2565,7 +2565,7 @@ static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
  * return immediately. */
 void exit_sie(struct kvm_vcpu *vcpu)
 {
-	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
 	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
 		cpu_relax();
 }
@@ -2840,7 +2840,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
 		/* enforce guest PER */
-		atomic_or(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_P);
 
 		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
 			rc = kvm_s390_import_bp_data(vcpu, dbg);
@@ -2941,8 +2941,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	if (kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu)) {
 		if (!ibs_enabled(vcpu)) {
 			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 1);
-			atomic_or(CPUSTAT_IBS,
-					&vcpu->arch.sie_block->cpuflags);
+			kvm_s390_set_cpuflags(vcpu, CPUSTAT_IBS);
 		}
 		goto retry;
 	}
@@ -3627,7 +3626,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
 	kvm_s390_clear_stop_irq(vcpu);
 
-	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOPPED);
 	__disable_ibs_on_vcpu(vcpu);
 
 	for (i = 0; i < online_vcpus; i++) {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 5d6ae0326d9e..902b5befb691 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -894,7 +894,7 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
 	 * External calls have to lead to a kick of the vcpu and
 	 * therefore the vsie -> Simulate Wait state.
 	 */
-	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
 	/*
 	 * We have to adjust the g3 epoch by the g2 epoch. The epoch will
 	 * automatically be adjusted on tod clock changes via kvm_sync_clock.
-- 
2.14.3
