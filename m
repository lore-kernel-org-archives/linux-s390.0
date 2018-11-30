From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:13 +0000
Subject: [PATCH v4 08/10] KVM: s390: add functions to (un)register GISC with GISA
Message-Id: <20181130143215.69496-9-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add the IAM (Interruption Alert Mask) to the architectue specific
kvm struct. This mask in the GISA is used to define for which ISC
a GIB alert can be issued.

The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
are used to (un)register a GISC (guest ISC) with a virtual machine and
its GISA.

Upon successful completion, kvm_s390_gisc_register() returns the
ISC to be used for GIB alert interruptions. A negative return code
indicates an error during registration.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  6 ++++++
 arch/s390/kvm/interrupt.c        | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0deba3ae8bc7..e34cc9b107fb 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -849,6 +849,9 @@ struct kvm_arch{
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
 	int gib_in_use;
+	u8 iam;
+	u32 iam_ref_count[MAX_ISC + 1];
+	spinlock_t iam_ref_lock;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
@@ -882,6 +885,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 
+extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
+extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_check_processor_compat(void *rtn) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 37a5df4e8dac..dd80bdc056a5 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2962,6 +2962,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 {
 	if (css_general_characteristics.aiv) {
 		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+		kvm->arch.iam = 0;
+		spin_lock_init(&kvm->arch.iam_ref_lock);
 		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 		kvm_s390_gisa_clear(kvm);
 		kvm->arch.gib_in_use = !!gib;
@@ -2973,8 +2975,50 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 	if (!kvm->arch.gisa)
 		return;
 	kvm->arch.gisa = NULL;
+	kvm->arch.iam = 0;
 }
 
+int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
+{
+	if (!kvm->arch.gib_in_use)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -EINVAL;
+
+	spin_lock(&kvm->arch.iam_ref_lock);
+	if (kvm->arch.iam_ref_count[gisc] == 0)
+		kvm->arch.iam |= 0x80 >> gisc;
+	kvm->arch.iam_ref_count[gisc]++;
+	spin_unlock(&kvm->arch.iam_ref_lock);
+
+	return gib->nisc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
+
+int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
+{
+	int rc = 0;
+
+	if (!kvm->arch.gib_in_use)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -EINVAL;
+
+	spin_lock(&kvm->arch.iam_ref_lock);
+	if (kvm->arch.iam_ref_count[gisc] == 0) {
+		rc = -EFAULT;
+		goto out;
+	}
+	kvm->arch.iam_ref_count[gisc]--;
+	if (kvm->arch.iam_ref_count[gisc] == 0)
+		kvm->arch.iam &= ~(0x80 >> gisc);
+out:
+	spin_unlock(&kvm->arch.iam_ref_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
+
 void kvm_s390_gib_destroy(void)
 {
 	if (!gib)
-- 
2.13.4
