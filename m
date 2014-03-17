From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 1/5] linux-headers: add new interfaces
Date: Mon, 17 Mar 2014 19:11:57 +0100
Message-ID: <1395079921-29325-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Per-vm capability enablement, adapter interrupt sources, irq routing on s390.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/asm-s390/kvm.h |   24 ++++++++++++++++++++++++
 linux-headers/linux/kvm.h    |   17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index cb4c1eb..c003c6a 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
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
@@ -76,4 +98,6 @@ struct kvm_sync_regs {
 #define KVM_REG_S390_PFTOKEN	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x5)
 #define KVM_REG_S390_PFCOMPARE	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x6)
 #define KVM_REG_S390_PFSELECT	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x7)
+#define KVM_REG_S390_PP		(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x8)
+#define KVM_REG_S390_GBEA	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x9)
 #endif
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index e27a4b3..b278ab3 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -740,6 +740,9 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_SPAPR_MULTITCE 94
 #define KVM_CAP_EXT_EMUL_CPUID 95
 #define KVM_CAP_HYPERV_TIME 96
+#define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
+#define KVM_CAP_ENABLE_CAP_VM 98
+#define KVM_CAP_S390_IRQCHIP 99
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -755,9 +758,18 @@ struct kvm_irq_routing_msi {
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
@@ -767,6 +779,7 @@ struct kvm_irq_routing_entry {
 	union {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
+		struct kvm_irq_routing_s390_adapter adapter;
 		__u32 pad[8];
 	} u;
 };
@@ -1075,6 +1088,10 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_DEBUGREGS */
 #define KVM_GET_DEBUGREGS         _IOR(KVMIO,  0xa1, struct kvm_debugregs)
 #define KVM_SET_DEBUGREGS         _IOW(KVMIO,  0xa2, struct kvm_debugregs)
+/*
+ * vcpu version available with KVM_ENABLE_CAP
+ * vm version available with KVM_CAP_ENABLE_CAP_VM
+ */
 #define KVM_ENABLE_CAP            _IOW(KVMIO,  0xa3, struct kvm_enable_cap)
 /* Available with KVM_CAP_XSAVE */
 #define KVM_GET_XSAVE		  _IOR(KVMIO,  0xa4, struct kvm_xsave)
-- 
1.7.9.5
