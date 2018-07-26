From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 26 Jul 2018 19:54:09 +0000
Subject: [PATCH v7 02/22] s390/zcrypt: Review inline assembler constraints.
Message-Id: <20180726195429.31960-3-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Harald Freudenberger <freude@de.ibm.com>

Reviewed and adapted the register use and asm constraints
of the C inline assembler functions in accordance to the
the AP instructions specifications.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/ap_asm.h | 40 +++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/crypto/ap_asm.h b/drivers/s390/crypto/ap_asm.h
index b22d30aaf810..e22ee126c9df 100644
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
2.17.0
