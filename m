From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:15 +0000
Subject: [GIT PULL 04/18] KVM: s390: move bitmap idle_mask into arch struct top level
Message-Id: <1550835749-26436-5-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

The vcpu idle_mask state is used by but not specific
to the emulated floating interruptions. The state is
relevant to gisa related interruptions as well.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-4-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/interrupt.c        | 11 +++++------
 arch/s390/kvm/kvm-s390.h         |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3cba08f..c259a67 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -591,7 +591,6 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int next_rr_cpu;
-	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 	struct mutex ais_lock;
 	u8 simm;
 	u8 nimm;
@@ -838,6 +837,7 @@ struct kvm_arch{
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
+	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 167a306..2a3eb9f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -318,13 +318,13 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
-	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
+	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.idle_mask);
 }
 
 static void __unset_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_WAIT);
-	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
+	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.idle_mask);
 }
 
 static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
@@ -1726,7 +1726,6 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
  */
 static void __floating_irq_kick(struct kvm *kvm, u64 type)
 {
-	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
 
@@ -1735,11 +1734,11 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 		return;
 
 	/* find idle VCPUs first, then round robin */
-	sigcpu = find_first_bit(fi->idle_mask, online_vcpus);
+	sigcpu = find_first_bit(kvm->arch.idle_mask, online_vcpus);
 	if (sigcpu == online_vcpus) {
 		do {
-			sigcpu = fi->next_rr_cpu;
-			fi->next_rr_cpu = (fi->next_rr_cpu + 1) % online_vcpus;
+			sigcpu = kvm->arch.float_int.next_rr_cpu++;
+			kvm->arch.float_int.next_rr_cpu %= online_vcpus;
 			/* avoid endless loops if all vcpus are stopped */
 			if (nr_tries++ >= online_vcpus)
 				return;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1f6e36c..72ef877 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -67,7 +67,7 @@ static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 
 static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
 {
-	return test_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
+	return test_bit(vcpu->vcpu_id, vcpu->kvm->arch.idle_mask);
 }
 
 static inline int kvm_is_ucontrol(struct kvm *kvm)
-- 
2.7.4
