From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 14/15] cpu-model/s390: Add cpu model selection routine
Date: Tue, 17 Feb 2015 15:24:12 +0100
Message-ID: <1424183053-4310-15-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch basically implements the routine:

- s390_select_cpu_model()

It tests if the the cpu classes have been initialized and the requested
cpu model is either a valid model or a valid alias. If these conditions
are met, the associated cpu model properties (cpu identifier, ibc value,
cpu facilities) are established with the current accelerator. If also this
step was successful, QEMU stores the related cpu model type name to be
returned by subsequent calls to this routine. This will guarantee all
cpus will use the same model.

Here an example of a returned cpu type name: '2827-ga2-s390-cpu'

If one of the priviously mentioned steps fail, QEMU stores and returns the
default cpu model type name: 's390-cpu'.

The function has a trace point.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  4 ++++
 trace-events              |  3 +++
 3 files changed, 52 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 9bc4d89..bd36d10 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -13,6 +13,7 @@
 #include "qemu-common.h"
 #include "cpu-models.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #define S390_FAC_NAME(n, _cpu_id) glue(glue(glue(FAC, n), _), _cpu_id)
 
@@ -707,3 +708,47 @@ bool s390_cpu_models_used(void)
     return s390_cpu_typename() && strcmp(s390_cpu_typename(), TYPE_S390_CPU);
 }
 
+/**
+ * s390_select_cpu_model - select the cpu model to be used by QEMU
+ * @model: the cpu model name
+ *
+ * Returns: the cpu class type name (<type>-<ga>-s390-cpu) associated
+ *          to the requested cpu model
+ *          TYPE_S390_CPU in case the requested model is invalid or
+ *          cannot be requested for the currently used accelerator
+ */
+const char *s390_select_cpu_model(const char *model)
+{
+    S390ProcessorProps proc;
+    const char *typename;
+    S390CPUClass *cc;
+
+    /* return already selected cpu typename */
+    typename = s390_cpu_typename();
+    if (typename) {
+        goto out;
+    }
+
+    /* return standard cpu typename when cpu models are unavailable */
+    typename = TYPE_S390_CPU;
+    if (!s390_cpu_classes_initialized() || !model) {
+        goto out;
+    }
+    cc = S390_CPU_CLASS(s390_cpu_class_by_name(model));
+    if (!cc) {
+        goto out;
+    }
+    proc.cpuid = cpuid(cc->proc);
+    proc.ibc = cc->proc->ibc;
+    memcpy(proc.fac_list, cc->fac_list, S390_FAC_LIST_SIZE_BYTE);
+    if (s390_set_processor_props(&proc)) {
+        goto out;
+    }
+
+    /* return requested cpu typename in success case */
+    typename = object_class_get_name((ObjectClass *) cc);
+out:
+    selected_cpu_typename = typename;
+    trace_select_cpu_model(model, typename);
+    return typename;
+}
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index bc478d8..254e1ef 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -44,6 +44,9 @@
 #define type_cpuid(x)     ((uint64_t)((x) & 0xffff) << 16)
 #define id_cpuid(x)       ((uint64_t)((x) & 0xffffff) << 32)
 #define ver_cpuid(x)      ((uint64_t)((x) & 0xff) << 56)
+#define cpuid(x)          (ver_cpuid(x->ver) |  \
+                           id_cpuid(x->id) |    \
+                           type_cpuid(x->type))
 
 #define oldest_ibc(x)     (((uint32_t)(x) >> 16) & 0xfff)
 #define newest_ibc(x)     ((uint32_t)(x) & 0xfff)
@@ -115,6 +118,7 @@ bool s390_test_facility(S390CPUClass *cc, unsigned long nr);
 bool s390_probe_mode(void);
 const char *s390_cpu_typename(void);
 bool s390_cpu_models_used(void);
+const char *s390_select_cpu_model(const char *model);
 
 /*
  * bits 0-7   : CMOS generation
diff --git a/trace-events b/trace-events
index f39f879..014fa12 100644
--- a/trace-events
+++ b/trace-events
@@ -1588,3 +1588,6 @@ i8257_unregistered_dma(int nchan, int dma_pos, int dma_len) "unregistered DMA ch
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
 cpu_halt(int cpu_index) "halting cpu %d"
 cpu_unhalt(int cpu_index) "unhalting cpu %d"
+
+# target-s390x/cpu-model.c
+select_cpu_model(const char *model, const char *typename) "CPU-MODEL: requested: %s selected: %s"
-- 
1.8.3.1
