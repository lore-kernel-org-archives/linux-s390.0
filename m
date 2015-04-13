From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 11/17] target-s390x: Add KVM VM attribute interface for S390 CPU models
Date: Mon, 13 Apr 2015 15:56:30 +0200
Message-ID: <1428933396-37887-12-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch implements routines to set and retrieve processor configuration
data and to retrieve machine configuration data. The machine related data
is used together with the CPU model facility lists to determine the list of
supported CPU models of this host. The above mentioned routines have QEMU
trace point instrumentation.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.h | 36 ++++++++++++++++++++-
 target-s390x/kvm.c        | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 trace-events              |  3 ++
 3 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index 35dde5a..efa255e 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -43,11 +43,45 @@ typedef struct S390CPUAlias {
     char *model;
 } S390CPUAlias;
 
-extern GSList *s390_cpu_aliases;
+typedef struct S390ProcessorProps {
+    uint64_t cpuid;
+    uint16_t ibc;
+    uint8_t  pad[6];
+    uint64_t fac_list[FAC_LIST_ARCH_S390_SIZE_UINT64];
+} S390ProcessorProps;
+
+typedef struct S390MachineProps {
+    uint64_t cpuid;
+    uint32_t ibc;
+    uint8_t  pad[4];
+    uint64_t fac_mask[FAC_LIST_ARCH_S390_SIZE_UINT64];
+    uint64_t fac_list[FAC_LIST_ARCH_S390_SIZE_UINT64];
+} S390MachineProps;
 
 ObjectClass *s390_cpu_class_by_name(const char *name);
 int set_s390_cpu_alias(const char *name, const char *model);
 
+#ifdef CONFIG_KVM
+int kvm_s390_get_processor_props(S390ProcessorProps *prop);
+int kvm_s390_set_processor_props(S390ProcessorProps *prop);
+bool kvm_s390_cpu_classes_initialized(void);
+#else
+static inline int kvm_s390_get_processor_props(S390ProcessorProps *prop)
+{
+    return -ENOSYS;
+}
+static inline int kvm_s390_set_processor_props(S390ProcessorProps *prop)
+{
+    return -ENOSYS;
+}
+static inline bool kvm_s390_cpu_classes_initialized(void)
+{
+    return false;
+}
+#endif
+
+extern GSList *s390_cpu_aliases;
+
 /*
  * bits 0-7   : CMOS generation
  * bits 8-9   : reserved
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index b48c643..42f01a8 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -44,6 +44,7 @@
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "cpu-models.h"
 
 /* #define DEBUG_KVM */
 
@@ -122,6 +123,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static int cap_sync_regs;
 static int cap_async_pf;
+static bool cpu_classes_initialized;
 
 static void *legacy_s390_alloc(size_t size, uint64_t *align);
 
@@ -242,6 +244,59 @@ static void kvm_s390_init_crypto(void)
     kvm_s390_init_dea_kw();
 }
 
+static int cpu_model_get(KVMState *s, uint64_t attr, uint64_t addr)
+{
+    int rc = -ENOSYS;
+    struct kvm_device_attr dev_attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = attr,
+        .addr = addr,
+    };
+
+    if (kvm_vm_check_attr(s, dev_attr.group, dev_attr.attr)) {
+        rc = kvm_vm_ioctl(s, KVM_GET_DEVICE_ATTR, &dev_attr);
+    }
+
+    return rc;
+}
+
+static int cpu_model_set(KVMState *s, uint64_t attr, uint64_t addr)
+{
+    int rc = -ENOSYS;
+    struct kvm_device_attr dev_attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = attr,
+        .addr = addr,
+    };
+
+    if (kvm_vm_check_attr(s, dev_attr.group, dev_attr.attr)) {
+        rc = kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &dev_attr);
+    }
+
+    return rc;
+}
+
+static int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
+{
+    int rc = -EFAULT;
+
+    if (s) {
+        rc = cpu_model_get(s, KVM_S390_VM_CPU_MACHINE, (uint64_t) prop);
+    }
+    trace_kvm_get_machine_props(rc, prop->cpuid, prop->ibc);
+
+    return rc;
+}
+
+static void kvm_setup_cpu_classes(KVMState *s)
+{
+    S390MachineProps mach;
+
+    if (!kvm_s390_get_machine_props(s, &mach)) {
+        cpu_classes_initialized = false;
+    }
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
@@ -255,6 +310,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     kvm_vm_enable_cap(s, KVM_CAP_S390_USER_SIGP, 0);
+    kvm_setup_cpu_classes(s);
 
     return 0;
 }
@@ -1940,3 +1996,26 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
     return 0;
 }
+
+int kvm_s390_get_processor_props(S390ProcessorProps *prop)
+{
+    int rc;
+
+    rc = cpu_model_get(kvm_state, KVM_S390_VM_CPU_PROCESSOR, (uint64_t) prop);
+    trace_kvm_get_processor_props(rc, prop->cpuid, prop->ibc);
+    return rc;
+}
+
+int kvm_s390_set_processor_props(S390ProcessorProps *prop)
+{
+    int rc;
+
+    rc = cpu_model_set(kvm_state, KVM_S390_VM_CPU_PROCESSOR, (uint64_t) prop);
+    trace_kvm_set_processor_props(rc);
+    return rc;
+}
+
+bool kvm_s390_cpu_classes_initialized(void)
+{
+    return cpu_classes_initialized;
+}
diff --git a/trace-events b/trace-events
index 30eba92..2f1d734 100644
--- a/trace-events
+++ b/trace-events
@@ -1582,6 +1582,9 @@ kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
 kvm_sigp_finished(uint8_t order, int cpu_index, int dst_index, int cc) "SIGP: Finished order %u on cpu %d -> cpu %d with cc=%d"
+kvm_get_machine_props(int rc, uint64_t cpuid, uint16_t ibc) "CPU-MODEL: fetching machine properties rc=%d cpuid=0x%"PRIx64" ibc=0x%"PRIx16
+kvm_get_processor_props(int rc, uint64_t cpuid, uint32_t ibc_range) "CPU-MODEL: fetching processor properties rc=%d cpuid=0x%"PRIx64" ibc_range=0x%"PRIx32
+kvm_set_processor_props(int rc) "CPU-MODEL: requesting processor properties rc=%d"
 
 # hw/dma/i8257.c
 i8257_unregistered_dma(int nchan, int dma_pos, int dma_len) "unregistered DMA channel used nchan=%d dma_pos=%d dma_len=%d"
-- 
1.8.3.1
