From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 12/15] Add optional parameters to QMP command query-cpu-definitions
Date: Mon, 30 Mar 2015 16:28:25 +0200
Message-ID: <1427725708-52100-13-git-send-email-mimu@linux.vnet.ibm.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
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
 include/sysemu/arch_init.h  |  6 +++++-
 qapi-schema.json            | 14 ++++++++++++--
 qmp-commands.hx             |  2 +-
 qmp.c                       | 11 ++++++++---
 stubs/arch-query-cpu-def.c  |  6 +++++-
 target-arm/helper.c         |  6 +++++-
 target-i386/cpu.c           |  6 +++++-
 target-ppc/translate_init.c |  6 +++++-
 target-s390x/cpu.c          |  6 +++++-
 9 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 86344a2..ab48c35 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -36,7 +36,11 @@ void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
 
-CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
+                                                  const char *machine,
+                                                  bool has_accel,
+                                                  AccelId accel,
+                                                  Error **errp);
 CpuModelInfo *arch_query_cpu_model(Error **errp);
 
 #endif
diff --git a/qapi-schema.json b/qapi-schema.json
index 14d294f..61a145d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2532,21 +2532,31 @@
 #
 # @name: the name of the CPU definition
 #
+# @default: #optional defines if cpu model is the default (since 2.4)
+#
+# @runnable: #optional defines if cpu model is runnable (since 2.4)
+#
 # Since: 1.2.0
 ##
 { 'type': 'CpuDefinitionInfo',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*is-default': 'bool', '*runnable': 'bool' } }
 
 ##
 # @query-cpu-definitions:
 #
 # Return a list of supported virtual CPU definitions
 #
+# @machine: #optional machine type (since 2.4)
+#
+# @accel: #optional accelerator id (since 2.4)
+#
 # Returns: a list of CpuDefInfo
 #
 # Since: 1.2.0
 ##
-{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
+{ 'command': 'query-cpu-definitions',
+  'data': { '*machine': 'str', '*accel': 'AccelId' },
+  'returns': ['CpuDefinitionInfo'] }
 
 ##
 # @CpuModelInfo:
diff --git a/qmp-commands.hx b/qmp-commands.hx
index 8fe577f..ed86773d 100644
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
index ad63803..ad52fb3 100644
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
 
 CpuModelInfo *qmp_query_cpu_model(Error **errp)
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
index 10886c5..d56d47a 100644
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
index b2d1c95..c7fa98e 100644
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
index 1698b52..615173f 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -66,7 +66,11 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
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
