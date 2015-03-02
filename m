From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 05/16] target-s390x: Generate facility defines per cpu model
Date: Mon,  2 Mar 2015 13:43:57 +0100
Message-ID: <1425300248-40277-6-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch introduces the helper "gen-facilities" which allows to generate
facility list definitions and masks at compile time. Its flexibility is
better and the error-proneness is lower when compared to static programming
time added statements.

The helper includes "target-s390x/cpu-facilities.h" to be able to use named
facility bits instead of numbers. Its output will be feed back into the
cpu model related header file "target-s390x/cpu-models.h" by including
"target-s390x/gen-facilities.h" to implement model related data structures.

The following defines/symbols are expected to be provided by the cpu-facilities
header file:

FAC_LIST_ARCH_S390_SIZE_UINT8
FAC_N3
FAC_ZARCH
FAC_ZARCH_ACTIVE
...

The defines provided by gen-facilities follow the following schema:

FAC_LIST_CPU_S390_SIZE_UINT1 %PRIu32
FAC_LIST_CPU_S390_SIZE_UINT8 %PRIu32
FAC_LIST_CPU_S390_SIZE_UINT64 %PRIu32
FAC_LIST_CPU_S390_MASK_QEMU 0x%016PRIx64,0x%016PRIx64,...
FAC_LIST_CPU_S390_<TYPE>_GA<n> 0x%016PRIx64,0x%016PRIx64,...

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 Makefile.target               |   2 +-
 rules.mak                     |   3 +
 target-s390x/Makefile.objs    |  18 ++
 target-s390x/gen-facilities.c | 401 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 423 insertions(+), 1 deletion(-)
 create mode 100644 target-s390x/gen-facilities.c

diff --git a/Makefile.target b/Makefile.target
index 58c6ae1..d174d5e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -188,7 +188,7 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx
 qmp-commands-old.h: $(SRC_PATH)/qmp-commands.hx
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"  GEN   $(TARGET_DIR)$@")
 
-clean:
+clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
 	rm -f hmp-commands.h qmp-commands-old.h gdbstub-xml.c
diff --git a/rules.mak b/rules.mak
index 3a05627..d367e23 100644
--- a/rules.mak
+++ b/rules.mak
@@ -13,6 +13,9 @@ MAKEFLAGS += -rR
 %.m:
 %.mak:
 
+# default target cleanup
+clean-target:
+
 # Flags for C++ compilation
 QEMU_CXXFLAGS = -D__STDC_LIMIT_MACROS $(filter-out -Wstrict-prototypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls, $(QEMU_CFLAGS))
 
diff --git a/target-s390x/Makefile.objs b/target-s390x/Makefile.objs
index dd62cbd..1b65776 100644
--- a/target-s390x/Makefile.objs
+++ b/target-s390x/Makefile.objs
@@ -3,3 +3,21 @@ obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
 obj-$(CONFIG_KVM) += kvm.o
+
+# build and run facility generator
+#
+fac = gen-facilities
+fac-src = $(SRC_PATH)/target-$(TARGET_BASE_ARCH)
+fac-dst = $(SRC_PATH)/$(TARGET_DIR)
+fac-bin = $(TARGET_DIR)$(fac)
+fac-h = $(fac-bin).h
+GENERATED_HEADERS += $(fac-dst)$(fac).h
+
+$(fac-dst)$(fac).h: $(fac-dst)$(fac)
+	$(call quiet-command,$< >$@,"  GEN   $(fac-h)")
+
+$(fac-dst)$(fac): $(fac-src)/$(fac).c $(fac-src)/cpu-facilities.h
+	$(call quiet-command,$(CC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(CFLAGS) -o $@ $<,"  CC    $(fac-bin)")
+
+clean-target:
+	rm -f $(fac-bin) $(fac-h)
diff --git a/target-s390x/gen-facilities.c b/target-s390x/gen-facilities.c
new file mode 100644
index 0000000..9d48bcc
--- /dev/null
+++ b/target-s390x/gen-facilities.c
@@ -0,0 +1,401 @@
+/*
+ * S390 facility list/mask generator
+ *
+ * Copyright 2015 IBM Corp.
+ *
+ * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <assert.h>
+#include <values.h>
+#include "cpu-facilities.h"
+
+/***** BEGIN FACILITY DEFS *****/
+
+/*******************************
+ * CMOS G7 processors
+ *******************************/
+
+/* 2064-GA1 */
+static uint16_t set_2064_GA1[] = {
+    FAC_N3,
+    FAC_ZARCH,
+    FAC_ZARCH_ACTIVE,
+};
+#define clear_2064_GA1 EmptyFacs
+
+/* 2064-GA2 */
+static uint16_t set_2064_GA2[] = {
+    FAC_EXTENDED_TRANSLATION_2,
+};
+#define clear_2064_GA2 EmptyFacs
+
+/* 2064-GA3 */
+#define set_2064_GA3 EmptyFacs
+#define clear_2064_GA3 EmptyFacs
+
+/* 2066-GA1 */
+#define set_2066_GA1 EmptyFacs
+#define clear_2066_GA1 EmptyFacs
+
+/*******************************
+ * CMOS G8 processors
+ *******************************/
+
+/* 2084-GA1 */
+static uint16_t set_2084_GA1[] = {
+    FAC_DAT_ENH,
+    FAC_MESSAGE_SECURITY_ASSIST,
+    FAC_LONG_DISPLACEMENT,
+    FAC_LONG_DISPLACEMENT_FAST,
+    FAC_HFP_MADDSUB,
+};
+#define clear_2084_GA1 EmptyFacs
+
+/* 2084-GA2 */
+static uint16_t set_2084_GA2[] = {
+    4,
+};
+#define clear_2084_GA2 EmptyFacs
+
+/* 2084-GA3 */
+static uint16_t set_2084_GA3[] = {
+    FAC_ASN_LX_REUSE,
+    FAC_EXTENDED_TRANSLATION_3,
+};
+#define clear_2084_GA3 EmptyFacs
+
+/* 2084-GA4 */
+#define set_2084_GA4 EmptyFacs
+#define clear_2084_GA4 EmptyFacs
+
+/* 2084-GA5 */
+static uint16_t set_2084_GA5[] = {
+    FAC_TOD_CLOCK_STEERING,
+};
+#define clear_2084_GA5 EmptyFacs
+
+/* 2086-GA1 */
+#define set_2086_GA1 EmptyFacs
+#define clear_2086_GA1 EmptyFacs
+
+/* 2086-GA2 */
+#define set_2086_GA2 EmptyFacs
+#define clear_2086_GA2 EmptyFacs
+
+/* 2086-GA3 */
+#define set_2086_GA3 EmptyFacs
+#define clear_2086_GA3 EmptyFacs
+
+/*******************************
+ * CMOS G9 processors
+ *******************************/
+
+/* 2094-GA1 */
+static uint16_t set_2094_GA1[] = {
+    FAC_STFLE,
+    FAC_EXTENDED_IMMEDIATE,
+    FAC_HFP_UNNORMALIZED_EXT,
+    FAC_ETF2_ENH,
+    FAC_STORE_CLOCK_FAST,
+    FAC_ETF3_ENH,
+    FAC_EXTRACT_CPU_TIME,
+};
+#define clear_2094_GA1 EmptyFacs
+
+/* 2094-GA2 */
+static uint16_t set_2094_GA2[] = {
+    FAC_SENSE_RUNNING_STATUS,
+    FAC_MOVE_WITH_OPTIONAL_SPEC,
+    FAC_COMPARE_AND_SWAP_AND_STORE,
+    FAC_FLOATING_POINT_SUPPPORT_ENH,
+    FAC_DFP,
+};
+#define clear_2094_GA2 EmptyFacs
+
+/* 2094-GA3 */
+static uint16_t set_2094_GA3[] = {
+    FAC_PFPO,
+};
+#define clear_2094_GA3 EmptyFacs
+
+/* 2096-GA1 */
+#define set_2096_GA1 EmptyFacs
+#define clear_2096_GA1 EmptyFacs
+
+/* 2096-GA2 */
+#define set_2096_GA2 EmptyFacs
+#define clear_2096_GA2 EmptyFacs
+
+/*******************************
+ * CMOS G10 processors
+ *******************************/
+
+/* 2097-GA1 */
+static uint16_t set_2097_GA1[] = {
+    FAC_ENHANCED_DAT_1,
+    FAC_CONDITIONAL_SSKE,
+    FAC_CONFIGURATION_TOPOLOGY,
+    FAC_PARSING_ENH,
+    FAC_COMPARE_AND_SWAP_AND_STORE_2,
+    FAC_GENERAL_INSTRUCTIONS_EXT,
+    FAC_EXECUTE_EXT,
+    FAC_DFP_FAST,
+};
+#define clear_2097_GA1 EmptyFacs
+
+/* 2097-GA2 */
+static uint16_t set_2097_GA2[] = {
+    65,
+    FAC_CPU_MEASUREMENT_COUNTER,
+    FAC_CPU_MEASUREMENT_SAMPLING,
+};
+#define clear_2097_GA2 EmptyFacs
+
+/* 2097-GA3 */
+static uint16_t set_2097_GA3[] = {
+    FAC_LOAD_PROGRAM_PARAMETERS,
+};
+#define clear_2097_GA3 EmptyFacs
+
+/* 2098-GA1 */
+#define set_2098_GA1 EmptyFacs
+#define clear_2098_GA1 EmptyFacs
+
+/* 2098-GA2 */
+#define set_2098_GA2 EmptyFacs
+#define clear_2098_GA2 EmptyFacs
+
+/*******************************
+ * CMOS G11 processors
+ *******************************/
+
+/* 2817-GA1 */
+static uint16_t set_2817_GA1[] = {
+    FAC_ENHANCED_MONITOR,
+    FAC_FLOATING_POINT_EXT,
+    FAC_MULTI_45,
+    46,
+    FAC_ACCESS_EXCEPTION_FS_INDICATION,
+};
+static uint16_t clear_2817_GA1[] = {
+    65,
+};
+
+/* 2817-GA2 */
+static uint16_t set_2817_GA2[] = {
+    FAC_IPTE_RANGE,
+    FAC_NONQ_KEY_SETTING,
+    FAC_CMPSC_ENH,
+    FAC_RESET_REFERENCE_BITS_MULTIPLE,
+    FAC_MESSAGE_SECURITY_ASSIST_3,
+    FAC_MESSAGE_SECURITY_ASSIST_4,
+};
+#define clear_2817_GA2 EmptyFacs
+
+/* 2818-GA1 */
+#define set_2818_GA1 EmptyFacs
+#define clear_2818_GA1 EmptyFacs
+
+/*******************************
+ * CMOS G12 processors
+ *******************************/
+
+/* 2827-GA1 */
+static uint16_t set_2827_GA1[] = {
+    FAC_DFP_ZONED_CONVERSION,
+    FAC_MULTI_49,
+    FAC_CONSTRAINT_TRANSACTIONAL_EXE,
+    FAC_LOCAL_TLB_CLEARING,
+    FAC_INTERLOCKED_ACCESS_2,
+    FAC_TRANSACTIONAL_EXE,
+    FAC_ENHANCED_DAT_2,
+};
+#define clear_2827_GA1 EmptyFacs
+
+/* 2827-GA2 */
+#define set_2827_GA2 EmptyFacs
+#define clear_2827_GA2 EmptyFacs
+
+/* 2828-GA1 */
+#define set_2828_GA1 EmptyFacs
+#define clear_2828_GA1 EmptyFacs
+
+/****** END FACILITY DEFS ******/
+
+#define S390_ARCH_FAC_LIST_SIZE_BYTE \
+    (S390_ARCH_FAC_LIST_SIZE / 8)
+
+#define _YEARS  "2014, 2015"
+#define _NAME_H "TARGET_S390X_GEN_FACILITIES_H"
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
+
+#define FAC_INITIALIZER(_name)                         \
+    {                                                  \
+        .Name = "FAC_LIST_CPU_S390_" #_name,           \
+        .SetBits =                                     \
+            { .Data = set_##_name,                     \
+              .Length = ARRAY_SIZE(set_##_name) },     \
+        .ClearBits =                                   \
+            { .Data = clear_##_name,                   \
+              .Length = ARRAY_SIZE(clear_##_name) },   \
+    }
+
+enum BitOps {
+    SetBit,
+    ClearBit,
+};
+
+typedef struct BitSpec {
+    uint16_t *Data;
+    uint32_t Length;
+} BitSpec;
+
+typedef struct FacDefSpec {
+    const char *Name;
+    BitSpec SetBits;
+    BitSpec ClearBits;
+} FacDefSpec;
+
+static uint16_t EmptyFacs[] = {};
+
+/*******************************
+ * processor GA series
+ *******************************/
+static FacDefSpec FacDef[] = {
+    FAC_INITIALIZER(2064_GA1),
+    FAC_INITIALIZER(2064_GA2),
+    FAC_INITIALIZER(2064_GA3),
+    FAC_INITIALIZER(2066_GA1),
+    FAC_INITIALIZER(2084_GA1),
+    FAC_INITIALIZER(2084_GA2),
+    FAC_INITIALIZER(2084_GA3),
+    FAC_INITIALIZER(2086_GA1),
+    FAC_INITIALIZER(2084_GA4),
+    FAC_INITIALIZER(2086_GA2),
+    FAC_INITIALIZER(2084_GA5),
+    FAC_INITIALIZER(2086_GA3),
+    FAC_INITIALIZER(2094_GA1),
+    FAC_INITIALIZER(2094_GA2),
+    FAC_INITIALIZER(2094_GA3),
+    FAC_INITIALIZER(2096_GA1),
+    FAC_INITIALIZER(2096_GA2),
+    FAC_INITIALIZER(2097_GA1),
+    FAC_INITIALIZER(2097_GA2),
+    FAC_INITIALIZER(2098_GA1),
+    FAC_INITIALIZER(2097_GA3),
+    FAC_INITIALIZER(2098_GA2),
+    FAC_INITIALIZER(2817_GA1),
+    FAC_INITIALIZER(2817_GA2),
+    FAC_INITIALIZER(2818_GA1),
+    FAC_INITIALIZER(2827_GA1),
+    FAC_INITIALIZER(2827_GA2),
+    FAC_INITIALIZER(2828_GA1),
+};
+
+/*******************************
+ * QEMU facility list mask
+ *******************************/
+#define set_MASK_QEMU EmptyFacs
+#define clear_MASK_QEMU EmptyFacs
+
+static FacDefSpec QemuMaskDef = FAC_INITIALIZER(MASK_QEMU);
+
+static void BigEndianBitOps(enum BitOps BitOp, uint64_t Facility[],
+                            uint32_t MaxWord, BitSpec Bits)
+{
+    uint32_t i, Bit, Word, WidthInBits;
+
+    WidthInBits = _TYPEBITS(typeof(Facility[0]));
+    for (i = 0; i < Bits.Length; i++) {
+        Bit = (WidthInBits - 1) - (Bits.Data[i] & (WidthInBits - 1));
+        Word = Bits.Data[i] / WidthInBits;
+        assert(Word < MaxWord);
+        switch (BitOp) {
+        case SetBit:
+            Facility[Word] |= __UINT64_C(1) << Bit;
+            break;
+        case ClearBit:
+            Facility[Word] &= ~(__UINT64_C(1) << Bit);
+            break;
+        }
+    }
+}
+
+static uint32_t PrintFacilityList(uint32_t Model, FacDefSpec FacDef[])
+{
+    uint32_t i, Words, Size;
+    uint64_t Facility[FAC_LIST_ARCH_S390_SIZE_UINT8];
+
+    for (Size = ARRAY_SIZE(Facility), i = 0; i < Size; i++) {
+        Facility[i] = __UINT64_C(0);
+    }
+    for (i = 0; i <= Model; i++) {
+        BigEndianBitOps(SetBit, Facility, Size, FacDef[i].SetBits);
+        BigEndianBitOps(ClearBit, Facility, Size, FacDef[i].ClearBits);
+    }
+    for (Words = 0, i = 0; i < Size; i++) {
+        if (Facility[i]) {
+            Words = i;
+        }
+    }
+    printf("#define %s\t", FacDef[Model].Name);
+    for (i = 0; i <= Words; i++) {
+        printf("0x%016"PRIx64"%c", Facility[i], i < Words ? ',' : '\n');
+    }
+    return ++Words;
+}
+
+static inline uint32_t Max(uint32_t uIntA, uint32_t uIntB)
+{
+    if (uIntA > uIntB) {
+        return uIntA;
+    }
+    return uIntB;
+}
+
+static inline void PrintAllFacilityDefs(void)
+{
+    uint32_t i, MaxWords, MaxBytes, MaxBits;
+
+    printf("\n/* CPU model facility list data */\n");
+    for (MaxWords = 0, i = 0; i < ARRAY_SIZE(FacDef); i++) {
+        MaxWords = Max(PrintFacilityList(i, FacDef), MaxWords);
+    }
+    printf("\n/* QEMU facility mask data */\n");
+    MaxWords = Max(PrintFacilityList(0, &QemuMaskDef), MaxWords);
+    MaxBytes = MaxWords * sizeof(uint64_t);
+    MaxBits = MaxBytes * CHARBITS;
+    printf("\n/* facility list/mask sizes */\n");
+    printf("#define FAC_LIST_CPU_S390_SIZE_UINT1\t%"PRIu32"\n", MaxBits);
+    printf("#define FAC_LIST_CPU_S390_SIZE_UINT8\t%"PRIu32"\n", MaxBytes);
+    printf("#define FAC_LIST_CPU_S390_SIZE_UINT64\t%"PRIu32"\n", MaxWords);
+}
+
+int main(int argc, char *argv[])
+{
+    printf("/*\n"
+           " * AUTOMATICALLY GENERATED, DO NOT MODIFY HERE, EDIT\n"
+           " * SOURCE FILE \"%s\" INSTEAD.\n"
+           " *\n"
+           " * Copyright %s IBM Corp.\n"
+           " *\n"
+           " * This work is licensed under the terms of the GNU GPL, "
+           "version 2 or (at\n * your option) any later version. See "
+           "the COPYING file in the top-level\n * directory.\n"
+           " */\n\n"
+           "#ifndef %s\n#define %s\n", __FILE__, _YEARS, _NAME_H, _NAME_H);
+    PrintAllFacilityDefs();
+    printf("\n#endif\n");
+    return 0;
+}
-- 
1.8.3.1
