From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 15/17] target-s390x: Extend arch specific QMP command query-cpu-definitions
Date: Mon, 13 Apr 2015 15:56:34 +0200
Message-ID: <1428933396-37887-16-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the QMP command 'query-cpu-definitions' in the S390
context. The command returns a list of cpu definitions in the current host
context. A runnable and migratable cpu model has the related attributes
set to true. The order attribute is used to bring the listed cpu definitions
in a release order.

request:
  {"execute": "query-cpu-definitions",
              "arguments": { "accel": "kvm",
                             "machine": "s390-ccw-virtio" }
  }

answer:
  {"return": [ { "order": 3345, "name": "2964-ga1",
                 "live-migration-safe": true },
               { "name": "zBC12", "runnable": true },
               { "name": "2828", "runnable": true },
               ...
               { "name": "host", "runnable": true },
               ...
               { "order": 3090, "name": "2827-ga2", "runnable": true,
                 "live-migration-safe": true, "is-default": true },
               ...
               { "name": "none", "runnable": true } ]
  }

The request arguments are optional and if omitted lead to different answers.
Eventually only the CPU model none gets returned as runnable and as default

               ...
               { "name": "none", "runnable": true, "is-default": true }

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c |  15 ++++++
 target-s390x/cpu-models.h |   7 +++
 target-s390x/cpu.c        | 126 +++++++++++++++++++++++++++++++++++++++++++---
 target-s390x/kvm.c        |  49 +++++++++++++++++-
 4 files changed, 189 insertions(+), 8 deletions(-)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index fa74a8a..b696897 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -208,6 +208,21 @@ int set_s390_cpu_alias(const char *name, const char *model)
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
index c24550b..76673f4 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -87,6 +87,7 @@ void s390_setup_cpu_classes(S390AccelMode mode, S390MachineProps *prop,
                             uint64_t *fac_list_mask);
 void s390_setup_cpu_aliases(void);
 gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
+gint s390_cpu_class_desc_order_compare(gconstpointer a, gconstpointer b);
 void s390_cpu_list_entry(gpointer data, gpointer user_data);
 bool s390_cpu_classes_initialized(void);
 uint64_t *s390_fac_list_mask_by_machine(const char *name);
@@ -94,10 +95,16 @@ uint64_t *s390_current_fac_list_mask(void);
 void s390_cpu_model_init(S390CPUClass *cc);
 
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
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 771acbd..a006b93 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -30,7 +30,10 @@
 #include "hw/hw.h"
 #include "trace.h"
 #include "cpu-models.h"
+#include "sysemu/accel.h"
+#include "qapi/qmp/qerror.h"
 #ifndef CONFIG_USER_ONLY
+#include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #endif
 
@@ -61,22 +64,131 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
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
+    CpuDefinitionInfoList *entry, **list = user_data;
+    CpuDefinitionInfo *info;
+    GSList *item;
+    S390CPUAlias *alias;
+    ObjectClass *alias_oc;
+
+    info = g_try_new0(CpuDefinitionInfo, 1);
+    if (!info) {
+        goto out;
+    }
+    info->name = strdup_cpu_name(cc);
+    info->runnable = cc->is_active[ACCEL_TEMP];
+    info->has_runnable = info->runnable;
+    info->is_default = cc->is_host[ACCEL_TEMP];
+    info->has_is_default = info->is_default;
+    info->live_migration_safe = cc->is_migration_safe;
+    info->has_live_migration_safe = info->live_migration_safe;
+    info->order = cc->mach.order;
+    info->has_order = info->order != 0;
+
+    entry = g_try_new0(CpuDefinitionInfoList, 1);
+    if (!entry) {
+        goto out;
+    }
+    entry->value = info;
+    entry->next = *list;
+    *list = entry;
+
+    for (item = s390_cpu_aliases; item != NULL; item = item->next) {
+        alias = (S390CPUAlias *) item->data;
+        alias_oc = s390_cpu_class_by_name(alias->model);
+        if (alias_oc != oc) {
+            continue;
+        }
+
+        info = g_try_new0(CpuDefinitionInfo, 1);
+        if (!info) {
+            goto out;
+        }
+        info->name = g_strdup(alias->name);
+        info->runnable = cc->is_active[ACCEL_TEMP];
+        info->has_runnable = info->runnable;
+
+        entry = g_try_new0(CpuDefinitionInfoList, 1);
+        if (!entry) {
+            goto out;
+        }
+        entry->value = info;
+        entry->next = *list;
+        *list = entry;
+    }
+
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
+    uint64_t *mask = NULL;
+    CpuDefinitionInfoList *list = NULL;
+
+    if (has_machine) {
+        mask = s390_fac_list_mask_by_machine(machine);
+        if (!mask) {
+            error_set(errp, QERR_INVALID_PARAMETER_VALUE, "machine",
+                      "a valid machine type");
+            return NULL;
+        }
+    }
 
-    info = g_malloc0(sizeof(*info));
-    info->name = g_strdup("host");
+    memset(&mach, 0, sizeof(mach));
+    if (has_accel) {
+        switch (accel) {
+        case ACCEL_ID_KVM:
+            kvm_s390_get_machine_props(NULL, &mach);
+            break;
+        default:
+            return qmp_query_cpu_definition_host();
+        }
+    }
 
-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
+    s390_setup_cpu_classes(ACCEL_TEMP, &mach, mask);
+
+    classes = object_class_get_list(TYPE_S390_CPU, false);
+    classes = g_slist_sort(classes, s390_cpu_class_asc_order_compare);
+    g_slist_foreach(classes, qmp_query_cpu_definition_entry, &list);
+    g_slist_free(classes);
 
-    return entry;
+    return list;
 }
 #endif
 
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 784ea8c..b7b1524 100644
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
     trace_kvm_get_machine_props(rc, prop->cpuid, prop->ibc);
 
-- 
1.8.3.1
