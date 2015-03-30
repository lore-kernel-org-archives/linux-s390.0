From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 05/15] target-s390x: Define cpu model
	specific facility lists
Date: Mon, 30 Mar 2015 16:28:18 +0200
Message-ID: <1427725708-52100-6-git-send-email-mimu@linux.vnet.ibm.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>
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
 target-s390x/cpu-models.c | 12 ++++++++++++
 target-s390x/cpu-models.h |  8 ++++++++
 target-s390x/cpu.c        |  1 +
 3 files changed, 21 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 908e8eb..028e3de 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -12,6 +12,7 @@
 
 #include "qemu-common.h"
 #include "cpu-models.h"
+#include "gen-facilities.h"
 
 #define S390_PROC_DEF(_name, _cpu_id, _desc)                            \
     static void                                                         \
@@ -20,6 +21,10 @@
     {                                                                   \
         DeviceClass *dc = DEVICE_CLASS(oc);                             \
         S390CPUClass *cc = S390_CPU_CLASS(oc);                          \
+        uint64_t nbits = FAC_LIST_CPU_S390_SIZE_UINT1;                  \
+        uint64_t fac_list[FAC_LIST_CPU_S390_SIZE_UINT64] = {            \
+            glue(FAC_LIST_, _cpu_id)                                    \
+        };                                                              \
                                                                         \
         cc->mach.ga    = cpu_ga(_cpu_id);                               \
         cc->mach.class = cpu_class(_cpu_id);                            \
@@ -29,6 +34,7 @@
         cc->proc.id    = S390_DEF_ID;                                   \
         cc->proc.type  = cpu_type(_cpu_id);                             \
         cc->proc.ibc   = S390_DEF_IBC;                                  \
+        bitmap_copy(cc->proc.fac_list, fac_list, nbits);                \
         dc->desc       = _desc;                                         \
     }                                                                   \
     static const TypeInfo                                               \
@@ -45,6 +51,11 @@
     }                                                                   \
     type_init(glue(_cpu_id, _cpu_register_types))
 
+/* facilities implemented by qemu */
+uint64_t qemu_s390_fac_list_mask[FAC_LIST_CPU_S390_SIZE_UINT64] = {
+    FAC_LIST_CPU_S390_MASK_QEMU
+};
+
 /* define S390 CPU model classes */
 S390_PROC_DEF("2064-ga1", CPU_S390_2064_GA1, "IBM zSeries 900 GA1")
 S390_PROC_DEF("2064-ga2", CPU_S390_2064_GA2, "IBM zSeries 900 GA2")
@@ -75,3 +86,4 @@ S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
 S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
 S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
 S390_PROC_DEF("2964-ga1", CPU_S390_2964_GA1, "IBM z13 GA1")
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index b02c38b..948af10 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -13,6 +13,14 @@
 #ifndef TARGET_S390X_CPU_MODELS_H
 #define TARGET_S390X_CPU_MODELS_H
 
+#include "cpu-facilities.h"
+#include "gen-facilities.h"
+
+#define FAC_LIST_ARCH_S390_SIZE_UINT1 \
+    (FAC_LIST_ARCH_S390_SIZE_UINT8 * BITS_PER_BYTE)
+#define FAC_LIST_ARCH_S390_SIZE_UINT64 \
+    (FAC_LIST_ARCH_S390_SIZE_UINT8 / sizeof(uint64_t))
+
 #define S390_EC 0x1
 #define S390_BC 0x2
 
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index e0537fa..0db62c2 100644
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
-- 
1.8.3.1
