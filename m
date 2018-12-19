From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 08/15] KVM: s390: add the GIB and its related life-cyle functions
Date: Wed, 19 Dec 2018 20:17:49 +0100
Message-ID: <20181219191756.57973-9-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The Guest Information Block (GIB) links the GISA of all guests
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
 arch/s390/include/asm/kvm_host.h | 10 +++++++++
 arch/s390/kvm/interrupt.c        | 44 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  1 +
 arch/s390/kvm/kvm-s390.h         |  2 ++
 4 files changed, 57 insertions(+)

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
index 9b1fa39b6f90..5a54360cecfe 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -7,6 +7,9 @@
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "kvm-s390"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
 #include <linux/hrtimer.h>
@@ -38,6 +41,8 @@
 #define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
 #define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
 
+static struct kvm_s390_gib *gib;
+
 /* handle external calls via sigp interpretation facility */
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
@@ -2913,6 +2918,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 		return;
 	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
 	nullify_gisa(kvm->arch.gisa);
+	kvm->arch.gib_in_use = !!gib;
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 }
 
@@ -2922,3 +2928,41 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
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
+	int rc = 0;
+
+	if (!css_general_characteristics.aiv) {
+		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
+		goto out;
+	}
+
+	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!gib) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	gib->nisc = nisc;
+	if (chsc_sgib((u32)(u64)gib)) {
+		pr_err("Associating the GIB with the AIV facility failed\n");
+		free_page((unsigned long)gib);
+		gib = NULL;
+		rc = -EIO;
+		goto out;
+	}
+
+	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
+out:
+	return rc;
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
