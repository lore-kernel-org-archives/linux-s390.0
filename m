From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/20] KVM: s390: include guest facilities in kvm facility test
Date: Fri,  6 Mar 2015 14:16:36 +0100
Message-ID: <1425647812-61838-5-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

Most facility related decisions in KVM have to take into account:

- the facilities offered by the underlying run container (LPAR/VM)
- the facilities supported by the KVM code itself
- the facilities requested by a guest VM

This patch adds the KVM driver requested facilities to the test routine.

It additionally renames struct s390_model_fac to kvm_s390_fac and its field
names to be more meaningful.

The semantics of the facilities stored in the KVM architecture structure
is changed. The address arch.model.fac->list now points to the guest
facility list and arch.model.fac->mask points to the KVM facility mask.

This patch fixes the behaviour of KVM for some facilities for guests
that ignore the guest visible facility bits, e.g. guests could use
transactional memory intructions on hosts supporting them even if the
chosen cpu model would not offer them.

The userspace interface is not affected by this change.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 12 ++++++------
 arch/s390/kvm/kvm-s390.c         | 30 ++++++++++++++++--------------
 arch/s390/kvm/kvm-s390.h         |  3 ++-
 arch/s390/kvm/priv.c             |  2 +-
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d84559e..f407bbf 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -515,15 +515,15 @@ struct s390_io_adapter {
 #define S390_ARCH_FAC_MASK_SIZE_U64 \
 	(S390_ARCH_FAC_MASK_SIZE_BYTE / sizeof(u64))
 
-struct s390_model_fac {
-	/* facilities used in SIE context */
-	__u64 sie[S390_ARCH_FAC_LIST_SIZE_U64];
-	/* subset enabled by kvm */
-	__u64 kvm[S390_ARCH_FAC_LIST_SIZE_U64];
+struct kvm_s390_fac {
+	/* facility list requested by guest */
+	__u64 list[S390_ARCH_FAC_LIST_SIZE_U64];
+	/* facility mask supported by kvm & hosting machine */
+	__u64 mask[S390_ARCH_FAC_LIST_SIZE_U64];
 };
 
 struct kvm_s390_cpu_model {
-	struct s390_model_fac *fac;
+	struct kvm_s390_fac *fac;
 	struct cpuid cpu_id;
 	unsigned short ibc;
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 76894c8..5a02be4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -522,7 +522,7 @@ static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 		memcpy(&kvm->arch.model.cpu_id, &proc->cpuid,
 		       sizeof(struct cpuid));
 		kvm->arch.model.ibc = proc->ibc;
-		memcpy(kvm->arch.model.fac->kvm, proc->fac_list,
+		memcpy(kvm->arch.model.fac->list, proc->fac_list,
 		       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	} else
 		ret = -EFAULT;
@@ -556,7 +556,7 @@ static int kvm_s390_get_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 	}
 	memcpy(&proc->cpuid, &kvm->arch.model.cpu_id, sizeof(struct cpuid));
 	proc->ibc = kvm->arch.model.ibc;
-	memcpy(&proc->fac_list, kvm->arch.model.fac->kvm, S390_ARCH_FAC_LIST_SIZE_BYTE);
+	memcpy(&proc->fac_list, kvm->arch.model.fac->list, S390_ARCH_FAC_LIST_SIZE_BYTE);
 	if (copy_to_user((void __user *)attr->addr, proc, sizeof(*proc)))
 		ret = -EFAULT;
 	kfree(proc);
@@ -576,8 +576,8 @@ static int kvm_s390_get_machine(struct kvm *kvm, struct kvm_device_attr *attr)
 	}
 	get_cpu_id((struct cpuid *) &mach->cpuid);
 	mach->ibc = sclp_get_ibc();
-	memcpy(&mach->fac_mask, kvm_s390_fac_list_mask,
-	       kvm_s390_fac_list_mask_size() * sizeof(u64));
+	memcpy(&mach->fac_mask, kvm->arch.model.fac->mask,
+	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	memcpy((unsigned long *)&mach->fac_list, S390_lowcore.stfle_fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	if (copy_to_user((void __user *)attr->addr, mach, sizeof(*mach)))
@@ -893,16 +893,16 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	/*
 	 * The architectural maximum amount of facilities is 16 kbit. To store
 	 * this amount, 2 kbyte of memory is required. Thus we need a full
-	 * page to hold the active copy (arch.model.fac->sie) and the current
-	 * facilities set (arch.model.fac->kvm). Its address size has to be
+	 * page to hold the guest facility list (arch.model.fac->list) and the
+	 * facility mask (arch.model.fac->mask). Its address size has to be
 	 * 31 bits and word aligned.
 	 */
 	kvm->arch.model.fac =
-		(struct s390_model_fac *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		(struct kvm_s390_fac *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!kvm->arch.model.fac)
 		goto out_nofac;
 
-	memcpy(kvm->arch.model.fac->kvm, S390_lowcore.stfle_fac_list,
+	memcpy(kvm->arch.model.fac->mask, S390_lowcore.stfle_fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
 	/*
@@ -914,7 +914,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	 */
 	if (!MACHINE_IS_LPAR)
 		for (i = 0; i < kvm_s390_fac_list_mask_size(); i++)
-			kvm_s390_fac_list_mask[i] &= kvm->arch.model.fac->kvm[i];
+			kvm_s390_fac_list_mask[i] &= kvm->arch.model.fac->mask[i];
 
 	/*
 	 * Apply the kvm facility mask to limit the kvm supported/tolerated
@@ -922,11 +922,15 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	 */
 	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
 		if (i < kvm_s390_fac_list_mask_size())
-			kvm->arch.model.fac->kvm[i] &= kvm_s390_fac_list_mask[i];
+			kvm->arch.model.fac->mask[i] &= kvm_s390_fac_list_mask[i];
 		else
-			kvm->arch.model.fac->kvm[i] = 0UL;
+			kvm->arch.model.fac->mask[i] = 0UL;
 	}
 
+	/* Populate the facility list initially. */
+	memcpy(kvm->arch.model.fac->list, kvm->arch.model.fac->mask,
+	       S390_ARCH_FAC_LIST_SIZE_BYTE);
+
 	kvm_s390_get_cpu_id(&kvm->arch.model.cpu_id);
 	kvm->arch.model.ibc = sclp_get_ibc() & 0x0fff;
 
@@ -1172,8 +1176,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	mutex_lock(&vcpu->kvm->lock);
 	vcpu->arch.cpu_id = vcpu->kvm->arch.model.cpu_id;
-	memcpy(vcpu->kvm->arch.model.fac->sie, vcpu->kvm->arch.model.fac->kvm,
-	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	vcpu->arch.sie_block->ibc = vcpu->kvm->arch.model.ibc;
 	mutex_unlock(&vcpu->kvm->lock);
 
@@ -1219,7 +1221,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)kvm->arch.sca;
 		set_bit(63 - id, (unsigned long *) &kvm->arch.sca->mcn);
 	}
-	vcpu->arch.sie_block->fac = (int) (long) kvm->arch.model.fac->sie;
+	vcpu->arch.sie_block->fac = (int) (long) kvm->arch.model.fac->list;
 
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 985c211..c34109a 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -128,7 +128,8 @@ static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
 /* test availability of facility in a kvm intance */
 static inline int test_kvm_facility(struct kvm *kvm, unsigned long nr)
 {
-	return __test_facility(nr, kvm->arch.model.fac->kvm);
+	return __test_facility(nr, kvm->arch.model.fac->mask) &&
+		__test_facility(nr, kvm->arch.model.fac->list);
 }
 
 /* are cpu states controlled by user space */
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index bdd9b5b..3511169 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -348,7 +348,7 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	 * We need to shift the lower 32 facility bits (bit 0-31) from a u64
 	 * into a u32 memory representation. They will remain bits 0-31.
 	 */
-	fac = *vcpu->kvm->arch.model.fac->sie >> 32;
+	fac = *vcpu->kvm->arch.model.fac->list >> 32;
 	rc = write_guest_lc(vcpu, offsetof(struct _lowcore, stfl_fac_list),
 			    &fac, sizeof(fac));
 	if (rc)
-- 
2.3.0
