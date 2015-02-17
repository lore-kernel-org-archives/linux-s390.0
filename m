From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 09/15] cpu-model/s390: Add KVM VM attribute interface routines
Date: Tue, 17 Feb 2015 15:24:07 +0100
Message-ID: <1424183053-4310-10-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch implements routines to set and retrieve processor configuration
data and to retrieve machine configuration data. The machine related data
is used together with the cpu model facility lists to determine the list of
supported cpu models of this host. The above mentioned routines have QEMU
trace point instrumentation.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.h |  39 ++++++++++++++++++
 target-s390x/kvm.c        | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 trace-events              |   3 ++
 3 files changed, 144 insertions(+)

diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index 623a7b2..76b3456 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -45,6 +45,45 @@ typedef struct S390CPUAlias {
     char *model;
 } S390CPUAlias;
 
+typedef struct S390ProcessorProps {
+    uint64_t cpuid;
+    uint16_t ibc;
+    uint8_t  pad[6];
+    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
+} S390ProcessorProps;
+
+typedef struct S390MachineProps {
+    uint64_t cpuid;
+    uint32_t ibc_range;
+    uint8_t  pad[4];
+    uint64_t fac_list_mask[S390_ARCH_FAC_LIST_SIZE_UINT64];
+    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
+} S390MachineProps;
+
+#ifdef CONFIG_KVM
+int kvm_s390_get_processor_props(S390ProcessorProps *prop);
+int kvm_s390_set_processor_props(S390ProcessorProps *prop);
+bool kvm_s390_cpu_classes_initialized(void);
+bool kvm_s390_probe_mode(void);
+#else
+static inline int kvm_s390_get_processor_props(S390ProcessorProps *prob)
+{
+    return -ENOSYS;
+}
+static inline int kvm_s390_set_processor_props(S390ProcessorProps *prob)
+{
+    return -ENOSYS;
+}
+static inline bool kvm_s390_cpu_classes_initialized(void)
+{
+    return false;
+}
+static inline bool kvm_s390_probe_mode(void)
+{
+    return false;
+}
+#endif
+
 /*
  * bits 0-7   : CMOS generation
  * bits 8-9   : reserved
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 6f2d5b4..c518489 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -42,6 +42,7 @@
 #include "qapi-event.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "cpu-models.h"
 
 /* #define DEBUG_KVM */
 
@@ -117,6 +118,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static int cap_sync_regs;
 static int cap_async_pf;
+static bool cpu_classes_initialized;
 
 static void *legacy_s390_alloc(size_t size, uint64_t *align);
 
@@ -172,6 +174,68 @@ static void kvm_s390_enable_cmma(KVMState *s)
     trace_kvm_enable_cmma(rc);
 }
 
+static int cpu_model_get(KVMState *s, uint64_t attr, uint64_t addr)
+{
+    struct kvm_device_attr dev_attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = attr,
+        .addr = addr,
+    };
+
+    return kvm_vm_ioctl(s, KVM_GET_DEVICE_ATTR, &dev_attr);
+}
+
+static int cpu_model_set(KVMState *s, uint64_t attr, uint64_t addr)
+{
+    struct kvm_device_attr dev_attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = attr,
+        .addr = addr,
+    };
+
+    return kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &dev_attr);
+}
+
+static int has_cpu_model_call(KVMState *s, uint64_t attr)
+{
+    int rc;
+    struct kvm_device_attr dev_attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = attr,
+    };
+
+    if (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) == 0) {
+        return -ENOSYS;
+    }
+
+    rc = kvm_vm_ioctl(s, KVM_HAS_DEVICE_ATTR, &dev_attr);
+    if (rc == 0) {
+        return 0;
+    }
+    return -EFAULT;
+}
+
+static int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
+{
+    int rc;
+
+    rc = has_cpu_model_call(s, KVM_S390_VM_CPU_MACHINE);
+    if (!rc) {
+        rc = cpu_model_get(s, KVM_S390_VM_CPU_MACHINE, (uint64_t) prop);
+    }
+    trace_kvm_get_machine_props(rc, prop->cpuid, prop->ibc_range);
+    return rc;
+}
+
+static void kvm_s390_setup_cpu_classes(KVMState *s)
+{
+    S390MachineProps mach;
+
+    if (!kvm_s390_get_machine_props(s, &mach)) {
+        cpu_classes_initialized = false;
+    }
+}
+
 int kvm_arch_init(KVMState *s)
 {
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
@@ -185,6 +249,8 @@ int kvm_arch_init(KVMState *s)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
         phys_mem_set_alloc(legacy_s390_alloc);
     }
+
+    kvm_s390_setup_cpu_classes(s);
     return 0;
 }
 
@@ -1570,3 +1636,39 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
     return 0;
 }
+
+int kvm_s390_get_processor_props(S390ProcessorProps *prop)
+{
+    int rc;
+
+    rc = has_cpu_model_call(kvm_state, KVM_S390_VM_CPU_PROCESSOR);
+    if (!rc) {
+        rc = cpu_model_get(kvm_state,
+                           KVM_S390_VM_CPU_PROCESSOR, (uint64_t) prop);
+    }
+    trace_kvm_get_processor_props(rc, prop->cpuid, prop->ibc);
+    return rc;
+}
+
+int kvm_s390_set_processor_props(S390ProcessorProps *prop)
+{
+    int rc;
+
+    rc = has_cpu_model_call(kvm_state, KVM_S390_VM_CPU_PROCESSOR);
+    if (!rc) {
+        rc = cpu_model_set(kvm_state,
+                           KVM_S390_VM_CPU_PROCESSOR, (uint64_t) prop);
+    }
+    trace_kvm_set_processor_props(rc);
+    return rc;
+}
+
+bool kvm_s390_cpu_classes_initialized(void)
+{
+    return cpu_classes_initialized;
+}
+
+bool kvm_s390_probe_mode(void)
+{
+    return kvm_probe_mode_enabled();
+}
diff --git a/trace-events b/trace-events
index f87b077..f39f879 100644
--- a/trace-events
+++ b/trace-events
@@ -1577,6 +1577,9 @@ mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
+kvm_get_machine_props(int rc, uint64_t cpuid, uint16_t ibc) "CPU-MODEL: fetching machine properties rc=%d cpuid=0x%"PRIx64" ibc=0x%"PRIx16
+kvm_get_processor_props(int rc, uint64_t cpuid, uint32_t ibc_range) "CPU-MODEL: fetching processor properties rc=%d cpuid=0x%"PRIx64" ibc_range=0x%"PRIx32
+kvm_set_processor_props(int rc) "CPU-MODEL: requesting processor properties rc=%d"
 
 # hw/dma/i8257.c
 i8257_unregistered_dma(int nchan, int dma_pos, int dma_len) "unregistered DMA channel used nchan=%d dma_pos=%d dma_len=%d"
-- 
1.8.3.1
