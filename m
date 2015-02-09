From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/7] KVM: s390: add cpu model support
Date: Mon,  9 Feb 2015 13:33:46 +0100
Message-ID: <1423485227-51721-7-git-send-email-borntraeger@de.ibm.com>
References: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

This patch enables cpu model support in kvm/s390 via the vm attribute
interface.

During KVM initialization, the host properties cpuid, IBC value and the
facility list are stored in the architecture specific cpu model structure.

During vcpu setup, these properties are taken to initialize the related SIE
state. This mechanism allows to adjust the properties from user space and thus
to implement different selectable cpu models.

This patch uses the IBC functionality to block instructions that have not
been implemented at the requested CPU type and GA level compared to the
full host capability.

Userspace has to initialize the cpu model before vcpu creation. A cpu model
change of running vcpus is not possible.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt |  45 +++++++++++
 arch/s390/include/asm/kvm_host.h         |   4 +-
 arch/s390/include/uapi/asm/kvm.h         |  21 +++++
 arch/s390/kvm/kvm-s390.c                 | 132 +++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index c3b17c6..5542c46 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -38,3 +38,48 @@ Allows userspace to query the actual limit and set a new limit for
 the maximum guest memory size. The limit will be rounded up to
 2048 MB, 4096 GB, 8192 TB respectively, as this limit is governed by
 the number of page table levels.
+
+2. GROUP: KVM_S390_VM_CPU_MODEL
+Architectures: s390
+
+2.1. ATTRIBUTE: KVM_S390_VM_CPU_MACHINE (r/o)
+
+Allows user space to retrieve machine and kvm specific cpu related information:
+
+struct kvm_s390_vm_cpu_machine {
+       __u64 cpuid;           # CPUID of host
+       __u32 ibc;             # IBC level range offered by host
+       __u8  pad[4];
+       __u64 fac_mask[256];   # set of cpu facilities enabled by KVM
+       __u64 fac_list[256];   # set of cpu facilities offered by host
+}
+
+Parameters: address of buffer to store the machine related cpu data
+            of type struct kvm_s390_vm_cpu_machine*
+Returns:    -EFAULT if the given address is not accessible from kernel space
+	    -ENOMEM if not enough memory is available to process the ioctl
+	    0 in case of success
+
+2.2. ATTRIBUTE: KVM_S390_VM_CPU_PROCESSOR (r/w)
+
+Allows user space to retrieve or request to change cpu related information for a vcpu:
+
+struct kvm_s390_vm_cpu_processor {
+       __u64 cpuid;           # CPUID currently (to be) used by this vcpu
+       __u16 ibc;             # IBC level currently (to be) used by this vcpu
+       __u8  pad[6];
+       __u64 fac_list[256];   # set of cpu facilities currently (to be) used
+                              # by this vcpu
+}
+
+KVM does not enforce or limit the cpu model data in any form. Take the information
+retrieved by means of KVM_S390_VM_CPU_MACHINE as hint for reasonable configuration
+setups. Instruction interceptions triggered by additionally set facilitiy bits that
+are not handled by KVM need to by imlemented in the VM driver code.
+
+Parameters: address of buffer to store/set the processor related cpu
+	    data of type struct kvm_s390_vm_cpu_processor*.
+Returns:    -EBUSY in case 1 or more vcpus are already activated (only in write case)
+	    -EFAULT if the given address is not accessible from kernel space
+	    -ENOMEM if not enough memory is available to process the ioctl
+	    0 in case of success
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 79dc3b0..d84559e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -89,7 +89,8 @@ struct kvm_s390_sie_block {
 	atomic_t cpuflags;		/* 0x0000 */
 	__u32 : 1;			/* 0x0004 */
 	__u32 prefix : 18;
-	__u32 : 13;
+	__u32 : 1;
+	__u32 ibc : 12;
 	__u8	reserved08[4];		/* 0x0008 */
 #define PROG_IN_SIE (1<<0)
 	__u32	prog0c;			/* 0x000c */
@@ -524,6 +525,7 @@ struct s390_model_fac {
 struct kvm_s390_cpu_model {
 	struct s390_model_fac *fac;
 	struct cpuid cpu_id;
+	unsigned short ibc;
 };
 
 struct kvm_s390_crypto {
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 546fc3a..9c77e60 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -59,6 +59,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_MEM_CTRL		0
 #define KVM_S390_VM_TOD			1
 #define KVM_S390_VM_CRYPTO		2
+#define KVM_S390_VM_CPU_MODEL		3
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -69,6 +70,26 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
 
+/* kvm attributes for KVM_S390_VM_CPU_MODEL */
+/* processor related attributes are r/w */
+#define KVM_S390_VM_CPU_PROCESSOR	0
+struct kvm_s390_vm_cpu_processor {
+	__u64 cpuid;
+	__u16 ibc;
+	__u8  pad[6];
+	__u64 fac_list[256];
+};
+
+/* machine related attributes are r/o */
+#define KVM_S390_VM_CPU_MACHINE		1
+struct kvm_s390_vm_cpu_machine {
+	__u64 cpuid;
+	__u32 ibc;
+	__u8  pad[4];
+	__u64 fac_mask[256];
+	__u64 fac_list[256];
+};
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8c538a1..0c36239 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -502,6 +502,106 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
+static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_cpu_processor *proc;
+	int ret = 0;
+
+	mutex_lock(&kvm->lock);
+	if (atomic_read(&kvm->online_vcpus)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
+	if (!proc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	if (!copy_from_user(proc, (void __user *)attr->addr,
+			    sizeof(*proc))) {
+		memcpy(&kvm->arch.model.cpu_id, &proc->cpuid,
+		       sizeof(struct cpuid));
+		kvm->arch.model.ibc = proc->ibc;
+		memcpy(kvm->arch.model.fac->kvm, proc->fac_list,
+		       S390_ARCH_FAC_LIST_SIZE_BYTE);
+	} else
+		ret = -EFAULT;
+	kfree(proc);
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+static int kvm_s390_set_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret = -ENXIO;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_CPU_PROCESSOR:
+		ret = kvm_s390_set_processor(kvm, attr);
+		break;
+	}
+	return ret;
+}
+
+static int kvm_s390_get_processor(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_cpu_processor *proc;
+	int ret = 0;
+
+	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
+	if (!proc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memcpy(&proc->cpuid, &kvm->arch.model.cpu_id, sizeof(struct cpuid));
+	proc->ibc = kvm->arch.model.ibc;
+	memcpy(&proc->fac_list, kvm->arch.model.fac->kvm, S390_ARCH_FAC_LIST_SIZE_BYTE);
+	if (copy_to_user((void __user *)attr->addr, proc, sizeof(*proc)))
+		ret = -EFAULT;
+	kfree(proc);
+out:
+	return ret;
+}
+
+static int kvm_s390_get_machine(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_cpu_machine *mach;
+	int ret = 0;
+
+	mach = kzalloc(sizeof(*mach), GFP_KERNEL);
+	if (!mach) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	get_cpu_id((struct cpuid *) &mach->cpuid);
+	mach->ibc = sclp_get_ibc();
+	memcpy(&mach->fac_mask, kvm_s390_fac_list_mask,
+	       kvm_s390_fac_list_mask_size() * sizeof(u64));
+	memcpy((unsigned long *)&mach->fac_list, S390_lowcore.stfle_fac_list,
+	       S390_ARCH_FAC_LIST_SIZE_U64);
+	if (copy_to_user((void __user *)attr->addr, mach, sizeof(*mach)))
+		ret = -EFAULT;
+	kfree(mach);
+out:
+	return ret;
+}
+
+static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret = -ENXIO;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_CPU_PROCESSOR:
+		ret = kvm_s390_get_processor(kvm, attr);
+		break;
+	case KVM_S390_VM_CPU_MACHINE:
+		ret = kvm_s390_get_machine(kvm, attr);
+		break;
+	}
+	return ret;
+}
+
 static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret;
@@ -513,6 +613,9 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_TOD:
 		ret = kvm_s390_set_tod(kvm, attr);
 		break;
+	case KVM_S390_VM_CPU_MODEL:
+		ret = kvm_s390_set_cpu_model(kvm, attr);
+		break;
 	case KVM_S390_VM_CRYPTO:
 		ret = kvm_s390_vm_set_crypto(kvm, attr);
 		break;
@@ -535,6 +638,9 @@ static int kvm_s390_vm_get_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_TOD:
 		ret = kvm_s390_get_tod(kvm, attr);
 		break;
+	case KVM_S390_VM_CPU_MODEL:
+		ret = kvm_s390_get_cpu_model(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -571,6 +677,17 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 			break;
 		}
 		break;
+	case KVM_S390_VM_CPU_MODEL:
+		switch (attr->attr) {
+		case KVM_S390_VM_CPU_PROCESSOR:
+		case KVM_S390_VM_CPU_MACHINE:
+			ret = 0;
+			break;
+		default:
+			ret = -ENXIO;
+			break;
+		}
+		break;
 	case KVM_S390_VM_CRYPTO:
 		switch (attr->attr) {
 		case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
@@ -782,6 +899,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	       S390_ARCH_FAC_LIST_SIZE_U64);
 
 	/*
+	 * If this KVM host runs *not* in a LPAR, relax the facility bits
+	 * of the kvm facility mask by all missing facilities. This will allow
+	 * to determine the right CPU model by means of the remaining facilities.
+	 * Live guest migration must prohibit the migration of KVMs running in
+	 * a LPAR to non LPAR hosts.
+	 */
+	if (!MACHINE_IS_LPAR)
+		for (i = 0; i < kvm_s390_fac_list_mask_size(); i++)
+			kvm_s390_fac_list_mask[i] &= kvm->arch.model.fac->kvm[i];
+
+	/*
 	 * Apply the kvm facility mask to limit the kvm supported/tolerated
 	 * facility list.
 	 */
@@ -793,6 +921,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	}
 
 	kvm_s390_get_cpu_id(&kvm->arch.model.cpu_id);
+	kvm->arch.model.ibc = sclp_get_ibc() & 0x0fff;
 
 	if (kvm_s390_crypto_init(kvm) < 0)
 		goto out_crypto;
@@ -1034,9 +1163,12 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 
+	mutex_lock(&vcpu->kvm->lock);
 	vcpu->arch.cpu_id = vcpu->kvm->arch.model.cpu_id;
 	memcpy(vcpu->kvm->arch.model.fac->sie, vcpu->kvm->arch.model.fac->kvm,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
+	vcpu->arch.sie_block->ibc = vcpu->kvm->arch.model.ibc;
+	mutex_unlock(&vcpu->kvm->lock);
 
 	kvm_s390_vcpu_crypto_setup(vcpu);
 
-- 
1.9.3
