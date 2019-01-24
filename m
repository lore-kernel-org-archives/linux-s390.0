From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v6 12/13] KVM: s390: add gib_alert_irq_handler()
Date: Thu, 24 Jan 2019 13:59:38 +0100
Message-ID: <20190124125939.130763-13-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch implements a handler for GIB alert interruptions
on the host. Its task is to alert guests that interrupts are
pending for them.

A GIB alert interrupt statistic counter is added as well:

$ cat /proc/interrupts
          CPU0       CPU1
  ...
  GAL:      23         37   [I/O] GIB Alert
  ...

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/irq.h      |   1 +
 arch/s390/include/asm/isc.h      |   1 +
 arch/s390/include/asm/kvm_host.h |   3 +
 arch/s390/kernel/irq.c           |   1 +
 arch/s390/kvm/interrupt.c        | 186 +++++++++++++++++++++++++++++++++++++--
 arch/s390/kvm/kvm-s390.c         |   2 +
 6 files changed, 189 insertions(+), 5 deletions(-)

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
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2cfff617cb21..c5f51566ecd6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -825,6 +825,9 @@ struct kvm_s390_gisa_iam {
 struct kvm_s390_gisa_interrupt {
 	struct kvm_s390_gisa *origin;
 	struct kvm_s390_gisa_iam alert;
+	struct hrtimer timer;
+	u64 expires;
+	DECLARE_BITMAP(kicked_mask, KVM_MAX_VCPUS);
 };
 
 struct kvm_arch{
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
index 6bc9dab6d352..3294f77f4fce 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -26,6 +26,7 @@
 #include <asm/gmap.h>
 #include <asm/switch_to.h>
 #include <asm/nmi.h>
+#include <asm/airq.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
@@ -249,6 +250,57 @@ static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
 	return 0;
 }
 
+/**
+ * gisa_clear_ipm - clear the GISA interruption pending mask
+ *
+ * @gisa: gisa to operate on
+ *
+ * Clear the IPM atomically with the next alert address and the IAM
+ * of the GISA unconditionally. All three fields are located in the
+ * first long word of the GISA.
+ */
+static inline void gisa_clear_ipm(struct kvm_s390_gisa *gisa)
+{
+	u64 word, _word;
+
+	do {
+		word = READ_ONCE(gisa->u64.word[0]);
+		_word = word & ~(0xffUL << 24);
+	} while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
+}
+
+/**
+ * gisa_get_ipm_or_restore_iam - return IPM or restore GISA IAM
+ *
+ * @gi: gisa interrupt struct to work on
+ *
+ * Atomically restores the interruption alert mask if none of the
+ * relevant ISCs are pending and return the IPM.
+ *
+ * Returns: the relevant pending ISCs
+ */
+static inline u8 gisa_get_ipm_or_restore_iam(struct kvm_s390_gisa_interrupt *gi)
+{
+	u8 pending_mask, alert_mask;
+	u64 word, _word;
+
+	do {
+		word = READ_ONCE(gi->origin->u64.word[0]);
+		alert_mask = READ_ONCE(gi->alert.mask);
+		pending_mask = (u8)(word >> 24) & alert_mask;
+		if (pending_mask)
+			return pending_mask;
+		_word = (word & ~0xffUL) | alert_mask;
+	} while (cmpxchg(&gi->origin->u64.word[0], word, _word) != word);
+
+	return 0;
+}
+
+static inline int gisa_in_alert_list(struct kvm_s390_gisa *gisa)
+{
+	return READ_ONCE(gisa->next_alert) != (u32)(u64)gisa;
+}
+
 static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
@@ -2920,14 +2972,100 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 	return n;
 }
 
+static void __airqs_kick_single_vcpu(struct kvm *kvm, u8 deliverable_mask)
+{
+	int vcpu_id, online_vcpus = atomic_read(&kvm->online_vcpus);
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+	struct kvm_vcpu *vcpu;
+
+	for_each_set_bit(vcpu_id, kvm->arch.idle_mask, online_vcpus) {
+		vcpu = kvm_get_vcpu(kvm, vcpu_id);
+		if (psw_ioint_disabled(vcpu))
+			continue;
+		deliverable_mask &= (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
+		if (deliverable_mask) {
+			/* lately kicked but not yet running */
+			if (test_and_set_bit(vcpu_id, gi->kicked_mask))
+				return;
+			kvm_s390_vcpu_wakeup(vcpu);
+			return;
+		}
+	}
+}
+
+static enum hrtimer_restart gisa_vcpu_kicker(struct hrtimer *timer)
+{
+	struct kvm_s390_gisa_interrupt *gi =
+		container_of(timer, struct kvm_s390_gisa_interrupt, timer);
+	struct kvm *kvm =
+		container_of(gi->origin, struct sie_page2, gisa)->kvm;
+	u8 pending_mask;
+
+	pending_mask = gisa_get_ipm_or_restore_iam(gi);
+	if (pending_mask) {
+		__airqs_kick_single_vcpu(kvm, pending_mask);
+		hrtimer_forward_now(timer, ns_to_ktime(gi->expires));
+		return HRTIMER_RESTART;
+	};
+
+	return HRTIMER_NORESTART;
+}
+
+#define NULL_GISA_ADDR 0x00000000UL
+#define NONE_GISA_ADDR 0x00000001UL
+#define GISA_ADDR_MASK 0xfffff000UL
+
+static void process_gib_alert_list(void)
+{
+	struct kvm_s390_gisa_interrupt *gi;
+	struct kvm_s390_gisa *gisa;
+	struct kvm *kvm;
+	u32 final, origin = 0UL;
+
+	do {
+		/*
+		 * If the NONE_GISA_ADDR is still stored in the alert list
+		 * origin, we will leave the outer loop. No further GISA has
+		 * been added to the alert list by millicode while processing
+		 * the current alert list.
+		 */
+		final = (origin & NONE_GISA_ADDR);
+		/*
+		 * Cut off the alert list and store the NONE_GISA_ADDR in the
+		 * alert list origin to avoid further GAL interruptions.
+		 * A new alert list can be build up by millicode in parallel
+		 * for guests not in the yet cut-off alert list. When in the
+		 * final loop, store the NULL_GISA_ADDR instead. This will re-
+		 * enable GAL interruptions on the host again.
+		 */
+		origin = xchg(&gib->alert_list_origin,
+			      (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
+		/*
+		 * Loop through the just cut-off alert list and start the
+		 * gisa timers to kick idle vcpus to consume the pending
+		 * interruptions asap.
+		 */
+		while (origin & GISA_ADDR_MASK) {
+			gisa = (struct kvm_s390_gisa *)(u64)origin;
+			origin = gisa->next_alert;
+			gisa->next_alert = (u32)(u64)gisa;
+			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
+			gi = &kvm->arch.gisa_int;
+			if (hrtimer_active(&gi->timer))
+				hrtimer_cancel(&gi->timer);
+			hrtimer_start(&gi->timer, 0, HRTIMER_MODE_REL);
+		}
+	} while (!final);
+
+}
+
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
 	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 
 	if (!gi->origin)
 		return;
-	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
-	gi->origin->next_alert = (u32)(u64)gi->origin;
+	gisa_clear_ipm(gi->origin);
 	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
 }
 
@@ -2940,13 +3078,25 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	gi->origin = &kvm->arch.sie_page2->gisa;
 	gi->alert.mask = 0;
 	spin_lock_init(&gi->alert.ref_lock);
-	kvm_s390_gisa_clear(kvm);
+	gi->expires = 50 * 1000; /* 50 usec */
+	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gi->timer.function = gisa_vcpu_kicker;
+	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
+	gi->origin->next_alert = (u32)(u64)gi->origin;
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
 {
-	kvm->arch.gisa_int.origin = NULL;
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
+	if (!gi->origin)
+		return;
+	hrtimer_cancel(&gi->timer);
+	WRITE_ONCE(gi->alert.mask, 0);
+	while (gisa_in_alert_list(gi->origin))
+		cpu_relax();
+	gi->origin = NULL;
 }
 
 /**
@@ -3037,11 +3187,23 @@ int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
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
@@ -3061,16 +3223,30 @@ int kvm_s390_gib_init(u8 nisc)
 		goto out;
 	}
 
+	gib_alert_irq.isc = nisc;
+	if (register_adapter_interrupt(&gib_alert_irq)) {
+		pr_err("Registering the GIB alert interruption handler failed\n");
+		rc = -EIO;
+		goto out_free_gib;
+	}
+
 	gib->nisc = nisc;
 	if (chsc_sgib((u32)(u64)gib)) {
 		pr_err("Associating the GIB with the AIV facility failed\n");
 		free_page((unsigned long)gib);
 		gib = NULL;
 		rc = -EIO;
-		goto out;
+		goto out_unreg_gal;
 	}
 
 	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
+	goto out;
+
+out_unreg_gal:
+	unregister_adapter_interrupt(&gib_alert_irq);
+out_free_gib:
+	free_page((unsigned long)gib);
+	gib = NULL;
 out:
 	return rc;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 67023d5656fd..0e6ba4d17207 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3460,6 +3460,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 		kvm_s390_patch_guest_per_regs(vcpu);
 	}
 
+	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.gisa_int.kicked_mask);
+
 	vcpu->arch.sie_block->icptcode = 0;
 	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
 	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
-- 
2.13.4
