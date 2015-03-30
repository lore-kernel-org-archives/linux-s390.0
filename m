From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 11/15] target-s390x: New QMP command query-cpu-model
Date: Mon, 30 Mar 2015 16:28:24 +0200
Message-ID: <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements a new QMP request named 'query-cpu-model'.
It returns the cpu model of cpu 0 and its backing accelerator.

request:
  {"execute" : "query-cpu-model" }

answer:
  {"return" : {"name": "2827-ga2", "accel": "kvm" }}

Alias names are resolved to their respective machine type and GA names
already during cpu instantiation. Thus, also a cpu model like 'host'
which is implemented as alias will return its normalized cpu model name.

Furthermore the patch implements the following function:

- s390_cpu_models_used(), returns true if S390 cpu models are in use

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 include/sysemu/arch_init.h |  1 +
 qapi-schema.json           | 35 +++++++++++++++++++++++++++++++++++
 qmp-commands.hx            |  6 ++++++
 qmp.c                      |  5 +++++
 stubs/Makefile.objs        |  1 +
 stubs/arch-query-cpu-mod.c |  9 +++++++++
 target-s390x/cpu-models.c  | 14 ++++++++++++++
 target-s390x/cpu-models.h  |  1 +
 target-s390x/cpu.c         | 29 +++++++++++++++++++++++++++++
 9 files changed, 101 insertions(+)
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
index ac9594d..14d294f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2516,6 +2516,16 @@
 { 'command': 'query-machines', 'returns': ['MachineInfo'] }
 
 ##
+# @AccelId
+#
+# Defines accelerator ids
+#
+# Since: 2.4
+##
+{ 'enum': 'AccelId',
+  'data': ['qtest', 'tcg', 'kvm', 'xen'  ] }
+
+##
 # @CpuDefinitionInfo:
 #
 # Virtual CPU definition.
@@ -2538,6 +2548,31 @@
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
 
+##
+# @CpuModelInfo:
+#
+# Virtual CPU model definition.
+#
+# @name: the name of the CPU model definition
+#
+# @accel: AccelId (name) of this cpu models accelerator
+#
+# Since: 2.4
+##
+{ 'type': 'CpuModelInfo',
+  'data': { 'name': 'str', 'accel': 'AccelId' } }
+
+##
+# @query-cpu-model:
+#
+# Return the current virtual CPU model
+#
+# Returns: CpuModelInfo
+#
+# Since: 2.4
+##
+{ 'command': 'query-cpu-model', 'returns': 'CpuModelInfo' }
+
 # @AddfdInfo:
 #
 # Information about a file descriptor that was added to an fd set.
diff --git a/qmp-commands.hx b/qmp-commands.hx
index 3a42ad0..8fe577f 100644
--- a/qmp-commands.hx
+++ b/qmp-commands.hx
@@ -3417,6 +3417,12 @@ EQMP
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
index c479e77..ad63803 100644
--- a/qmp.c
+++ b/qmp.c
@@ -572,6 +572,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
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
index dce9cd2..ca70d5d 100644
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
index ba873ea..187d110 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -707,3 +707,17 @@ void s390_cpu_model_init(S390CPUClass *cc)
         }
     }
 }
+
+/**
+ * s390_cpu_models_used:
+ *
+ * This function indicates if cpus with model properties are in use.
+ *
+ * Returns: a boolean value.
+ *
+ * Since: 2.4
+ */
+bool s390_cpu_models_used(void)
+{
+    return cpu_models_used;
+}
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index fe3997f..67f0519 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -112,6 +112,7 @@ bool s390_cpu_classes_initialized(void);
 uint64_t *s390_fac_list_mask_by_machine(const char *name);
 uint64_t *s390_current_fac_list_mask(void);
 void s390_cpu_model_init(S390CPUClass *cc);
+bool s390_cpu_models_used(void);
 
 extern uint64_t qemu_s390_fac_list_mask[];
 
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 829945d..1698b52 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -37,6 +37,11 @@
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
+static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
+{
+    return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
+}
+
 /* generate CPU information for cpu -? */
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
@@ -74,6 +79,30 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
 
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
+    cc = S390_CPU_GET_CLASS(s390_cpu_addr2state(0));
+    info->name = strdup_s390_cpu_name(cc);
+    if (!info->name) {
+        g_free(info);
+        return NULL;
+    }
+    if (kvm_enabled()) {
+        info->accel = ACCEL_ID_KVM;
+    }
+    return info;
+}
 #endif
 
 static void s390_cpu_set_pc(CPUState *cs, vaddr value)
-- 
1.8.3.1
