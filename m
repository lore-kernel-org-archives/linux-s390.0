Return-Path: <linux-doc-owner@vger.kernel.org>
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/kvm: diagnose 318 handling
Date: Tue,  2 Apr 2019 13:46:36 -0400
In-Reply-To: <20190402174636.15175-1-walling@linux.ibm.com>
References: <20190402174636.15175-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190402174636.15175-3-walling@linux.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
be intercepted by SIE and handled via KVM. Let's introduce some
functions to communicate between userspace and KVM via ioctls. These
will be used to get/set the diag318 related information (also known
as the "Control Program Code" or "CPC"), as well as check the system
if KVM supports handling this instruction.

This information can help with diagnosing the OS the VM is running
in (Linux, z/VM, etc) if the OS calls this instruction.

The get/set functions are introduced primarily for VM migration and
reset, though no harm could be done to the system if a userspace
program decides to alter this data (this is highly discouraged).

The Control Program Name Code (CPNC) is stored in the SIE block and
a copy is retained in each VCPU. The Control Program Version Code
(CPVC) retains a copy in each VCPU as well.

At this time, the CPVC is not reported as its format is yet to be
defined.

Note that the CPNC is set in the SIE block iff the host hardware
supports it.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 14 ++++
 arch/s390/include/asm/kvm_host.h         |  7 +-
 arch/s390/include/uapi/asm/kvm.h         |  4 ++
 arch/s390/kvm/diag.c                     | 17 +++++
 arch/s390/kvm/kvm-s390.c                 | 83 ++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h                 |  1 +
 arch/s390/kvm/vsie.c                     |  2 +
 7 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 95ca68d663a4..9a8d9346c5d7 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -267,3 +267,17 @@ Parameters: address of a buffer in user space to store the data (u64) to;
 	    if it is enabled
 Returns:    -EFAULT if the given address is not accessible from kernel space
 	    0 in case of success.
+
+6. GROUP: KVM_S390_VM_MISC
+Architectures: s390
+
+6.1. KVM_S390_VM_MISC_CPC (r/w)
+
+Allows userspace to access the "Control Program Code" which consists of a
+1-byte "Control Program Name Code" and a 7-byte "Control Program Version Code".
+This information is initialized during IPL and must be preserved during
+migration.
+
+Parameters: address of a buffer in user space to store the data (u64) to
+Returns:    -EFAULT if the given address is not accessible from kernel space
+	     0 in case of success.
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c47e22bba87f..d2f30426b8d6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -228,8 +228,9 @@ struct kvm_s390_sie_block {
 	__u8    ecb3;			/* 0x0063 */
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68;		/* 0x0068 */
-	__u8    epdx;			/* 0x0069 */
-	__u8    reserved6a[2];		/* 0x006a */
+	__u8	epdx;			/* 0x0069 */
+	__u8	cpnc;			/* 0x006a */
+	__u8	reserved6b;		/* 0x006b */
 	__u32	todpr;			/* 0x006c */
 #define GISA_FORMAT1 0x00000001
 	__u32	gd;			/* 0x0070 */
@@ -391,6 +392,7 @@ struct kvm_vcpu_stat {
 	u64 diagnose_9c;
 	u64 diagnose_258;
 	u64 diagnose_308;
+	u64 diagnose_318;
 	u64 diagnose_500;
 	u64 diagnose_other;
 };
@@ -866,6 +868,7 @@ struct kvm_arch{
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 	struct kvm_s390_gisa_interrupt gisa_int;
+	union diag318_info diag318_info;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 16511d97e8dc..3d3d2a5611d1 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
 #define KVM_S390_VM_MIGRATION		4
+#define KVM_S390_VM_MISC		5
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_MIGRATION_START	1
 #define KVM_S390_VM_MIGRATION_STATUS	2
 
+/* kvm attributes for KVM_S390_VM_MISC */
+#define KVM_S390_VM_MISC_CPC		0
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 45634b3d2e0a..9762e6ad9ab0 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -235,6 +235,21 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 	return ret < 0 ? ret : 0;
 }
 
+static int __diag_set_control_prog_name(struct kvm_vcpu *vcpu)
+{
+	unsigned int reg = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
+	u64 cpc = vcpu->run->s.regs.gprs[reg];
+
+	vcpu->stat.diagnose_318++;
+	kvm_s390_set_cpc(vcpu->kvm, cpc);
+
+	VCPU_EVENT(vcpu, 3, "diag 0x318 cpnc: 0x%x cpvc: 0x%llx",
+		   vcpu->kvm->arch.diag318_info.cpnc,
+		   (u64)vcpu->kvm->arch.diag318_info.cpvc);
+
+	return 0;
+}
+
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
 	int code = kvm_s390_get_base_disp_rs(vcpu, NULL) & 0xffff;
@@ -254,6 +269,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 		return __diag_page_ref_service(vcpu);
 	case 0x308:
 		return __diag_ipl_functions(vcpu);
+	case 0x318:
+		return __diag_set_control_prog_name(vcpu);
 	case 0x500:
 		return __diag_virtio_hypercall(vcpu);
 	default:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4638303ba6a8..910af1813706 100644
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
@@ -1190,6 +1191,70 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
+void kvm_s390_set_cpc(struct kvm *kvm, u64 cpc)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	mutex_lock(&kvm->lock);
+	kvm->arch.diag318_info.val = cpc;
+
+	VM_EVENT(kvm, 3, "SET: CPNC: 0x%x CPVC: 0x%llx",
+		 kvm->arch.diag318_info.cpnc, (u64)kvm->arch.diag318_info.cpvc);
+
+	if (sclp.has_diag318) {
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			vcpu->arch.sie_block->cpnc = kvm->arch.diag318_info.cpnc;
+		}
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
+	if (put_user(kvm->arch.diag318_info.val, (u64 __user *)attr->addr))
+		return -EFAULT;
+
+	VM_EVENT(kvm, 3, "QUERY: CPNC: 0x%x, CPVC: 0x%llx",
+		 kvm->arch.diag318_info.cpnc, (u64)kvm->arch.diag318_info.cpvc);
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
@@ -1597,6 +1662,9 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MIGRATION:
 		ret = kvm_s390_vm_set_migration(kvm, attr);
 		break;
+	case KVM_S390_VM_MISC:
+		ret = kvm_s390_set_misc(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -1622,6 +1690,9 @@ static int kvm_s390_vm_get_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MIGRATION:
 		ret = kvm_s390_vm_get_migration(kvm, attr);
 		break;
+	case KVM_S390_VM_MISC:
+		ret = kvm_s390_get_misc(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -1695,6 +1766,16 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
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
@@ -2815,6 +2896,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
 	/* make vcpu_load load the right gmap on the first trigger */
 	vcpu->arch.enabled_gmap = vcpu->arch.gmap;
+	if (sclp.has_diag318)
+		vcpu->arch.sie_block->cpnc = vcpu->kvm->arch.diag318_info.cpnc;
 }
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6d9448dbd052..35fb642f6e7f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -281,6 +281,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
+void kvm_s390_set_cpc(struct kvm *kvm, u64 cpc);
 void kvm_s390_set_tod_clock(struct kvm *kvm,
 			    const struct kvm_s390_vm_tod_clock *gtod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d62fa148558b..3e94102822f9 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -543,6 +543,8 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->ecd |= scb_o->ecd & ECD_ETOKENF;
 
 	scb_s->hpid = HPID_VSIE;
+	if (sclp.has_diag318)
+		scb_s->cpnc = scb_o->cpnc;
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
-- 
2.20.1
