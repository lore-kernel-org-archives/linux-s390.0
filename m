From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 13/15] target-s390x: Extend QMP command query-cpu-definitions
Date: Mon, 30 Mar 2015 16:28:26 +0200
Message-ID: <1427725708-52100-14-git-send-email-mimu@linux.vnet.ibm.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the QMP command 'query-cpu-definitions' in the S390
context. The command returns a list of cpu model names in the current host
context. A consumer may successfully request each listed cpu model as long
for a given accelerator and machine this model is runnable.

request:
  {"execute": "query-cpu-definitions",
              "arguments": { "accel": "kvm",
                             "machine": "s390-ccw-virtio" }
  }

answer:
  {"return": [ {"name":"2964-ga1","runnable":false,"is-default":false},
               {"name":"2828-ga1","runnable":true,"is-default":false},
               {"name":"2827-ga2","runnable":true,"is-default":true},
               {"name":"2827-ga1","runnable":true,"is-default":false},
               ...
               {"name":"2064-ga1","runnable":true,"is-default":false} ]
  }

The request arguments are optional and if omitted only the cpu model names
are returned without the runnable or is-default attributes.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c |  15 ++++++
 target-s390x/cpu-models.h |   7 +++
 target-s390x/cpu.c        | 114 +++++++++++++++++++++++++++++++++++++++++++---
 target-s390x/kvm.c        |  49 +++++++++++++++++++-
 4 files changed, 177 insertions(+), 8 deletions(-)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 187d110..aba44dd 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -215,6 +215,21 @@ int set_s390_cpu_alias(const char *name, const char *model)
     return 0;
 }
 
+/* compare order of two cpu classes for descending sort */
+gint s390_cpu_class_desc_order_compare(gconstpointer a, gconstpointer b)
+{
+    S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *) a);
+    S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *) b);
+
+    if (cc_a->mach.order < cc_b->mach.order) {
+        return 1;
+    }
+    if (cc_a->mach.order > cc_b->mach.order) {
+        return -1;
+    }
+    return 0;
+}
+
 /* return machine class for specific machine type */
 static void s390_machine_class_test_cpu_class(gpointer data, gpointer user_data)
 {
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index 67f0519..4734c58 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -85,10 +85,16 @@ typedef struct S390MachineProps {
 } S390MachineProps;
 
 #ifdef CONFIG_KVM
+int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop);
 int kvm_s390_get_processor_props(S390ProcessorProps *prop);
 int kvm_s390_set_processor_props(S390ProcessorProps *prop);
 bool kvm_s390_cpu_classes_initialized(void);
 #else
+static inline int kvm_s390_get_machine_props(KVMState *s,
+                                             S390MachineProps *prop)
+{
+    return -ENOSYS;
+}
 static inline int kvm_s390_get_processor_props(S390ProcessorProps *prop)
 {
     return -ENOSYS;
@@ -107,6 +113,7 @@ void s390_setup_cpu_classes(S390AccelMode mode, S390MachineProps *prop,
                             uint64_t *fac_list_mask);
 void s390_setup_cpu_aliases(void);
 gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
+gint s390_cpu_class_desc_order_compare(gconstpointer a, gconstpointer b);
 void s390_cpu_list_entry(gpointer data, gpointer user_data);
 bool s390_cpu_classes_initialized(void);
 uint64_t *s390_fac_list_mask_by_machine(const char *name);
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 615173f..0ccacb7 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -30,13 +30,21 @@
 #include "hw/hw.h"
 #include "trace.h"
 #include "cpu-models.h"
+#include "sysemu/accel.h"
+#include "qapi/qmp/qerror.h"
 #ifndef CONFIG_USER_ONLY
+#include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #endif
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
+typedef struct CpuDefParm {
+    CpuDefinitionInfoList *list;
+    bool showFullEntry;
+} CpuDefParm;
+
 static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
 {
     return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
@@ -66,22 +74,114 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 }
 
 #ifndef CONFIG_USER_ONLY
+static CpuDefinitionInfoList *qmp_query_cpu_definition_host(void)
+{
+    CpuDefinitionInfoList *host = NULL;
+    CpuDefinitionInfo *info;
+
+    info = g_try_new0(CpuDefinitionInfo, 1);
+    if (!info) {
+        goto out;
+    }
+    info->name = g_strdup("host");
+
+    host = g_try_new0(CpuDefinitionInfoList, 1);
+    if (!host) {
+        g_free(info->name);
+        g_free(info);
+        goto out;
+    }
+    host->value = info;
+out:
+    return host;
+}
+
+static void qmp_query_cpu_definition_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = (ObjectClass *) data;
+    S390CPUClass *cc = S390_CPU_CLASS(oc);
+    CpuDefinitionInfoList *entry;
+    CpuDefinitionInfo *info;
+    CpuDefParm *parm = user_data;
+
+    if (!strcmp(object_class_get_name(oc), TYPE_S390_CPU)) {
+        return;
+    }
+    info = g_try_new0(CpuDefinitionInfo, 1);
+    if (!info) {
+        goto out;
+    }
+    info->name = strdup_s390_cpu_name(cc);
+    if (parm->showFullEntry) {
+        info->runnable = cc->is_active[ACCEL_TEMP];
+        info->has_runnable = true;
+        info->is_default = cc->is_host[ACCEL_TEMP];
+        info->has_is_default = true;
+    }
+
+    entry = g_try_new0(CpuDefinitionInfoList, 1);
+    if (!entry) {
+        goto out;
+    }
+    entry->value = info;
+    entry->next = parm->list;
+    parm->list = entry;
+    return;
+out:
+    if (info) {
+        g_free(info->name);
+        g_free(info);
+    }
+}
+
 CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
                                                   const char *machine,
                                                   bool has_accel,
                                                   AccelId accel,
                                                   Error **errp)
 {
-    CpuDefinitionInfoList *entry;
-    CpuDefinitionInfo *info;
+    S390MachineProps mach;
+    GSList *classes;
+    uint64_t *mask;
+    CpuDefParm parm = {
+        .list = NULL,
+        .showFullEntry = false,
+    };
 
-    info = g_malloc0(sizeof(*info));
-    info->name = g_strdup("host");
+    if (!s390_cpu_models_used()) {
+        return qmp_query_cpu_definition_host();
+    }
 
-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
+    if (!has_accel || !has_machine) {
+        goto out;
+    }
+
+    switch (accel) {
+    case ACCEL_ID_KVM:
+        if (kvm_s390_get_machine_props(NULL, &mach) < 0) {
+            return qmp_query_cpu_definition_host();
+        }
+        break;
+    default:
+        goto out_empty;
+    }
+
+    mask = s390_fac_list_mask_by_machine(machine);
+    if (!mask) {
+        error_set(errp, QERR_INVALID_PARAMETER_VALUE, "machine",
+                  "a valid machine type");
+        goto out_empty;
+    }
 
-    return entry;
+    s390_setup_cpu_classes(ACCEL_TEMP, &mach, mask);
+    parm.showFullEntry = true;
+out:
+    classes = object_class_get_list(TYPE_S390_CPU, false);
+    classes = g_slist_sort(classes, s390_cpu_class_asc_order_compare);
+    g_slist_foreach(classes, qmp_query_cpu_definition_entry, &parm);
+    g_slist_free(classes);
+out_empty:
+    return parm.list;
 }
 
 CpuModelInfo *arch_query_cpu_model(Error **errp)
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 9b2cfeb..f40e879 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -276,12 +276,59 @@ static int cpu_model_set(KVMState *s, uint64_t attr, uint64_t addr)
     return rc;
 }
 
-static int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
+static int get_machine_props_fallback(S390MachineProps *prop)
+{
+    struct kvm_device_attr dev_attr;
+    int rc, kvmfd = -1, vmfd = -1;
+
+    rc  = qemu_open("/dev/kvm", O_RDWR);
+    if (rc < 0) {
+        goto out_err;
+    }
+    kvmfd = rc;
+
+    rc = ioctl(kvmfd, KVM_CREATE_VM, 0);
+    if (rc < 0) {
+        goto out_err;
+    }
+    vmfd = rc;
+
+    rc = ioctl(vmfd, KVM_CHECK_EXTENSION, KVM_CAP_VM_ATTRIBUTES);
+    if (rc < 0) {
+        rc = -ENOSYS;
+        goto out_err;
+    }
+
+    dev_attr.group = KVM_S390_VM_CPU_MODEL;
+    dev_attr.attr = KVM_S390_VM_CPU_MACHINE;
+    rc = ioctl(vmfd, KVM_HAS_DEVICE_ATTR, &dev_attr);
+    if (rc < 0) {
+        rc = -EFAULT;
+        goto out_err;
+    }
+
+    dev_attr.addr = (uint64_t) prop;
+    rc = ioctl(vmfd, KVM_GET_DEVICE_ATTR, &dev_attr);
+
+out_err:
+    if (vmfd >= 0) {
+        close(vmfd);
+    }
+    if (kvmfd >= 0) {
+        close(kvmfd);
+    }
+
+    return rc;
+}
+
+int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
 {
     int rc = -EFAULT;
 
     if (s) {
         rc = cpu_model_get(s, KVM_S390_VM_CPU_MACHINE, (uint64_t) prop);
+    } else {
+        rc = get_machine_props_fallback(prop);
     }
     trace_kvm_get_machine_props(rc, prop->cpuid, prop->ibc_range);
 
-- 
1.8.3.1
