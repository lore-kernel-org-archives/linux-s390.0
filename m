From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 12/17] target-s390x: Add S390 CPU class initialization routines
Date: Mon, 13 Apr 2015 15:56:31 +0200
Message-ID: <1428933396-37887-13-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch provides routines to dynamically update the previously defined
S390 CPU classes in the current host context. The main function performing
this process is s390_setup_cpu_classes(). It takes the current host context
and a facility list mask as parameter to setup the classes accordingly. It
basically performs the following sub-tasks:

- Update of CPU classes with accelerator specific host and QEMU properties
- Mark adequate CPU class as default CPU class to be used for CPU model 'host'
- Invalidate CPU classes not supported by this hosting machine
- Define machine type aliases to latest GA number of a processor model
- Define aliases for common CPU model names
- Set CPU model alias 'host' to default CPU class

Forthermore the patch provides the following routines:

- cpu_desc_avail(), s390 specific stub indicating that list_cpus() can run
- s390_setup_cpu_aliases(), adds cu model aliases
- s390_cpu_classes_initialized(), test if CPU classes have been initialized
- s390_fac_list_mask_by_machine(), returns facility list mask by machine
- s390_current_fac_list_mask(), returns facility list mask of current machine

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 500 ++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  29 +++
 target-s390x/cpu.c        |  17 +-
 target-s390x/kvm.c        |   5 +-
 4 files changed, 549 insertions(+), 2 deletions(-)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 28251f9..07039c0 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -13,6 +13,11 @@
 #include "qemu-common.h"
 #include "cpu-models.h"
 #include "gen-facilities.h"
+#include "qemu/error-report.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/cpu-common.h"
+#include "hw/boards.h"
+#endif
 
 #define S390_PROC_DEF(_name, _cpu_id, _desc)                            \
     static void                                                         \
@@ -88,8 +93,41 @@ S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
 S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
 S390_PROC_DEF("2964-ga1", CPU_S390_2964_GA1, "IBM z13 GA1")
 
+/* some types for calls to g_list_foreach() with parameters */
+typedef struct ParmBoolShortShort {
+    bool valid;
+    unsigned short type;
+    union {
+        unsigned short class;
+        unsigned short gen;
+        unsigned short ga;
+    };
+} ParmBoolShortShort;
+
+typedef struct ParmAddrAddrModeMask {
+    S390MachineProps *prop;
+    S390CPUClass *host_cc;
+    S390AccelMode mode;
+    uint64_t *mask;
+} ParmAddrAddrModeMask;
+
 GSList *s390_cpu_aliases;
 
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
 static gint s390_cpu_compare_name(gconstpointer a, gconstpointer b)
 {
     char *aname = strdup_cpu_name((S390CPUClass *) a);
@@ -170,3 +208,465 @@ int set_s390_cpu_alias(const char *name, const char *model)
     return 0;
 }
 
+/* return machine class for specific machine type */
+static void s390_machine_class_test_cpu_class(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmBoolShortShort *parm = user_data;
+
+    if (parm->valid || is_cpu_class_none(cc) || parm->type != cc->proc.type) {
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
+    ParmBoolShortShort parm_class, *parm = user_data;
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
+    ParmBoolShortShort *parm = user_data;
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
+    ParmBoolShortShort parm;
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
+    ParmAddrAddrModeMask *parm = user_data;
+    ParmBoolShortShort parm_tc;
+
+    if (!cc->is_active[parm->mode]) {
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
+        cc->is_host[parm->mode] = true;
+        parm->host_cc = cc;
+        return;
+    }
+    if (cc->proc.gen > machine_gen(cpuid_type(parm->prop->cpuid))) {
+        /* sort out CMOS generations later than hosts generation */
+        cc->is_active[parm->mode] = false;
+        return;
+    }
+    if (cc->mach.order > parm->host_cc->mach.order) {
+        /* select later machine as host */
+        parm->host_cc->is_host[parm->mode] = false;
+        cc->is_host[parm->mode] = true;
+        parm->host_cc = cc;
+    }
+}
+
+/* update a specific cpu model class with host retrieved configuration */
+static void s390_update_cpu_class(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    ParmAddrAddrModeMask *parm = user_data;
+    S390CPUClass *cc = S390_CPU_CLASS(oc);
+    uint64_t nbits = FAC_LIST_CPU_S390_SIZE_UINT1;
+    static uint64_t fac_list[FAC_LIST_CPU_S390_SIZE_UINT64];
+
+    cc->is_host[parm->mode] = false;
+
+    if (is_cpu_class_none(cc)) {
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
+    if (has_ibc(parm->prop->ibc)) {
+        if (cc->proc.gen >= S390_CMOS_G10) {
+            cc->proc.ibc = ((cc->proc.gen - S390_CMOS_G10) << 4);
+            cc->proc.ibc += cc->mach.ga;
+            if (cc->mach.class == S390_BC) {
+                cc->proc.ibc++;
+            }
+            if (cc->proc.ibc < oldest_ibc(parm->prop->ibc)) {
+                cc->proc.ibc = oldest_ibc(parm->prop->ibc);
+            }
+            if (cc->proc.ibc > newest_ibc(parm->prop->ibc)) {
+                cc->proc.ibc = newest_ibc(parm->prop->ibc);
+            }
+        } else {
+            cc->proc.ibc = oldest_ibc(parm->prop->ibc);
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
+    if (parm->mask) {
+        bitmap_or(cc->fac_list[parm->mode], parm->mask,
+                  parm->prop->fac_mask, nbits);
+        bitmap_and(cc->fac_list[parm->mode], cc->fac_list[parm->mode],
+                   cc->proc.fac_list, nbits);
+    } else {
+        bitmap_and(cc->fac_list[parm->mode], parm->prop->fac_mask,
+                   cc->proc.fac_list, nbits);
+    }
+
+    /*
+     * Finally, mark the cpu class active if all resulting/desired
+     * facilities are offered by the host.
+     * (RFL & MFL) != RFL
+     */
+    bitmap_and(fac_list, cc->fac_list[parm->mode], parm->prop->fac_list, nbits);
+    if (bitmap_equal(fac_list, cc->fac_list[parm->mode], nbits)) {
+        cc->is_active[parm->mode] = true;
+    }
+}
+
+/* cpu models newer than the hosting machine are not supported */
+static void s390_disable_not_supported_cpu_class(gpointer data,
+                                                 gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmAddrAddrModeMask *parm = user_data;
+
+    if (!cc->is_active[parm->mode]) {
+        return;
+    }
+    if (parm->host_cc) {
+        if (cc->proc.gen < parm->host_cc->proc.gen) {
+            return;
+        }
+        if (cc->proc.gen == parm->host_cc->proc.gen) {
+            if (cc->mach.class == parm->host_cc->mach.class &&
+                cc->mach.ga <= parm->host_cc->mach.ga) {
+                return;
+            }
+            if (cc->mach.class == S390_EC &&
+                cc->mach.ga > parm->host_cc->mach.ga) {
+                return;
+            }
+            if (cc->mach.class == S390_BC &&
+                cc->mach.ga < parm->host_cc->mach.ga) {
+                return;
+            }
+        }
+    }
+    cc->is_active[parm->mode] = false;
+}
+
+static void set_s390_cpu_alias_by_type_ga(unsigned short type,
+                                          unsigned short ga)
+{
+    set_s390_cpu_alias(g_strdup_printf("%04x", type),
+                       g_strdup_printf("%04x-ga%u", type, ga));
+}
+
+/* set cpu model type alias to newest ga release */
+static void s390_set_ga_alias(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+    ParmBoolShortShort *parm = user_data;
+
+    if (!cc->is_active[ACCEL_CURRENT]) {
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
+/* set cpu model alias host to cpu class marked is host cpu class */
+static void s390_set_host_alias(gpointer data, gpointer user_data)
+{
+    S390CPUClass *cc = S390_CPU_CLASS((ObjectClass *) data);
+
+    if (cc->is_active[ACCEL_CURRENT] && cc->is_host[ACCEL_CURRENT]) {
+        set_s390_cpu_alias("host", g_strdup_printf("%04x-ga%u",
+                                                   cc->proc.type,
+                                                   cc->mach.ga));
+    }
+}
+
+/**
+ * s390_setup_cpu_classes:
+ * @mode: the accelerator mode
+ * @prop: the machine property structure's address
+ *
+ * This function validates the defined cpu classes against the given
+ * machine properties @prop. Only cpu classes that are runnable on the
+ * current host will be set active. In addition the corresponding
+ * cpuid, ibc value and the active set of facilities will be
+ * initialized. Depending on @mode, the function porforms operations
+ * on the current or the temporary accelerator properies.
+ *
+ * Since: 2.4
+ */
+void s390_setup_cpu_classes(S390AccelMode mode, S390MachineProps *prop,
+                            uint64_t *fac_list_mask)
+{
+    GSList *list;
+    ParmAddrAddrModeMask parm = {
+        .mode = mode,
+        .prop = prop,
+        .mask = fac_list_mask,
+        .host_cc = NULL,
+    };
+
+    list = object_class_get_list(TYPE_S390_CPU, false);
+    list = g_slist_sort(list, s390_cpu_class_asc_order_compare);
+
+    g_slist_foreach(list, (GFunc) s390_update_cpu_class, (gpointer) &parm);
+    g_slist_foreach(list, (GFunc) s390_mark_host_cpu_class, (gpointer) &parm);
+    g_slist_foreach(list, (GFunc) s390_disable_not_supported_cpu_class, &parm);
+
+    g_slist_free(list);
+}
+
+/**
+ * s390_setup_cpu_aliases:
+ *
+ * This function addes cpu model aliases that will allow to specify common
+ * model names in cunjunction with the -cpu command line parameter.
+ * There will be aliases for cpu types, pointing to the respective newest
+ * ga of a cpu type, aliases like z-something which are widely known and
+ * a the alias host pointing to the cpu type representing the current hosting
+ * mahine.
+ *
+ * Since: 2.4
+ */
+void s390_setup_cpu_aliases(void)
+{
+    GSList *list;
+    ParmBoolShortShort parm = { .type = 0, .ga = 0 };
+
+    list = object_class_get_list(TYPE_S390_CPU, false);
+    list = g_slist_sort(list, s390_cpu_class_asc_order_compare);
+
+    g_slist_foreach(list, (GFunc) s390_set_ga_alias, &parm);
+    set_s390_cpu_alias_by_type_ga(parm.type, parm.ga);
+
+    set_s390_cpu_alias("z900",   "2064");
+    set_s390_cpu_alias("z800",   "2066");
+    set_s390_cpu_alias("z990",   "2084");
+    set_s390_cpu_alias("z890",   "2086");
+    set_s390_cpu_alias("z9-109", "2094-ga1");
+    set_s390_cpu_alias("z9",     "2094");
+    set_s390_cpu_alias("z9-ec",  "2094");
+    set_s390_cpu_alias("z9-bc",  "2096");
+    set_s390_cpu_alias("z10",    "2097");
+    set_s390_cpu_alias("z10-ec", "2097");
+    set_s390_cpu_alias("z10-bc", "2098");
+    set_s390_cpu_alias("z196",   "2817");
+    set_s390_cpu_alias("z114",   "2818");
+    set_s390_cpu_alias("zEC12",  "2827");
+    set_s390_cpu_alias("zBC12",  "2828");
+    set_s390_cpu_alias("z13",    "2964");
+
+    g_slist_foreach(list, (GFunc) s390_set_host_alias, &parm);
+
+    g_slist_free(list);
+}
+
+/* list all supported cpu models and alias names */
+void s390_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *alias_oc, *oc = data;
+    CPUListState *s = user_data;
+    DeviceClass  *dc = DEVICE_CLASS(oc);
+    S390CPUClass *cc = S390_CPU_CLASS(oc);
+    S390CPUAlias *alias;
+    GSList *item;
+    char *name;
+
+    if (!kvm_enabled()) {
+        return;
+    }
+    if (!cc->is_active[ACCEL_CURRENT]) {
+        return;
+    }
+    name = strdup_cpu_name(cc);
+    (*s->cpu_fprintf)(s->file, "s390 %-10s %s\n",
+                      name, dc->desc ? dc->desc : "");
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
+ * Since: 2.4
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
+ * s390_fac_list_mask_by_machine:
+ * @name: machine name
+ *
+ * This function returns the address of a facility list mask to
+ * be used in cunjunction with the specified machine type name
+ * or alias.
+ *
+ * Returns: The address of the facility list mask or %NULL in case
+ *          @name is not a valid machine type name or alias
+ *
+ * Since: 2.4
+ */
+#ifndef CONFIG_USER_ONLY
+uint64_t *s390_fac_list_mask_by_machine(const char *name)
+{
+    uint64_t *mask = NULL;
+    GSList *machine, *mlist = object_class_get_list(TYPE_MACHINE, false);
+    MachineClass *mc;
+
+    for (machine = mlist; machine; machine = machine->next) {
+        mc = machine->data;
+        if (!strcmp(mc->name, name) ||
+            (mc->alias && !strcmp(mc->alias, name))) {
+            /* add cases as required */
+            mask = qemu_s390_fac_list_mask;
+            break;
+        }
+    }
+    return mask;
+}
+#endif
+
+/**
+ * s390_current_fac_list_mask:
+ *
+ * This function returns the address of a facility list mask of the
+ * currently active machine.
+ *
+ * Returns: The address of the facility list mask.
+ *
+ * Since: 2.4
+ */
+#ifndef CONFIG_USER_ONLY
+uint64_t *s390_current_fac_list_mask(void)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(MACHINE(qdev_get_machine()));
+
+    return s390_fac_list_mask_by_machine(mc->name);
+}
+#endif
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index efa255e..00454d3 100644
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
 /*
  * S390 cpu aliases will be added dynamically
  */
@@ -60,6 +80,14 @@ typedef struct S390MachineProps {
 
 ObjectClass *s390_cpu_class_by_name(const char *name);
 int set_s390_cpu_alias(const char *name, const char *model);
+void s390_setup_cpu_classes(S390AccelMode mode, S390MachineProps *prop,
+                            uint64_t *fac_list_mask);
+void s390_setup_cpu_aliases(void);
+gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
+void s390_cpu_list_entry(gpointer data, gpointer user_data);
+bool s390_cpu_classes_initialized(void);
+uint64_t *s390_fac_list_mask_by_machine(const char *name);
+uint64_t *s390_current_fac_list_mask(void);
 
 #ifdef CONFIG_KVM
 int kvm_s390_get_processor_props(S390ProcessorProps *prop);
@@ -81,6 +109,7 @@ static inline bool kvm_s390_cpu_classes_initialized(void)
 #endif
 
 extern GSList *s390_cpu_aliases;
+extern uint64_t qemu_s390_fac_list_mask[];
 
 /*
  * bits 0-7   : CMOS generation
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index c081885..cbab627 100644
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
index 42f01a8..784ea8c 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -293,7 +293,10 @@ static void kvm_setup_cpu_classes(KVMState *s)
     S390MachineProps mach;
 
     if (!kvm_s390_get_machine_props(s, &mach)) {
-        cpu_classes_initialized = false;
+        s390_setup_cpu_classes(ACCEL_CURRENT, &mach,
+                               s390_current_fac_list_mask());
+        s390_setup_cpu_aliases();
+        cpu_classes_initialized = true;
     }
 }
 
-- 
1.8.3.1
