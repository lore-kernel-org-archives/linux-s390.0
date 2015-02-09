From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/7] KVM: s390: use facilities and cpu_id per KVM
Date: Mon,  9 Feb 2015 13:33:45 +0100
Message-ID: <1423485227-51721-6-git-send-email-borntraeger@de.ibm.com>
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

The patch introduces facilities and cpu_ids per virtual machine.
Different virtual machines may want to expose different facilities and
cpu ids to the guest, so let's make them per-vm instead of global.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 21 +++++++++
 arch/s390/kvm/gaccess.c          |  4 +-
 arch/s390/kvm/kvm-s390.c         | 92 +++++++++++++++++++++++++---------------
 arch/s390/kvm/kvm-s390.h         | 13 ++++--
 arch/s390/kvm/priv.c             | 13 ++++--
 5 files changed, 99 insertions(+), 44 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 77ae014..79dc3b0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -506,6 +506,26 @@ struct s390_io_adapter {
 #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
 #define MAX_S390_ADAPTER_MAPS 256
 
+/* maximum size of facilities and facility mask is 2k bytes */
+#define S390_ARCH_FAC_LIST_SIZE_BYTE (1<<11)
+#define S390_ARCH_FAC_LIST_SIZE_U64 \
+	(S390_ARCH_FAC_LIST_SIZE_BYTE / sizeof(u64))
+#define S390_ARCH_FAC_MASK_SIZE_BYTE S390_ARCH_FAC_LIST_SIZE_BYTE
+#define S390_ARCH_FAC_MASK_SIZE_U64 \
+	(S390_ARCH_FAC_MASK_SIZE_BYTE / sizeof(u64))
+
+struct s390_model_fac {
+	/* facilities used in SIE context */
+	__u64 sie[S390_ARCH_FAC_LIST_SIZE_U64];
+	/* subset enabled by kvm */
+	__u64 kvm[S390_ARCH_FAC_LIST_SIZE_U64];
+};
+
+struct kvm_s390_cpu_model {
+	struct s390_model_fac *fac;
+	struct cpuid cpu_id;
+};
+
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
 	__u32 crycbd;
@@ -536,6 +556,7 @@ struct kvm_arch{
 	int ipte_lock_count;
 	struct mutex ipte_mutex;
 	spinlock_t start_stop_lock;
+	struct kvm_s390_cpu_model model;
 	struct kvm_s390_crypto crypto;
 	u64 epoch;
 };
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8a1be90..267523c 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -357,8 +357,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	union asce asce;
 
 	ctlreg0.val = vcpu->arch.sie_block->gcr[0];
-	edat1 = ctlreg0.edat && test_vfacility(8);
-	edat2 = edat1 && test_vfacility(78);
+	edat1 = ctlreg0.edat && test_kvm_facility(vcpu->kvm, 8);
+	edat2 = edat1 && test_kvm_facility(vcpu->kvm, 78);
 	asce.val = get_vcpu_asce(vcpu);
 	if (asce.r)
 		goto real_address;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index deac473..8c538a1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -30,7 +30,6 @@
 #include <asm/pgtable.h>
 #include <asm/nmi.h>
 #include <asm/switch_to.h>
-#include <asm/facility.h>
 #include <asm/sclp.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -100,15 +99,20 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
-unsigned long *vfacilities;
-static struct gmap_notifier gmap_notifier;
+/* upper facilities limit for kvm */
+unsigned long kvm_s390_fac_list_mask[] = {
+	0xff82fffbf4fc2000UL,
+	0x005c000000000000UL,
+};
 
-/* test availability of vfacility */
-int test_vfacility(unsigned long nr)
+unsigned long kvm_s390_fac_list_mask_size(void)
 {
-	return __test_facility(nr, (void *) vfacilities);
+	BUILD_BUG_ON(ARRAY_SIZE(kvm_s390_fac_list_mask) > S390_ARCH_FAC_MASK_SIZE_U64);
+	return ARRAY_SIZE(kvm_s390_fac_list_mask);
 }
 
+static struct gmap_notifier gmap_notifier;
+
 /* Section: not file related */
 int kvm_arch_hardware_enable(void)
 {
@@ -351,7 +355,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_vcpu *vcpu;
 	int i;
 
-	if (!test_vfacility(76))
+	if (!test_kvm_facility(kvm, 76))
 		return -EINVAL;
 
 	mutex_lock(&kvm->lock);
@@ -700,9 +704,15 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+static void kvm_s390_get_cpu_id(struct cpuid *cpu_id)
+{
+	get_cpu_id(cpu_id);
+	cpu_id->version = 0xff;
+}
+
 static int kvm_s390_crypto_init(struct kvm *kvm)
 {
-	if (!test_vfacility(76))
+	if (!test_kvm_facility(kvm, 76))
 		return 0;
 
 	kvm->arch.crypto.crycb = kzalloc(sizeof(*kvm->arch.crypto.crycb),
@@ -721,7 +731,7 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
-	int rc;
+	int i, rc;
 	char debug_name[16];
 	static unsigned long sca_offset;
 
@@ -756,6 +766,34 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.dbf)
 		goto out_nodbf;
 
+	/*
+	 * The architectural maximum amount of facilities is 16 kbit. To store
+	 * this amount, 2 kbyte of memory is required. Thus we need a full
+	 * page to hold the active copy (arch.model.fac->sie) and the current
+	 * facilities set (arch.model.fac->kvm). Its address size has to be
+	 * 31 bits and word aligned.
+	 */
+	kvm->arch.model.fac =
+		(struct s390_model_fac *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!kvm->arch.model.fac)
+		goto out_nofac;
+
+	memcpy(kvm->arch.model.fac->kvm, S390_lowcore.stfle_fac_list,
+	       S390_ARCH_FAC_LIST_SIZE_U64);
+
+	/*
+	 * Apply the kvm facility mask to limit the kvm supported/tolerated
+	 * facility list.
+	 */
+	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
+		if (i < kvm_s390_fac_list_mask_size())
+			kvm->arch.model.fac->kvm[i] &= kvm_s390_fac_list_mask[i];
+		else
+			kvm->arch.model.fac->kvm[i] = 0UL;
+	}
+
+	kvm_s390_get_cpu_id(&kvm->arch.model.cpu_id);
+
 	if (kvm_s390_crypto_init(kvm) < 0)
 		goto out_crypto;
 
@@ -787,6 +825,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 out_nogmap:
 	kfree(kvm->arch.crypto.crycb);
 out_crypto:
+	free_page((unsigned long)kvm->arch.model.fac);
+out_nofac:
 	debug_unregister(kvm->arch.dbf);
 out_nodbf:
 	free_page((unsigned long)(kvm->arch.sca));
@@ -839,6 +879,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_free_vcpus(kvm);
+	free_page((unsigned long)kvm->arch.model.fac);
 	free_page((unsigned long)(kvm->arch.sca));
 	debug_unregister(kvm->arch.dbf);
 	kfree(kvm->arch.crypto.crycb);
@@ -934,7 +975,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
-	if (!test_vfacility(76))
+	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
@@ -973,7 +1014,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 						    CPUSTAT_STOPPED |
 						    CPUSTAT_GED);
 	vcpu->arch.sie_block->ecb   = 6;
-	if (test_vfacility(50) && test_vfacility(73))
+	if (test_kvm_facility(vcpu->kvm, 50) && test_kvm_facility(vcpu->kvm, 73))
 		vcpu->arch.sie_block->ecb |= 0x10;
 
 	vcpu->arch.sie_block->ecb2  = 8;
@@ -982,7 +1023,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp_has_sigpif())
 		vcpu->arch.sie_block->eca |= 0x10000000U;
-	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE |
 				      ICTL_TPROT;
 
@@ -993,8 +1033,10 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	}
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
-	get_cpu_id(&vcpu->arch.cpu_id);
-	vcpu->arch.cpu_id.version = 0xff;
+
+	vcpu->arch.cpu_id = vcpu->kvm->arch.model.cpu_id;
+	memcpy(vcpu->kvm->arch.model.fac->sie, vcpu->kvm->arch.model.fac->kvm,
+	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
 	kvm_s390_vcpu_crypto_setup(vcpu);
 
@@ -1038,6 +1080,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)kvm->arch.sca;
 		set_bit(63 - id, (unsigned long *) &kvm->arch.sca->mcn);
 	}
+	vcpu->arch.sie_block->fac = (int) (long) kvm->arch.model.fac->sie;
 
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
@@ -2103,30 +2146,11 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 static int __init kvm_s390_init(void)
 {
-	int ret;
-	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-	if (ret)
-		return ret;
-
-	/*
-	 * guests can ask for up to 255+1 double words, we need a full page
-	 * to hold the maximum amount of facilities. On the other hand, we
-	 * only set facilities that are known to work in KVM.
-	 */
-	vfacilities = (unsigned long *) get_zeroed_page(GFP_KERNEL|GFP_DMA);
-	if (!vfacilities) {
-		kvm_exit();
-		return -ENOMEM;
-	}
-	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
-	vfacilities[0] &= 0xff82fffbf4fc2000UL;
-	vfacilities[1] &= 0x005c000000000000UL;
-	return 0;
+	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
 static void __exit kvm_s390_exit(void)
 {
-	free_page((unsigned long) vfacilities);
 	kvm_exit();
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c22dce8..985c211 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -18,12 +18,10 @@
 #include <linux/hrtimer.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <asm/facility.h>
 
 typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 
-/* declare vfacilities extern */
-extern unsigned long *vfacilities;
-
 /* Transactional Memory Execution related macros */
 #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & 0x10))
 #define TDB_FORMAT1		1
@@ -127,6 +125,12 @@ static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
 	vcpu->arch.sie_block->gpsw.mask |= cc << 44;
 }
 
+/* test availability of facility in a kvm intance */
+static inline int test_kvm_facility(struct kvm *kvm, unsigned long nr)
+{
+	return __test_facility(nr, kvm->arch.model.fac->kvm);
+}
+
 /* are cpu states controlled by user space */
 static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 {
@@ -183,7 +187,8 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
 /* is cmma enabled */
 bool kvm_s390_cmma_enabled(struct kvm *kvm);
-int test_vfacility(unsigned long nr);
+unsigned long kvm_s390_fac_list_mask_size(void);
+extern unsigned long kvm_s390_fac_list_mask[];
 
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 1be578d..bdd9b5b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -337,19 +337,24 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
 	int rc;
+	unsigned int fac;
 
 	vcpu->stat.instruction_stfl++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
+	/*
+	 * We need to shift the lower 32 facility bits (bit 0-31) from a u64
+	 * into a u32 memory representation. They will remain bits 0-31.
+	 */
+	fac = *vcpu->kvm->arch.model.fac->sie >> 32;
 	rc = write_guest_lc(vcpu, offsetof(struct _lowcore, stfl_fac_list),
-			    vfacilities, 4);
+			    &fac, sizeof(fac));
 	if (rc)
 		return rc;
-	VCPU_EVENT(vcpu, 5, "store facility list value %x",
-		   *(unsigned int *) vfacilities);
-	trace_kvm_s390_handle_stfl(vcpu, *(unsigned int *) vfacilities);
+	VCPU_EVENT(vcpu, 5, "store facility list value %x", fac);
+	trace_kvm_s390_handle_stfl(vcpu, fac);
 	return 0;
 }
 
-- 
1.9.3
