From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 11/15] cpu-model/s390: Add QMP command
	query-cpu-model
Date: Tue, 17 Feb 2015 15:24:09 +0100
Message-ID: <1424183053-4310-12-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Mueller <mimu@linux.vnet.ibm.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This patch implements a new QMP request named 'query-cpu-model'.
It returns the cpu model of cpu 0 and its backing accelerator.

request:
  {"execute" : "query-cpu-model" }

answer:
  {"return" : {"name": "2827-ga2", "accelerator": "kvm" }}

Alias names are resolved to their respective machine type and GA names
already during cpu instantiation. Thus, also a cpu model like 'host'
which is implemented as alias will return its normalized cpu model name.

Furthermore the patch implements the following functions:

- s390_cpu_typename(), returns the currently selected cpu type name or NULL
- s390_cpu_models_used(), returns true if S390 cpu models are in use

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 include/sysemu/arch_init.h |  1 +
 qapi-schema.json           | 23 +++++++++++++++++++++++
 qmp-commands.hx            |  6 ++++++
 qmp.c                      |  5 +++++
 stubs/Makefile.objs        |  1 +
 stubs/arch-query-cpu-mod.c |  9 +++++++++
 target-s390x/cpu-models.c  | 25 +++++++++++++++++++++++++
 target-s390x/cpu-models.h  |  2 ++
 target-s390x/cpu.c         | 32 ++++++++++++++++++++++++++++++++
 9 files changed, 104 insertions(+)
 create mode 100644 stubs/arch-query-cpu-mod.c

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 54b36c1..86344a2 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -37,5 +37,6 @@ int kvm_available(void);
 int xen_available(void);
 
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
+CpuModelInfo *arch_query_cpu_model(Error **errp);
 
 #endif
diff --git a/qapi-schema.json b/qapi-schema.json
index 4d237c8..9431fc2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2507,6 +2507,29 @@
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
 
+##
+# @CpuModelInfo:
+#
+# Virtual CPU model definition.
+#
+# @name: the name of the CPU model definition
+#
+# Since: 2.3.0
+##
+{ 'type': 'CpuModelInfo',
+  'data': { 'name': 'str', '*accelerator': 'AccelId' } }
+
+##
+# @query-cpu-model:
+#
+# Return to current virtual CPU model
+#
+# Returns: CpuModelInfo
+#
+# Since: 2.3.0
+##
+{ 'command': 'query-cpu-model', 'returns': 'CpuModelInfo' }
+
 # @AddfdInfo:
 #
 # Information about a file descriptor that was added to an fd set.
diff --git a/qmp-commands.hx b/qmp-commands.hx
index a85d847..98bfedd 100644
--- a/qmp-commands.hx
+++ b/qmp-commands.hx
@@ -3392,6 +3392,12 @@ EQMP
     },
 
     {
+        .name       = "query-cpu-model",
+        .args_type  = "",
+        .mhandler.cmd_new = qmp_marshal_input_query_cpu_model,
+    },
+
+    {
         .name       = "query-target",
         .args_type  = "",
         .mhandler.cmd_new = qmp_marshal_input_query_target,
diff --git a/qmp.c b/qmp.c
index 6b2c4be..d32abbc 100644
--- a/qmp.c
+++ b/qmp.c
@@ -568,6 +568,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return arch_query_cpu_definitions(errp);
 }
 
+CpuModelInfo *qmp_query_cpu_model(Error **errp)
+{
+    return arch_query_cpu_model(errp);
+}
+
 void qmp_add_client(const char *protocol, const char *fdname,
                     bool has_skipauth, bool skipauth, bool has_tls, bool tls,
                     Error **errp)
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index fd7a489..45daa92 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,4 +1,5 @@
 stub-obj-y += arch-query-cpu-def.o
+stub-obj-y += arch-query-cpu-mod.o
 stub-obj-y += bdrv-commit-all.o
 stub-obj-y += chr-baum-init.o
 stub-obj-y += chr-msmouse.o
diff --git a/stubs/arch-query-cpu-mod.c b/stubs/arch-query-cpu-mod.c
new file mode 100644
index 0000000..90ebd08
--- /dev/null
+++ b/stubs/arch-query-cpu-mod.c
@@ -0,0 +1,9 @@
+#include "qemu-common.h"
+#include "sysemu/arch_init.h"
+#include "qapi/qmp/qerror.h"
+
+CpuModelInfo *arch_query_cpu_model(Error **errp)
+{
+    error_set(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 9f40998..4d03adc 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -110,6 +110,7 @@ typedef struct ParmAddrAddrAccel {
 } ParmAddrAddrAccel;
 
 static GSList *s390_cpu_aliases;
+static const char *selected_cpu_typename;
 
 /* compare order of two cpu classes for ascending sort */
 gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b)
@@ -631,3 +632,27 @@ bool s390_probe_mode(void)
     return false;
 }
 
+/**
+ * s390_cpu_typename - get name of selected cpu class type
+ *
+ * Returns: address to name of selected cpu class type
+ *          NULL if no cpu class type has been selected yet
+ */
+const char *s390_cpu_typename(void)
+{
+    return selected_cpu_typename;
+}
+
+/**
+ * s390_cpu_models_used - indicates that cpus with model properties
+ *                        are in use
+ *
+ * Returns: true  if a cpu model type name has been selected
+ *          false if either no cpu class type was selected yet or the
+ *                selected type is TYPE_S390_CPU
+ */
+bool s390_cpu_models_used(void)
+{
+    return s390_cpu_typename() && strcmp(s390_cpu_typename(), TYPE_S390_CPU);
+}
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index be94667..23ac2c4 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -110,6 +110,8 @@ void s390_cpu_list_entry(gpointer data, gpointer user_data);
 bool s390_cpu_classes_initialized(void);
 bool s390_test_facility(S390CPUClass *cc, unsigned long nr);
 bool s390_probe_mode(void);
+const char *s390_cpu_typename(void);
+bool s390_cpu_models_used(void);
 
 /*
  * bits 0-7   : CMOS generation
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index d27832b..d98578b 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -37,6 +37,11 @@
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
+static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
+{
+    return g_strdup_printf("%04x-ga%u", cc->proc->type, cc->mach->ga);
+}
+
 /* generate CPU information for cpu -? */
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
@@ -74,6 +79,33 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
 
     return entry;
 }
+
+CpuModelInfo *arch_query_cpu_model(Error **errp)
+{
+    CpuModelInfo *info;
+    S390CPUClass *cc;
+
+    if (!s390_cpu_models_used()) {
+        return NULL;
+    }
+    info = g_try_new0(CpuModelInfo, 1);
+    if (!info) {
+        return NULL;
+    }
+    cc = S390_CPU_CLASS(object_class_by_name(s390_cpu_typename()));
+    info->name = strdup_s390_cpu_name(cc);
+    if (!info->name) {
+        g_free(info);
+        return NULL;
+    }
+    info->accelerator = ACCEL_ID_MAX;
+    if (kvm_enabled()) {
+        info->accelerator = ACCEL_ID_KVM;
+    }
+    info->has_accelerator = (info->accelerator != ACCEL_ID_MAX);
+
+    return info;
+}
 #endif
 
 static void s390_cpu_set_pc(CPUState *cs, vaddr value)
-- 
1.8.3.1
