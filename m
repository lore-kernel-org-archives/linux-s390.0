From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:14 +0000
Subject: [PATCH v4 09/10] KVM: s390: add and wire function gib_alert_irq_handler()
Message-Id: <20181130143215.69496-10-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The patch implements a handler for GIB alert interruptions
on the host. Its task is to alert storage backed guests that
interrupts are pending for them.

A GIB alert interrupt statistic counter is added as well:

$ cat /proc/interrupts
          CPU0       CPU1
  ...
  GAL:      23         37   [I/O] GIB Alert
  ...

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/irq.h |  1 +
 arch/s390/include/asm/isc.h |  1 +
 arch/s390/kernel/irq.c      |  1 +
 arch/s390/kvm/interrupt.c   | 66 ++++++++++++++++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.h    |  5 ++++
 5 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
index 2f7f27e5493f..afaf5e3c57fd 100644
--- a/arch/s390/include/asm/irq.h
+++ b/arch/s390/include/asm/irq.h
@@ -62,6 +62,7 @@ enum interruption_class {
 	IRQIO_MSI,
 	IRQIO_VIR,
 	IRQIO_VAI,
+	IRQIO_GAL,
 	NMI_NMI,
 	CPU_RST,
 	NR_ARCH_IRQS
diff --git a/arch/s390/include/asm/isc.h b/arch/s390/include/asm/isc.h
index 6cb9e2ed05b6..b2cc1ec78d06 100644
--- a/arch/s390/include/asm/isc.h
+++ b/arch/s390/include/asm/isc.h
@@ -21,6 +21,7 @@
 /* Adapter interrupts. */
 #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
 #define PCI_ISC 2			/* PCI I/O subchannels */
+#define GAL_ISC 5			/* GIB alert */
 #define AP_ISC 6			/* adjunct processor (crypto) devices */
 
 /* Functions for registration of I/O interruption subclasses */
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 0e8d68bac82c..0cd5a5f96729 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -88,6 +88,7 @@ static const struct irq_class irqclass_sub_desc[] = {
 	{.irq = IRQIO_MSI,  .name = "MSI", .desc = "[I/O] MSI Interrupt" },
 	{.irq = IRQIO_VIR,  .name = "VIR", .desc = "[I/O] Virtual I/O Devices"},
 	{.irq = IRQIO_VAI,  .name = "VAI", .desc = "[I/O] Virtual I/O Devices AI"},
+	{.irq = IRQIO_GAL,  .name = "GAL", .desc = "[I/O] GIB Alert"},
 	{.irq = NMI_NMI,    .name = "NMI", .desc = "[NMI] Machine Check"},
 	{.irq = CPU_RST,    .name = "RST", .desc = "[CPU] CPU Restart"},
 };
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index dd80bdc056a5..d87632996b07 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -23,6 +23,7 @@
 #include <asm/gmap.h>
 #include <asm/switch_to.h>
 #include <asm/nmi.h>
+#include <asm/airq.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
@@ -1099,6 +1100,17 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 	if (kvm_arch_vcpu_runnable(vcpu))
 		return 0;
 
+	/*
+	 * This could be the single vcpu of the guest or the last vcpu
+	 * open for I/O interruptons going into wait state.
+	 */
+	if (vcpu->kvm->arch.gib_in_use &&
+	    !in_alert_list(vcpu->kvm->arch.gisa)) {
+		if (unlikely(kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa)))
+			return 0;
+		vcpu->kvm->arch.gisa->iam = vcpu->kvm->arch.iam;
+	}
+
 	if (psw_interrupts_disabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "disabled wait");
 		return -EOPNOTSUPP; /* disabled wait */
@@ -2904,7 +2916,7 @@ static void nullify_gisa(struct kvm_s390_gisa *gisa)
 #define NONE_GISA_ADDR 0x00000001UL
 #define GISA_ADDR_MASK 0xfffff000UL
 
-static void __maybe_unused process_gib_alert_list(void)
+static void process_gib_alert_list(void)
 {
 	u32 final, next_alert, origin = 0UL;
 	struct kvm_s390_gisa *gisa;
@@ -2953,6 +2965,9 @@ static void __maybe_unused process_gib_alert_list(void)
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
 	if (kvm->arch.gisa) {
+		kvm->arch.gisa->iam = 0;
+		while (in_alert_list(kvm->arch.gisa))
+			process_gib_alert_list();
 		nullify_gisa(kvm->arch.gisa);
 		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
 	}
@@ -2964,9 +2979,9 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
 		kvm->arch.iam = 0;
 		spin_lock_init(&kvm->arch.iam_ref_lock);
-		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
-		kvm_s390_gisa_clear(kvm);
+		nullify_gisa(kvm->arch.gisa);
 		kvm->arch.gib_in_use = !!gib;
+		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 	}
 }
 
@@ -2974,6 +2989,10 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 {
 	if (!kvm->arch.gisa)
 		return;
+
+	kvm->arch.gisa->iam = 0;
+	while (in_alert_list(kvm->arch.gisa))
+		process_gib_alert_list();
 	kvm->arch.gisa = NULL;
 	kvm->arch.iam = 0;
 }
@@ -3019,36 +3038,65 @@ int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
 }
 EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
 
+static void gib_alert_irq_handler(struct airq_struct *airq)
+{
+	inc_irq_stat(IRQIO_GAL);
+	process_gib_alert_list();
+}
+
+static struct airq_struct gib_alert_irq = {
+	.handler = gib_alert_irq_handler,
+	.lsi_ptr = &gib_alert_irq.lsi_mask,
+};
+
 void kvm_s390_gib_destroy(void)
 {
 	if (!gib)
 		return;
 	chsc_sgib(0);
+	unregister_adapter_interrupt(&gib_alert_irq);
 	free_page((unsigned long)gib);
 	gib = NULL;
 }
 
 int kvm_s390_gib_init(u8 nisc)
 {
+	int rc = 0;
+
 	if (!css_general_characteristics.aiv) {
 		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
-		return 0;
+		goto out;
 	}
 
 	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!gib) {
 		KVM_EVENT(3, "gib 0x%pK memory allocation failed", gib);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	gib_alert_irq.isc = nisc;
+	if (register_adapter_interrupt(&gib_alert_irq)) {
+		KVM_EVENT(3, "gib 0x%pK GAI registration failed", gib);
+		rc = -EIO;
+		goto out_free;
 	}
 
 	gib->nisc = nisc;
 	if (chsc_sgib((u32)(u64)gib)) {
 		KVM_EVENT(3, "gib 0x%pK AIV association failed", gib);
-		free_page((unsigned long)gib);
-		gib = NULL;
-		return -EIO;
+		rc = -EIO;
+		goto out_unreg;
 	}
 
 	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
-	return 0;
+	return rc;
+
+out_unreg:
+	unregister_adapter_interrupt(&gib_alert_irq);
+out_free:
+	free_page((unsigned long)gib);
+	gib = NULL;
+out:
+	return rc;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1a79105b0e9f..1c93ceaeb9e4 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -196,6 +196,11 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 	return kvm->arch.user_cpu_state_ctrl != 0;
 }
 
+static inline bool in_alert_list(struct kvm_s390_gisa *gisa)
+{
+	return (u32)(u64)gisa != gisa->next_alert;
+}
+
 /* implemented in interrupt.c */
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
-- 
2.13.4
