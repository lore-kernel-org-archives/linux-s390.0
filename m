From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 26 Jul 2018 19:54:08 +0000
Subject: [PATCH v7 01/22] s390/zcrypt: Add ZAPQ inline function.
Message-Id: <20180726195429.31960-2-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Harald Freudenberger <freude@de.ibm.com>

Added new inline function ap_pqap_zapq()
which is a C inline function wrapper for
the AP PQAP(ZAPQ) instruction.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/ap_asm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/s390/crypto/ap_asm.h b/drivers/s390/crypto/ap_asm.h
index 16b59ce5e01d..b22d30aaf810 100644
--- a/drivers/s390/crypto/ap_asm.h
+++ b/drivers/s390/crypto/ap_asm.h
@@ -69,6 +69,25 @@ static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
 	return reg1;
 }
 
+/**
+ * ap_pqap_zapq(): Reset and zeroize adjunct processor queue.
+ * @qid: The AP queue number
+ *
+ * Returns AP queue status structure.
+ */
+static inline struct ap_queue_status ap_zapq(ap_qid_t qid)
+{
+	register unsigned long reg0 asm ("0") = qid | (2UL << 24);
+	register struct ap_queue_status reg1 asm ("1");
+
+	asm volatile(
+		".long 0xb2af0000"		/* PQAP(ZAPQ) */
+		: "=d" (reg1)
+		: "d" (reg0)
+		: "cc");
+	return reg1;
+}
+
 /**
  * ap_aqic(): Control interruption for a specific AP.
  * @qid: The AP queue number
-- 
2.17.0
