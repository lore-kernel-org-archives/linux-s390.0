From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 14/16] target-s390x: Extend QMP command query-cpu-definitions
Date: Mon,  2 Mar 2015 13:44:06 +0100
Message-ID: <1425300248-40277-15-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the QMP command 'query-cpu-definitions' in the S390
context. The command returns a list of cpu model names in the current host
context. A consumer may successfully request each listed cpu model as long
for a given accelerator this model is runnable.

The QMP type AccelCpuModelInfo is introduced and the type CpuDefinitionInfo
is extended by the optional field 'accelerators'. It contains a list of named
accelerators and some indication whether the associated cpu model is runnable
or the default cpu model. The default cpu model is used if either no specific
cpu model is requested during QEMU startup or if the cpu model with name
'host' is requested.

request:
  {"execute": "query-cpu-definitions"}

answer:
  {"return":
    [{"name":"2964-ga1","accelerators":[{"name":"kvm","runnable":false,"default":false}]},
     {"name":"2828-ga1","accelerators":[{"name":"kvm","runnable":false,"default":false}]},
     {"name":"2827-ga2","accelerators":[{"name":"kvm","runnable":true,"default":true}]},
     {"name":"2827-ga1","accelerators":[{"name":"kvm","runnable":true,"default":false}]},
     {"name":"2818-ga1","accelerators":[{"name":"kvm","runnable":true,"default":false}]},
     ...
     {"name":"2064-ga1","accelerators":[{"runnable":true,"name":"kvm","default":false}]}
    ]
   }

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 qapi-schema.json          |  21 +++++++++-
 target-s390x/cpu-models.c |  15 +++++++
 target-s390x/cpu-models.h |   1 +
 target-s390x/cpu.c        | 100 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 130 insertions(+), 7 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index e9b213f..44863e5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2485,16 +2485,35 @@
   'data': ['qtest', 'tcg', 'kvm', 'xen'  ] }
 
 ##
+# @AccelCpuModelInfo:
+#
+# Accelerator specific CPU model data
+#
+# @name: the accelerator name
+#
+# @default: cpu model for 'host'
+#
+# @runnable: cpu model can be activated on hosting machine
+#
+# Since: 2.3
+#
+##
+{ 'type': 'AccelCpuModelInfo',
+  'data': { 'name': 'AccelId', 'default': 'bool', 'runnable': 'bool' } }
+
+##
 # @CpuDefinitionInfo:
 #
 # Virtual CPU definition.
 #
 # @name: the name of the CPU definition
 #
+# @accelerators: #optional cpu model offered per accelerator (since 2.3)
+#
 # Since: 1.2.0
 ##
 { 'type': 'CpuDefinitionInfo',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*accelerators': ['AccelCpuModelInfo'] } }
 
 ##
 # @query-cpu-definitions:
diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 116dbcc..7ad61df 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -211,6 +211,21 @@ int set_s390_cpu_alias(const char *name, const char *model)
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
index 51db298..3605aa4 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -110,6 +110,7 @@ static inline bool kvm_s390_probe_mode(void)
 
 int s390_setup_cpu_classes(AccelId accel, S390MachineProps *prop);
 gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
+gint s390_cpu_class_desc_order_compare(gconstpointer a, gconstpointer b);
 void s390_cpu_list_entry(gpointer data, gpointer user_data);
 bool s390_cpu_classes_initialized(void);
 bool s390_probe_mode(void);
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index cefaff1..6bf6554 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -66,18 +66,106 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 }
 
 #ifndef CONFIG_USER_ONLY
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+static AccelCpuModelInfoList *qmp_query_accel_entry(AccelId accel,
+                                                    S390CPUClass *cc,
+                                                    AccelCpuModelInfoList *prev)
+{
+    AccelCpuModelInfoList *list;
+    AccelCpuModelInfo *info;
+
+    info = g_try_new0(AccelCpuModelInfo, 1);
+    if (!info) {
+        goto out;
+    }
+    info->name = accel;
+    info->runnable = cc->is_active[accel];
+    info->q_default = cc->is_host[accel];
+    list = g_try_new0(AccelCpuModelInfoList, 1);
+    if (!list) {
+        goto out;
+    }
+    list->value = info;
+    list->next = prev;
+
+    return list;
+out:
+    g_free(info);
+    return prev;
+}
+
+static void qmp_query_cpu_definition_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = (ObjectClass *) data;
+    S390CPUClass *cc = S390_CPU_CLASS(oc);
+    CpuDefinitionInfoList *list, **prev = user_data;
+    CpuDefinitionInfo *info;
+
+    if (!strcmp(object_class_get_name(oc), TYPE_S390_CPU)) {
+        return;
+    }
+    info = g_try_new0(CpuDefinitionInfo, 1);
+    if (!info) {
+        goto out;
+    }
+    info->name = strdup_s390_cpu_name(cc);
+    if (kvm_enabled()) {
+        info->accelerators =
+            qmp_query_accel_entry(ACCEL_ID_KVM, cc, info->accelerators);
+    }
+    info->has_accelerators = (info->accelerators) ? true : false;
+    list = g_try_new0(CpuDefinitionInfoList, 1);
+    if (!list) {
+        goto out;
+    }
+    list->value = info;
+    list->next = *prev;
+    *prev = list;
+    return;
+out:
+    if (info) {
+        g_free(info->name);
+        g_free(info);
+    }
+}
+
+static CpuDefinitionInfoList *qmp_query_cpu_definition_host(void)
 {
-    CpuDefinitionInfoList *entry;
+    CpuDefinitionInfoList *host = NULL;
     CpuDefinitionInfo *info;
 
-    info = g_malloc0(sizeof(*info));
+    info = g_try_new0(CpuDefinitionInfo, 1);
+    if (!info) {
+        goto out;
+    }
     info->name = g_strdup("host");
 
-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
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
+CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+{
+    CpuDefinitionInfoList *list = NULL;
+    GSList *class_list;
+
+    if (!s390_probe_mode()) {
+        if (!s390_cpu_models_used()) {
+            return qmp_query_cpu_definition_host();
+        }
+    }
+    class_list = object_class_get_list(TYPE_S390_CPU, false);
+    class_list = g_slist_sort(class_list, s390_cpu_class_asc_order_compare);
+    g_slist_foreach(class_list, qmp_query_cpu_definition_entry, &list);
+    g_slist_free(class_list);
 
-    return entry;
+    return list;
 }
 
 CpuModelInfo *arch_query_cpu_model(Error **errp)
-- 
1.8.3.1
