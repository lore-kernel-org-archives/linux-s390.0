From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:08 +0000
Subject: [PATCH v4 03/10] KVM: s390: add the GIB and its related life-cyle functions
Message-Id: <20181130143215.69496-4-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The GIB (Guest Information Block) links the GISA of all guests
that have adapter interrupts pending. These interrupts cannot be
delivered because no vcpu of these guests is currently running in
SIE context. Instead, a GIB alert is issued on the host to schedule
these guests to run.

This mechanism allows to process adapter interrupts for currently
not running guests.

The GIB is created during host initialization and associated with
the Adapter Interruption Facility in case an Adapter Interruption
Virtualization Facility is available.

The GIB initialization and thus the activation of the related code
will be done in an upcoming patch of this series.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 10 ++++++++++
 arch/s390/kvm/interrupt.c        | 37 +++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  1 +
 arch/s390/kvm/kvm-s390.h         |  2 ++
 4 files changed, 50 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d5d24889c3bc..537e5e59f27e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -785,6 +785,15 @@ struct kvm_s390_gisa {
 	};
 };
 
+struct kvm_s390_gib {
+	u32 alert_list_origin;
+	u32 reserved01;
+	u8:5;
+	u8  nisc:3;
+	u8  reserved03[3];
+	u32 reserved04[5];
+};
+
 /*
  * sie_page2 has to be allocated as DMA because fac_list, crycb and
  * gisa need 31bit addresses in the sie control block.
@@ -838,6 +847,7 @@ struct kvm_arch{
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
+	int gib_in_use;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fcb55b02990e..5d20a0ce8a30 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -31,6 +31,8 @@
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
 
+static struct kvm_s390_gib *gib;
+
 /* handle external calls via sigp interpretation facility */
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
@@ -2899,6 +2901,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
 		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 		kvm_s390_gisa_clear(kvm);
+		kvm->arch.gib_in_use = !!gib;
 	}
 }
 
@@ -2908,3 +2911,37 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 		return;
 	kvm->arch.gisa = NULL;
 }
+
+void kvm_s390_gib_destroy(void)
+{
+	if (!gib)
+		return;
+	chsc_sgib(0);
+	free_page((unsigned long)gib);
+	gib = NULL;
+}
+
+int kvm_s390_gib_init(u8 nisc)
+{
+	if (!css_general_characteristics.aiv) {
+		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
+		return 0;
+	}
+
+	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!gib) {
+		KVM_EVENT(3, "gib 0x%pK memory allocation failed", gib);
+		return -ENOMEM;
+	}
+
+	gib->nisc = nisc;
+	if (chsc_sgib((u32)(u64)gib)) {
+		KVM_EVENT(3, "gib 0x%pK AIV association failed", gib);
+		free_page((unsigned long)gib);
+		gib = NULL;
+		return -EIO;
+	}
+
+	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
+	return 0;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d8d8e0788157..7bc24e16a31d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -445,6 +445,7 @@ int kvm_arch_init(void *opaque)
 
 void kvm_arch_exit(void)
 {
+	kvm_s390_gib_destroy();
 	debug_unregister(kvm_s390_dbf);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1f6e36cdce0d..1a79105b0e9f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -381,6 +381,8 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu,
 void kvm_s390_gisa_init(struct kvm *kvm);
 void kvm_s390_gisa_clear(struct kvm *kvm);
 void kvm_s390_gisa_destroy(struct kvm *kvm);
+int kvm_s390_gib_init(u8 nisc);
+void kvm_s390_gib_destroy(void);
 
 /* implemented in guestdbg.c */
 void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
-- 
2.13.4
