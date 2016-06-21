From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 28/51] KVM: s390: vsie: initial support for nested virtualization
Date: Tue, 21 Jun 2016 15:13:06 +0200
Message-ID: <1466514809-146638-29-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch adds basic support for nested virtualization on s390x, called
VSIE (virtual SIE) and allows it to be used by the guest if the necessary
facilities are supported by the hardware and enabled for the guest.

In order to make this work, we have to shadow the sie control block
provided by guest 2. In order to gain some performance, we have to
reuse the same shadow blocks as good as possible. For now, we allow
as many shadow blocks as we have VCPUs (that way, every VCPU can run the
VSIE concurrently).

We have to watch out for the prefix getting unmapped out of our shadow
gmap and properly get the VCPU out of VSIE in that case, to fault the
prefix pages back in. We use the PROG_REQUEST bit for that purpose.

This patch is based on an initial prototype by Tobias Elpelt.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  15 +-
 arch/s390/include/uapi/asm/kvm.h |   1 +
 arch/s390/kvm/Makefile           |   2 +-
 arch/s390/kvm/kvm-s390.c         |  15 +
 arch/s390/kvm/kvm-s390.h         |   7 +
 arch/s390/kvm/priv.c             |   1 +
 arch/s390/kvm/vsie.c             | 755 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 794 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/kvm/vsie.c

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 96bef30..255609c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -145,7 +145,7 @@ struct kvm_s390_sie_block {
 	__u64	cputm;			/* 0x0028 */
 	__u64	ckc;			/* 0x0030 */
 	__u64	epoch;			/* 0x0038 */
-	__u8	reserved40[4];		/* 0x0040 */
+	__u32	svcc;			/* 0x0040 */
 #define LCTL_CR0	0x8000
 #define LCTL_CR6	0x0200
 #define LCTL_CR9	0x0040
@@ -167,6 +167,9 @@ struct kvm_s390_sie_block {
 #define ICPT_INST	0x04
 #define ICPT_PROGI	0x08
 #define ICPT_INSTPROGI	0x0C
+#define ICPT_EXTINT	0x14
+#define ICPT_VALIDITY	0x20
+#define ICPT_STOP	0x28
 #define ICPT_OPEREXC	0x2C
 #define ICPT_PARTEXEC	0x38
 #define ICPT_IOINST	0x40
@@ -281,6 +284,7 @@ struct kvm_vcpu_stat {
 	u32 instruction_stsi;
 	u32 instruction_stfl;
 	u32 instruction_tprot;
+	u32 instruction_sie;
 	u32 instruction_essa;
 	u32 instruction_sthyi;
 	u32 instruction_sigp_sense;
@@ -637,6 +641,14 @@ struct sie_page2 {
 	u8 reserved900[0x1000 - 0x900];			/* 0x0900 */
 } __packed;
 
+struct kvm_s390_vsie {
+	struct mutex mutex;
+	struct radix_tree_root addr_to_page;
+	int page_count;
+	int next;
+	struct page *pages[KVM_MAX_VCPUS];
+};
+
 struct kvm_arch{
 	void *sca;
 	int use_esca;
@@ -661,6 +673,7 @@ struct kvm_arch{
 	struct sie_page2 *sie_page2;
 	struct kvm_s390_cpu_model model;
 	struct kvm_s390_crypto crypto;
+	struct kvm_s390_vsie vsie;
 	u64 epoch;
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index f0818d7..62423b1 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -98,6 +98,7 @@ struct kvm_s390_vm_cpu_machine {
 
 #define KVM_S390_VM_CPU_FEAT_NR_BITS	1024
 #define KVM_S390_VM_CPU_FEAT_ESOP	0
+#define KVM_S390_VM_CPU_FEAT_SIEF2	1
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 82e73e2..09a9e6d 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -12,6 +12,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-objs += diag.o gaccess.o guestdbg.o sthyi.o
+kvm-objs += diag.o gaccess.o guestdbg.o sthyi.o vsie.o
 
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a890f7d..3fb1242 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -99,6 +99,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_stfl", VCPU_STAT(instruction_stfl) },
 	{ "instruction_tprot", VCPU_STAT(instruction_tprot) },
 	{ "instruction_sthyi", VCPU_STAT(instruction_sthyi) },
+	{ "instruction_sie", VCPU_STAT(instruction_sie) },
 	{ "instruction_sigp_sense", VCPU_STAT(instruction_sigp_sense) },
 	{ "instruction_sigp_sense_running", VCPU_STAT(instruction_sigp_sense_running) },
 	{ "instruction_sigp_external_call", VCPU_STAT(instruction_sigp_external_call) },
@@ -142,6 +143,7 @@ static DECLARE_BITMAP(kvm_s390_available_cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS)
 static struct kvm_s390_vm_cpu_subfunc kvm_s390_available_subfunc;
 
 static struct gmap_notifier gmap_notifier;
+static struct gmap_notifier vsie_gmap_notifier;
 debug_info_t *kvm_s390_dbf;
 
 /* Section: not file related */
@@ -187,6 +189,8 @@ int kvm_arch_hardware_setup(void)
 {
 	gmap_notifier.notifier_call = kvm_gmap_notifier;
 	gmap_register_pte_notifier(&gmap_notifier);
+	vsie_gmap_notifier.notifier_call = kvm_s390_vsie_gmap_notifier;
+	gmap_register_pte_notifier(&vsie_gmap_notifier);
 	atomic_notifier_chain_register(&s390_epoch_delta_notifier,
 				       &kvm_clock_notifier);
 	return 0;
@@ -195,6 +199,7 @@ int kvm_arch_hardware_setup(void)
 void kvm_arch_hardware_unsetup(void)
 {
 	gmap_unregister_pte_notifier(&gmap_notifier);
+	gmap_unregister_pte_notifier(&vsie_gmap_notifier);
 	atomic_notifier_chain_unregister(&s390_epoch_delta_notifier,
 					 &kvm_clock_notifier);
 }
@@ -252,6 +257,14 @@ static void kvm_s390_cpu_feat_init(void)
 
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+	/*
+	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
+	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
+	 */
+	if (!sclp.has_sief2 || !MACHINE_HAS_ESOP || !sclp.has_64bscao ||
+	    !test_facility(3))
+		return;
+	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIEF2);
 }
 
 int kvm_arch_init(void *opaque)
@@ -1406,6 +1419,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.epoch = 0;
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
+	kvm_s390_vsie_init(kvm);
 	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
 
 	return 0;
@@ -1463,6 +1477,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		gmap_remove(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
 	kvm_s390_clear_float_irqs(kvm);
+	kvm_s390_vsie_destroy(kvm);
 	KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 52aa47e..b137fba 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -252,6 +252,13 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
 
+/* implemented in vsie.c */
+int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu);
+void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
+				 unsigned long end);
+void kvm_s390_vsie_init(struct kvm *kvm);
+void kvm_s390_vsie_destroy(struct kvm *kvm);
+
 /* implemented in sigp.c */
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 3db3be1..c77ad2d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -719,6 +719,7 @@ static const intercept_handler_t b2_handlers[256] = {
 	[0x10] = handle_set_prefix,
 	[0x11] = handle_store_prefix,
 	[0x12] = handle_store_cpu_address,
+	[0x14] = kvm_s390_handle_vsie,
 	[0x21] = handle_ipte_interlock,
 	[0x29] = handle_iske,
 	[0x2a] = handle_rrbe,
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
new file mode 100644
index 0000000..747d4f9
--- /dev/null
+++ b/arch/s390/kvm/vsie.c
@@ -0,0 +1,755 @@
+/*
+ * kvm nested virtualization support for s390x
+ *
+ * Copyright IBM Corp. 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
+ */
+#include <linux/vmalloc.h>
+#include <linux/kvm_host.h>
+#include <linux/bug.h>
+#include <linux/list.h>
+#include <linux/bitmap.h>
+#include <asm/gmap.h>
+#include <asm/mmu_context.h>
+#include <asm/sclp.h>
+#include <asm/nmi.h>
+#include "kvm-s390.h"
+#include "gaccess.h"
+
+struct vsie_page {
+	struct kvm_s390_sie_block scb_s;	/* 0x0000 */
+	/* the pinned originial scb */
+	struct kvm_s390_sie_block *scb_o;	/* 0x0200 */
+	/* the shadow gmap in use by the vsie_page */
+	struct gmap *gmap;			/* 0x0208 */
+	__u8 reserved[0x1000 - 0x0210];		/* 0x0210 */
+} __packed;
+
+/* trigger a validity icpt for the given scb */
+static int set_validity_icpt(struct kvm_s390_sie_block *scb,
+			     __u16 reason_code)
+{
+	scb->ipa = 0x1000;
+	scb->ipb = ((__u32) reason_code) << 16;
+	scb->icptcode = ICPT_VALIDITY;
+	return 1;
+}
+
+/* mark the prefix as unmapped, this will block the VSIE */
+static void prefix_unmapped(struct vsie_page *vsie_page)
+{
+	atomic_or(PROG_REQUEST, &vsie_page->scb_s.prog20);
+}
+
+/* mark the prefix as unmapped and wait until the VSIE has been left */
+static void prefix_unmapped_sync(struct vsie_page *vsie_page)
+{
+	prefix_unmapped(vsie_page);
+	if (vsie_page->scb_s.prog0c & PROG_IN_SIE)
+		atomic_or(CPUSTAT_STOP_INT, &vsie_page->scb_s.cpuflags);
+	while (vsie_page->scb_s.prog0c & PROG_IN_SIE)
+		cpu_relax();
+}
+
+/* mark the prefix as mapped, this will allow the VSIE to run */
+static void prefix_mapped(struct vsie_page *vsie_page)
+{
+	atomic_andnot(PROG_REQUEST, &vsie_page->scb_s.prog20);
+}
+
+
+/* copy the updated intervention request bits into the shadow scb */
+static void update_intervention_requests(struct vsie_page *vsie_page)
+{
+	const int bits = CPUSTAT_STOP_INT | CPUSTAT_IO_INT | CPUSTAT_EXT_INT;
+	int cpuflags;
+
+	cpuflags = atomic_read(&vsie_page->scb_o->cpuflags);
+	atomic_andnot(bits, &vsie_page->scb_s.cpuflags);
+	atomic_or(cpuflags & bits, &vsie_page->scb_s.cpuflags);
+}
+
+/* shadow (filter and validate) the cpuflags  */
+static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	int newflags, cpuflags = atomic_read(&scb_o->cpuflags);
+
+	/* we don't allow ESA/390 guests */
+	if (!(cpuflags & CPUSTAT_ZARCH))
+		return set_validity_icpt(scb_s, 0x0001U);
+
+	if (cpuflags & (CPUSTAT_RRF | CPUSTAT_MCDS))
+		return set_validity_icpt(scb_s, 0x0001U);
+	else if (cpuflags & (CPUSTAT_SLSV | CPUSTAT_SLSR))
+		return set_validity_icpt(scb_s, 0x0007U);
+
+	/* intervention requests will be set later */
+	newflags = CPUSTAT_ZARCH;
+
+	atomic_set(&scb_s->cpuflags, newflags);
+	return 0;
+}
+
+/* unshadow the scb, copying parameters back to the real scb */
+static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+
+	/* interception */
+	scb_o->icptcode = scb_s->icptcode;
+	scb_o->icptstatus = scb_s->icptstatus;
+	scb_o->ipa = scb_s->ipa;
+	scb_o->ipb = scb_s->ipb;
+	scb_o->gbea = scb_s->gbea;
+
+	/* timer */
+	scb_o->cputm = scb_s->cputm;
+	scb_o->ckc = scb_s->ckc;
+	scb_o->todpr = scb_s->todpr;
+
+	/* guest state */
+	scb_o->gpsw = scb_s->gpsw;
+	scb_o->gg14 = scb_s->gg14;
+	scb_o->gg15 = scb_s->gg15;
+	memcpy(scb_o->gcr, scb_s->gcr, 128);
+	scb_o->pp = scb_s->pp;
+
+	/* interrupt intercept */
+	switch (scb_s->icptcode) {
+	case ICPT_PROGI:
+	case ICPT_INSTPROGI:
+	case ICPT_EXTINT:
+		memcpy((void *)((u64)scb_o + 0xc0),
+		       (void *)((u64)scb_s + 0xc0), 0xf0 - 0xc0);
+		break;
+	case ICPT_PARTEXEC:
+		/* MVPG only */
+		memcpy((void *)((u64)scb_o + 0xc0),
+		       (void *)((u64)scb_s + 0xc0), 0xd0 - 0xc0);
+		break;
+	}
+
+	if (scb_s->ihcpu != 0xffffU)
+		scb_o->ihcpu = scb_s->ihcpu;
+}
+
+/*
+ * Setup the shadow scb by copying and checking the relevant parts of the g2
+ * provided scb.
+ *
+ * Returns: - 0 if the scb has been shadowed
+ *          - > 0 if control has to be given to guest 2
+ */
+static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	int rc;
+
+	/* make sure we don't have any leftovers when reusing the scb */
+	scb_s->icptcode = 0;
+	scb_s->eca = 0;
+	scb_s->ecb = 0;
+	scb_s->ecb2 = 0;
+	scb_s->ecb3 = 0;
+	scb_s->ecd = 0;
+
+	rc = prepare_cpuflags(vcpu, vsie_page);
+	if (rc)
+		goto out;
+
+	/* timer */
+	scb_s->cputm = scb_o->cputm;
+	scb_s->ckc = scb_o->ckc;
+	scb_s->todpr = scb_o->todpr;
+	scb_s->epoch = scb_o->epoch;
+
+	/* guest state */
+	scb_s->gpsw = scb_o->gpsw;
+	scb_s->gg14 = scb_o->gg14;
+	scb_s->gg15 = scb_o->gg15;
+	memcpy(scb_s->gcr, scb_o->gcr, 128);
+	scb_s->pp = scb_o->pp;
+
+	/* interception / execution handling */
+	scb_s->gbea = scb_o->gbea;
+	scb_s->lctl = scb_o->lctl;
+	scb_s->svcc = scb_o->svcc;
+	scb_s->ictl = scb_o->ictl;
+	/*
+	 * SKEY handling functions can't deal with false setting of PTE invalid
+	 * bits. Therefore we cannot provide interpretation and would later
+	 * have to provide own emulation handlers.
+	 */
+	scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+	scb_s->icpua = scb_o->icpua;
+
+	 /* SIE will do mso/msl validity and exception checks for us */
+	scb_s->msl = scb_o->msl & 0xfffffffffff00000UL;
+	scb_s->mso = scb_o->mso & 0xfffffffffff00000UL;
+	scb_s->prefix = scb_o->prefix;
+
+	/* We have to definetly flush the tlb if this scb never ran */
+	if (scb_s->ihcpu != 0xffffU)
+		scb_s->ihcpu = scb_o->ihcpu;
+
+	/* MVPG and Protection Exception Interpretation are always available */
+	scb_s->eca |= scb_o->eca & 0x01002000U;
+
+out:
+	if (rc)
+		unshadow_scb(vcpu, vsie_page);
+	return rc;
+}
+
+void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
+				 unsigned long end)
+{
+	struct kvm *kvm = gmap->private;
+	struct vsie_page *cur;
+	unsigned long prefix;
+	struct page *page;
+	int i;
+
+	if (!gmap_is_shadow(gmap))
+		return;
+	if (start >= 1UL << 31)
+		/* We are only interested in prefix pages */
+		return;
+
+	/*
+	 * Only new shadow blocks are added to the list during runtime,
+	 * therefore we can safely reference them all the time.
+	 */
+	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
+		page = READ_ONCE(kvm->arch.vsie.pages[i]);
+		if (!page)
+			continue;
+		cur = page_to_virt(page);
+		if (READ_ONCE(cur->gmap) != gmap)
+			continue;
+		prefix = cur->scb_s.prefix << GUEST_PREFIX_SHIFT;
+		/* with mso/msl, the prefix lies at an offset */
+		prefix += cur->scb_s.mso;
+		if (prefix <= end && start <= prefix + PAGE_SIZE - 1)
+			prefix_unmapped_sync(cur);
+	}
+}
+
+/*
+ * Map the first prefix page.
+ *
+ * The prefix will be protected, a gmap notifier will inform about unmaps.
+ * The shadow scb must not be executed until the prefix is remapped, this is
+ * guaranteed by properly handling PROG_REQUEST.
+ *
+ * Returns: - 0 on if successfully mapped or already mapped
+ *          - > 0 if control has to be given to guest 2
+ *          - -EAGAIN if the caller can retry immediately
+ *          - -ENOMEM if out of memory
+ */
+static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	u64 prefix = scb_s->prefix << GUEST_PREFIX_SHIFT;
+	int rc;
+
+	/* mark it as mapped so we can catch any concurrent unmappers */
+	prefix_mapped(vsie_page);
+
+	/* with mso/msl, the prefix lies at offset *mso* */
+	prefix += scb_s->mso;
+
+	rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, prefix);
+	/*
+	 * We don't have to mprotect, we will be called for all unshadows.
+	 * SIE will detect if protection applies and trigger a validity.
+	 */
+	if (rc)
+		prefix_unmapped(vsie_page);
+	if (rc > 0 || rc == -EFAULT)
+		rc = set_validity_icpt(scb_s, 0x0037U);
+	return rc;
+}
+
+/*
+ * Pin the guest page given by gpa and set hpa to the pinned host address.
+ * Will always be pinned writable.
+ *
+ * Returns: - 0 on success
+ *          - -EINVAL if the gpa is not valid guest storage
+ *          - -ENOMEM if out of memory
+ */
+static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
+{
+	struct page *page;
+	hva_t hva;
+	int rc;
+
+	hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
+	if (kvm_is_error_hva(hva))
+		return -EINVAL;
+	rc = get_user_pages_fast(hva, 1, 1, &page);
+	if (rc < 0)
+		return rc;
+	else if (rc != 1)
+		return -ENOMEM;
+	*hpa = (hpa_t) page_to_virt(page) + (gpa & ~PAGE_MASK);
+	return 0;
+}
+
+/* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
+static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
+{
+	struct page *page;
+
+	page = virt_to_page(hpa);
+	set_page_dirty_lock(page);
+	put_page(page);
+	/* mark the page always as dirty for migration */
+	mark_page_dirty(kvm, gpa_to_gfn(gpa));
+}
+
+/* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
+static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	hpa_t hpa;
+	gpa_t gpa;
+
+	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
+	if (hpa) {
+		gpa = scb_o->scaol & ~0xfUL;
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		scb_s->scaol = 0;
+		scb_s->scaoh = 0;
+	}
+}
+
+/*
+ * Instead of shadowing some blocks, we can simply forward them because the
+ * addresses in the scb are 64 bit long.
+ *
+ * This works as long as the data lies in one page. If blocks ever exceed one
+ * page, we have to fall back to shadowing.
+ *
+ * As we reuse the sca, the vcpu pointers contained in it are invalid. We must
+ * therefore not enable any facilities that access these pointers (e.g. SIGPIF).
+ *
+ * Returns: - 0 if all blocks were pinned.
+ *          - > 0 if control has to be given to guest 2
+ *          - -ENOMEM if out of memory
+ */
+static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	hpa_t hpa;
+	gpa_t gpa;
+	int rc = 0;
+
+	gpa = scb_o->scaol & ~0xfUL;
+	if (gpa) {
+		if (!(gpa & ~0x1fffUL))
+			rc = set_validity_icpt(scb_s, 0x0038U);
+		else if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
+			rc = set_validity_icpt(scb_s, 0x0011U);
+		else if ((gpa & PAGE_MASK) !=
+			 ((gpa + sizeof(struct bsca_block) - 1) & PAGE_MASK))
+			rc = set_validity_icpt(scb_s, 0x003bU);
+		if (!rc) {
+			rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+			if (rc == -EINVAL)
+				rc = set_validity_icpt(scb_s, 0x0034U);
+		}
+		if (rc)
+			goto unpin;
+		scb_s->scaoh = (u32)((u64)hpa >> 32);
+		scb_s->scaol = (u32)(u64)hpa;
+	}
+	return 0;
+unpin:
+	unpin_blocks(vcpu, vsie_page);
+	return rc;
+}
+
+/* unpin the scb provided by guest 2, marking it as dirty */
+static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		      gpa_t gpa)
+{
+	hpa_t hpa = (hpa_t) vsie_page->scb_o;
+
+	if (hpa)
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+	vsie_page->scb_o = NULL;
+}
+
+/*
+ * Pin the scb at gpa provided by guest 2 at vsie_page->scb_o.
+ *
+ * Returns: - 0 if the scb was pinned.
+ *          - > 0 if control has to be given to guest 2
+ *          - -ENOMEM if out of memory
+ */
+static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		   gpa_t gpa)
+{
+	hpa_t hpa;
+	int rc;
+
+	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+	if (rc == -EINVAL) {
+		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		if (!rc)
+			rc = 1;
+	}
+	if (!rc)
+		vsie_page->scb_o = (struct kvm_s390_sie_block *) hpa;
+	return rc;
+}
+
+/*
+ * Inject a fault into guest 2.
+ *
+ * Returns: - > 0 if control has to be given to guest 2
+ *            < 0 if an error occurred during injection.
+ */
+static int inject_fault(struct kvm_vcpu *vcpu, __u16 code, __u64 vaddr,
+			bool write_flag)
+{
+	struct kvm_s390_pgm_info pgm = {
+		.code = code,
+		.trans_exc_code =
+			/* 0-51: virtual address */
+			(vaddr & 0xfffffffffffff000UL) |
+			/* 52-53: store / fetch */
+			(((unsigned int) !write_flag) + 1) << 10,
+			/* 62-63: asce id (alway primary == 0) */
+		.exc_access_id = 0, /* always primary */
+		.op_access_id = 0, /* not MVPG */
+	};
+	int rc;
+
+	if (code == PGM_PROTECTION)
+		pgm.trans_exc_code |= 0x4UL;
+
+	rc = kvm_s390_inject_prog_irq(vcpu, &pgm);
+	return rc ? rc : 1;
+}
+
+/*
+ * Handle a fault during vsie execution on a gmap shadow.
+ *
+ * Returns: - 0 if the fault was resolved
+ *          - > 0 if control has to be given to guest 2
+ *          - < 0 if an error occurred
+ */
+static int handle_fault(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	int rc;
+
+	if (current->thread.gmap_int_code == PGM_PROTECTION)
+		/* we can directly forward all protection exceptions */
+		return inject_fault(vcpu, PGM_PROTECTION,
+				    current->thread.gmap_addr, 1);
+
+	rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap,
+				   current->thread.gmap_addr);
+	if (rc > 0) {
+		rc = inject_fault(vcpu, rc,
+				  current->thread.gmap_addr,
+				  current->thread.gmap_write_flag);
+	}
+	return rc;
+}
+
+static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
+{
+	vsie_page->scb_s.icptcode = 0;
+}
+
+/*
+ * Run the vsie on a shadow scb and a shadow gmap, without any further
+ * sanity checks, handling SIE faults.
+ *
+ * Returns: - 0 everything went fine
+ *          - > 0 if control has to be given to guest 2
+ *          - < 0 if an error occurred
+ */
+static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	int rc;
+
+	if (need_resched())
+		schedule();
+	if (test_cpu_flag(CIF_MCCK_PENDING))
+		s390_handle_mcck();
+
+	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
+	local_irq_disable();
+	kvm_guest_enter();
+	local_irq_enable();
+
+	rc = sie64a(scb_s, vcpu->run->s.regs.gprs);
+
+	local_irq_disable();
+	kvm_guest_exit();
+	local_irq_enable();
+	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	if (rc > 0)
+		rc = 0; /* we could still have an icpt */
+	else if (rc == -EFAULT)
+		return handle_fault(vcpu, vsie_page);
+
+	switch (scb_s->icptcode) {
+	case ICPT_STOP:
+		/* stop not requested by g2 - must have been a kick */
+		if (!(atomic_read(&scb_o->cpuflags) & CPUSTAT_STOP_INT))
+			clear_vsie_icpt(vsie_page);
+		break;
+	case ICPT_VALIDITY:
+		if ((scb_s->ipa & 0xf000) != 0xf000)
+			scb_s->ipa += 0x1000;
+		break;
+	}
+	return rc;
+}
+
+static void release_gmap_shadow(struct vsie_page *vsie_page)
+{
+	if (vsie_page->gmap)
+		gmap_put(vsie_page->gmap);
+	WRITE_ONCE(vsie_page->gmap, NULL);
+}
+
+static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
+			       struct vsie_page *vsie_page)
+{
+	unsigned long asce;
+	union ctlreg0 cr0;
+	struct gmap *gmap;
+	int edat;
+
+	asce = vcpu->arch.sie_block->gcr[1];
+	cr0.val = vcpu->arch.sie_block->gcr[0];
+	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
+	edat += edat && test_kvm_facility(vcpu->kvm, 78);
+
+	gmap = gmap_shadow(vcpu->arch.gmap, asce, edat);
+	if (IS_ERR(gmap))
+		return PTR_ERR(gmap);
+	gmap->private = vcpu->kvm;
+	WRITE_ONCE(vsie_page->gmap, gmap);
+	return 0;
+}
+
+/*
+ * Run the vsie on a shadowed scb, managing the gmap shadow, handling
+ * prefix pages and faults.
+ *
+ * Returns: - 0 if no errors occurred
+ *          - > 0 if control has to be given to guest 2
+ *          - -ENOMEM if out of memory
+ */
+static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	int rc = 0;
+
+	while (1) {
+		rc = acquire_gmap_shadow(vcpu, vsie_page);
+		if (!rc)
+			rc = map_prefix(vcpu, vsie_page);
+		if (!rc) {
+			gmap_enable(vsie_page->gmap);
+			update_intervention_requests(vsie_page);
+			rc = do_vsie_run(vcpu, vsie_page);
+			gmap_enable(vcpu->arch.gmap);
+		}
+		release_gmap_shadow(vsie_page);
+
+		if (rc == -EAGAIN)
+			rc = 0;
+		if (rc || scb_s->icptcode || signal_pending(current) ||
+		    kvm_s390_vcpu_has_irq(vcpu, 0))
+			break;
+	};
+
+	if (rc == -EFAULT) {
+		/*
+		 * Addressing exceptions are always presentes as intercepts.
+		 * As addressing exceptions are suppressing and our guest 3 PSW
+		 * points at the responsible instruction, we have to
+		 * forward the PSW and set the ilc. If we can't read guest 3
+		 * instruction, we can use an arbitrary ilc. Let's always use
+		 * ilen = 4 for now, so we can avoid reading in guest 3 virtual
+		 * memory. (we could also fake the shadow so the hardware
+		 * handles it).
+		 */
+		scb_s->icptcode = ICPT_PROGI;
+		scb_s->iprcc = PGM_ADDRESSING;
+		scb_s->pgmilc = 4;
+		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
+	}
+	return rc;
+}
+
+/*
+ * Get or create a vsie page for a scb address.
+ *
+ * Returns: - address of a vsie page (cached or new one)
+ *          - NULL if the same scb address is already used by another VCPU
+ *          - ERR_PTR(-ENOMEM) if out of memory
+ */
+static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
+{
+	struct vsie_page *vsie_page;
+	struct page *page;
+	int nr_vcpus;
+
+	rcu_read_lock();
+	page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
+	rcu_read_unlock();
+	if (page) {
+		if (page_ref_inc_return(page) == 2)
+			return page_to_virt(page);
+		page_ref_dec(page);
+	}
+
+	/*
+	 * We want at least #online_vcpus shadows, so every VCPU can execute
+	 * the VSIE in parallel.
+	 */
+	nr_vcpus = atomic_read(&kvm->online_vcpus);
+
+	mutex_lock(&kvm->arch.vsie.mutex);
+	if (kvm->arch.vsie.page_count < nr_vcpus) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page) {
+			mutex_unlock(&kvm->arch.vsie.mutex);
+			return ERR_PTR(-ENOMEM);
+		}
+		page_ref_inc(page);
+		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = page;
+		kvm->arch.vsie.page_count++;
+	} else {
+		/* reuse an existing entry that belongs to nobody */
+		while (true) {
+			page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
+			if (page_ref_inc_return(page) == 2)
+				break;
+			page_ref_dec(page);
+			kvm->arch.vsie.next++;
+			kvm->arch.vsie.next %= nr_vcpus;
+		}
+		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+	}
+	page->index = addr;
+	/* double use of the same address */
+	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
+		page_ref_dec(page);
+		mutex_unlock(&kvm->arch.vsie.mutex);
+		return NULL;
+	}
+	mutex_unlock(&kvm->arch.vsie.mutex);
+
+	vsie_page = page_to_virt(page);
+	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
+	vsie_page->scb_s.ihcpu = 0xffffU;
+	return vsie_page;
+}
+
+/* put a vsie page acquired via get_vsie_page */
+static void put_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	struct page *page = pfn_to_page(__pa(vsie_page) >> PAGE_SHIFT);
+
+	page_ref_dec(page);
+}
+
+int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
+{
+	struct vsie_page *vsie_page;
+	unsigned long scb_addr;
+	int rc;
+
+	vcpu->stat.instruction_sie++;
+	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIEF2))
+		return -EOPNOTSUPP;
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	BUILD_BUG_ON(sizeof(struct vsie_page) != 4096);
+	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
+
+	/* 512 byte alignment */
+	if (unlikely(scb_addr & 0x1ffUL))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0))
+		return 0;
+
+	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
+	if (IS_ERR(vsie_page))
+		return PTR_ERR(vsie_page);
+	else if (!vsie_page)
+		/* double use of sie control block - simply do nothing */
+		return 0;
+
+	rc = pin_scb(vcpu, vsie_page, scb_addr);
+	if (rc)
+		goto out_put;
+	rc = shadow_scb(vcpu, vsie_page);
+	if (rc)
+		goto out_unpin_scb;
+	rc = pin_blocks(vcpu, vsie_page);
+	if (rc)
+		goto out_unshadow;
+	rc = vsie_run(vcpu, vsie_page);
+	unpin_blocks(vcpu, vsie_page);
+out_unshadow:
+	unshadow_scb(vcpu, vsie_page);
+out_unpin_scb:
+	unpin_scb(vcpu, vsie_page, scb_addr);
+out_put:
+	put_vsie_page(vcpu->kvm, vsie_page);
+
+	return rc < 0 ? rc : 0;
+}
+
+/* Init the vsie data structures. To be called when a vm is initialized. */
+void kvm_s390_vsie_init(struct kvm *kvm)
+{
+	mutex_init(&kvm->arch.vsie.mutex);
+	INIT_RADIX_TREE(&kvm->arch.vsie.addr_to_page, GFP_KERNEL);
+}
+
+/* Destroy the vsie data structures. To be called when a vm is destroyed. */
+void kvm_s390_vsie_destroy(struct kvm *kvm)
+{
+	struct page *page;
+	int i;
+
+	mutex_lock(&kvm->arch.vsie.mutex);
+	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
+		page = kvm->arch.vsie.pages[i];
+		kvm->arch.vsie.pages[i] = NULL;
+		/* free the radix tree entry */
+		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		__free_page(page);
+	}
+	kvm->arch.vsie.page_count = 0;
+	mutex_unlock(&kvm->arch.vsie.mutex);
+}
-- 
2.5.5
