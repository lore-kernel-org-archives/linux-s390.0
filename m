From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 3/4] KVM: s390: irq routing for adapter interrupts.
Date: Fri, 21 Mar 2014 13:52:20 +0100
Message-ID: <1395406341-14698-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1395406341-14698-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395406341-14698-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Introduce a new interrupt class for s390 adapter interrupts and enable
irqfds for s390.

This is depending on a new s390 specific vm capability, KVM_CAP_S390_IRQCHIP,
that needs to be enabled by userspace.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |   21 +++++--
 arch/s390/include/asm/kvm_host.h  |    9 +++
 arch/s390/kvm/Kconfig             |    2 +
 arch/s390/kvm/Makefile            |    2 +-
 arch/s390/kvm/interrupt.c         |  121 +++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/irq.h               |   22 +++++++
 arch/s390/kvm/kvm-s390.c          |   17 ++++++
 include/linux/kvm_host.h          |    9 +++
 include/uapi/linux/kvm.h          |   11 ++++
 9 files changed, 209 insertions(+), 5 deletions(-)
 create mode 100644 arch/s390/kvm/irq.h

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index faf6fe9..2cb1640 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -586,8 +586,8 @@ struct kvm_fpu {
 
 4.24 KVM_CREATE_IRQCHIP
 
-Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64, ARM, arm64
+Capability: KVM_CAP_IRQCHIP, KVM_CAP_S390_IRQCHIP (s390)
+Architectures: x86, ia64, ARM, arm64, s390
 Type: vm ioctl
 Parameters: none
 Returns: 0 on success, -1 on error
@@ -596,7 +596,10 @@ Creates an interrupt controller model in the kernel.  On x86, creates a virtual
 ioapic, a virtual PIC (two PICs, nested), and sets up future vcpus to have a
 local APIC.  IRQ routing for GSIs 0-15 is set to both PIC and IOAPIC; GSI 16-23
 only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM/arm64, a GIC is
-created.
+created. On s390, a dummy irq routing table is created.
+
+Note that on s390 the KVM_CAP_S390_IRQCHIP vm capability needs to be enabled
+before KVM_CREATE_IRQCHIP can be used.
 
 
 4.25 KVM_IRQ_LINE
@@ -1336,7 +1339,7 @@ KVM_ASSIGN_DEV_IRQ. Partial deassignment of host or guest IRQ is allowed.
 4.52 KVM_SET_GSI_ROUTING
 
 Capability: KVM_CAP_IRQ_ROUTING
-Architectures: x86 ia64
+Architectures: x86 ia64 s390
 Type: vm ioctl
 Parameters: struct kvm_irq_routing (in)
 Returns: 0 on success, -1 on error
@@ -1359,6 +1362,7 @@ struct kvm_irq_routing_entry {
 	union {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
+		struct kvm_irq_routing_s390_adapter adapter;
 		__u32 pad[8];
 	} u;
 };
@@ -1366,6 +1370,7 @@ struct kvm_irq_routing_entry {
 /* gsi routing entry types */
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
+#define KVM_IRQ_ROUTING_S390_ADAPTER 3
 
 No flags are specified so far, the corresponding field must be set to zero.
 
@@ -1381,6 +1386,14 @@ struct kvm_irq_routing_msi {
 	__u32 pad;
 };
 
+struct kvm_irq_routing_s390_adapter {
+	__u64 ind_addr;
+	__u64 summary_addr;
+	__u64 ind_offset;
+	__u32 summary_offset;
+	__u32 adapter_id;
+};
+
 
 4.53 KVM_ASSIGN_SET_MSIX_NR
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0d52352..dd39337 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -24,6 +24,14 @@
 #define KVM_MAX_VCPUS 64
 #define KVM_USER_MEM_SLOTS 32
 
+/*
+ * These seem to be used for allocating ->chip in the routing table,
+ * which we don't use. 4096 is an out-of-thin-air value. If we need
+ * to look at ->chip later on, we'll need to revisit this.
+ */
+#define KVM_NR_IRQCHIPS 1
+#define KVM_IRQCHIP_NUM_PINS 4096
+
 struct sca_entry {
 	atomic_t scn;
 	__u32	reserved;
@@ -274,6 +282,7 @@ struct kvm_arch{
 	struct kvm_device *flic;
 	struct gmap *gmap;
 	int css_support;
+	int use_irqchip;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 };
 
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index c8bacbc..10d529a 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -25,6 +25,8 @@ config KVM
 	select HAVE_KVM_EVENTFD
 	select KVM_ASYNC_PF
 	select KVM_ASYNC_PF_SYNC
+	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_IRQ_ROUTING
 	---help---
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index a47d2c3..d3adb37 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -7,7 +7,7 @@
 # as published by the Free Software Foundation.
 
 KVM := ../../../virt/kvm
-common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o
+common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7ecef5a..2e2814e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
 #include <linux/hrtimer.h>
+#include <linux/mmu_context.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <asm/asm-offsets.h>
@@ -1284,3 +1285,123 @@ struct kvm_device_ops kvm_flic_ops = {
 	.create = flic_create,
 	.destroy = flic_destroy,
 };
+
+static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
+{
+	unsigned long bit;
+
+	bit = bit_nr + (addr % PAGE_SIZE) * 8;
+
+	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
+}
+
+static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
+					  u64 addr)
+{
+	struct s390_map_info *map;
+
+	if (!adapter)
+		return NULL;
+
+	list_for_each_entry(map, &adapter->maps, list) {
+		if (map->guest_addr == addr)
+			return map;
+	}
+	return NULL;
+}
+
+static int adapter_indicators_set(struct kvm *kvm,
+				  struct s390_io_adapter *adapter,
+				  struct kvm_s390_adapter_int *adapter_int)
+{
+	unsigned long bit;
+	int summary_set, idx;
+	struct s390_map_info *info;
+	void *map;
+
+	info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!info)
+		return -1;
+	map = page_address(info->page);
+	bit = get_ind_bit(info->addr, adapter_int->ind_offset, adapter->swap);
+	set_bit(bit, map);
+	idx = srcu_read_lock(&kvm->srcu);
+	mark_page_dirty(kvm, info->guest_addr >> PAGE_SHIFT);
+	set_page_dirty_lock(info->page);
+	info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!info) {
+		srcu_read_unlock(&kvm->srcu, idx);
+		return -1;
+	}
+	map = page_address(info->page);
+	bit = get_ind_bit(info->addr, adapter_int->summary_offset,
+			  adapter->swap);
+	summary_set = test_and_set_bit(bit, map);
+	mark_page_dirty(kvm, info->guest_addr >> PAGE_SHIFT);
+	set_page_dirty_lock(info->page);
+	srcu_read_unlock(&kvm->srcu, idx);
+	return summary_set ? 0 : 1;
+}
+
+/*
+ * < 0 - not injected due to error
+ * = 0 - coalesced, summary indicator already active
+ * > 0 - injected interrupt
+ */
+static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
+			   struct kvm *kvm, int irq_source_id, int level,
+			   bool line_status)
+{
+	int ret;
+	struct s390_io_adapter *adapter;
+
+	/* We're only interested in the 0->1 transition. */
+	if (!level)
+		return 0;
+	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
+	if (!adapter)
+		return -1;
+	down_read(&adapter->maps_lock);
+	ret = adapter_indicators_set(kvm, adapter, &e->adapter);
+	up_read(&adapter->maps_lock);
+	if ((ret > 0) && !adapter->masked) {
+		struct kvm_s390_interrupt s390int = {
+			.type = KVM_S390_INT_IO(1, 0, 0, 0),
+			.parm = 0,
+			.parm64 = (adapter->isc << 27) | 0x80000000,
+		};
+		ret = kvm_s390_inject_vm(kvm, &s390int);
+		if (ret == 0)
+			ret = 1;
+	}
+	return ret;
+}
+
+int kvm_set_routing_entry(struct kvm_irq_routing_table *rt,
+			  struct kvm_kernel_irq_routing_entry *e,
+			  const struct kvm_irq_routing_entry *ue)
+{
+	int ret;
+
+	switch (ue->type) {
+	case KVM_IRQ_ROUTING_S390_ADAPTER:
+		e->set = set_adapter_int;
+		e->adapter.summary_addr = ue->u.adapter.summary_addr;
+		e->adapter.ind_addr = ue->u.adapter.ind_addr;
+		e->adapter.summary_offset = ue->u.adapter.summary_offset;
+		e->adapter.ind_offset = ue->u.adapter.ind_offset;
+		e->adapter.adapter_id = ue->u.adapter.adapter_id;
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
+		int irq_source_id, int level, bool line_status)
+{
+	return -EINVAL;
+}
diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
new file mode 100644
index 0000000..d98e415
--- /dev/null
+++ b/arch/s390/kvm/irq.h
@@ -0,0 +1,22 @@
+/*
+ * s390 irqchip routines
+ *
+ * Copyright IBM Corp. 2014
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ */
+#ifndef __KVM_IRQ_H
+#define __KVM_IRQ_H
+
+#include <linux/kvm_host.h>
+
+static inline int irqchip_in_kernel(struct kvm *kvm)
+{
+	return 1;
+}
+
+#endif
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2e6fbb0..ce5b659 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -196,6 +196,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		return -EINVAL;
 
 	switch (cap->cap) {
+	case KVM_CAP_S390_IRQCHIP:
+		kvm->arch.use_irqchip = 1;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -228,6 +232,18 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
 		break;
 	}
+	case KVM_CREATE_IRQCHIP: {
+		struct kvm_irq_routing_entry routing;
+
+		r = -EINVAL;
+		if (kvm->arch.use_irqchip) {
+			/* Set up dummy routing. */
+			memset(&routing, 0, sizeof(routing));
+			kvm_set_irq_routing(kvm, &routing, 0, 0);
+			r = 0;
+		}
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
@@ -284,6 +300,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	}
 
 	kvm->arch.css_support = 0;
+	kvm->arch.use_irqchip = 0;
 
 	return 0;
 out_nogmap:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9816b68..da7510b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -297,6 +297,14 @@ static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memsl
 	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
 }
 
+struct kvm_s390_adapter_int {
+	u64 ind_addr;
+	u64 summary_addr;
+	u64 ind_offset;
+	u32 summary_offset;
+	u32 adapter_id;
+};
+
 struct kvm_kernel_irq_routing_entry {
 	u32 gsi;
 	u32 type;
@@ -309,6 +317,7 @@ struct kvm_kernel_irq_routing_entry {
 			unsigned pin;
 		} irqchip;
 		struct msi_msg msi;
+		struct kvm_s390_adapter_int adapter;
 	};
 	struct hlist_node link;
 };
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 46ea1b4..a8f4ee5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -742,6 +742,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_HYPERV_TIME 96
 #define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
 #define KVM_CAP_ENABLE_CAP_VM 98
+#define KVM_CAP_S390_IRQCHIP 99
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -757,9 +758,18 @@ struct kvm_irq_routing_msi {
 	__u32 pad;
 };
 
+struct kvm_irq_routing_s390_adapter {
+	__u64 ind_addr;
+	__u64 summary_addr;
+	__u64 ind_offset;
+	__u32 summary_offset;
+	__u32 adapter_id;
+};
+
 /* gsi routing entry types */
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
+#define KVM_IRQ_ROUTING_S390_ADAPTER 3
 
 struct kvm_irq_routing_entry {
 	__u32 gsi;
@@ -769,6 +779,7 @@ struct kvm_irq_routing_entry {
 	union {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
+		struct kvm_irq_routing_s390_adapter adapter;
 		__u32 pad[8];
 	} u;
 };
-- 
1.7.9.5
