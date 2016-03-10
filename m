From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 9/9] KVM: s390: allocate only one DMA page per VM
Date: Thu, 10 Mar 2016 16:36:59 +0100
Message-ID: <1457624219-110920-10-git-send-email-borntraeger@de.ibm.com>
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

We can fit the 2k for the STFLE interpretation and the crypto
control block into one DMA page. As we now only have to allocate
one DMA page, we can clean up the code a bit.

As a nice side effect, this also fixes a problem with crycbd alignment in
case special allocation debug options are enabled, debugged by Sascha
Silbe.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 23 +++++++++------
 arch/s390/kvm/kvm-s390.c         | 60 +++++++++++++++-------------------------
 arch/s390/kvm/kvm-s390.h         |  4 +--
 arch/s390/kvm/priv.c             |  2 +-
 4 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d61e645..3c25495 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -600,15 +600,11 @@ struct s390_io_adapter {
 #define S390_ARCH_FAC_MASK_SIZE_U64 \
 	(S390_ARCH_FAC_MASK_SIZE_BYTE / sizeof(u64))
 
-struct kvm_s390_fac {
-	/* facility list requested by guest */
-	__u64 list[S390_ARCH_FAC_LIST_SIZE_U64];
-	/* facility mask supported by kvm & hosting machine */
-	__u64 mask[S390_ARCH_FAC_LIST_SIZE_U64];
-};
-
 struct kvm_s390_cpu_model {
-	struct kvm_s390_fac *fac;
+	/* facility mask supported by kvm & hosting machine */
+	__u64 fac_mask[S390_ARCH_FAC_LIST_SIZE_U64];
+	/* facility list requested by guest (in dma page) */
+	__u64 *fac_list;
 	struct cpuid cpu_id;
 	unsigned short ibc;
 };
@@ -627,6 +623,16 @@ struct kvm_s390_crypto_cb {
 	__u8    reserved80[128];                /* 0x0080 */
 };
 
+/*
+ * sie_page2 has to be allocated as DMA because fac_list and crycb need
+ * 31bit addresses in the sie control block.
+ */
+struct sie_page2 {
+	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
+	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
+	u8 reserved900[0x1000 - 0x900];			/* 0x0900 */
+} __packed;
+
 struct kvm_arch{
 	void *sca;
 	int use_esca;
@@ -647,6 +653,7 @@ struct kvm_arch{
 	int ipte_lock_count;
 	struct mutex ipte_mutex;
 	spinlock_t start_stop_lock;
+	struct sie_page2 *sie_page2;
 	struct kvm_s390_cpu_model model;
 	struct kvm_s390_crypto crypto;
 	u64 epoch;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b6a0654..c186d55 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -355,8 +355,8 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		if (atomic_read(&kvm->online_vcpus)) {
 			r = -EBUSY;
 		} else if (MACHINE_HAS_VX) {
-			set_kvm_facility(kvm->arch.model.fac->mask, 129);
-			set_kvm_facility(kvm->arch.model.fac->list, 129);
+			set_kvm_facility(kvm->arch.model.fac_mask, 129);
+			set_kvm_facility(kvm->arch.model.fac_list, 129);
 			r = 0;
 		} else
 			r = -EINVAL;
@@ -370,8 +370,8 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		if (atomic_read(&kvm->online_vcpus)) {
 			r = -EBUSY;
 		} else if (test_facility(64)) {
-			set_kvm_facility(kvm->arch.model.fac->mask, 64);
-			set_kvm_facility(kvm->arch.model.fac->list, 64);
+			set_kvm_facility(kvm->arch.model.fac_mask, 64);
+			set_kvm_facility(kvm->arch.model.fac_list, 64);
 			r = 0;
 		}
 		mutex_unlock(&kvm->lock);
@@ -654,7 +654,7 @@ static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 		memcpy(&kvm->arch.model.cpu_id, &proc->cpuid,
 		       sizeof(struct cpuid));
 		kvm->arch.model.ibc = proc->ibc;
-		memcpy(kvm->arch.model.fac->list, proc->fac_list,
+		memcpy(kvm->arch.model.fac_list, proc->fac_list,
 		       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	} else
 		ret = -EFAULT;
@@ -688,7 +688,8 @@ static int kvm_s390_get_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 	}
 	memcpy(&proc->cpuid, &kvm->arch.model.cpu_id, sizeof(struct cpuid));
 	proc->ibc = kvm->arch.model.ibc;
-	memcpy(&proc->fac_list, kvm->arch.model.fac->list, S390_ARCH_FAC_LIST_SIZE_BYTE);
+	memcpy(&proc->fac_list, kvm->arch.model.fac_list,
+	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	if (copy_to_user((void __user *)attr->addr, proc, sizeof(*proc)))
 		ret = -EFAULT;
 	kfree(proc);
@@ -708,7 +709,7 @@ static int kvm_s390_get_machine(struct kvm *kvm, struct kvm_device_attr *attr)
 	}
 	get_cpu_id((struct cpuid *) &mach->cpuid);
 	mach->ibc = sclp.ibc;
-	memcpy(&mach->fac_mask, kvm->arch.model.fac->mask,
+	memcpy(&mach->fac_mask, kvm->arch.model.fac_mask,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	memcpy((unsigned long *)&mach->fac_list, S390_lowcore.stfle_fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
@@ -1085,16 +1086,12 @@ static void kvm_s390_get_cpu_id(struct cpuid *cpu_id)
 	cpu_id->version = 0xff;
 }
 
-static int kvm_s390_crypto_init(struct kvm *kvm)
+static void kvm_s390_crypto_init(struct kvm *kvm)
 {
 	if (!test_kvm_facility(kvm, 76))
-		return 0;
-
-	kvm->arch.crypto.crycb = kzalloc(sizeof(*kvm->arch.crypto.crycb),
-					 GFP_KERNEL | GFP_DMA);
-	if (!kvm->arch.crypto.crycb)
-		return -ENOMEM;
+		return;
 
+	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_s390_set_crycb_format(kvm);
 
 	/* Enable AES/DEA protected key functions by default */
@@ -1104,8 +1101,6 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 			 sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
 	get_random_bytes(kvm->arch.crypto.crycb->dea_wrapping_key_mask,
 			 sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
-
-	return 0;
 }
 
 static void sca_dispose(struct kvm *kvm)
@@ -1159,37 +1154,30 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.dbf)
 		goto out_err;
 
-	/*
-	 * The architectural maximum amount of facilities is 16 kbit. To store
-	 * this amount, 2 kbyte of memory is required. Thus we need a full
-	 * page to hold the guest facility list (arch.model.fac->list) and the
-	 * facility mask (arch.model.fac->mask). Its address size has to be
-	 * 31 bits and word aligned.
-	 */
-	kvm->arch.model.fac =
-		(struct kvm_s390_fac *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!kvm->arch.model.fac)
+	kvm->arch.sie_page2 =
+	     (struct sie_page2 *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!kvm->arch.sie_page2)
 		goto out_err;
 
 	/* Populate the facility mask initially. */
-	memcpy(kvm->arch.model.fac->mask, S390_lowcore.stfle_fac_list,
+	memcpy(kvm->arch.model.fac_mask, S390_lowcore.stfle_fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
 		if (i < kvm_s390_fac_list_mask_size())
-			kvm->arch.model.fac->mask[i] &= kvm_s390_fac_list_mask[i];
+			kvm->arch.model.fac_mask[i] &= kvm_s390_fac_list_mask[i];
 		else
-			kvm->arch.model.fac->mask[i] = 0UL;
+			kvm->arch.model.fac_mask[i] = 0UL;
 	}
 
 	/* Populate the facility list initially. */
-	memcpy(kvm->arch.model.fac->list, kvm->arch.model.fac->mask,
+	kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
+	memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
 	kvm_s390_get_cpu_id(&kvm->arch.model.cpu_id);
 	kvm->arch.model.ibc = sclp.ibc & 0x0fff;
 
-	if (kvm_s390_crypto_init(kvm) < 0)
-		goto out_err;
+	kvm_s390_crypto_init(kvm);
 
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
@@ -1225,8 +1213,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	return 0;
 out_err:
-	kfree(kvm->arch.crypto.crycb);
-	free_page((unsigned long)kvm->arch.model.fac);
+	free_page((unsigned long)kvm->arch.sie_page2);
 	debug_unregister(kvm->arch.dbf);
 	sca_dispose(kvm);
 	KVM_EVENT(3, "creation of vm failed: %d", rc);
@@ -1272,10 +1259,9 @@ static void kvm_free_vcpus(struct kvm *kvm)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_free_vcpus(kvm);
-	free_page((unsigned long)kvm->arch.model.fac);
 	sca_dispose(kvm);
 	debug_unregister(kvm->arch.dbf);
-	kfree(kvm->arch.crypto.crycb);
+	free_page((unsigned long)kvm->arch.sie_page2);
 	if (!kvm_is_ucontrol(kvm))
 		gmap_free(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
@@ -1640,7 +1626,7 @@ static void kvm_s390_vcpu_setup_model(struct kvm_vcpu *vcpu)
 	vcpu->arch.cpu_id = model->cpu_id;
 	vcpu->arch.sie_block->ibc = model->ibc;
 	if (test_kvm_facility(vcpu->kvm, 7))
-		vcpu->arch.sie_block->fac = (int) (long) model->fac->list;
+		vcpu->arch.sie_block->fac = (u32)(u64) model->fac_list;
 }
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index b1f7ee3..8621ab0 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -160,8 +160,8 @@ static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
 /* test availability of facility in a kvm instance */
 static inline int test_kvm_facility(struct kvm *kvm, unsigned long nr)
 {
-	return __test_facility(nr, kvm->arch.model.fac->mask) &&
-		__test_facility(nr, kvm->arch.model.fac->list);
+	return __test_facility(nr, kvm->arch.model.fac_mask) &&
+		__test_facility(nr, kvm->arch.model.fac_list);
 }
 
 static inline int set_kvm_facility(u64 *fac_list, unsigned long nr)
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index add9909..f218ccf 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -354,7 +354,7 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	 * We need to shift the lower 32 facility bits (bit 0-31) from a u64
 	 * into a u32 memory representation. They will remain bits 0-31.
 	 */
-	fac = *vcpu->kvm->arch.model.fac->list >> 32;
+	fac = *vcpu->kvm->arch.model.fac_list >> 32;
 	rc = write_guest_lc(vcpu, offsetof(struct lowcore, stfl_fac_list),
 			    &fac, sizeof(fac));
 	if (rc)
-- 
2.5.0
