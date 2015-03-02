From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 06/16] target-s390x: Introduce cpu models
Date: Mon,  2 Mar 2015 13:43:58 +0100
Message-ID: <1425300248-40277-7-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the static part of the s390 cpu class definitions.
It defines s390 cpu models by means of virtual cpu ids (enum) which contain
information on the cpu generation, the machine class, the GA number and
the machine type. The cpu id is used to instantiate a cpu class per cpu
model.

In addition the patch introduces the QMP enumeration AccelId. It is used
to index certain cpu model poperties per accelerator.

Furthermore it extends the existing S390CPUClass by model related properties.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 qapi-schema.json           | 11 +++++++
 target-s390x/Makefile.objs |  1 +
 target-s390x/cpu-models.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h  | 71 ++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-qom.h     | 25 +++++++++++++++
 5 files changed, 185 insertions(+)
 create mode 100644 target-s390x/cpu-models.c
 create mode 100644 target-s390x/cpu-models.h

diff --git a/qapi-schema.json b/qapi-schema.json
index e16f8eb..ea436ec 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2473,6 +2473,17 @@
 ##
 { 'command': 'query-machines', 'returns': ['MachineInfo'] }
 
+
+##
+# @AccelId
+#
+# Defines accelerator ids
+#
+# Since: 2.3
+##
+{ 'enum': 'AccelId',
+  'data': ['qtest', 'tcg', 'kvm', 'xen'  ] }
+
 ##
 # @CpuDefinitionInfo:
 #
diff --git a/target-s390x/Makefile.objs b/target-s390x/Makefile.objs
index 1b65776..4ee0f1d 100644
--- a/target-s390x/Makefile.objs
+++ b/target-s390x/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y += translate.o helper.o cpu.o interrupt.o
 obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
 obj-y += gdbstub.o
+obj-y += cpu-models.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
 obj-$(CONFIG_KVM) += kvm.o
 
diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
new file mode 100644
index 0000000..3520691
--- /dev/null
+++ b/target-s390x/cpu-models.c
@@ -0,0 +1,77 @@
+/*
+ * CPU models for s390
+ *
+ * Copyright 2014,2015 IBM Corp.
+ *
+ * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu-common.h"
+#include "cpu-models.h"
+
+#define S390_PROC_DEF(_name, _cpu_id, _desc)                            \
+    static void                                                         \
+    glue(_cpu_id, _cpu_class_init)                                      \
+    (ObjectClass *oc, void *data)                                       \
+    {                                                                   \
+        DeviceClass *dc = DEVICE_CLASS(oc);                             \
+        S390CPUClass *cc = S390_CPU_CLASS(oc);                          \
+                                                                        \
+        cc->is_active[ACCEL_ID_KVM] = true;                             \
+        cc->mach.ga    = cpu_ga(_cpu_id);                               \
+        cc->mach.class = cpu_class(_cpu_id);                            \
+        cc->mach.order = cpu_order(_cpu_id);                            \
+        cc->proc.gen   = cpu_generation(_cpu_id);                       \
+        cc->proc.ver   = S390_DEF_VERSION;                              \
+        cc->proc.id    = S390_DEF_ID;                                   \
+        cc->proc.type  = cpu_type(_cpu_id);                             \
+        cc->proc.ibc   = S390_DEF_IBC;                                  \
+        dc->desc       = _desc;                                         \
+    }                                                                   \
+    static const TypeInfo                                               \
+    glue(_cpu_id, _cpu_type_info) = {                                   \
+        .name       = _name "-" TYPE_S390_CPU,                          \
+        .parent     = TYPE_S390_CPU,                                    \
+        .class_init = glue(_cpu_id, _cpu_class_init),                   \
+    };                                                                  \
+    static void                                                         \
+    glue(_cpu_id, _cpu_register_types)(void)                            \
+    {                                                                   \
+        type_register_static(                                           \
+            &glue(_cpu_id, _cpu_type_info));                            \
+    }                                                                   \
+    type_init(glue(_cpu_id, _cpu_register_types))
+
+/* define S390 CPU model classes */
+S390_PROC_DEF("2064-ga1", CPU_S390_2064_GA1, "IBM zSeries 900 GA1")
+S390_PROC_DEF("2064-ga2", CPU_S390_2064_GA2, "IBM zSeries 900 GA2")
+S390_PROC_DEF("2064-ga3", CPU_S390_2064_GA3, "IBM zSeries 900 GA3")
+S390_PROC_DEF("2066-ga1", CPU_S390_2066_GA1, "IBM zSeries 800 GA1")
+S390_PROC_DEF("2084-ga1", CPU_S390_2084_GA1, "IBM zSeries 990 GA1")
+S390_PROC_DEF("2084-ga2", CPU_S390_2084_GA2, "IBM zSeries 990 GA2")
+S390_PROC_DEF("2084-ga3", CPU_S390_2084_GA3, "IBM zSeries 990 GA3")
+S390_PROC_DEF("2084-ga4", CPU_S390_2084_GA4, "IBM zSeries 990 GA4")
+S390_PROC_DEF("2084-ga5", CPU_S390_2084_GA5, "IBM zSeries 990 GA5")
+S390_PROC_DEF("2086-ga1", CPU_S390_2086_GA1, "IBM zSeries 890 GA1")
+S390_PROC_DEF("2086-ga2", CPU_S390_2086_GA2, "IBM zSeries 890 GA2")
+S390_PROC_DEF("2086-ga3", CPU_S390_2086_GA3, "IBM zSeries 890 GA3")
+S390_PROC_DEF("2094-ga1", CPU_S390_2094_GA1, "IBM System z9 EC GA1")
+S390_PROC_DEF("2094-ga2", CPU_S390_2094_GA2, "IBM System z9 EC GA2")
+S390_PROC_DEF("2094-ga3", CPU_S390_2094_GA3, "IBM System z9 EC GA3")
+S390_PROC_DEF("2096-ga1", CPU_S390_2096_GA1, "IBM System z9 BC GA1")
+S390_PROC_DEF("2096-ga2", CPU_S390_2096_GA2, "IBM System z9 BC GA2")
+S390_PROC_DEF("2097-ga1", CPU_S390_2097_GA1, "IBM System z10 EC GA1")
+S390_PROC_DEF("2097-ga2", CPU_S390_2097_GA2, "IBM System z10 EC GA2")
+S390_PROC_DEF("2097-ga3", CPU_S390_2097_GA3, "IBM System z10 EC GA3")
+S390_PROC_DEF("2098-ga1", CPU_S390_2098_GA1, "IBM System z10 BC GA1")
+S390_PROC_DEF("2098-ga2", CPU_S390_2098_GA2, "IBM System z10 BC GA2")
+S390_PROC_DEF("2817-ga1", CPU_S390_2817_GA1, "IBM zEnterprise 196 GA1")
+S390_PROC_DEF("2817-ga2", CPU_S390_2817_GA2, "IBM zEnterprise 196 GA2")
+S390_PROC_DEF("2818-ga1", CPU_S390_2818_GA1, "IBM zEnterprise 114 GA1")
+S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
+S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
+S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
new file mode 100644
index 0000000..db681bf
--- /dev/null
+++ b/target-s390x/cpu-models.h
@@ -0,0 +1,71 @@
+/*
+ * CPU models for s390
+ *
+ * Copyright 2014,2015 IBM Corp.
+ *
+ * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef TARGET_S390X_CPU_MODELS_H
+#define TARGET_S390X_CPU_MODELS_H
+
+#define S390_EC 0x1
+#define S390_BC 0x2
+
+#define S390_DEF_VERSION 0xff
+#define S390_DEF_IBC     0x0
+#define S390_DEF_ID      0xdecade
+#define S390_DEF_TYPE    0x2064
+
+#define cpu_type(x)       (((x) >>  0) & 0xffff)
+#define cpu_order(x)      (((x) >> 16) & 0xffff)
+#define cpu_ga(x)         (((x) >> 16) & 0xf)
+#define cpu_class(x)      (((x) >> 20) & 0x3)
+#define cpu_generation(x) (((x) >> 24) & 0xff)
+
+/*
+ * bits 0-7   : CMOS generation
+ * bits 8-9   : reserved
+ * bits 10-11 : machine class 0=unknown 1=EC 2=BC
+ * bits 12-15 : GA
+ * bits 16-31 : machine type
+ *
+ * note: bits are named according to s390
+ *       architecture specific endienness
+ */
+enum {
+    CPU_S390_2064_GA1 = 0x07112064,
+    CPU_S390_2064_GA2 = 0x07122064,
+    CPU_S390_2064_GA3 = 0x07132064,
+    CPU_S390_2066_GA1 = 0x07212066,
+    CPU_S390_2084_GA1 = 0x08112084,
+    CPU_S390_2084_GA2 = 0x08122084,
+    CPU_S390_2084_GA3 = 0x08132084,
+    CPU_S390_2084_GA4 = 0x08142084,
+    CPU_S390_2084_GA5 = 0x08152084,
+    CPU_S390_2086_GA1 = 0x08212086,
+    CPU_S390_2086_GA2 = 0x08222086,
+    CPU_S390_2086_GA3 = 0x08232086,
+    CPU_S390_2094_GA1 = 0x09112094,
+    CPU_S390_2094_GA2 = 0x09122094,
+    CPU_S390_2094_GA3 = 0x09132094,
+    CPU_S390_2096_GA1 = 0x09212096,
+    CPU_S390_2096_GA2 = 0x09222096,
+    CPU_S390_2097_GA1 = 0x0a112097,
+    CPU_S390_2097_GA2 = 0x0a122097,
+    CPU_S390_2097_GA3 = 0x0a132097,
+    CPU_S390_2098_GA1 = 0x0a212098,
+    CPU_S390_2098_GA2 = 0x0a222098,
+    CPU_S390_2817_GA1 = 0x0b112817,
+    CPU_S390_2817_GA2 = 0x0b122817,
+    CPU_S390_2818_GA1 = 0x0b212818,
+    CPU_S390_2827_GA1 = 0x0c112827,
+    CPU_S390_2827_GA2 = 0x0c122827,
+    CPU_S390_2828_GA1 = 0x0c212828,
+};
+
+#endif
diff --git a/target-s390x/cpu-qom.h b/target-s390x/cpu-qom.h
index 8b376df..a9a5029 100644
--- a/target-s390x/cpu-qom.h
+++ b/target-s390x/cpu-qom.h
@@ -22,6 +22,7 @@
 
 #include "qom/cpu.h"
 #include "cpu.h"
+#include "gen-facilities.h"
 
 #define TYPE_S390_CPU "s390-cpu"
 
@@ -32,6 +33,24 @@
 #define S390_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(S390CPUClass, (obj), TYPE_S390_CPU)
 
+/* machine related properties */
+typedef struct S390CPUMachineProps {
+    uint16_t class;      /* machine class */
+    uint16_t ga;         /* availability number of machine */
+    uint16_t order;      /* order of availability */
+} S390CPUMachineProps;
+
+/* processor related properties */
+typedef struct S390CPUProcessorProps {
+    uint16_t gen;        /* S390 CMOS generation */
+    uint16_t ver;        /* version of processor */
+    uint32_t id;         /* processor identification*/
+    uint16_t type;       /* machine type */
+    uint16_t ibc;        /* IBC value */
+                         /* processor related facility list */
+    uint64_t fac_list[FAC_LIST_CPU_S390_SIZE_UINT64];
+} S390CPUProcessorProps;
+
 /**
  * S390CPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -52,6 +71,12 @@ typedef struct S390CPUClass {
     void (*load_normal)(CPUState *cpu);
     void (*cpu_reset)(CPUState *cpu);
     void (*initial_cpu_reset)(CPUState *cpu);
+    bool is_active[ACCEL_ID_MAX]; /* model enabled for given host and accel */
+    bool is_host[ACCEL_ID_MAX];   /* model markes host for given accel */
+                                  /* active facility list */
+    uint64_t fac_list[FAC_LIST_CPU_S390_SIZE_UINT64];
+    S390CPUMachineProps   mach;   /* machine specific properties */
+    S390CPUProcessorProps proc;   /* processor specific properties */
 } S390CPUClass;
 
 /**
-- 
1.8.3.1
