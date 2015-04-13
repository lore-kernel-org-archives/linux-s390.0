From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 05/17] Add optional parameters to QMP
	command query-cpu-definitions
Date: Mon, 13 Apr 2015 15:56:24 +0200
Message-ID: <1428933396-37887-6-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch adds optional parameters to the QMP command query-cpu-definitions.
Thus the signature of routine arch_query_cpu_definitions needs to be changed
for the stub function and all target implementations:

target-arm
target-i386
target-ppc
target-s390

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 include/sysemu/arch_init.h  |  7 +++++--
 qapi-schema.json            | 28 +++++++++++++++++++++++++---
 qmp-commands.hx             |  2 +-
 qmp.c                       | 11 ++++++++---
 stubs/arch-query-cpu-def.c  |  6 +++++-
 target-arm/helper.c         |  6 +++++-
 target-i386/cpu.c           |  6 +++++-
 target-ppc/translate_init.c |  6 +++++-
 target-s390x/cpu.c          |  6 +++++-
 9 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 54b36c1..0d4bf51 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -36,6 +36,9 @@ void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
 
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
-
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp);
 #endif
diff --git a/qapi-schema.json b/qapi-schema.json
index 215a7bc..285b2d3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2536,21 +2536,43 @@
 #
 # @name: the name of the CPU definition
 #
+# @default: #optional true if cpu model is the default,
+#           omitted if false (since 2.4)
+#
+# @runnable: #optional true if cpu model is runnable,
+#            omitted if false (since 2.4)
+#
+# @live-migration-safe: #optional true if cpu model represents a
+#                       cpu model that is safely migratable
+#                       omitted if false (since 2.4)
+#
+# @order: #optional order criterion
+#
 # Since: 1.2.0
 ##
 { 'type': 'CpuDefinitionInfo',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*is-default': 'bool', '*runnable': 'bool',
+            '*live-migration-safe': 'bool', '*order': 'int' } }
 
 ##
 # @query-cpu-definitions:
 #
-# Return a list of supported virtual CPU definitions
+# Return a list of supported virtual CPU definitions. In context with the
+# optional parameters @machine and @accel the returned list contains
+# also information if the respective cpu definition is runnable or the
+# default to be used.
+#
+# @machine: #optional machine type (since 2.4)
+#
+# @accel: #optional accelerator id (since 2.4)
 #
 # Returns: a list of CpuDefInfo
 #
 # Since: 1.2.0
 ##
-{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
+{ 'command': 'query-cpu-definitions',
+  'data': { '*machine': 'str', '*accel': 'AccelId' },
+  'returns': ['CpuDefinitionInfo'] }
 
 # @AddfdInfo:
 #
diff --git a/qmp-commands.hx b/qmp-commands.hx
index 3a42ad0..6592e2c 100644
--- a/qmp-commands.hx
+++ b/qmp-commands.hx
@@ -3412,7 +3412,7 @@ EQMP
 
     {
         .name       = "query-cpu-definitions",
-        .args_type  = "",
+        .args_type  = "machine:s?,accel:s?",
         .mhandler.cmd_new = qmp_marshal_input_query_cpu_definitions,
     },
 
diff --git a/qmp.c b/qmp.c
index e6c7050..16a24d1 100644
--- a/qmp.c
+++ b/qmp.c
@@ -567,9 +567,14 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
     return prop_list;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return arch_query_cpu_definitions(errp);
+CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
+                                                 const char *machine,
+                                                 bool has_accel,
+                                                 AccelId accel,
+                                                 Error **errp)
+{
+    return arch_query_cpu_definitions(has_machine, machine,
+                                      has_accel, accel, errp);
 }
 
 void qmp_add_client(const char *protocol, const char *fdname,
diff --git a/stubs/arch-query-cpu-def.c b/stubs/arch-query-cpu-def.c
index 22e0b43..6f8904e 100644
--- a/stubs/arch-query-cpu-def.c
+++ b/stubs/arch-query-cpu-def.c
@@ -2,7 +2,11 @@
 #include "sysemu/arch_init.h"
 #include "qapi/qmp/qerror.h"
 
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp)
 {
     error_set(errp, QERR_UNSUPPORTED);
     return NULL;
diff --git a/target-arm/helper.c b/target-arm/helper.c
index d77c6de..41ff2be 100644
--- a/target-arm/helper.c
+++ b/target-arm/helper.c
@@ -3535,7 +3535,11 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
     *cpu_list = entry;
 }
 
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
diff --git a/target-i386/cpu.c b/target-i386/cpu.c
index 03b33cf..3c1c8db 100644
--- a/target-i386/cpu.c
+++ b/target-i386/cpu.c
@@ -2023,7 +2023,11 @@ void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     }
 }
 
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     X86CPUDefinition *def;
diff --git a/target-ppc/translate_init.c b/target-ppc/translate_init.c
index d74f4f0..2729b9f 100644
--- a/target-ppc/translate_init.c
+++ b/target-ppc/translate_init.c
@@ -9472,7 +9472,11 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     *first = entry;
 }
 
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index e0537fa..4d43ace 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -45,7 +45,11 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 }
 
 #ifndef CONFIG_USER_ONLY
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp)
 {
     CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
-- 
1.8.3.1
