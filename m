From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 04/16] target-s390x: Introduce cpu facilities
Date: Mon,  2 Mar 2015 13:43:56 +0100
Message-ID: <1425300248-40277-5-git-send-email-mimu@linux.vnet.ibm.com>
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

The patch introduces S390 CPU facility bit numbers and names
as well as the architectural facility size limit in bytes.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-facilities.h | 76 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 target-s390x/cpu-facilities.h

diff --git a/target-s390x/cpu-facilities.h b/target-s390x/cpu-facilities.h
new file mode 100644
index 0000000..1f1716a
--- /dev/null
+++ b/target-s390x/cpu-facilities.h
@@ -0,0 +1,76 @@
+/*
+ * CPU facilities for s390
+ *
+ * Copyright 2015 IBM Corp.
+ *
+ * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef TARGET_S390X_CPU_FACILITIES_H
+#define TARGET_S390X_CPU_FACILITIES_H
+
+/* architectural size of facilities is 2KB */
+#define FAC_LIST_ARCH_S390_SIZE_UINT8 (1<<11)
+
+/* CPU facility bits */
+typedef enum {
+    FAC_N3                              = 0,
+    FAC_ZARCH                           = 1,
+    FAC_ZARCH_ACTIVE                    = 2,
+    FAC_DAT_ENH                         = 3,
+    FAC_ASN_LX_REUSE                    = 6,
+    FAC_STFLE                           = 7,
+    FAC_ENHANCED_DAT_1                  = 8,
+    FAC_SENSE_RUNNING_STATUS            = 9,
+    FAC_CONDITIONAL_SSKE                = 10,
+    FAC_CONFIGURATION_TOPOLOGY          = 11,
+    FAC_IPTE_RANGE                      = 13,
+    FAC_NONQ_KEY_SETTING                = 14,
+    FAC_EXTENDED_TRANSLATION_2          = 16,
+    FAC_MESSAGE_SECURITY_ASSIST         = 17,
+    FAC_LONG_DISPLACEMENT               = 18,
+    FAC_LONG_DISPLACEMENT_FAST          = 19,
+    FAC_HFP_MADDSUB                     = 20,
+    FAC_EXTENDED_IMMEDIATE              = 21,
+    FAC_EXTENDED_TRANSLATION_3          = 22,
+    FAC_HFP_UNNORMALIZED_EXT            = 23,
+    FAC_ETF2_ENH                        = 24,
+    FAC_STORE_CLOCK_FAST                = 25,
+    FAC_PARSING_ENH                     = 26,
+    FAC_MOVE_WITH_OPTIONAL_SPEC         = 27,
+    FAC_TOD_CLOCK_STEERING              = 28,
+    FAC_ETF3_ENH                        = 30,
+    FAC_EXTRACT_CPU_TIME                = 31,
+    FAC_COMPARE_AND_SWAP_AND_STORE      = 32,
+    FAC_COMPARE_AND_SWAP_AND_STORE_2    = 33,
+    FAC_GENERAL_INSTRUCTIONS_EXT        = 34,
+    FAC_EXECUTE_EXT                     = 35,
+    FAC_ENHANCED_MONITOR                = 36,
+    FAC_FLOATING_POINT_EXT              = 37,
+    FAC_LOAD_PROGRAM_PARAMETERS         = 40,
+    FAC_FLOATING_POINT_SUPPPORT_ENH     = 41,
+    FAC_DFP                             = 42,
+    FAC_DFP_FAST                        = 43,
+    FAC_PFPO                            = 44,
+    FAC_MULTI_45                        = 45,
+    FAC_CMPSC_ENH                       = 47,
+    FAC_DFP_ZONED_CONVERSION            = 48,
+    FAC_MULTI_49                        = 49,
+    FAC_CONSTRAINT_TRANSACTIONAL_EXE    = 50,
+    FAC_LOCAL_TLB_CLEARING              = 51,
+    FAC_INTERLOCKED_ACCESS_2            = 52,
+    FAC_RESET_REFERENCE_BITS_MULTIPLE   = 66,
+    FAC_CPU_MEASUREMENT_COUNTER         = 67,
+    FAC_CPU_MEASUREMENT_SAMPLING        = 68,
+    FAC_TRANSACTIONAL_EXE               = 73,
+    FAC_ACCESS_EXCEPTION_FS_INDICATION  = 75,
+    FAC_MESSAGE_SECURITY_ASSIST_3       = 76,
+    FAC_MESSAGE_SECURITY_ASSIST_4       = 77,
+    FAC_ENHANCED_DAT_2                  = 78,
+} S390Facility;
+
+#endif
-- 
1.8.3.1
