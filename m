From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 3/5] KVM: s390: adapter interrupt sources
Date: Mon, 17 Mar 2014 19:11:37 +0100
Message-ID: <1395079899-29239-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add a new interface to register/deregister sources of adapter interrupts
identified by an unique id via the flic. Adapters may also be maskable
and carry a list of pinned pages.

These adapters will be used by irq routing later.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt |   43 ++++++
 arch/s390/include/asm/kvm_host.h                |   20 +++
 arch/s390/include/uapi/asm/kvm.h                |   22 ++++
 arch/s390/kvm/interrupt.c                       |  161 ++++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.c                        |    1 +
 arch/s390/kvm/kvm-s390.h                        |    2 +
 6 files changed, 248 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index 410fa67..db16111 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -12,6 +12,7 @@ FLIC provides support to
 - inspect currently pending interrupts (KVM_FLIC_GET_ALL_IRQS)
 - purge all pending floating interrupts (KVM_DEV_FLIC_CLEAR_IRQS)
 - enable/disable for the guest transparent async page faults
+- register and modify adapter interrupt sources (KVM_DEV_FLIC_ADAPTER_*)
 
 Groups:
   KVM_DEV_FLIC_ENQUEUE
@@ -44,3 +45,45 @@ Groups:
     Disables async page faults for the guest and waits until already pending
     async page faults are done. This is necessary to trigger a completion interrupt
     for every init interrupt before migrating the interrupt list.
+
+  KVM_DEV_FLIC_ADAPTER_REGISTER
+    Register an I/O adapter interrupt source. Takes a kvm_s390_io_adapter
+    describing the adapter to register:
+
+struct kvm_s390_io_adapter {
+	__u32 id;
+	__u8 isc;
+	__u8 maskable;
+	__u8 swap;
+	__u8 pad;
+};
+
+   id contains the unique id for the adapter, isc the I/O interruption subclass
+   to use, maskable whether this adapter may be masked (interrupts turned off)
+   and swap whether the indicators need to be byte swapped.
+
+
+  KVM_DEV_FLIC_ADAPTER_MODIFY
+    Modifies attributes of an existing I/O adapter interrupt source. Takes
+    a kvm_s390_io_adapter_req specifiying the adapter and the operation:
+
+struct kvm_s390_io_adapter_req {
+	__u32 id;
+	__u8 type;
+	__u8 mask;
+	__u16 pad0;
+	__u64 addr;
+};
+
+    id specifies the adapter and type the operation. The supported operations
+    are:
+
+    KVM_S390_IO_ADAPTER_MASK
+      mask or unmask the adapter, as specified in mask
+
+    KVM_S390_IO_ADAPTER_MAP
+      pin a userspace page for the address provided in addr and add it to the
+      list of mappings
+
+    KVM_S390_IO_ADAPTER_UNMAP
+      release a userspace page as specified in addr from the list of mappings
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 734d302..356f595 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -19,6 +19,7 @@
 #include <linux/kvm.h>
 #include <asm/debug.h>
 #include <asm/cpu.h>
+#include <asm/isc.h>
 
 #define KVM_MAX_VCPUS 64
 #define KVM_USER_MEM_SLOTS 32
@@ -245,6 +246,24 @@ struct kvm_vm_stat {
 struct kvm_arch_memory_slot {
 };
 
+struct s390_map_info {
+	struct list_head list;
+	__u64 addr;
+	struct page *page;
+};
+
+struct s390_io_adapter {
+	unsigned int id;
+	int isc;
+	bool maskable;
+	bool masked;
+	bool swap;
+	struct rw_semaphore maps_lock;
+	struct list_head maps;
+};
+
+#define MAX_S390_IO_ADAPTERS (MAX_ISC + 1) * 8
+
 struct kvm_arch{
 	struct sca_block *sca;
 	debug_info_t *dbf;
@@ -252,6 +271,7 @@ struct kvm_arch{
 	struct kvm_device *flic;
 	struct gmap *gmap;
 	int css_support;
+	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 2f0ade2..c003c6a 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -22,6 +22,8 @@
 #define KVM_DEV_FLIC_CLEAR_IRQS		3
 #define KVM_DEV_FLIC_APF_ENABLE		4
 #define KVM_DEV_FLIC_APF_DISABLE_WAIT	5
+#define KVM_DEV_FLIC_ADAPTER_REGISTER	6
+#define KVM_DEV_FLIC_ADAPTER_MODIFY	7
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
@@ -32,6 +34,26 @@
 #define KVM_S390_MAX_FLOAT_IRQS	266250
 #define KVM_S390_FLIC_MAX_BUFFER	0x2000000
 
+struct kvm_s390_io_adapter {
+	__u32 id;
+	__u8 isc;
+	__u8 maskable;
+	__u8 swap;
+	__u8 pad;
+};
+
+#define KVM_S390_IO_ADAPTER_MASK 1
+#define KVM_S390_IO_ADAPTER_MAP 2
+#define KVM_S390_IO_ADAPTER_UNMAP 3
+
+struct kvm_s390_io_adapter_req {
+	__u32 id;
+	__u8 type;
+	__u8 mask;
+	__u16 pad0;
+	__u64 addr;
+};
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 79d2e4f..94b337e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1,7 +1,7 @@
 /*
  * handling kvm guest interrupts
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008,2014
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -1054,6 +1054,159 @@ static int enqueue_floating_irq(struct kvm_device *dev,
 	return r;
 }
 
+static struct s390_io_adapter *get_io_adapter(struct kvm *kvm, unsigned int id)
+{
+	if (id >= MAX_S390_IO_ADAPTERS)
+		return NULL;
+	return kvm->arch.adapters[id];
+}
+
+static int register_io_adapter(struct kvm_device *dev,
+			       struct kvm_device_attr *attr)
+{
+	struct s390_io_adapter *adapter;
+	struct kvm_s390_io_adapter adapter_info;
+
+	if (copy_from_user(&adapter_info,
+			   (void __user *)attr->addr, sizeof(adapter_info)))
+		return -EFAULT;
+
+	if ((adapter_info.id >= MAX_S390_IO_ADAPTERS) ||
+	    (dev->kvm->arch.adapters[adapter_info.id] != NULL))
+		return -EINVAL;
+
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&adapter->maps);
+	init_rwsem(&adapter->maps_lock);
+	adapter->id = adapter_info.id;
+	adapter->isc = adapter_info.isc;
+	adapter->maskable = adapter_info.maskable;
+	adapter->masked = false;
+	adapter->swap = adapter_info.swap;
+	dev->kvm->arch.adapters[adapter->id] = adapter;
+
+	return 0;
+}
+
+int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
+{
+	int ret;
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+
+	if (!adapter || !adapter->maskable)
+		return -EINVAL;
+	ret = adapter->masked;
+	adapter->masked = masked;
+	return ret;
+}
+
+static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
+{
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+	struct s390_map_info *map;
+	int ret;
+
+	if (!adapter || !addr)
+		return -EINVAL;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	INIT_LIST_HEAD(&map->list);
+	map->addr = addr;
+	ret = get_user_pages_fast(addr, 1, 1, &map->page);
+	if (ret < 0)
+		goto out;
+	BUG_ON(ret != 1);
+	down_write(&adapter->maps_lock);
+	list_add_tail(&map->list, &adapter->maps);
+	up_write(&adapter->maps_lock);
+	ret = 0;
+out:
+	if (ret)
+		kfree(map);
+	return ret;
+}
+
+static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
+{
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+	struct s390_map_info *map, *tmp;
+	int found = 0;
+
+	if (!adapter || !addr)
+		return -EINVAL;
+
+	down_write(&adapter->maps_lock);
+	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
+		if (map->addr == addr) {
+			found = 1;
+			list_del(&map->list);
+			put_page(map->page);
+			kfree(map);
+			break;
+		}
+	}
+	up_write(&adapter->maps_lock);
+
+	return found ? 0 : -EINVAL;
+}
+
+void kvm_s390_destroy_adapters(struct kvm *kvm)
+{
+	int i;
+	struct s390_map_info *map, *tmp;
+
+	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
+		if (!kvm->arch.adapters[i])
+			continue;
+		list_for_each_entry_safe(map, tmp,
+					 &kvm->arch.adapters[i]->maps, list) {
+			list_del(&map->list);
+			put_page(map->page);
+			kfree(map);
+		}
+		kfree(kvm->arch.adapters[i]);
+	}
+}
+
+static int modify_io_adapter(struct kvm_device *dev,
+			     struct kvm_device_attr *attr)
+{
+	struct kvm_s390_io_adapter_req req;
+	struct s390_io_adapter *adapter;
+	int ret;
+
+	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
+		return -EFAULT;
+
+	adapter = get_io_adapter(dev->kvm, req.id);
+	if (!adapter)
+		return -EINVAL;
+	switch (req.type) {
+	case KVM_S390_IO_ADAPTER_MASK:
+		ret = kvm_s390_mask_adapter(dev->kvm, req.id, req.mask);
+		if (ret > 0)
+			ret = 0;
+		break;
+	case KVM_S390_IO_ADAPTER_MAP:
+		ret = kvm_s390_adapter_map(dev->kvm, req.id, req.addr);
+		break;
+	case KVM_S390_IO_ADAPTER_UNMAP:
+		ret = kvm_s390_adapter_unmap(dev->kvm, req.id, req.addr);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = 0;
@@ -1082,6 +1235,12 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		kvm_for_each_vcpu(i, vcpu, dev->kvm)
 			kvm_clear_async_pf_completion_queue(vcpu);
 		break;
+	case KVM_DEV_FLIC_ADAPTER_REGISTER:
+		r = register_io_adapter(dev, attr);
+		break;
+	case KVM_DEV_FLIC_ADAPTER_MODIFY:
+		r = modify_io_adapter(dev, attr);
+		break;
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9f1e99f..2e6fbb0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -343,6 +343,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	debug_unregister(kvm->arch.dbf);
 	if (!kvm_is_ucontrol(kvm))
 		gmap_free(kvm->arch.gmap);
+	kvm_s390_destroy_adapters(kvm);
 }
 
 /* Section: vcpu related */
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index ed4750a..5502cc95 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -136,6 +136,7 @@ int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid);
+int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked);
 
 /* implemented in priv.c */
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
@@ -162,5 +163,6 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 /* implemented in interrupt.c */
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
+void kvm_s390_destroy_adapters(struct kvm *kvm);
 
 #endif
-- 
1.7.9.5
