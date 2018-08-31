From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 31 Aug 2018 16:51:18 +0000
Subject: [PATCH 2/3] s390/kvm: handle diagnose 318 instruction call
Message-Id: <1535734279-10204-3-git-send-email-walling@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The diagnose 318 instruction is a privileged instruction that must be
interpreted by SIE and handled via KVM.

The control program name and version codes (CPNC and CPVC) set by this
instruction are saved to the kvm->arch struct. The CPNC is also set in
the SIE control block of all VCPUs. The new kvm_s390_set_misc interface
is introduced for migration.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h       |  6 ++-
 arch/s390/include/uapi/asm/kvm.h       |  5 ++
 arch/s390/kvm/diag.c                   | 16 ++++++
 arch/s390/kvm/kvm-s390.c               | 90 ++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h               |  1 +
 tools/arch/s390/include/uapi/asm/kvm.h |  1 +
 6 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 29c940b..fabeb32 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -227,7 +227,8 @@ struct kvm_s390_sie_block {
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68;		/* 0x0068 */
 	__u8    epdx;			/* 0x0069 */
-	__u8    reserved6a[2];		/* 0x006a */
+	__u8    cpnc;			/* 0x006a */
+	__u8	reserved6b;		/* 0x006b */
 	__u32	todpr;			/* 0x006c */
 #define GISA_FORMAT1 0x00000001
 	__u32	gd;			/* 0x0070 */
@@ -383,6 +384,7 @@ struct kvm_vcpu_stat {
 	u64 diagnose_9c;
 	u64 diagnose_258;
 	u64 diagnose_308;
+	u64 diagnose_318;
 	u64 diagnose_500;
 	u64 diagnose_other;
 };
@@ -829,6 +831,8 @@ struct kvm_arch{
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
+	u8 cpnc;
+	u64 cpvc;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 9a50f02..e66b409 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
 #define KVM_S390_VM_MIGRATION		4
+#define KVM_S390_VM_MISC		5
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -130,6 +131,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_DIAG318	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
@@ -166,6 +168,9 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_MIGRATION_START	1
 #define KVM_S390_VM_MIGRATION_STATUS	2
 
+/* kvm attributes for KVM_S390_VM_MISC */
+#define KVM_S390_VM_MISC_CPC		0
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 45634b3d..4f013e9 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -235,6 +235,20 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 	return ret < 0 ? ret : 0;
 }
 
+static int __diag_set_control_prog_name(struct kvm_vcpu *vcpu)
+{
+	unsigned int reg = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
+	unsigned long cpc = vcpu->run->s.regs.gprs[reg];
+
+	vcpu->stat.diagnose_318++;
+	kvm_s390_set_cpc(vcpu->kvm, cpc);
+
+	VCPU_EVENT(vcpu, 3, "diag 0x318 name code: %x version code: %llx",
+		   vcpu->kvm->arch.cpnc, vcpu->kvm->arch.cpvc);
+
+	return 0;
+}
+
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
 	int code = kvm_s390_get_base_disp_rs(vcpu, NULL) & 0xffff;
@@ -254,6 +268,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 		return __diag_page_ref_service(vcpu);
 	case 0x308:
 		return __diag_ipl_functions(vcpu);
+	case 0x318:
+		return __diag_set_control_prog_name(vcpu);
 	case 0x500:
 		return __diag_virtio_hypercall(vcpu);
 	default:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 91ad4a9..678c9cb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -156,6 +156,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_diag_9c", VCPU_STAT(diagnose_9c) },
 	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
 	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
+	{ "instruction_diag_318", VCPU_STAT(diagnose_318) },
 	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
 	{ "instruction_diag_other", VCPU_STAT(diagnose_other) },
 	{ NULL }
@@ -370,6 +371,10 @@ static void kvm_s390_cpu_feat_init(void)
 
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+
+	/* Always allow diag318 for a guest */
+	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_DIAG318);
+
 	/*
 	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
 	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
@@ -1140,6 +1145,72 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
+void kvm_s390_set_cpc(struct kvm *kvm, u64 cpc)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	mutex_lock(&kvm->lock);
+	kvm->arch.cpnc = cpc >> 56;
+	kvm->arch.cpvc = cpc & 0x00ffffffffffffffUL;
+
+	VM_EVENT(kvm, 3, "SET: CPNC: 0x%x CPVC: 0x%llx",
+		 kvm->arch.cpnc, kvm->arch.cpvc);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		vcpu->arch.sie_block->cpnc = kvm->arch.cpnc;
+	}
+	mutex_unlock(&kvm->lock);
+}
+
+static int kvm_s390_set_misc(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+	u64 cpc;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_MISC_CPC:
+		ret = -EFAULT;
+		if (get_user(cpc, (u64 __user *)attr->addr))
+			break;
+		kvm_s390_set_cpc(kvm, cpc);
+		ret = 0;
+		break;
+	default:
+		ret = -ENXIO;
+		break;
+	}
+	return ret;
+}
+
+static int kvm_s390_get_cpc(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	u64 cpc = ((u64)kvm->arch.cpnc << 56) | kvm->arch.cpvc;
+
+	if (put_user(cpc, (u64 __user *)attr->addr))
+		return -EFAULT;
+
+	VM_EVENT(kvm, 3, "QUERY: CPNC: 0x%x CPVC: 0x%llx",
+		 kvm->arch.cpnc, kvm->arch.cpvc);
+
+	return 0;
+}
+
+static int kvm_s390_get_misc(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_MISC_CPC:
+		ret = kvm_s390_get_cpc(kvm, attr);
+		break;
+	default:
+		ret = -ENXIO;
+		break;
+	}
+	return ret;
+}
+
 static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_vm_cpu_processor *proc;
@@ -1402,6 +1473,9 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MIGRATION:
 		ret = kvm_s390_vm_set_migration(kvm, attr);
 		break;
+	case KVM_S390_VM_MISC:
+		ret = kvm_s390_set_misc(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -1427,6 +1501,9 @@ static int kvm_s390_vm_get_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MIGRATION:
 		ret = kvm_s390_vm_get_migration(kvm, attr);
 		break;
+	case KVM_S390_VM_MISC:
+		ret = kvm_s390_get_misc(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -1497,6 +1574,16 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MIGRATION:
 		ret = 0;
 		break;
+	case KVM_S390_VM_MISC:
+		switch (attr->attr) {
+		case KVM_S390_VM_MISC_CPC:
+			ret = 0;
+			break;
+		default:
+			ret = -ENXIO;
+			break;
+		}
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -2568,6 +2655,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
 	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
+
+	vcpu->arch.sie_block->cpnc = vcpu->kvm->arch.cpnc;
+
 	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 981e3ba..d1f65dd 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -281,6 +281,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
+void kvm_s390_set_cpc(struct kvm *kvm, u64 cpc);
 void kvm_s390_set_tod_clock(struct kvm *kvm,
 			    const struct kvm_s390_vm_tod_clock *gtod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 4cdaa55..caa5858 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_DIAG318	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
-- 
2.7.4
