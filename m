From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 11/16] target-s390x: Add cpu class
	initialization routines
Date: Mon,  2 Mar 2015 13:44:03 +0100
Message-ID: <1425300248-40277-12-git-send-email-mimu@linux.vnet.ibm.com>
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

This patch provides routines to dynamically update the previously defined
S390 cpu classes in the current host context. The main function performing
this process is s390_setup_cpu_classes(). It takes the current host context
as parameter to setup the classes accordingly. It basically performs the
following sub-tasks:

- Update of cpu classes with accelerator specific host and QEMU properties
- Mark adequate cpu class as default cpu class to be used for cpu model 'host'
- Invalidate cpu classes not supported by this hosting machine
- Define machine type aliases to latest GA number of a processor model
- Define aliases for common cpu model names
- Set cpu model alias 'host' to default cpu class

Forthermore the patch provides the following routines:

- cpu_desc_avail(), s390 specific stub indicating that list_cpus() can run
- s390_cpu_classes_initialized(), test if cpu classes have been initialized
- s390_probe_mode(), indicates if probe mode is active

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 458 ++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  26 +++
 target-s390x/cpu.c        |  17 +-
 target-s390x/kvm.c        |   4 +-
 4 files changed, 503 insertions(+), 2 deletions(-)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 608189d..83e590a 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -13,6 +13,7 @@
 #include "qemu-common.h"
 #include "cpu-models.h"
 #include "gen-facilities.h"
+#include "qemu/error-report.h"
 
 #define S390_PROC_DEF(_name, _cpu_id, _desc)                            \
     static void                                                         \
@@ -87,8 +88,41 @@ S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
 S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
 S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
 
+/* some types for calls to g_list_foreach() with parameters */
+typedef struct ParmBoolShortShortAccel {
+    bool valid;
+    unsigned short type;
+    union {
+        unsigned short class;
+        unsigned short gen;
+        unsigned short ga;
+    };
+    AccelId accel;
+} ParmBoolShortShortAccel;
+
+typedef struct ParmAddrAddrAccel {
+    S390MachineProps *prop;
+    S390CPUClass *host_cc;
+    AccelId accel;
+} ParmAddrAddrAccel;
+
 static GSList *s390_cpu_aliases;
 
+/* compare order of two cpu classes for ascending sort */
+gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b)
+{
+    S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *) a);
+    S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *) b);
+
+    if (cc_a->mach.order < cc_b->mach.order) {
+        return -1;
+    }
+    if (cc_a->mach.order > cc_b->mach.order) {
+        return 1;
+    }
+    return 0;
+}
+
 static gint s390_cpu_compare_class_name(gconstpointer a, gconstpointer b)
 {
     const char *aname = object_class_get_name((ObjectClass *) a);
@@ -176,3 +210,427 @@ int set_s390_cpu_alias(const char *name, const char *model)
     return 0;
 }
 
+/* return machine class for specific machine type */
+static void s390_machine_class_test_cpu_class(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmBoolShortShortAccel *parm = user_data;
+
+    if (parm->valid || !cc->proc.type || parm->type != cc->proc.type) {
+        return;
+    }
+
+    parm->class = cc->mach.class;
+    parm->valid = true;
+}
+
+/* return machine class by machine type */
+static unsigned short machine_class(unsigned short type, void *user_data)
+{
+    GSList *list = object_class_get_list(TYPE_S390_CPU, false);
+    ParmBoolShortShortAccel parm_class, *parm = user_data;
+
+    if (parm->type != type) {
+        parm->class = 0;
+    }
+    if (!parm->class) {
+        parm_class.type = type;
+        parm_class.class = 0;
+        parm_class.valid = false;
+        g_slist_foreach(list, (GFunc) s390_machine_class_test_cpu_class,
+                        &parm_class);
+        g_slist_free(list);
+        if (parm_class.valid) {
+            parm->class = parm_class.class;
+        }
+    }
+    parm->type = type;
+
+    return parm->class;
+}
+
+/* return CMOS generation for specific machine type */
+static void s390_machine_class_test_cpu_gen(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmBoolShortShortAccel *parm = user_data;
+
+    if (parm->valid) {
+        return;
+    }
+
+    if (parm->type == cc->proc.type) {
+        parm->gen = cc->proc.gen;
+        parm->valid = true;
+    }
+}
+
+/* return CMOS generation by machine type */
+static uint16_t machine_gen(unsigned short type)
+{
+    GSList *list = object_class_get_list(TYPE_S390_CPU, false);
+    ParmBoolShortShortAccel parm;
+
+    parm.type = type;
+    parm.gen = 0;
+    parm.valid = false;
+    g_slist_foreach(list, (GFunc) s390_machine_class_test_cpu_gen, &parm);
+    g_slist_free(list);
+
+    return parm.gen;
+}
+
+/* mark cpu class, used in host cpu model case */
+static void s390_mark_host_cpu_class(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmAddrAddrAccel *parm = user_data;
+    ParmBoolShortShortAccel parm_tc;
+
+    if (!cc->is_active[parm->accel]) {
+        return;
+    }
+
+    parm_tc.type = 0;
+    parm_tc.class = 0;
+    if (cc->mach.class != machine_class(cpuid_type(parm->prop->cpuid),
+                                        &parm_tc)) {
+        /* sort out machines that differ from host machine class */
+        return;
+    }
+    if (!parm->host_cc) {
+        /* use first matching machine type */
+        cc->is_host[parm->accel] = true;
+        parm->host_cc = cc;
+        return;
+    }
+    if (cc->proc.gen > machine_gen(cpuid_type(parm->prop->cpuid))) {
+        /* sort out CMOS generations later than hosts generation */
+        cc->is_active[parm->accel] = false;
+        return;
+    }
+    if (cc->mach.order > parm->host_cc->mach.order) {
+        /* select later machine as host */
+        parm->host_cc->is_host[parm->accel] = false;
+        cc->is_host[parm->accel] = true;
+        parm->host_cc = cc;
+    }
+}
+
+/* update a specific cpu model class with host retrieved configuration */
+static void s390_update_cpu_class(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    ParmAddrAddrAccel *parm = user_data;
+    S390CPUClass *cc = S390_CPU_CLASS(oc);
+    uint64_t fac_list[FAC_LIST_CPU_S390_SIZE_UINT64];
+    uint64_t nbits = FAC_LIST_CPU_S390_SIZE_UINT1;
+
+    if (!cc->proc.type) {
+        return;
+    }
+
+    /* Set processor identifier */
+    cc->proc.id = cpuid_id(parm->prop->cpuid);
+
+    /*
+     * Define model specific IBC value in current host context.
+     * IBC was introduced with CMOS version 10 i.e. type 2097.
+     * For older CPUs it is assumed to be 0x000. The BC system
+     * has always the same IBC version as the previous EC system.
+     * If the host supports IBC but not the requested type, it
+     * will be set to the oldest supported value.
+     */
+    if (has_ibc(parm->prop->ibc_range)) {
+        if (cc->proc.gen >= S390_CMOS_G10) {
+            cc->proc.ibc = ((cc->proc.gen - S390_CMOS_G10) << 4);
+            cc->proc.ibc += cc->mach.ga;
+            if (cc->mach.class == S390_BC) {
+                cc->proc.ibc++;
+            }
+            if (cc->proc.ibc < oldest_ibc(parm->prop->ibc_range)) {
+                cc->proc.ibc = oldest_ibc(parm->prop->ibc_range);
+            }
+            if (cc->proc.ibc > newest_ibc(parm->prop->ibc_range)) {
+                cc->proc.ibc = newest_ibc(parm->prop->ibc_range);
+            }
+        } else {
+            cc->proc.ibc = oldest_ibc(parm->prop->ibc_range);
+        }
+    }
+
+    /*
+     * Processor generation and GA level specific facility properties:
+     *
+     * - cc->fac_list (RFL):
+     *       resulting facility list to be requested for guest cpus
+     * - cc->proc.fac_list (PFL):
+     *       facility list defined per processor generation and GA level
+     *
+     * Machine specific facility properties reported by the host:
+     *
+     * - parm->prop->fac_list (MFL):
+     *       host specifc facility list, might be reduced by some facilities
+     *       in case the host is backed by z/VM and not a LPAR
+     * - parm->prop->fac_list_mask (MFM):
+     *       host specific facility list mask containing facilities
+     *
+     * QEMU defined properties:
+     *
+     *  - qemu_s390_fac_list_mask (QFM):
+     *        locally defined facilities, they are added to the set of
+     *        facilities requested for a guest vcpu. They are visible in
+     *        the guest and require qemu side instruction handling
+     *
+     * The calculation for the vcpu specific facility list (RFL) from the
+     * above defined lists/masks works as follows:
+     *
+     * RFL = PFL & (QFM | MFM)
+     *
+     * Set resulting/desired facilities of given cpu class
+     */
+    bitmap_or(cc->fac_list, qemu_s390_fac_list_mask,
+              parm->prop->fac_list_mask, nbits);
+    bitmap_and(cc->fac_list, cc->fac_list, cc->proc.fac_list, nbits);
+
+    /*
+     * Finally, mark the cpu class inactive if not all resulting/desired
+     * facilities are offered by the host.
+     * (RFL & MFL) != RFL
+     */
+    bitmap_and(fac_list, cc->fac_list, parm->prop->fac_list, nbits);
+    if (!bitmap_equal(fac_list, cc->fac_list, nbits)) {
+        cc->is_active[parm->accel] = false;
+    }
+}
+
+/* a cpu class that is newer then the current host */
+static void s390_set_not_supported_cpu_class(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmAddrAddrAccel *parm = user_data;
+
+    if (!cc->is_active[parm->accel]) {
+        return;
+    }
+    if (cc->proc.gen < parm->host_cc->proc.gen) {
+        return;
+    }
+    if (cc->proc.gen == parm->host_cc->proc.gen) {
+        if (cc->mach.class == parm->host_cc->mach.class &&
+            cc->mach.ga <= parm->host_cc->mach.ga) {
+            return;
+        }
+        if (cc->mach.class == S390_EC &&
+            cc->mach.ga > parm->host_cc->mach.ga) {
+            return;
+        }
+        if (cc->mach.class == S390_BC &&
+            cc->mach.ga < parm->host_cc->mach.ga) {
+            return;
+        }
+    }
+    cc->is_active[parm->accel] = false;
+}
+
+/* set alias by type and ga */
+static int set_s390_cpu_alias_by_type_ga(unsigned short type, unsigned short ga)
+{
+    char name[8], model[16];
+
+    snprintf(name, sizeof(name), "%04x", type);
+    snprintf(model, sizeof(model), "%04x-ga%u", type, ga);
+
+    return set_s390_cpu_alias(name, model);
+}
+
+/* set alias if system has latest ga of a type */
+static void s390_set_ga_alias(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmBoolShortShortAccel *parm = user_data;
+
+    if (!cc->is_active[parm->accel]) {
+        return;
+    }
+    if (!parm->type) {
+        parm->type = cc->proc.type;
+    }
+    if (cc->proc.type == parm->type) {
+        parm->ga = cc->mach.ga;
+        return;
+    }
+    set_s390_cpu_alias_by_type_ga(parm->type, parm->ga);
+    parm->type = cc->proc.type;
+    parm->ga = cc->mach.ga;
+}
+
+/* set host marked cpu class as alias to respective class */
+static void s390_set_host_alias_from_cpu_class(gpointer data,
+                                               gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmAddrAddrAccel *parm = user_data;
+
+    char model[16];
+
+    if (!cc->is_active[parm->accel] || !cc->is_host[parm->accel]) {
+        return;
+    }
+    snprintf(model, sizeof(model), "%04x-ga%u", cc->proc.type, cc->mach.ga);
+    set_s390_cpu_alias("host", model);
+}
+
+/**
+ * s390_setup_cpu_classes:
+ * @accel: the accelerator id
+ * @prop: the machine property structure's address
+ *
+ * This function validates the defined cpu classes against the given
+ * machine properties @prop. Only cpu classes that are runnable on the
+ * current host will be set active. In addition the corresponding
+ * cpuid, ibc value and the active set of facilities will be
+ * initialized. When in probe mode, the function can be called for
+ * several accelerators @accel. Though aliases will only be added when
+ * not in probe mode.
+ *
+ * Returns: %0 in case of success -%EINVAL elsewise.
+ *
+ * Since: 2.3
+ */
+int s390_setup_cpu_classes(AccelId accel, S390MachineProps *prop)
+{
+    GSList *list;
+    ParmAddrAddrAccel parm;
+    ParmBoolShortShortAccel parm_alias;
+
+    list = object_class_get_list(TYPE_S390_CPU, false);
+    list = g_slist_sort(list, s390_cpu_class_asc_order_compare);
+
+    /* update cpu classes with accellerator properties */
+    parm.accel = accel;
+    parm.prop = prop;
+    g_slist_foreach(list, (GFunc) s390_update_cpu_class, (gpointer) &parm);
+
+    /* define cpu model "host" */
+    parm.host_cc = NULL;
+    g_slist_foreach(list, (GFunc) s390_mark_host_cpu_class, (gpointer) &parm);
+
+    if (!parm.host_cc) {
+        error_report("Failed to mark host cpu class");
+        return -EINVAL;
+    }
+
+    /* inactivate cpu classes not supported by this host */
+    g_slist_foreach(list, (GFunc) s390_set_not_supported_cpu_class, &parm);
+
+    /* set machine type aliases to latest ga of model (e.g. 2064 -> 2064-ga3) */
+    parm_alias.accel = accel;
+    parm_alias.type = 0;
+    parm_alias.ga = 0;
+    g_slist_foreach(list, (GFunc) s390_set_ga_alias, &parm_alias);
+    set_s390_cpu_alias_by_type_ga(parm_alias.type, parm_alias.ga);
+
+    if (!s390_probe_mode()) {
+        /* set aliases for common model names to machine types */
+        set_s390_cpu_alias("z900",   "2064");
+        set_s390_cpu_alias("z800",   "2066");
+        set_s390_cpu_alias("z990",   "2084");
+        set_s390_cpu_alias("z890",   "2086");
+        set_s390_cpu_alias("z9-109", "2094-ga1");
+        set_s390_cpu_alias("z9",     "2094");
+        set_s390_cpu_alias("z9-ec",  "2094");
+        set_s390_cpu_alias("z9-bc",  "2096");
+        set_s390_cpu_alias("z10",    "2097");
+        set_s390_cpu_alias("z10-ec", "2097");
+        set_s390_cpu_alias("z10-bc", "2098");
+        set_s390_cpu_alias("z196",   "2817");
+        set_s390_cpu_alias("z114",   "2818");
+        set_s390_cpu_alias("zEC12",  "2827");
+        set_s390_cpu_alias("zBC12",  "2828");
+        /* set alias for cpu model "host" at end of list */
+        g_slist_foreach(list, (GFunc) s390_set_host_alias_from_cpu_class,
+                        &parm);
+    }
+
+    g_slist_free(list);
+    return 0;
+}
+
+/* list all supported cpu models and alias names */
+void s390_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *alias_oc, *oc = data;
+    CPUListState *s = user_data;
+    DeviceClass  *dc = DEVICE_CLASS(oc);
+    S390CPUClass *cc = S390_CPU_CLASS(oc);
+    const char *typename = object_class_get_name(oc);
+    S390CPUAlias *alias;
+    AccelId accel;
+    GSList *item;
+    char *name;
+
+    if (!kvm_enabled()) {
+        return;
+    }
+    accel = ACCEL_ID_KVM;
+    if (!cc->is_active[accel]) {
+        return;
+    }
+    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_S390_CPU));
+    (*s->cpu_fprintf)(s->file, "s390 %-10s %s\n", name, dc->desc);
+
+    for (item = s390_cpu_aliases; item != NULL; item = item->next) {
+        alias = (S390CPUAlias *) item->data;
+        alias_oc = s390_cpu_class_by_name(alias->model);
+        if (alias_oc != oc) {
+            continue;
+        }
+        (*s->cpu_fprintf)(s->file, "s390 %-10s (alias for %s)\n",
+                          alias->name, name);
+    }
+
+    g_free(name);
+}
+
+/**
+ * s390_cpu_classes_initialized:
+ *
+ * This function indicates if the all cpu classes and their properties
+ * have been initialized.
+ *
+ * Returns: a boolean value.
+ *
+ * Since: 2.3
+ */
+bool s390_cpu_classes_initialized(void)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_cpu_classes_initialized();
+    }
+    return false;
+}
+
+bool cpu_desc_avail(void)
+{
+    return s390_cpu_classes_initialized();
+}
+
+/**
+ * s390_probe_mode:
+ *
+ * This function indicates that cpu class initialization takes place
+ * in probe mode.
+ *
+ * Returns: a boolean value.
+ *
+ * Since: 2.3
+ */
+bool s390_probe_mode(void)
+{
+    if (kvm_enabled() && kvm_s390_probe_mode()) {
+        return true;
+    }
+    return false;
+}
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index b6b57d4..aa81c9b 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -29,12 +29,32 @@
 #define S390_DEF_ID      0xdecade
 #define S390_DEF_TYPE    0x2064
 
+/* first s390 CMOS generation supporting IBC */
+#define S390_CMOS_G10    0xa
+
 #define cpu_type(x)       (((x) >>  0) & 0xffff)
 #define cpu_order(x)      (((x) >> 16) & 0xffff)
 #define cpu_ga(x)         (((x) >> 16) & 0xf)
 #define cpu_class(x)      (((x) >> 20) & 0x3)
 #define cpu_generation(x) (((x) >> 24) & 0xff)
 
+#define cpuid_type(x)     (((x) >> 16) & 0xffff)
+#define cpuid_id(x)       (((x) >> 32) & 0xffffff)
+#define cpuid_ver(x)      (((x) >> 56) & 0xff)
+
+#define type_cpuid(x)     ((uint64_t)((x) & 0xffff) << 16)
+#define id_cpuid(x)       ((uint64_t)((x) & 0xffffff) << 32)
+#define ver_cpuid(x)      ((uint64_t)((x) & 0xff) << 56)
+
+#define oldest_ibc(x)     (((uint32_t)(x) >> 16) & 0xfff)
+#define newest_ibc(x)     ((uint32_t)(x) & 0xfff)
+#define has_ibc(x)        (oldest_ibc(x) != 0)
+
+#define S390_DEF_CPUID             \
+    (ver_cpuid(S390_DEF_VERSION) | \
+     id_cpuid(S390_DEF_ID) |       \
+     type_cpuid(S390_DEF_TYPE))
+
 ObjectClass *s390_cpu_class_by_name(const char *name);
 int set_s390_cpu_alias(const char *name, const char *model);
 
@@ -85,6 +105,12 @@ static inline bool kvm_s390_probe_mode(void)
 }
 #endif
 
+int s390_setup_cpu_classes(AccelId accel, S390MachineProps *prop);
+gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
+void s390_cpu_list_entry(gpointer data, gpointer user_data);
+bool s390_cpu_classes_initialized(void);
+bool s390_probe_mode(void);
+
 /*
  * bits 0-7   : CMOS generation
  * bits 8-9   : reserved
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 1992910..c9200ee 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -41,7 +41,22 @@
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
 #ifdef CONFIG_KVM
-    (*cpu_fprintf)(f, "s390 %16s\n", "host");
+    CPUListState s = {
+        .file = f,
+        .cpu_fprintf = cpu_fprintf,
+    };
+    GSList *list;
+
+    if (kvm_enabled() && s390_cpu_classes_initialized()) {
+        list = object_class_get_list(TYPE_S390_CPU, false);
+        list = g_slist_sort(list, s390_cpu_class_asc_order_compare);
+        g_slist_foreach(list, s390_cpu_list_entry, &s);
+        g_slist_free(list);
+    } else {
+#endif
+        (*cpu_fprintf)(f, "s390 host\n");
+#ifdef CONFIG_KVM
+    }
 #endif
 }
 
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 5404137..07d07b2 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -233,7 +233,9 @@ static void kvm_s390_setup_cpu_classes(KVMState *s)
     S390MachineProps mach;
 
     if (!kvm_s390_get_machine_props(s, &mach)) {
-        cpu_classes_initialized = false;
+        if (!s390_setup_cpu_classes(ACCEL_ID_KVM, &mach)) {
+            cpu_classes_initialized = true;
+        }
     }
 }
 
-- 
1.8.3.1
