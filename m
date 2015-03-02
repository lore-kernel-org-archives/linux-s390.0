From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 15/16] target-s390x: Introduce facility test routine
Date: Mon,  2 Mar 2015 13:44:07 +0100
Message-ID: <1425300248-40277-16-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch introduces routine s390_facility_test() which allows to
verify a specific facility bit is set.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 30 ++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 7ad61df..5c4eac5 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -698,3 +698,33 @@ bool s390_cpu_models_used(void)
 {
     return cpu_models_used;
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
+ * Since: 2.3
+ */
+bool s390_test_facility(S390CPUClass *cc, uint16_t nr)
+{
+    if (!cc) {
+        return false;
+    }
+    return test_facility(cc->fac_list, nr) ? true : false;
+}
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index 3605aa4..557f5e5 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -116,6 +116,7 @@ bool s390_cpu_classes_initialized(void);
 bool s390_probe_mode(void);
 void s390_cpu_model_init(S390CPUClass *cc);
 bool s390_cpu_models_used(void);
+bool s390_test_facility(S390CPUClass *cc, uint16_t nr);
 
 /*
  * bits 0-7   : CMOS generation
-- 
1.8.3.1
