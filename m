From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 16/17] target-s390x: Introduce S390 CPU
	facility test routine
Date: Mon, 13 Apr 2015 15:56:35 +0200
Message-ID: <1428933396-37887-17-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
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

The patch introduces routine s390_facility_test() which allows to
verify if a specific facility bit is set.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 29 +++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index b696897..f218dde 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -715,3 +715,32 @@ void s390_cpu_model_init(S390CPUClass *cc)
         kvm_s390_set_processor_props(&proc);
     }
 }
+
+static inline int test_facility(uint64_t *fac_list, uint16_t nr)
+{
+    uint16_t word = nr / BITS_PER_LONG;
+    uint16_t be_bit = (BITS_PER_LONG - 1) - (nr % BITS_PER_LONG);
+
+    return (nr < FAC_LIST_CPU_S390_SIZE_UINT1) ?
+        (fac_list[word] >> be_bit) & __UINT64_C(1) : 0;
+}
+
+/**
+ * s390_test_facility:
+ * @nr: facility bit number to test
+ * @cc: cpu class to test
+ *
+ * The functions tests if the cpu facility identified by bit @nr is available
+ * to the cpu class @cc.
+ *
+ * Returns: a boolean value.
+ *
+ * Since: 2.4
+ */
+bool s390_test_facility(S390CPUClass *cc, uint16_t nr)
+{
+    if (!cc) {
+        return false;
+    }
+    return test_facility(cc->fac_list[ACCEL_CURRENT], nr) ? true : false;
+}
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index 76673f4..23242aa 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -93,6 +93,7 @@ bool s390_cpu_classes_initialized(void);
 uint64_t *s390_fac_list_mask_by_machine(const char *name);
 uint64_t *s390_current_fac_list_mask(void);
 void s390_cpu_model_init(S390CPUClass *cc);
+bool s390_test_facility(S390CPUClass *cc, uint16_t nr);
 
 #ifdef CONFIG_KVM
 int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop);
-- 
1.8.3.1
