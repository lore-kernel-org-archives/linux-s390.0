From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 01/16] Introduce probe mode for machine type
	none
Date: Mon,  2 Mar 2015 13:43:53 +0100
Message-ID: <1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

QEMU now switches into "probe mode" when the selected machine is "none" and no
specific accelerator(s) has been requested (i.e.: "-machine none").

In probe mode a by "<ARCH>_CONFIG" defines predefined list of accelerators run
their init() methods.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 accel.c              | 31 +++++++++++++++++++++++++------
 include/hw/boards.h  |  1 +
 include/sysemu/kvm.h | 10 ++++++++++
 kvm-all.c            |  3 +++
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/accel.c b/accel.c
index 74e41da..260b009 100644
--- a/accel.c
+++ b/accel.c
@@ -36,6 +36,9 @@
 
 int tcg_tb_size;
 static bool tcg_allowed = true;
+static const char *probe_mode_accels =
+    "kvm:"
+    "tcg";
 
 static int tcg_init(MachineState *ms)
 {
@@ -59,13 +62,15 @@ static AccelClass *accel_find(const char *opt_name)
     return ac;
 }
 
-static int accel_init_machine(AccelClass *acc, MachineState *ms)
+static int accel_init_machine(AccelClass *acc, MachineState *ms,
+                              bool probe_mode)
 {
     ObjectClass *oc = OBJECT_CLASS(acc);
     const char *cname = object_class_get_name(oc);
     AccelState *accel = ACCEL(object_new(cname));
     int ret;
     ms->accelerator = accel;
+    ms->probe_mode = probe_mode;
     *(acc->allowed) = true;
     ret = acc->init_machine(ms);
     if (ret < 0) {
@@ -78,20 +83,30 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
 
 int configure_accelerator(MachineState *ms)
 {
-    const char *p;
+    const char *p, *name;
     char buf[10];
     int ret;
     bool accel_initialised = false;
     bool init_failed = false;
     AccelClass *acc = NULL;
+    ObjectClass *oc;
+    bool probe_mode = false;
 
     p = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (p == NULL) {
-        /* Use the default "accelerator", tcg */
-        p = "tcg";
+        oc = (ObjectClass *) MACHINE_GET_CLASS(current_machine);
+        name = object_class_get_name(oc);
+        probe_mode = !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
+        if (probe_mode) {
+            /* Use these accelerators in probe mode, tcg should be last */
+            p = probe_mode_accels;
+        } else {
+            /* Use the default "accelerator", tcg */
+            p = "tcg";
+        }
     }
 
-    while (!accel_initialised && *p != '\0') {
+    while ((probe_mode || !accel_initialised) && *p != '\0') {
         if (*p == ':') {
             p++;
         }
@@ -106,7 +121,7 @@ int configure_accelerator(MachineState *ms)
                    acc->name);
             continue;
         }
-        ret = accel_init_machine(acc, ms);
+        ret = accel_init_machine(acc, ms, probe_mode);
         if (ret < 0) {
             init_failed = true;
             fprintf(stderr, "failed to initialize %s: %s\n",
@@ -128,6 +143,10 @@ int configure_accelerator(MachineState *ms)
         fprintf(stderr, "Back to %s accelerator.\n", acc->name);
     }
 
+    if (probe_mode) {
+        accel_initialised = false;
+    }
+
     return !accel_initialised;
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3ddc449..3253fa5 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -135,6 +135,7 @@ struct MachineState {
     bool usb;
     char *firmware;
     bool iommu;
+    bool probe_mode;
 
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 30cb84d..fbc18c8 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -50,6 +50,7 @@ extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
+extern bool kvm_probe_mode;
 
 #if defined CONFIG_KVM || !defined NEED_CPU_H
 #define kvm_enabled()           (kvm_allowed)
@@ -143,6 +144,15 @@ extern bool kvm_readonly_mem_allowed;
  */
 #define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
 
+/**
+ * kvm_probe_mode_enabled:
+ *
+ * Returns: true if KVM is initialized for a machine type that
+ * has its probe_mode attribute set (ie QEMU was started in probe
+ * mode)
+ */
+#define kvm_probe_mode_enabled() (kvm_probe_mode)
+
 #else
 #define kvm_enabled()           (0)
 #define kvm_irqchip_in_kernel() (false)
diff --git a/kvm-all.c b/kvm-all.c
index 05a79c2..f9e4434 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -126,6 +126,7 @@ bool kvm_gsi_routing_allowed;
 bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
+bool kvm_probe_mode;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
@@ -1471,6 +1472,8 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
+    kvm_probe_mode = ms->probe_mode;
+
     s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
     /* If unspecified, use the default value */
-- 
1.8.3.1
