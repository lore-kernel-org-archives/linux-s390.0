From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 06/15] cpu-model/s390: Define cpu model specific facility lists
Date: Tue, 17 Feb 2015 15:24:04 +0100
Message-ID: <1424183053-4310-7-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch defines S390 cpu facilities and their presence at the
different cpu model levels. Beside defining a base which facilities
have to be requested per cpu model, these sets are associated to the
defined cpu classes and used to calculate the list of supported
cpu models in context of the current hosting machine model.

The also defined qemu side facility mask allows to implement and enable
facilities in QEMU land.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c |  13 ++++
 target-s390x/cpu-models.h | 182 ++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu.c        |   3 +
 3 files changed, 198 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 4841553..9e5c5fb 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -13,6 +13,8 @@
 #include "qemu-common.h"
 #include "cpu-models.h"
 
+#define S390_FAC_NAME(n, _cpu_id) glue(glue(glue(FAC, n), _), _cpu_id)
+
 #define S390_PROC_DEF(_name, _cpu_id, _desc)                            \
     static void                                                         \
     glue(_cpu_id, _cpu_class_init)                                      \
@@ -22,6 +24,7 @@
         S390CPUClass *cc = S390_CPU_CLASS(oc);                          \
                                                                         \
         cc->is_active[ACCEL_ID_KVM] = true;                             \
+        cc->fac_list    = g_malloc0(S390_ARCH_FAC_LIST_SIZE_BYTE);;     \
         cc->mach        = g_malloc0(sizeof(S390CPUMachineProps));       \
         cc->mach->ga    = cpu_ga(_cpu_id);                              \
         cc->mach->class = cpu_class(_cpu_id);                           \
@@ -32,6 +35,9 @@
         cc->proc->id    = S390_DEF_ID;                                  \
         cc->proc->type  = cpu_type(_cpu_id);                            \
         cc->proc->ibc   = S390_DEF_IBC;                                 \
+        cc->proc->fac_list = g_malloc0(S390_ARCH_FAC_LIST_SIZE_BYTE);   \
+        cc->proc->fac_list[0] = S390_FAC_NAME(0, _cpu_id);              \
+        cc->proc->fac_list[1] = S390_FAC_NAME(1, _cpu_id);              \
         dc->desc        = _desc;                                        \
     }                                                                   \
     static const TypeInfo                                               \
@@ -48,6 +54,12 @@
     }                                                                   \
     type_init(glue(_cpu_id, _cpu_register_types))
 
+/* facilities iplemented by qemu */
+uint64_t qemu_s390_fac_list_mask[] = {
+    FAC0_QEMU_S390_MASK,
+    FAC1_QEMU_S390_MASK,
+};
+
 /* define S390 CPU model classes */
 S390_PROC_DEF("2064-ga1", CPU_S390_2064_GA1, "IBM zSeries 900 GA1")
 S390_PROC_DEF("2064-ga2", CPU_S390_2064_GA2, "IBM zSeries 900 GA2")
@@ -77,3 +89,4 @@ S390_PROC_DEF("2818-ga1", CPU_S390_2818_GA1, "IBM zEnterprise 114 GA1")
 S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
 S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
 S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index db681bf..41af159 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -13,6 +13,13 @@
 #ifndef TARGET_S390X_CPU_MODELS_H
 #define TARGET_S390X_CPU_MODELS_H
 
+#include "cpu-facilities.h"
+
+#define S390_ARCH_FAC_LIST_SIZE_BYTE \
+    (S390_ARCH_FAC_LIST_SIZE)
+#define S390_ARCH_FAC_LIST_SIZE_UINT64 \
+    (S390_ARCH_FAC_LIST_SIZE / sizeof(uint64_t))
+
 #define S390_EC 0x1
 #define S390_BC 0x2
 
@@ -68,4 +75,179 @@ enum {
     CPU_S390_2828_GA1 = 0x0c212828,
 };
 
+#define S390_FAC_LIST_SIZE_UINT64 2
+#define S390_FAC_LIST_SIZE_BYTE                 \
+    (S390_FAC_LIST_SIZE_UINT64 * sizeof(uint64_t))
+#define S390_FAC_LIST_SIZE_BIT                  \
+    (S390_FAC_LIST_SIZE_BYTE << 3)
+
+#define FAC_BIT(WORD, BIT) \
+    (BIT / 64 == WORD ? 1ull << (63 - BIT % 64) : 0)
+
+/* S390 CPU facilities defined in QEMU mask */
+#define FAC0_QEMU_S390_MASK 0ULL
+#define FAC1_QEMU_S390_MASK 0ULL
+
+/* S390 CPU facility sets defined per CPU type and GA */
+#define FAC0_CPU_S390_2064_GA1                  \
+    (FAC_BIT(0, FAC_N3)                         \
+     | FAC_BIT(0, FAC_ZARCH)                    \
+     | FAC_BIT(0, FAC_ZARCH_ACTIVE))
+#define FAC1_CPU_S390_2064_GA1 0ULL
+
+#define FAC0_CPU_S390_2064_GA2                           \
+    (FAC0_CPU_S390_2064_GA1                              \
+     | FAC_BIT(0, FAC_EXTENDED_TRANSLATION_2))
+#define FAC1_CPU_S390_2064_GA2 FAC1_CPU_S390_2064_GA1
+
+#define FAC0_CPU_S390_2064_GA3 FAC0_CPU_S390_2064_GA2
+#define FAC1_CPU_S390_2064_GA3 FAC1_CPU_S390_2064_GA2
+
+#define FAC0_CPU_S390_2066_GA1 FAC0_CPU_S390_2064_GA3
+#define FAC1_CPU_S390_2066_GA1 FAC1_CPU_S390_2064_GA3
+
+#define FAC0_CPU_S390_2084_GA1                            \
+    (FAC0_CPU_S390_2064_GA3                               \
+     | FAC_BIT(0, FAC_DAT_ENH)                            \
+     | FAC_BIT(0, FAC_MESSAGE_SECURITY_ASSIST)            \
+     | FAC_BIT(0, FAC_LONG_DISPLACEMENT)                  \
+     | FAC_BIT(0, FAC_LONG_DISPLACEMENT_FAST)             \
+     | FAC_BIT(0, FAC_HFP_MADDSUB))
+#define FAC1_CPU_S390_2084_GA1 FAC1_CPU_S390_2064_GA3
+
+#define FAC0_CPU_S390_2084_GA2                            \
+    (FAC0_CPU_S390_2084_GA1                               \
+     | FAC_BIT(0, 4))
+#define FAC1_CPU_S390_2084_GA2 FAC1_CPU_S390_2084_GA1
+
+#define FAC0_CPU_S390_2084_GA3                            \
+    (FAC0_CPU_S390_2084_GA2                               \
+     | FAC_BIT(0, FAC_ASN_LX_REUSE)                       \
+     | FAC_BIT(0, FAC_EXTENDED_TRANSLATION_3))
+#define FAC1_CPU_S390_2084_GA3 FAC1_CPU_S390_2084_GA2
+
+#define FAC0_CPU_S390_2084_GA4 FAC0_CPU_S390_2084_GA3
+#define FAC1_CPU_S390_2084_GA4 FAC1_CPU_S390_2084_GA3
+
+#define FAC0_CPU_S390_2084_GA5                                   \
+    (FAC0_CPU_S390_2084_GA4                                      \
+     | FAC_BIT(0, FAC_TOD_CLOCK_STEERING))
+#define FAC1_CPU_S390_2084_GA5 FAC1_CPU_S390_2084_GA4
+
+#define FAC0_CPU_S390_2086_GA1 FAC0_CPU_S390_2084_GA3
+#define FAC1_CPU_S390_2086_GA1 FAC1_CPU_S390_2084_GA3
+
+#define FAC0_CPU_S390_2086_GA2 FAC0_CPU_S390_2084_GA4
+#define FAC1_CPU_S390_2086_GA2 FAC1_CPU_S390_2084_GA4
+
+#define FAC0_CPU_S390_2086_GA3 FAC0_CPU_S390_2084_GA5
+#define FAC1_CPU_S390_2086_GA3 FAC1_CPU_S390_2084_GA5
+
+#define FAC0_CPU_S390_2094_GA1                                   \
+    (FAC0_CPU_S390_2084_GA5                                      \
+     | FAC_BIT(0, FAC_STFLE)                                     \
+     | FAC_BIT(0, FAC_EXTENDED_IMMEDIATE)                        \
+     | FAC_BIT(0, FAC_HFP_UNNORMALIZED_EXT)                      \
+     | FAC_BIT(0, FAC_ETF2_ENH)                                  \
+     | FAC_BIT(0, FAC_STORE_CLOCK_FAST)                          \
+     | FAC_BIT(0, FAC_ETF3_ENH)                                  \
+     | FAC_BIT(0, FAC_EXTRACT_CPU_TIME))
+#define FAC1_CPU_S390_2094_GA1 FAC1_CPU_S390_2084_GA5
+
+#define FAC0_CPU_S390_2094_GA2                                   \
+    (FAC0_CPU_S390_2094_GA1                                      \
+     | FAC_BIT(0, FAC_SENSE_RUNNING_STATUS)                      \
+     | FAC_BIT(0, FAC_MOVE_WITH_OPTIONAL_SPEC)                   \
+     | FAC_BIT(0, FAC_COMPARE_AND_SWAP_AND_STORE)                \
+     | FAC_BIT(0, FAC_FLOATING_POINT_SUPPPORT_ENH)               \
+     | FAC_BIT(0, FAC_DFP))
+#define FAC1_CPU_S390_2094_GA2 FAC1_CPU_S390_2094_GA1
+
+#define FAC0_CPU_S390_2094_GA3                                  \
+    (FAC0_CPU_S390_2094_GA2                                     \
+      | FAC_BIT(0, FAC_PFPO))
+#define FAC1_CPU_S390_2094_GA3 FAC1_CPU_S390_2094_GA2
+
+#define FAC0_CPU_S390_2096_GA1 FAC0_CPU_S390_2094_GA3
+#define FAC1_CPU_S390_2096_GA1 FAC1_CPU_S390_2094_GA3
+
+#define FAC0_CPU_S390_2096_GA2 FAC0_CPU_S390_2096_GA1
+#define FAC1_CPU_S390_2096_GA2 FAC1_CPU_S390_2096_GA1
+
+#define FAC0_CPU_S390_2097_GA1                                     \
+    (FAC0_CPU_S390_2094_GA3                                        \
+     | FAC_BIT(0, FAC_ENHANCED_DAT_1)                              \
+     | FAC_BIT(0, FAC_CONDITIONAL_SSKE)                            \
+     | FAC_BIT(0, FAC_CONFIGURATION_TOPOLOGY)                      \
+     | FAC_BIT(0, FAC_PARSING_ENH)                                 \
+     | FAC_BIT(0, FAC_COMPARE_AND_SWAP_AND_STORE_2)                \
+     | FAC_BIT(0, FAC_GENERAL_INSTRUCTIONS_EXT)                    \
+     | FAC_BIT(0, FAC_EXECUTE_EXT)                                \
+     | FAC_BIT(0, FAC_DFP_FAST))
+#define FAC1_CPU_S390_2097_GA1 FAC1_CPU_S390_2094_GA3
+
+#define FAC0_CPU_S390_2097_GA2 FAC0_CPU_S390_2097_GA1
+#define FAC1_CPU_S390_2097_GA2                                     \
+    (FAC1_CPU_S390_2097_GA1                                        \
+     | FAC_BIT(1, 65)                                              \
+     | FAC_BIT(1, FAC_CPU_MEASUREMENT_COUNTER)                     \
+     | FAC_BIT(1, FAC_CPU_MEASUREMENT_SAMPLING))
+
+#define FAC0_CPU_S390_2097_GA3                           \
+    (FAC0_CPU_S390_2097_GA2                              \
+      | FAC_BIT(0, FAC_LOAD_PROGRAM_PARAMETERS))
+#define FAC1_CPU_S390_2097_GA3 FAC1_CPU_S390_2097_GA2
+
+#define FAC0_CPU_S390_2098_GA1 FAC0_CPU_S390_2097_GA2
+#define FAC1_CPU_S390_2098_GA1 FAC1_CPU_S390_2097_GA2
+
+#define FAC0_CPU_S390_2098_GA2 FAC0_CPU_S390_2097_GA3
+#define FAC1_CPU_S390_2098_GA2 FAC1_CPU_S390_2097_GA3
+
+#define FAC0_CPU_S390_2817_GA1                                     \
+    (FAC0_CPU_S390_2097_GA3                                        \
+     | FAC_BIT(0, FAC_ENHANCED_MONITOR)                            \
+     | FAC_BIT(0, FAC_FLOATING_POINT_EXT)                          \
+     | FAC_BIT(0, FAC_MULTI_45)                                    \
+     | FAC_BIT(0, 46))
+#define FAC1_CPU_S390_2817_GA1                                     \
+    ((FAC1_CPU_S390_2097_GA3                                       \
+      & ~FAC_BIT(1, 65))                                           \
+    | FAC_BIT(1, FAC_ACCESS_EXCEPTION_FS_INDICATION))
+
+#define FAC0_CPU_S390_2817_GA2                                          \
+    (FAC0_CPU_S390_2817_GA1                                             \
+     | FAC_BIT(0, FAC_IPTE_RANGE)                                       \
+     | FAC_BIT(0, FAC_NONQ_KEY_SETTING)                                 \
+     | FAC_BIT(0, FAC_CMPSC_ENH))
+#define FAC1_CPU_S390_2817_GA2                                          \
+    (FAC1_CPU_S390_2817_GA1                                             \
+     | FAC_BIT(1, FAC_RESET_REFERENCE_BITS_MULTIPLE)                    \
+     | FAC_BIT(1, FAC_MESSAGE_SECURITY_ASSIST_3)                        \
+     | FAC_BIT(1, FAC_MESSAGE_SECURITY_ASSIST_4))
+
+#define FAC0_CPU_S390_2818_GA1 FAC0_CPU_S390_2817_GA2
+#define FAC1_CPU_S390_2818_GA1 FAC1_CPU_S390_2817_GA2
+
+#define FAC0_CPU_S390_2827_GA1                                          \
+    (FAC0_CPU_S390_2817_GA2                                             \
+     | FAC_BIT(0, FAC_DFP_ZONED_CONVERSION)                             \
+     | FAC_BIT(0, FAC_MULTI_49)                                         \
+     | FAC_BIT(0, FAC_CONSTRAINT_TRANSACTIONAL_EXE)                     \
+     | FAC_BIT(0, FAC_LOCAL_TLB_CLEARING)                               \
+     | FAC_BIT(0, FAC_INTERLOCKED_ACCESS_2))
+#define FAC1_CPU_S390_2827_GA1                           \
+    (FAC1_CPU_S390_2817_GA2                              \
+     | FAC_BIT(1, FAC_TRANSACTIONAL_EXE)                 \
+     | FAC_BIT(1, FAC_ENHANCED_DAT_2))
+
+#define FAC0_CPU_S390_2827_GA2 FAC0_CPU_S390_2827_GA1
+#define FAC1_CPU_S390_2827_GA2 FAC1_CPU_S390_2827_GA1
+
+#define FAC0_CPU_S390_2828_GA1 FAC0_CPU_S390_2827_GA2
+#define FAC1_CPU_S390_2828_GA1 FAC1_CPU_S390_2827_GA2
+
+#define FAC0_CPU_S390_2964_GA1 FAC0_CPU_S390_2828_GA1
+#define FAC1_CPU_S390_2964_GA1 FAC1_CPU_S390_2828_GA1
+
 #endif
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 1040765..f30856e 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "trace.h"
+#include "cpu-models.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
 #endif
@@ -327,6 +328,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_core_xml_file = "s390x-core64.xml";
     scc->mach = g_malloc0(sizeof(*scc->mach));
     scc->proc = g_malloc0(sizeof(*scc->proc));
+    scc->fac_list = g_malloc0(S390_ARCH_FAC_LIST_SIZE_BYTE);
+    scc->proc->fac_list = g_malloc0(S390_ARCH_FAC_LIST_SIZE_BYTE);
 }
 
 static const TypeInfo s390_cpu_type_info = {
-- 
1.8.3.1
