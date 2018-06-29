From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 01/21] s390/zcrypt: Add ZAPQ inline function.
Date: Fri, 29 Jun 2018 17:11:03 -0400
Message-ID: <1530306683-7270-2-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Harald Freudenberger <freude@de.ibm.com>

Added new inline function ap_pqap_zapq()
which is a C inline function wrapper for
the AP PQAP(ZAPQ) instruction.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_asm.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/ap_asm.h b/drivers/s390/crypto/ap_asm.h
index 16b59ce..b22d30a 100644
--- a/drivers/s390/crypto/ap_asm.h
+++ b/drivers/s390/crypto/ap_asm.h
@@ -70,6 +70,25 @@ static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
 }
 
 /**
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
+/**
  * ap_aqic(): Control interruption for a specific AP.
  * @qid: The AP queue number
  * @qirqctrl: struct ap_qirq_ctrl (64 bit value)
-- 
1.7.1
