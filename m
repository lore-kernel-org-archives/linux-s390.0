From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 16/16] target-s390x: Enable cpu model usage
Date: Mon,  2 Mar 2015 13:44:08 +0100
Message-ID: <1425300248-40277-17-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch enables QEMU to instantiate S390 CPUs with cpu model types.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio.c | 12 +++++++++++-
 target-s390x/helper.c  |  9 ++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 412e49b..0bf7632 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -32,6 +32,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
+#include "sysemu/cpus.h"
 #include "exec/address-spaces.h"
 
 #include "hw/s390x/s390-virtio-bus.h"
@@ -153,7 +154,12 @@ void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys)
     int i;
 
     if (cpu_model == NULL) {
-        cpu_model = "host";
+        cpu_model = "none";
+    }
+
+    if (is_help_option(cpu_model)) {
+        list_cpus(stdout, &fprintf, cpu_model);
+        exit(0);
     }
 
     ipi_states = g_malloc(sizeof(S390CPU *) * smp_cpus);
@@ -163,6 +169,10 @@ void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys)
         CPUState *cs;
 
         cpu = cpu_s390x_init(cpu_model);
+        if (cpu == NULL) {
+            fprintf(stderr, "Unable to find CPU definition\n");
+            exit(1);
+        }
         cs = CPU(cpu);
 
         ipi_states[i] = cpu;
diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index e0fd8fc..5b6bad2 100644
--- a/target-s390x/helper.c
+++ b/target-s390x/helper.c
@@ -22,6 +22,7 @@
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
 #include "exec/cpu_ldst.h"
+#include "cpu-models.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #endif
@@ -66,13 +67,7 @@ void s390x_cpu_timer(void *opaque)
 
 S390CPU *cpu_s390x_init(const char *cpu_model)
 {
-    S390CPU *cpu;
-
-    cpu = S390_CPU(object_new(TYPE_S390_CPU));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
+    return S390_CPU(cpu_generic_init(TYPE_S390_CPU, cpu_model));
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
1.8.3.1
