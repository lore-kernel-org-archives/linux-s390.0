From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/11] KVM: s390: represent SIMD cap in kvm facility
Date: Wed, 18 Mar 2015 12:44:09 +0100
Message-ID: <1426679049-37696-12-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The patch represents capability KVM_CAP_S390_VECTOR_REGISTERS by means
of the SIMD facility bit. This allows to a) disable the use of SIMD when
used in conjunction with a not-SIMD-aware QEMU, b) to enable SIMD when
used with a SIMD-aware version of QEMU and c) finally by means of a QEMU
version using the future cpu model ioctls.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Tested-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 -
 arch/s390/kvm/kvm-s390.c         | 19 +++++++++++--------
 arch/s390/kvm/kvm-s390.h         | 11 +++++++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2356a8c..b8d1e97 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -562,7 +562,6 @@ struct kvm_arch{
 	int css_support;
 	int use_irqchip;
 	int use_cmma;
-	int use_vectors;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 42b8a25..9072127 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -278,8 +278,12 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		r = 0;
 		break;
 	case KVM_CAP_S390_VECTOR_REGISTERS:
-		kvm->arch.use_vectors = MACHINE_HAS_VX;
-		r = MACHINE_HAS_VX ? 0 : -EINVAL;
+		if (MACHINE_HAS_VX) {
+			set_kvm_facility(kvm->arch.model.fac->mask, 129);
+			set_kvm_facility(kvm->arch.model.fac->list, 129);
+			r = 0;
+		} else
+			r = -EINVAL;
 		break;
 	case KVM_CAP_S390_USER_STSI:
 		kvm->arch.user_stsi = 1;
@@ -1084,7 +1088,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
-	kvm->arch.use_vectors = 0;
 	kvm->arch.epoch = 0;
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
@@ -1186,12 +1189,12 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	save_fp_ctl(&vcpu->arch.host_fpregs.fpc);
-	if (vcpu->kvm->arch.use_vectors)
+	if (test_kvm_facility(vcpu->kvm, 129))
 		save_vx_regs((__vector128 *)&vcpu->arch.host_vregs->vrs);
 	else
 		save_fp_regs(vcpu->arch.host_fpregs.fprs);
 	save_access_regs(vcpu->arch.host_acrs);
-	if (vcpu->kvm->arch.use_vectors) {
+	if (test_kvm_facility(vcpu->kvm, 129)) {
 		restore_fp_ctl(&vcpu->run->s.regs.fpc);
 		restore_vx_regs((__vector128 *)&vcpu->run->s.regs.vrs);
 	} else {
@@ -1207,7 +1210,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	atomic_clear_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	gmap_disable(vcpu->arch.gmap);
-	if (vcpu->kvm->arch.use_vectors) {
+	if (test_kvm_facility(vcpu->kvm, 129)) {
 		save_fp_ctl(&vcpu->run->s.regs.fpc);
 		save_vx_regs((__vector128 *)&vcpu->run->s.regs.vrs);
 	} else {
@@ -1216,7 +1219,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	}
 	save_access_regs(vcpu->run->s.regs.acrs);
 	restore_fp_ctl(&vcpu->arch.host_fpregs.fpc);
-	if (vcpu->kvm->arch.use_vectors)
+	if (test_kvm_facility(vcpu->kvm, 129))
 		restore_vx_regs((__vector128 *)&vcpu->arch.host_vregs->vrs);
 	else
 		restore_fp_regs(vcpu->arch.host_fpregs.fprs);
@@ -1316,7 +1319,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp_has_sigpif())
 		vcpu->arch.sie_block->eca |= 0x10000000U;
-	if (vcpu->kvm->arch.use_vectors) {
+	if (test_kvm_facility(vcpu->kvm, 129)) {
 		vcpu->arch.sie_block->eca |= 0x00020000;
 		vcpu->arch.sie_block->ecd |= 0x20000000;
 	}
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 5d54191..c5aefef 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -149,6 +149,17 @@ static inline int test_kvm_facility(struct kvm *kvm, unsigned long nr)
 		__test_facility(nr, kvm->arch.model.fac->list);
 }
 
+static inline int set_kvm_facility(u64 *fac_list, unsigned long nr)
+{
+	unsigned char *ptr;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return -EINVAL;
+	ptr = (unsigned char *) fac_list + (nr >> 3);
+	*ptr |= (0x80UL >> (nr & 7));
+	return 0;
+}
+
 /* are cpu states controlled by user space */
 static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 {
-- 
2.3.0
