From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 12/16] target-s390x: Prepare accelerator
	during cpu object realization
Date: Mon,  2 Mar 2015 13:44:04 +0100
Message-ID: <1425300248-40277-13-git-send-email-mimu@linux.vnet.ibm.com>
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

This patch implements routine s390_cpu_model_init(). It is called by the
realize function during instantiation of an cpu object. Its task is to
initialize the current accelerator with the properties of the selected
processor model.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 36 ++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  4 ++++
 target-s390x/cpu.c        |  1 +
 3 files changed, 41 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 83e590a..c6c1771 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -107,6 +107,7 @@ typedef struct ParmAddrAddrAccel {
 } ParmAddrAddrAccel;
 
 static GSList *s390_cpu_aliases;
+static bool cpu_models_used;
 
 /* compare order of two cpu classes for ascending sort */
 gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b)
@@ -634,3 +635,38 @@ bool s390_probe_mode(void)
     return false;
 }
 
+/**
+ * s390_cpu_model_init:
+ * @cc: S390 CPU class
+ *
+ * This function intitializes the current accelerator with processor
+ * related properties.
+ *
+ * Since: 2.3
+ */
+void s390_cpu_model_init(S390CPUClass *cc)
+{
+    S390ProcessorProps proc;
+
+    /* none cpu model case */
+    if (!strcmp(object_class_get_name(OBJECT_CLASS(cc)), TYPE_S390_CPU)) {
+        return;
+    }
+
+    /* accelerator already prepared */
+    if (cpu_models_used) {
+        return;
+    }
+
+    proc.cpuid = cpuid(cc->proc);
+    proc.ibc = cc->proc.ibc;
+    bitmap_zero(proc.fac_list, FAC_LIST_ARCH_S390_SIZE_UINT1);
+    bitmap_copy(proc.fac_list, cc->fac_list, FAC_LIST_CPU_S390_SIZE_UINT1);
+
+    if (kvm_enabled()) {
+        if (!kvm_s390_set_processor_props(&proc)) {
+            cpu_models_used = true;
+        }
+    }
+}
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index aa81c9b..f3f914a 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -45,6 +45,9 @@
 #define type_cpuid(x)     ((uint64_t)((x) & 0xffff) << 16)
 #define id_cpuid(x)       ((uint64_t)((x) & 0xffffff) << 32)
 #define ver_cpuid(x)      ((uint64_t)((x) & 0xff) << 56)
+#define cpuid(x)          (ver_cpuid(x.ver) |  \
+                           id_cpuid(x.id) |    \
+                           type_cpuid(x.type))
 
 #define oldest_ibc(x)     (((uint32_t)(x) >> 16) & 0xfff)
 #define newest_ibc(x)     ((uint32_t)(x) & 0xfff)
@@ -110,6 +113,7 @@ gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
 void s390_cpu_list_entry(gpointer data, gpointer user_data);
 bool s390_cpu_classes_initialized(void);
 bool s390_probe_mode(void);
+void s390_cpu_model_init(S390CPUClass *cc);
 
 /*
  * bits 0-7   : CMOS generation
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index c9200ee..2f4192e 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -178,6 +178,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
 
+    s390_cpu_model_init(scc);
     s390_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 #if !defined(CONFIG_USER_ONLY)
-- 
1.8.3.1
