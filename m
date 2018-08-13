From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v9 02/22] s390/zcrypt: Review inline assembler constraints.
Date: Mon, 13 Aug 2018 17:47:59 -0400
Message-ID: <1534196899-16987-3-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Harald Freudenberger <freude@de.ibm.com>

Reviewed and adapted the register use and asm constraints
of the C inline assembler functions in accordance to the
the AP instructions specifications.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_asm.h |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/crypto/ap_asm.h b/drivers/s390/crypto/ap_asm.h
index b22d30a..e22ee12 100644
--- a/drivers/s390/crypto/ap_asm.h
+++ b/drivers/s390/crypto/ap_asm.h
@@ -20,14 +20,16 @@ static inline int ap_instructions_available(void)
 {
 	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
 	register unsigned long reg1 asm ("1") = -ENODEV;
-	register unsigned long reg2 asm ("2") = 0UL;
+	register unsigned long reg2 asm ("2");
 
 	asm volatile(
 		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
-		"0: la    %1,0\n"
+		"0: la    %0,0\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: "+d" (reg0), "+d" (reg1), "+d" (reg2) : : "cc");
+		: "+d" (reg1), "=d" (reg2)
+		: "d" (reg0)
+		: "cc");
 	return reg1;
 }
 
@@ -42,10 +44,12 @@ static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
 {
 	register unsigned long reg0 asm ("0") = qid;
 	register struct ap_queue_status reg1 asm ("1");
-	register unsigned long reg2 asm ("2") = 0UL;
+	register unsigned long reg2 asm ("2");
 
 	asm volatile(".long 0xb2af0000"		/* PQAP(TAPQ) */
-		     : "+d" (reg0), "=d" (reg1), "+d" (reg2) : : "cc");
+		     : "=d" (reg1), "=d" (reg2)
+		     : "d" (reg0)
+		     : "cc");
 	if (info)
 		*info = reg2;
 	return reg1;
@@ -59,13 +63,14 @@ static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
  */
 static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
 {
-	register unsigned long reg0 asm ("0") = qid | 0x01000000UL;
+	register unsigned long reg0 asm ("0") = qid | (1UL << 24);
 	register struct ap_queue_status reg1 asm ("1");
-	register unsigned long reg2 asm ("2") = 0UL;
 
 	asm volatile(
 		".long 0xb2af0000"		/* PQAP(RAPQ) */
-		: "+d" (reg0), "=d" (reg1), "+d" (reg2) : : "cc");
+		: "=d" (reg1)
+		: "d" (reg0)
+		: "cc");
 	return reg1;
 }
 
@@ -107,8 +112,8 @@ static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
 
 	asm volatile(
 		".long 0xb2af0000"		/* PQAP(AQIC) */
-		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
-		:
+		: "=d" (reg1_out)
+		: "d" (reg0), "d" (reg1_in), "d" (reg2)
 		: "cc");
 	return reg1_out;
 }
@@ -120,17 +125,17 @@ static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
  */
 static inline int ap_qci(void *config)
 {
-	register unsigned long reg0 asm ("0") = 0x04000000UL;
+	register unsigned long reg0 asm ("0") = 4UL << 24;
 	register unsigned long reg1 asm ("1") = -EINVAL;
 	register void *reg2 asm ("2") = (void *) config;
 
 	asm volatile(
 		".long 0xb2af0000\n"		/* PQAP(QCI) */
-		"0: la    %1,0\n"
+		"0: la    %0,0\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: "+d" (reg0), "+d" (reg1), "+d" (reg2)
-		:
+		: "+d" (reg1)
+		: "d" (reg0), "d" (reg2)
 		: "cc", "memory");
 
 	return reg1;
@@ -169,12 +174,13 @@ static inline struct ap_queue_status ap_qact(ap_qid_t qid, int ifbit,
 		| ((ifbit & 0x01) << 22);
 	register unsigned long reg1_in asm ("1") = apinfo->val;
 	register struct ap_queue_status reg1_out asm ("1");
-	register unsigned long reg2 asm ("2") = 0;
+	register unsigned long reg2 asm ("2");
 
 	asm volatile(
 		".long 0xb2af0000"		/* PQAP(QACT) */
-		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
-		: : "cc");
+		: "+d" (reg1_in), "=d" (reg1_out), "=d" (reg2)
+		: "d" (reg0)
+		: "cc");
 	apinfo->val = reg2;
 	return reg1_out;
 }
-- 
1.7.1
