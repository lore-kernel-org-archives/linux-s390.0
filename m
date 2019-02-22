From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:23 +0000
Subject: [GIT PULL 12/18] KVM: s390: add functions to (un)register GISC with GISA
Message-Id: <1550835749-26436-13-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

Add the Interruption Alert Mask (IAM) to the architecture specific
kvm struct. This mask in the GISA is used to define for which ISC
a GIB alert will be issued.

The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
are used to (un)register a GISC (guest ISC) with a virtual machine and
its GISA.

Upon successful completion, kvm_s390_gisc_register() returns the
ISC to be used for GIB alert interruptions. A negative return code
indicates an error during registration.

Theses functions will be used by other adapter types like AP and PCI to
request pass-through interruption support.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190131085247.13826-12-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  13 +++++
 arch/s390/kvm/interrupt.c        | 112 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 7077762..2cfff61 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -781,6 +781,9 @@ struct kvm_s390_gisa {
 			u8  reserved03[11];
 			u32 airq_count;
 		} g1;
+		struct {
+			u64 word[4];
+		} u64;
 	};
 };
 
@@ -813,8 +816,15 @@ struct kvm_s390_vsie {
 	struct page *pages[KVM_MAX_VCPUS];
 };
 
+struct kvm_s390_gisa_iam {
+	u8 mask;
+	spinlock_t ref_lock;
+	u32 ref_count[MAX_ISC + 1];
+};
+
 struct kvm_s390_gisa_interrupt {
 	struct kvm_s390_gisa *origin;
+	struct kvm_s390_gisa_iam alert;
 };
 
 struct kvm_arch{
@@ -885,6 +895,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 
+extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
+extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_check_processor_compat(void *rtn) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5efcd9e..040745b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -222,6 +222,33 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
+/**
+ * gisa_set_iam - change the GISA interruption alert mask
+ *
+ * @gisa: gisa to operate on
+ * @iam: new IAM value to use
+ *
+ * Change the IAM atomically with the next alert address and the IPM
+ * of the GISA if the GISA is not part of the GIB alert list. All three
+ * fields are located in the first long word of the GISA.
+ *
+ * Returns: 0 on success
+ *          -EBUSY in case the gisa is part of the alert list
+ */
+static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
+{
+	u64 word, _word;
+
+	do {
+		word = READ_ONCE(gisa->u64.word[0]);
+		if ((u64)gisa != word >> 32)
+			return -EBUSY;
+		_word = (word & ~0xffUL) | iam;
+	} while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
+
+	return 0;
+}
+
 static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
@@ -2911,6 +2938,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	if (!css_general_characteristics.aiv)
 		return;
 	gi->origin = &kvm->arch.sie_page2->gisa;
+	gi->alert.mask = 0;
+	spin_lock_init(&gi->alert.ref_lock);
 	kvm_s390_gisa_clear(kvm);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
@@ -2920,6 +2949,89 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 	kvm->arch.gisa_int.origin = NULL;
 }
 
+/**
+ * kvm_s390_gisc_register - register a guest ISC
+ *
+ * @kvm:  the kernel vm to work with
+ * @gisc: the guest interruption sub class to register
+ *
+ * The function extends the vm specific alert mask to use.
+ * The effective IAM mask in the GISA is updated as well
+ * in case the GISA is not part of the GIB alert list.
+ * It will be updated latest when the IAM gets restored
+ * by gisa_get_ipm_or_restore_iam().
+ *
+ * Returns: the nonspecific ISC (NISC) the gib alert mechanism
+ *          has registered with the channel subsystem.
+ *          -ENODEV in case the vm uses no GISA
+ *          -ERANGE in case the guest ISC is invalid
+ */
+int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
+{
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
+	if (!gi->origin)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -ERANGE;
+
+	spin_lock(&gi->alert.ref_lock);
+	gi->alert.ref_count[gisc]++;
+	if (gi->alert.ref_count[gisc] == 1) {
+		gi->alert.mask |= 0x80 >> gisc;
+		gisa_set_iam(gi->origin, gi->alert.mask);
+	}
+	spin_unlock(&gi->alert.ref_lock);
+
+	return gib->nisc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
+
+/**
+ * kvm_s390_gisc_unregister - unregister a guest ISC
+ *
+ * @kvm:  the kernel vm to work with
+ * @gisc: the guest interruption sub class to register
+ *
+ * The function reduces the vm specific alert mask to use.
+ * The effective IAM mask in the GISA is updated as well
+ * in case the GISA is not part of the GIB alert list.
+ * It will be updated latest when the IAM gets restored
+ * by gisa_get_ipm_or_restore_iam().
+ *
+ * Returns: the nonspecific ISC (NISC) the gib alert mechanism
+ *          has registered with the channel subsystem.
+ *          -ENODEV in case the vm uses no GISA
+ *          -ERANGE in case the guest ISC is invalid
+ *          -EINVAL in case the guest ISC is not registered
+ */
+int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
+{
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+	int rc = 0;
+
+	if (!gi->origin)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -ERANGE;
+
+	spin_lock(&gi->alert.ref_lock);
+	if (gi->alert.ref_count[gisc] == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+	gi->alert.ref_count[gisc]--;
+	if (gi->alert.ref_count[gisc] == 0) {
+		gi->alert.mask &= ~(0x80 >> gisc);
+		gisa_set_iam(gi->origin, gi->alert.mask);
+	}
+out:
+	spin_unlock(&gi->alert.ref_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
+
 void kvm_s390_gib_destroy(void)
 {
 	if (!gib)
-- 
2.7.4
