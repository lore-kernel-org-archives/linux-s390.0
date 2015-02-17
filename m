From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 15/15] cpu-model/s390: Enable S390 cpu model
Date: Tue, 17 Feb 2015 15:24:13 +0100
Message-ID: <1424183053-4310-16-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch enables QEMU to instantiate S390 CPUs with cpu model types.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio.c | 6 ++++++
 target-s390x/helper.c  | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index c215cd8..aabd772 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -32,6 +32,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
+#include "sysemu/cpus.h"
 #include "exec/address-spaces.h"
 
 #include "hw/s390x/s390-virtio-bus.h"
@@ -152,6 +153,11 @@ void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys)
         cpu_model = "host";
     }
 
+    if (is_help_option(cpu_model)) {
+        list_cpus(stdout, &fprintf, cpu_model);
+        exit(0);
+    }
+
     ipi_states = g_malloc(sizeof(S390CPU *) * smp_cpus);
 
     for (i = 0; i < smp_cpus; i++) {
diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index 5958343..568428d 100644
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
@@ -75,7 +76,7 @@ S390CPU *cpu_s390x_init(const char *cpu_model)
 {
     S390CPU *cpu;
 
-    cpu = S390_CPU(object_new(TYPE_S390_CPU));
+    cpu = S390_CPU(object_new(s390_select_cpu_model(cpu_model)));
 
     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
 
-- 
1.8.3.1
