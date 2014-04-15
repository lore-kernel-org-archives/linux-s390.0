From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 41/47] KVM: s390: hardware support for guest debugging
Date: Tue, 15 Apr 2014 14:00:44 +0200
Message-ID: <1397563250-3089-42-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch adds support to debug the guest using the PER facility on s390.
Single-stepping, hardware breakpoints and hardware watchpoints are supported. In
order to use the PER facility of the guest without it noticing it, the control
registers of the guest have to be patched and access to them has to be
intercepted(stctl, stctg, lctl, lctlg).

All PER program interrupts have to be intercepted and only the relevant PER
interrupts for the guest have to be given back. Special care has to be taken
about repeated exits on the same hardware breakpoint. The intervention of the
host in the guests PER configuration is not fully transparent. PER instruction
nullification can not be used by the guest and too many storage alteration
events may be reported to the guest (if it is activated for special address
ranges only) when the host concurrently debugging it.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  53 ++++-
 arch/s390/include/uapi/asm/kvm.h |   1 +
 arch/s390/kvm/Makefile           |   2 +-
 arch/s390/kvm/guestdbg.c         | 479 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/intercept.c        |   9 +
 arch/s390/kvm/interrupt.c        |   8 +-
 arch/s390/kvm/kvm-s390.c         |  53 ++++-
 arch/s390/kvm/kvm-s390.h         |  10 +
 8 files changed, 607 insertions(+), 8 deletions(-)
 create mode 100644 arch/s390/kvm/guestdbg.c

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 5d96489..0d45f6f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -93,13 +93,18 @@ struct kvm_s390_sie_block {
 	__u8	reserved40[4];		/* 0x0040 */
 #define LCTL_CR0	0x8000
 #define LCTL_CR6	0x0200
+#define LCTL_CR9	0x0040
+#define LCTL_CR10	0x0020
+#define LCTL_CR11	0x0010
 #define LCTL_CR14	0x0002
 	__u16   lctl;			/* 0x0044 */
 	__s16	icpua;			/* 0x0046 */
-#define ICTL_LPSW 0x00400000
-#define ICTL_ISKE 0x00004000
-#define ICTL_SSKE 0x00002000
-#define ICTL_RRBE 0x00001000
+#define ICTL_PINT	0x20000000
+#define ICTL_LPSW	0x00400000
+#define ICTL_STCTL	0x00040000
+#define ICTL_ISKE	0x00004000
+#define ICTL_SSKE	0x00002000
+#define ICTL_RRBE	0x00001000
 	__u32	ictl;			/* 0x0048 */
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
@@ -306,6 +311,45 @@ struct kvm_s390_float_interrupt {
 	unsigned int irq_count;
 };
 
+struct kvm_hw_wp_info_arch {
+	unsigned long addr;
+	unsigned long phys_addr;
+	int len;
+	char *old_data;
+};
+
+struct kvm_hw_bp_info_arch {
+	unsigned long addr;
+	int len;
+};
+
+/*
+ * Only the upper 16 bits of kvm_guest_debug->control are arch specific.
+ * Further KVM_GUESTDBG flags which an be used from userspace can be found in
+ * arch/s390/include/uapi/asm/kvm.h
+ */
+#define KVM_GUESTDBG_EXIT_PENDING 0x10000000
+
+#define guestdbg_enabled(vcpu) \
+		(vcpu->guest_debug & KVM_GUESTDBG_ENABLE)
+#define guestdbg_sstep_enabled(vcpu) \
+		(vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
+#define guestdbg_hw_bp_enabled(vcpu) \
+		(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
+#define guestdbg_exit_pending(vcpu) (guestdbg_enabled(vcpu) && \
+		(vcpu->guest_debug & KVM_GUESTDBG_EXIT_PENDING))
+
+struct kvm_guestdbg_info_arch {
+	unsigned long cr0;
+	unsigned long cr9;
+	unsigned long cr10;
+	unsigned long cr11;
+	struct kvm_hw_bp_info_arch *hw_bp_info;
+	struct kvm_hw_wp_info_arch *hw_wp_info;
+	int nr_hw_bp;
+	int nr_hw_wp;
+	unsigned long last_bp;
+};
 
 struct kvm_vcpu_arch {
 	struct kvm_s390_sie_block *sie_block;
@@ -321,6 +365,7 @@ struct kvm_vcpu_arch {
 		u64		stidp_data;
 	};
 	struct gmap *gmap;
+	struct kvm_guestdbg_info_arch guestdbg;
 #define KVM_S390_PFAULT_TOKEN_INVALID	(-1UL)
 	unsigned long pfault_token;
 	unsigned long pfault_select;
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index b8c0f07..0fc2643 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 #define __KVM_S390
+#define __KVM_HAVE_GUEST_DEBUG
 
 /* Device control API: s390-specific devices */
 #define KVM_DEV_FLIC_GET_ALL_IRQS	1
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 83a7a35..b3b5534 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -12,6 +12,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-objs += diag.o gaccess.o
+kvm-objs += diag.o gaccess.o guestdbg.o
 
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
new file mode 100644
index 0000000..100e99d
--- /dev/null
+++ b/arch/s390/kvm/guestdbg.c
@@ -0,0 +1,479 @@
+/*
+ * kvm guest debug support
+ *
+ * Copyright IBM Corp. 2014
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
+ */
+#include <linux/kvm_host.h>
+#include <linux/errno.h>
+#include "kvm-s390.h"
+#include "gaccess.h"
+
+/*
+ * Extends the address range given by *start and *stop to include the address
+ * range starting with estart and the length len. Takes care of overflowing
+ * intervals and tries to minimize the overall intervall size.
+ */
+static void extend_address_range(u64 *start, u64 *stop, u64 estart, int len)
+{
+	u64 estop;
+
+	if (len > 0)
+		len--;
+	else
+		len = 0;
+
+	estop = estart + len;
+
+	/* 0-0 range represents "not set" */
+	if ((*start == 0) && (*stop == 0)) {
+		*start = estart;
+		*stop = estop;
+	} else if (*start <= *stop) {
+		/* increase the existing range */
+		if (estart < *start)
+			*start = estart;
+		if (estop > *stop)
+			*stop = estop;
+	} else {
+		/* "overflowing" interval, whereby *stop > *start */
+		if (estart <= *stop) {
+			if (estop > *stop)
+				*stop = estop;
+		} else if (estop > *start) {
+			if (estart < *start)
+				*start = estart;
+		}
+		/* minimize the range */
+		else if ((estop - *stop) < (*start - estart))
+			*stop = estop;
+		else
+			*start = estart;
+	}
+}
+
+#define MAX_INST_SIZE 6
+
+static void enable_all_hw_bp(struct kvm_vcpu *vcpu)
+{
+	unsigned long start, len;
+	u64 *cr9 = &vcpu->arch.sie_block->gcr[9];
+	u64 *cr10 = &vcpu->arch.sie_block->gcr[10];
+	u64 *cr11 = &vcpu->arch.sie_block->gcr[11];
+	int i;
+
+	if (vcpu->arch.guestdbg.nr_hw_bp <= 0 ||
+	    vcpu->arch.guestdbg.hw_bp_info == NULL)
+		return;
+
+	/*
+	 * If the guest is not interrested in branching events, we can savely
+	 * limit them to the PER address range.
+	 */
+	if (!(*cr9 & PER_EVENT_BRANCH))
+		*cr9 |= PER_CONTROL_BRANCH_ADDRESS;
+	*cr9 |= PER_EVENT_IFETCH | PER_EVENT_BRANCH;
+
+	for (i = 0; i < vcpu->arch.guestdbg.nr_hw_bp; i++) {
+		start = vcpu->arch.guestdbg.hw_bp_info[i].addr;
+		len = vcpu->arch.guestdbg.hw_bp_info[i].len;
+
+		/*
+		 * The instruction in front of the desired bp has to
+		 * report instruction-fetching events
+		 */
+		if (start < MAX_INST_SIZE) {
+			len += start;
+			start = 0;
+		} else {
+			start -= MAX_INST_SIZE;
+			len += MAX_INST_SIZE;
+		}
+
+		extend_address_range(cr10, cr11, start, len);
+	}
+}
+
+static void enable_all_hw_wp(struct kvm_vcpu *vcpu)
+{
+	unsigned long start, len;
+	u64 *cr9 = &vcpu->arch.sie_block->gcr[9];
+	u64 *cr10 = &vcpu->arch.sie_block->gcr[10];
+	u64 *cr11 = &vcpu->arch.sie_block->gcr[11];
+	int i;
+
+	if (vcpu->arch.guestdbg.nr_hw_wp <= 0 ||
+	    vcpu->arch.guestdbg.hw_wp_info == NULL)
+		return;
+
+	/* if host uses storage alternation for special address
+	 * spaces, enable all events and give all to the guest */
+	if (*cr9 & PER_EVENT_STORE && *cr9 & PER_CONTROL_ALTERATION) {
+		*cr9 &= ~PER_CONTROL_ALTERATION;
+		*cr10 = 0;
+		*cr11 = PSW_ADDR_INSN;
+	} else {
+		*cr9 &= ~PER_CONTROL_ALTERATION;
+		*cr9 |= PER_EVENT_STORE;
+
+		for (i = 0; i < vcpu->arch.guestdbg.nr_hw_wp; i++) {
+			start = vcpu->arch.guestdbg.hw_wp_info[i].addr;
+			len = vcpu->arch.guestdbg.hw_wp_info[i].len;
+
+			extend_address_range(cr10, cr11, start, len);
+		}
+	}
+}
+
+void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.guestdbg.cr0 = vcpu->arch.sie_block->gcr[0];
+	vcpu->arch.guestdbg.cr9 = vcpu->arch.sie_block->gcr[9];
+	vcpu->arch.guestdbg.cr10 = vcpu->arch.sie_block->gcr[10];
+	vcpu->arch.guestdbg.cr11 = vcpu->arch.sie_block->gcr[11];
+}
+
+void kvm_s390_restore_guest_per_regs(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.sie_block->gcr[0] = vcpu->arch.guestdbg.cr0;
+	vcpu->arch.sie_block->gcr[9] = vcpu->arch.guestdbg.cr9;
+	vcpu->arch.sie_block->gcr[10] = vcpu->arch.guestdbg.cr10;
+	vcpu->arch.sie_block->gcr[11] = vcpu->arch.guestdbg.cr11;
+}
+
+void kvm_s390_patch_guest_per_regs(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * TODO: if guest psw has per enabled, otherwise 0s!
+	 * This reduces the amount of reported events.
+	 * Need to intercept all psw changes!
+	 */
+
+	if (guestdbg_sstep_enabled(vcpu)) {
+		vcpu->arch.sie_block->gcr[9] |= PER_EVENT_IFETCH;
+		vcpu->arch.sie_block->gcr[10] = 0;
+		vcpu->arch.sie_block->gcr[11] = PSW_ADDR_INSN;
+	}
+
+	if (guestdbg_hw_bp_enabled(vcpu)) {
+		enable_all_hw_bp(vcpu);
+		enable_all_hw_wp(vcpu);
+	}
+
+	/* TODO: Instruction-fetching-nullification not allowed for now */
+	if (vcpu->arch.sie_block->gcr[9] & PER_EVENT_NULLIFICATION)
+		vcpu->arch.sie_block->gcr[9] &= ~PER_EVENT_NULLIFICATION;
+}
+
+#define MAX_WP_SIZE 100
+
+static int __import_wp_info(struct kvm_vcpu *vcpu,
+			    struct kvm_hw_breakpoint *bp_data,
+			    struct kvm_hw_wp_info_arch *wp_info)
+{
+	int ret = 0;
+	wp_info->len = bp_data->len;
+	wp_info->addr = bp_data->addr;
+	wp_info->phys_addr = bp_data->phys_addr;
+	wp_info->old_data = NULL;
+
+	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
+		return -EINVAL;
+
+	wp_info->old_data = kmalloc(bp_data->len, GFP_KERNEL);
+	if (!wp_info->old_data)
+		return -ENOMEM;
+	/* try to backup the original value */
+	ret = read_guest(vcpu, wp_info->phys_addr, wp_info->old_data,
+			 wp_info->len);
+	if (ret) {
+		kfree(wp_info->old_data);
+		wp_info->old_data = NULL;
+	}
+
+	return ret;
+}
+
+#define MAX_BP_COUNT 50
+
+int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
+			    struct kvm_guest_debug *dbg)
+{
+	int ret = 0, nr_wp = 0, nr_bp = 0, i, size;
+	struct kvm_hw_breakpoint *bp_data = NULL;
+	struct kvm_hw_wp_info_arch *wp_info = NULL;
+	struct kvm_hw_bp_info_arch *bp_info = NULL;
+
+	if (dbg->arch.nr_hw_bp <= 0 || !dbg->arch.hw_bp)
+		return 0;
+	else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
+		return -EINVAL;
+
+	size = dbg->arch.nr_hw_bp * sizeof(struct kvm_hw_breakpoint);
+	bp_data = kmalloc(size, GFP_KERNEL);
+	if (!bp_data) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = copy_from_user(bp_data, dbg->arch.hw_bp, size);
+	if (ret)
+		goto error;
+
+	for (i = 0; i < dbg->arch.nr_hw_bp; i++) {
+		switch (bp_data[i].type) {
+		case KVM_HW_WP_WRITE:
+			nr_wp++;
+			break;
+		case KVM_HW_BP:
+			nr_bp++;
+			break;
+		default:
+			break;
+		}
+	}
+
+	size = nr_wp * sizeof(struct kvm_hw_wp_info_arch);
+	if (size > 0) {
+		wp_info = kmalloc(size, GFP_KERNEL);
+		if (!wp_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+	}
+	size = nr_bp * sizeof(struct kvm_hw_bp_info_arch);
+	if (size > 0) {
+		bp_info = kmalloc(size, GFP_KERNEL);
+		if (!bp_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for (nr_wp = 0, nr_bp = 0, i = 0; i < dbg->arch.nr_hw_bp; i++) {
+		switch (bp_data[i].type) {
+		case KVM_HW_WP_WRITE:
+			ret = __import_wp_info(vcpu, &bp_data[i],
+					       &wp_info[nr_wp]);
+			if (ret)
+				goto error;
+			nr_wp++;
+			break;
+		case KVM_HW_BP:
+			bp_info[nr_bp].len = bp_data[i].len;
+			bp_info[nr_bp].addr = bp_data[i].addr;
+			nr_bp++;
+			break;
+		}
+	}
+
+	vcpu->arch.guestdbg.nr_hw_bp = nr_bp;
+	vcpu->arch.guestdbg.hw_bp_info = bp_info;
+	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
+	vcpu->arch.guestdbg.hw_wp_info = wp_info;
+	return 0;
+error:
+	kfree(bp_data);
+	kfree(wp_info);
+	kfree(bp_info);
+	return ret;
+}
+
+void kvm_s390_clear_bp_data(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_hw_wp_info_arch *hw_wp_info = NULL;
+
+	for (i = 0; i < vcpu->arch.guestdbg.nr_hw_wp; i++) {
+		hw_wp_info = &vcpu->arch.guestdbg.hw_wp_info[i];
+		kfree(hw_wp_info->old_data);
+		hw_wp_info->old_data = NULL;
+	}
+	kfree(vcpu->arch.guestdbg.hw_wp_info);
+	vcpu->arch.guestdbg.hw_wp_info = NULL;
+
+	kfree(vcpu->arch.guestdbg.hw_bp_info);
+	vcpu->arch.guestdbg.hw_bp_info = NULL;
+
+	vcpu->arch.guestdbg.nr_hw_wp = 0;
+	vcpu->arch.guestdbg.nr_hw_bp = 0;
+}
+
+static inline int in_addr_range(u64 addr, u64 a, u64 b)
+{
+	if (a <= b)
+		return (addr >= a) && (addr <= b);
+	else
+		/* "overflowing" interval */
+		return (addr <= a) && (addr >= b);
+}
+
+#define end_of_range(bp_info) (bp_info->addr + bp_info->len - 1)
+
+static struct kvm_hw_bp_info_arch *find_hw_bp(struct kvm_vcpu *vcpu,
+					      unsigned long addr)
+{
+	struct kvm_hw_bp_info_arch *bp_info = vcpu->arch.guestdbg.hw_bp_info;
+	int i;
+
+	if (vcpu->arch.guestdbg.nr_hw_bp == 0)
+		return NULL;
+
+	for (i = 0; i < vcpu->arch.guestdbg.nr_hw_bp; i++) {
+		/* addr is directly the start or in the range of a bp */
+		if (addr == bp_info->addr)
+			goto found;
+		if (bp_info->len > 0 &&
+		    in_addr_range(addr, bp_info->addr, end_of_range(bp_info)))
+			goto found;
+
+		bp_info++;
+	}
+
+	return NULL;
+found:
+	return bp_info;
+}
+
+static struct kvm_hw_wp_info_arch *any_wp_changed(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_hw_wp_info_arch *wp_info = NULL;
+	void *temp = NULL;
+
+	if (vcpu->arch.guestdbg.nr_hw_wp == 0)
+		return NULL;
+
+	for (i = 0; i < vcpu->arch.guestdbg.nr_hw_wp; i++) {
+		wp_info = &vcpu->arch.guestdbg.hw_wp_info[i];
+		if (!wp_info || !wp_info->old_data || wp_info->len <= 0)
+			continue;
+
+		temp = kmalloc(wp_info->len, GFP_KERNEL);
+		if (!temp)
+			continue;
+
+		/* refetch the wp data and compare it to the old value */
+		if (!read_guest(vcpu, wp_info->phys_addr, temp,
+				wp_info->len)) {
+			if (memcmp(temp, wp_info->old_data, wp_info->len)) {
+				kfree(temp);
+				return wp_info;
+			}
+		}
+		kfree(temp);
+		temp = NULL;
+	}
+
+	return NULL;
+}
+
+void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_DEBUG;
+	vcpu->guest_debug &= ~KVM_GUESTDBG_EXIT_PENDING;
+}
+
+#define per_bp_event(code) \
+			(code & (PER_EVENT_IFETCH | PER_EVENT_BRANCH))
+#define per_write_wp_event(code) \
+			(code & (PER_EVENT_STORE | PER_EVENT_STORE_REAL))
+
+static int debug_exit_required(struct kvm_vcpu *vcpu)
+{
+	u32 perc = (vcpu->arch.sie_block->perc << 24);
+	struct kvm_debug_exit_arch *debug_exit = &vcpu->run->debug.arch;
+	struct kvm_hw_wp_info_arch *wp_info = NULL;
+	struct kvm_hw_bp_info_arch *bp_info = NULL;
+	unsigned long addr = vcpu->arch.sie_block->gpsw.addr;
+	unsigned long peraddr = vcpu->arch.sie_block->peraddr;
+
+	if (guestdbg_hw_bp_enabled(vcpu)) {
+		if (per_write_wp_event(perc) &&
+		    vcpu->arch.guestdbg.nr_hw_wp > 0) {
+			wp_info = any_wp_changed(vcpu);
+			if (wp_info) {
+				debug_exit->addr = wp_info->addr;
+				debug_exit->type = KVM_HW_WP_WRITE;
+				goto exit_required;
+			}
+		}
+		if (per_bp_event(perc) &&
+			 vcpu->arch.guestdbg.nr_hw_bp > 0) {
+			bp_info = find_hw_bp(vcpu, addr);
+			/* remove duplicate events if PC==PER address */
+			if (bp_info && (addr != peraddr)) {
+				debug_exit->addr = addr;
+				debug_exit->type = KVM_HW_BP;
+				vcpu->arch.guestdbg.last_bp = addr;
+				goto exit_required;
+			}
+			/* breakpoint missed */
+			bp_info = find_hw_bp(vcpu, peraddr);
+			if (bp_info && vcpu->arch.guestdbg.last_bp != peraddr) {
+				debug_exit->addr = peraddr;
+				debug_exit->type = KVM_HW_BP;
+				goto exit_required;
+			}
+		}
+	}
+	if (guestdbg_sstep_enabled(vcpu) && per_bp_event(perc)) {
+		debug_exit->addr = addr;
+		debug_exit->type = KVM_SINGLESTEP;
+		goto exit_required;
+	}
+
+	return 0;
+exit_required:
+	return 1;
+}
+
+#define guest_per_enabled(vcpu) \
+			     (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER)
+
+static void filter_guest_per_event(struct kvm_vcpu *vcpu)
+{
+	u32 perc = vcpu->arch.sie_block->perc << 24;
+	u64 peraddr = vcpu->arch.sie_block->peraddr;
+	u64 addr = vcpu->arch.sie_block->gpsw.addr;
+	u64 cr9 = vcpu->arch.sie_block->gcr[9];
+	u64 cr10 = vcpu->arch.sie_block->gcr[10];
+	u64 cr11 = vcpu->arch.sie_block->gcr[11];
+	/* filter all events, demanded by the guest */
+	u32 guest_perc = perc & cr9 & PER_EVENT_MASK;
+
+	if (!guest_per_enabled(vcpu))
+		guest_perc = 0;
+
+	/* filter "successful-branching" events */
+	if (guest_perc & PER_EVENT_BRANCH &&
+	    cr9 & PER_CONTROL_BRANCH_ADDRESS &&
+	    !in_addr_range(addr, cr10, cr11))
+		guest_perc &= ~PER_EVENT_BRANCH;
+
+	/* filter "instruction-fetching" events */
+	if (guest_perc & PER_EVENT_IFETCH &&
+	    !in_addr_range(peraddr, cr10, cr11))
+		guest_perc &= ~PER_EVENT_IFETCH;
+
+	/* All other PER events will be given to the guest */
+	/* TODO: Check alterated address/address space */
+
+	vcpu->arch.sie_block->perc = guest_perc >> 24;
+
+	if (!guest_perc)
+		vcpu->arch.sie_block->iprcc &= ~PGM_PER;
+}
+
+void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu)
+{
+	if (debug_exit_required(vcpu))
+		vcpu->guest_debug |= KVM_GUESTDBG_EXIT_PENDING;
+
+	filter_guest_per_event(vcpu);
+}
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index c0e6b49..f61c800 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -170,6 +170,8 @@ static void __extract_prog_irq(struct kvm_vcpu *vcpu,
 	}
 }
 
+#define per_event(vcpu) (vcpu->arch.sie_block->iprcc & PGM_PER)
+
 static int handle_prog(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_pgm_info pgm_info;
@@ -178,6 +180,13 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.exit_program_interruption++;
 
+	if (guestdbg_enabled(vcpu) && per_event(vcpu)) {
+		kvm_s390_handle_per_event(vcpu);
+		/* the interrupt might have been filtered out completely */
+		if (vcpu->arch.sie_block->iprcc == 0)
+			return 0;
+	}
+
 	/* Restore ITDB to Program-Interruption TDB in guest memory */
 	if (!IS_TE_ENABLED(vcpu) || !IS_ITDB_VALID(vcpu))
 		goto skip_itdb;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c49b4d4..f331014 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -131,7 +131,13 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 		CPUSTAT_IO_INT | CPUSTAT_EXT_INT | CPUSTAT_STOP_INT,
 		&vcpu->arch.sie_block->cpuflags);
 	vcpu->arch.sie_block->lctl = 0x0000;
-	vcpu->arch.sie_block->ictl &= ~ICTL_LPSW;
+	vcpu->arch.sie_block->ictl &= ~(ICTL_LPSW | ICTL_STCTL | ICTL_PINT);
+
+	if (guestdbg_enabled(vcpu)) {
+		vcpu->arch.sie_block->lctl |= (LCTL_CR0 | LCTL_CR9 |
+					       LCTL_CR10 | LCTL_CR11);
+		vcpu->arch.sie_block->ictl |= (ICTL_STCTL | ICTL_PINT);
+	}
 }
 
 static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7ae8c26..e6bbfe1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -934,10 +934,40 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	return -EINVAL; /* not implemented yet */
 }
 
+#define VALID_GUESTDBG_FLAGS (KVM_GUESTDBG_SINGLESTEP | \
+			      KVM_GUESTDBG_USE_HW_BP | \
+			      KVM_GUESTDBG_ENABLE)
+
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
-	return -EINVAL; /* not implemented yet */
+	int rc = 0;
+
+	vcpu->guest_debug = 0;
+	kvm_s390_clear_bp_data(vcpu);
+
+	if (vcpu->guest_debug & ~VALID_GUESTDBG_FLAGS)
+		return -EINVAL;
+
+	if (dbg->control & KVM_GUESTDBG_ENABLE) {
+		vcpu->guest_debug = dbg->control;
+		/* enforce guest PER */
+		atomic_set_mask(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+
+		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
+			rc = kvm_s390_import_bp_data(vcpu, dbg);
+	} else {
+		atomic_clear_mask(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		vcpu->arch.guestdbg.last_bp = 0;
+	}
+
+	if (rc) {
+		vcpu->guest_debug = 0;
+		kvm_s390_clear_bp_data(vcpu);
+		atomic_clear_mask(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+	}
+
+	return rc;
 }
 
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
@@ -1095,6 +1125,11 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	if (rc)
 		return rc;
 
+	if (guestdbg_enabled(vcpu)) {
+		kvm_s390_backup_guest_per_regs(vcpu);
+		kvm_s390_patch_guest_per_regs(vcpu);
+	}
+
 	vcpu->arch.sie_block->icptcode = 0;
 	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
 	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
@@ -1111,6 +1146,9 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 		   vcpu->arch.sie_block->icptcode);
 	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
 
+	if (guestdbg_enabled(vcpu))
+		kvm_s390_restore_guest_per_regs(vcpu);
+
 	if (exit_reason >= 0) {
 		rc = 0;
 	} else if (kvm_is_ucontrol(vcpu->kvm)) {
@@ -1176,7 +1214,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 		rc = vcpu_post_run(vcpu, exit_reason);
-	} while (!signal_pending(current) && !rc);
+	} while (!signal_pending(current) && !guestdbg_exit_pending(vcpu) && !rc);
 
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 	return rc;
@@ -1187,6 +1225,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int rc;
 	sigset_t sigsaved;
 
+	if (guestdbg_exit_pending(vcpu)) {
+		kvm_s390_prepare_debug_exit(vcpu);
+		return 0;
+	}
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -1199,6 +1242,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	case KVM_EXIT_S390_RESET:
 	case KVM_EXIT_S390_UCONTROL:
 	case KVM_EXIT_S390_TSCH:
+	case KVM_EXIT_DEBUG:
 		break;
 	default:
 		BUG();
@@ -1224,6 +1268,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		rc = -EINTR;
 	}
 
+	if (guestdbg_exit_pending(vcpu) && !rc)  {
+		kvm_s390_prepare_debug_exit(vcpu);
+		rc = 0;
+	}
+
 	if (rc == -EOPNOTSUPP) {
 		/* intercept cannot be handled in-kernel, prepare kvm-run */
 		kvm_run->exit_reason         = KVM_EXIT_S390_SIEIC;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 5f00fc1..be8ae0d 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -211,4 +211,14 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
 void kvm_s390_destroy_adapters(struct kvm *kvm);
 
+/* implemented in guestdbg.c */
+void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
+void kvm_s390_restore_guest_per_regs(struct kvm_vcpu *vcpu);
+void kvm_s390_patch_guest_per_regs(struct kvm_vcpu *vcpu);
+int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
+			    struct kvm_guest_debug *dbg);
+void kvm_s390_clear_bp_data(struct kvm_vcpu *vcpu);
+void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu);
+void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
+
 #endif
-- 
1.8.4.2
