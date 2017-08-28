From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 06/11] KVM: s390: Multiple Epoch Facility support
Date: Mon, 28 Aug 2017 10:07:29 +0200
Message-ID: <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

Allow for the enablement of MEF and the support for the extended
epoch in SIE and VSIE for the extended guest TOD-Clock.

A new interface is used for getting/setting a guest's extended
TOD-Clock that uses a single ioctl invocation, KVM_S390_VM_TOD_EXT.
The old method of getting and setting the guest TOD-Clock is
retained and is used when the old ioctls are called.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt |  14 ++++-
 arch/s390/include/asm/kvm_host.h         |   6 +-
 arch/s390/include/uapi/asm/kvm.h         |   6 ++
 arch/s390/kvm/kvm-s390.c                 | 101 +++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h                 |   2 +
 arch/s390/kvm/vsie.c                     |  10 +++
 arch/s390/tools/gen_facilities.c         |   1 +
 7 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 903fc92..8a86778 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -176,7 +176,8 @@ Architectures: s390
 
 3.1. ATTRIBUTE: KVM_S390_VM_TOD_HIGH
 
-Allows user space to set/get the TOD clock extension (u8).
+Allows user space to set/get the TOD clock extension (u8). (superseded by
+KVM_S390_VM_TOD_EXT).
 
 Parameters: address of a buffer in user space to store the data (u8) to
 Returns:    -EFAULT if the given address is not accessible from kernel space
@@ -190,6 +191,17 @@ the POP (u64).
 Parameters: address of a buffer in user space to store the data (u64) to
 Returns:    -EFAULT if the given address is not accessible from kernel space
 
+3.3. ATTRIBUTE: KVM_S390_VM_TOD_EXT
+
+Allows user space to set/get bits 0-63 of the TOD clock register as defined in
+the POP (u64), as well as the TOD clock extension (u8) if supported by the
+host.
+
+Parameters: address of a buffer in user space to store the data
+            (kvm_s390_vm_tod_clock) to
+Returns:    -EFAULT if the given address is not accessible from kernel space
+	    -EINVAL if setting the TOD clock extension to != 0 is not supported
+
 4. GROUP: KVM_S390_VM_CRYPTO
 Architectures: s390
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a409d59..51375e7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -226,7 +226,9 @@ struct kvm_s390_sie_block {
 #define ECB3_RI  0x01
 	__u8    ecb3;			/* 0x0063 */
 	__u32	scaol;			/* 0x0064 */
-	__u8	reserved68[4];		/* 0x0068 */
+	__u8	reserved68;		/* 0x0068 */
+	__u8    epdx;			/* 0x0069 */
+	__u8    reserved6a[2];		/* 0x006a */
 	__u32	todpr;			/* 0x006c */
 	__u8	reserved70[16];		/* 0x0070 */
 	__u64	mso;			/* 0x0080 */
@@ -265,6 +267,7 @@ struct kvm_s390_sie_block {
 	__u64	cbrlo;			/* 0x01b8 */
 	__u8	reserved1c0[8];		/* 0x01c0 */
 #define ECD_HOSTREGMGMT	0x20000000
+#define ECD_MEF		0x08000000
 	__u32	ecd;			/* 0x01c8 */
 	__u8	reserved1cc[18];	/* 0x01cc */
 	__u64	pp;			/* 0x01de */
@@ -739,6 +742,7 @@ struct kvm_arch{
 	struct kvm_s390_cpu_model model;
 	struct kvm_s390_crypto crypto;
 	struct kvm_s390_vsie vsie;
+	u8 epdx;
 	u64 epoch;
 	struct kvm_s390_migration_state *migration_state;
 	/* subset of available cpu features enabled by user space */
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 69d09c3..cd7359e 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -88,6 +88,12 @@ struct kvm_s390_io_adapter_req {
 /* kvm attributes for KVM_S390_VM_TOD */
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
+#define KVM_S390_VM_TOD_EXT		2
+
+struct kvm_s390_vm_tod_clock {
+	__u8  epoch_idx;
+	__u64 tod;
+};
 
 /* kvm attributes for KVM_S390_VM_CPU_MODEL */
 /* processor related attributes are r/w */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3f2884e..2547787 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -130,6 +130,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
+struct kvm_s390_tod_clock_ext {
+	__u8 epoch_idx;
+	__u64 tod;
+	__u8 reserved[7];
+} __packed;
+
 /* allow nested virtualization in KVM (if enabled by user space) */
 static int nested;
 module_param(nested, int, S_IRUGO);
@@ -874,6 +880,26 @@ static int kvm_s390_vm_get_migration(struct kvm *kvm,
 	return 0;
 }
 
+static int kvm_s390_set_tod_ext(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_tod_clock gtod;
+
+	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
+		return -EFAULT;
+
+	if (test_kvm_facility(kvm, 139))
+		kvm_s390_set_tod_clock_ext(kvm, &gtod);
+	else if (gtod.epoch_idx == 0)
+		kvm_s390_set_tod_clock(kvm, gtod.tod);
+	else
+		return -EINVAL;
+
+	VM_EVENT(kvm, 3, "SET: TOD extension: 0x%x, TOD base: 0x%llx",
+		gtod.epoch_idx, gtod.tod);
+
+	return 0;
+}
+
 static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	u8 gtod_high;
@@ -909,6 +935,9 @@ static int kvm_s390_set_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -EINVAL;
 
 	switch (attr->attr) {
+	case KVM_S390_VM_TOD_EXT:
+		ret = kvm_s390_set_tod_ext(kvm, attr);
+		break;
 	case KVM_S390_VM_TOD_HIGH:
 		ret = kvm_s390_set_tod_high(kvm, attr);
 		break;
@@ -922,6 +951,43 @@ static int kvm_s390_set_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
+static void kvm_s390_get_tod_clock_ext(struct kvm *kvm,
+					struct kvm_s390_vm_tod_clock *gtod)
+{
+	struct kvm_s390_tod_clock_ext htod;
+
+	preempt_disable();
+
+	get_tod_clock_ext((char *)&htod);
+
+	gtod->tod = htod.tod + kvm->arch.epoch;
+	gtod->epoch_idx = htod.epoch_idx + kvm->arch.epdx;
+
+	if (gtod->tod < htod.tod)
+		gtod->epoch_idx += 1;
+
+	preempt_enable();
+}
+
+static int kvm_s390_get_tod_ext(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_tod_clock gtod;
+
+	memset(&gtod, 0, sizeof(gtod));
+
+	if (test_kvm_facility(kvm, 139))
+		kvm_s390_get_tod_clock_ext(kvm, &gtod);
+	else
+		gtod.tod = kvm_s390_get_tod_clock_fast(kvm);
+
+	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
+		return -EFAULT;
+
+	VM_EVENT(kvm, 3, "QUERY: TOD extension: 0x%x, TOD base: 0x%llx",
+		gtod.epoch_idx, gtod.tod);
+	return 0;
+}
+
 static int kvm_s390_get_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	u8 gtod_high = 0;
@@ -954,6 +1020,9 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -EINVAL;
 
 	switch (attr->attr) {
+	case KVM_S390_VM_TOD_EXT:
+		ret = kvm_s390_get_tod_ext(kvm, attr);
+		break;
 	case KVM_S390_VM_TOD_HIGH:
 		ret = kvm_s390_get_tod_high(kvm, attr);
 		break;
@@ -2365,6 +2434,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= ECA_VX;
 		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
 	}
+	if (test_kvm_facility(vcpu->kvm, 139))
+		vcpu->arch.sie_block->ecd |= ECD_MEF;
+
 	vcpu->arch.sie_block->sdnxo = ((unsigned long) &vcpu->run->s.regs.sdnx)
 					| SDNXC;
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
@@ -2851,6 +2923,35 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
+				 const struct kvm_s390_vm_tod_clock *gtod)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_s390_tod_clock_ext htod;
+	int i;
+
+	mutex_lock(&kvm->lock);
+	preempt_disable();
+
+	get_tod_clock_ext((char *)&htod);
+
+	kvm->arch.epoch = gtod->tod - htod.tod;
+	kvm->arch.epdx = gtod->epoch_idx - htod.epoch_idx;
+
+	if (kvm->arch.epoch > gtod->tod)
+		kvm->arch.epdx -= 1;
+
+	kvm_s390_vcpu_block_all(kvm);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		vcpu->arch.sie_block->epoch = kvm->arch.epoch;
+		vcpu->arch.sie_block->epdx  = kvm->arch.epdx;
+	}
+
+	kvm_s390_vcpu_unblock_all(kvm);
+	preempt_enable();
+	mutex_unlock(&kvm->lock);
+}
+
 void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod)
 {
 	struct kvm_vcpu *vcpu;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6fedc8b..9f8fdd7 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -272,6 +272,8 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 int handle_sthyi(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
+void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
+				 const struct kvm_s390_vm_tod_clock *gtod);
 void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 715c19c..681d06e 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -349,6 +349,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->eca |= scb_o->eca & ECA_IB;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_CEI))
 		scb_s->eca |= scb_o->eca & ECA_CEI;
+	/* Epoch Extension */
+	if (test_kvm_facility(vcpu->kvm, 139))
+		scb_s->ecd |= scb_o->ecd & ECD_MEF;
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
@@ -919,6 +922,13 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
 	 */
 	preempt_disable();
 	scb_s->epoch += vcpu->kvm->arch.epoch;
+
+	if (test_kvm_facility(vcpu->kvm, 139)) {
+		scb_s->epdx += vcpu->kvm->arch.epdx;
+		if (scb_s->epoch < vcpu->kvm->arch.epoch)
+			scb_s->epdx += 1;
+	}
+
 	preempt_enable();
 }
 
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 181db5b..601bfcf 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -81,6 +81,7 @@ static struct facility_def facility_defs[] = {
 			130, /* instruction-execution-protection */
 			131, /* enhanced-SOP 2 and side-effect */
 			138, /* configuration z/architecture mode (czam) */
+			139, /* multiple epoch facility */
 			146, /* msa extension 8 */
 			-1  /* END */
 		}
-- 
2.7.4
