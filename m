From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 16/20] KVM: s390: Allocate and save/restore vector registers
Date: Fri,  6 Mar 2015 14:16:48 +0100
Message-ID: <1425647812-61838-17-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.vnet.ibm.com>

Define and allocate space for both the host and guest views of
the vector registers for a given vcpu.  The 32 vector registers
occupy 128 bits each (512 bytes total), but architecturally are
paired with 512 additional bytes of reserved space for future
expansion.

The kvm_sync_regs structs containing the registers are union'ed
with 1024 bytes of padding in the common kvm_run struct.  The
addition of 1024 bytes of new register information clearly exceeds
the existing union, so an expansion of that padding is required.

When changing environments, we need to appropriately save and
restore the vector registers viewed by both the host and guest,
into and out of the sync_regs space.

The floating point registers overlay the upper half of vector
registers 0-15, so there's a bit of data duplication here that
needs to be carefully avoided.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 10 ++++++++++
 arch/s390/include/asm/kvm_host.h  | 10 +++++++++-
 arch/s390/include/uapi/asm/kvm.h  |  4 ++++
 arch/s390/kvm/kvm-s390.c          | 39 +++++++++++++++++++++++++++++++++------
 include/uapi/linux/kvm.h          |  3 ++-
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index b112efc..ee47998e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3248,3 +3248,13 @@ All other orders will be handled completely in user space.
 Only privileged operation exceptions will be checked for in the kernel (or even
 in the hardware prior to interception). If this capability is not enabled, the
 old way of handling SIGP orders is used (partially in kernel and user space).
+
+7.3 KVM_CAP_S390_VECTOR_REGISTERS
+
+Architectures: s390
+Parameters: none
+Returns: 0 on success, negative value on error
+
+Allows use of the vector registers introduced with z13 processor, and
+provides for the synchronization between host and user space.  Will
+return -EINVAL if the machine does not support vectors.
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f407bbf..3449a38 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -183,11 +183,17 @@ struct kvm_s390_itdb {
 	__u8	data[256];
 } __packed;
 
+struct kvm_s390_vregs {
+	__vector128 vrs[32];
+	__u8	reserved200[512];	/* for future vector expansion */
+} __packed;
+
 struct sie_page {
 	struct kvm_s390_sie_block sie_block;
 	__u8 reserved200[1024];		/* 0x0200 */
 	struct kvm_s390_itdb itdb;	/* 0x0600 */
-	__u8 reserved700[2304];		/* 0x0700 */
+	__u8 reserved700[1280];		/* 0x0700 */
+	struct kvm_s390_vregs vregs;	/* 0x0c00 */
 } __packed;
 
 struct kvm_vcpu_stat {
@@ -465,6 +471,7 @@ struct kvm_vcpu_arch {
 	s390_fp_regs      host_fpregs;
 	unsigned int      host_acrs[NUM_ACRS];
 	s390_fp_regs      guest_fpregs;
+	struct kvm_s390_vregs	*host_vregs;
 	struct kvm_s390_local_interrupt local_int;
 	struct hrtimer    ckc_timer;
 	struct kvm_s390_pgm_info pgm;
@@ -551,6 +558,7 @@ struct kvm_arch{
 	int css_support;
 	int use_irqchip;
 	int use_cmma;
+	int use_vectors;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 9c77e60..ef1a5fc 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -150,6 +150,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_CRS    (1UL << 3)
 #define KVM_SYNC_ARCH0  (1UL << 4)
 #define KVM_SYNC_PFAULT (1UL << 5)
+#define KVM_SYNC_VRS    (1UL << 6)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -164,6 +165,9 @@ struct kvm_sync_regs {
 	__u64 pft;	/* pfault token [PFAULT] */
 	__u64 pfs;	/* pfault select [PFAULT] */
 	__u64 pfc;	/* pfault compare [PFAULT] */
+	__u64 vrs[32][2];	/* vector registers */
+	__u8  reserved[512];	/* for future vector expansion */
+	__u32 fpc;	/* only valid with vector registers */
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f3517e7..a8fe3ab 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -185,6 +185,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_COW:
 		r = MACHINE_HAS_ESOP;
 		break;
+	case KVM_CAP_S390_VECTOR_REGISTERS:
+		r = MACHINE_HAS_VX;
+		break;
 	default:
 		r = 0;
 	}
@@ -265,6 +268,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		kvm->arch.user_sigp = 1;
 		r = 0;
 		break;
+	case KVM_CAP_S390_VECTOR_REGISTERS:
+		kvm->arch.use_vectors = MACHINE_HAS_VX;
+		r = MACHINE_HAS_VX ? 0 : -EINVAL;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -942,6 +949,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
+	kvm->arch.use_vectors = 0;
 	kvm->arch.epoch = 0;
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
@@ -1035,6 +1043,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 				    KVM_SYNC_CRS |
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT;
+	if (test_kvm_facility(vcpu->kvm, 129))
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm))
 		return __kvm_ucontrol_vcpu_init(vcpu);
@@ -1045,10 +1055,18 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	save_fp_ctl(&vcpu->arch.host_fpregs.fpc);
-	save_fp_regs(vcpu->arch.host_fpregs.fprs);
+	if (vcpu->kvm->arch.use_vectors)
+		save_vx_regs((__vector128 *)&vcpu->arch.host_vregs->vrs);
+	else
+		save_fp_regs(vcpu->arch.host_fpregs.fprs);
 	save_access_regs(vcpu->arch.host_acrs);
-	restore_fp_ctl(&vcpu->arch.guest_fpregs.fpc);
-	restore_fp_regs(vcpu->arch.guest_fpregs.fprs);
+	if (vcpu->kvm->arch.use_vectors) {
+		restore_fp_ctl(&vcpu->run->s.regs.fpc);
+		restore_vx_regs((__vector128 *)&vcpu->run->s.regs.vrs);
+	} else {
+		restore_fp_ctl(&vcpu->arch.guest_fpregs.fpc);
+		restore_fp_regs(vcpu->arch.guest_fpregs.fprs);
+	}
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.gmap);
 	atomic_set_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
@@ -1058,11 +1076,19 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	atomic_clear_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	gmap_disable(vcpu->arch.gmap);
-	save_fp_ctl(&vcpu->arch.guest_fpregs.fpc);
-	save_fp_regs(vcpu->arch.guest_fpregs.fprs);
+	if (vcpu->kvm->arch.use_vectors) {
+		save_fp_ctl(&vcpu->run->s.regs.fpc);
+		save_vx_regs((__vector128 *)&vcpu->run->s.regs.vrs);
+	} else {
+		save_fp_ctl(&vcpu->arch.guest_fpregs.fpc);
+		save_fp_regs(vcpu->arch.guest_fpregs.fprs);
+	}
 	save_access_regs(vcpu->run->s.regs.acrs);
 	restore_fp_ctl(&vcpu->arch.host_fpregs.fpc);
-	restore_fp_regs(vcpu->arch.host_fpregs.fprs);
+	if (vcpu->kvm->arch.use_vectors)
+		restore_vx_regs((__vector128 *)&vcpu->arch.host_vregs->vrs);
+	else
+		restore_fp_regs(vcpu->arch.host_fpregs.fprs);
 	restore_access_regs(vcpu->arch.host_acrs);
 }
 
@@ -1196,6 +1222,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	vcpu->arch.sie_block = &sie_page->sie_block;
 	vcpu->arch.sie_block->itdba = (unsigned long) &sie_page->itdb;
+	vcpu->arch.host_vregs = &sie_page->vregs;
 
 	vcpu->arch.sie_block->icpua = id;
 	if (!kvm_is_ucontrol(kvm)) {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8055706..82634a4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -324,7 +324,7 @@ struct kvm_run {
 	__u64 kvm_dirty_regs;
 	union {
 		struct kvm_sync_regs regs;
-		char padding[1024];
+		char padding[2048];
 	} s;
 };
 
@@ -760,6 +760,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_ENABLE_HCALL 104
 #define KVM_CAP_CHECK_EXTENSION_VM 105
 #define KVM_CAP_S390_USER_SIGP 106
+#define KVM_CAP_S390_VECTOR_REGISTERS 107
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.3.0
