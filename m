From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v9 04/22] s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.
Date: Mon, 13 Aug 2018 17:48:01 -0400
Message-ID: <1534196899-16987-5-git-send-email-akrowiak@linux.vnet.ibm.com>
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

Move all the inline functions from the ap bus header
file ap_asm.h into the in-kernel api header file
arch/s390/include/asm/ap.h so that KVM can make use
of all the low level AP functions.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
 drivers/s390/crypto/ap_bus.c   |   23 +---
 drivers/s390/crypto/ap_bus.h   |    1 +
 drivers/s390/crypto/ap_card.c  |    1 -
 drivers/s390/crypto/ap_queue.c |    1 -
 5 files changed, 260 insertions(+), 50 deletions(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index c1bedb4..887494a 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -47,6 +47,50 @@ struct ap_queue_status {
 };
 
 /**
+ * ap_intructions_available() - Test if AP instructions are available.
+ *
+ * Returns 1 if the AP instructions are installed, otherwise 0.
+ */
+static inline int ap_instructions_available(void)
+{
+	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
+	register unsigned long reg1 asm ("1") = 0;
+	register unsigned long reg2 asm ("2") = 0;
+
+	asm volatile(
+		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
+		"0: la    %0,1\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "+d" (reg1), "+d" (reg2)
+		: "d" (reg0)
+		: "cc");
+	return reg1;
+}
+
+/**
+ * ap_tapq(): Test adjunct processor queue.
+ * @qid: The AP queue number
+ * @info: Pointer to queue descriptor
+ *
+ * Returns AP queue status structure.
+ */
+static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
+{
+	register unsigned long reg0 asm ("0") = qid;
+	register struct ap_queue_status reg1 asm ("1");
+	register unsigned long reg2 asm ("2");
+
+	asm volatile(".long 0xb2af0000"		/* PQAP(TAPQ) */
+		     : "=d" (reg1), "=d" (reg2)
+		     : "d" (reg0)
+		     : "cc");
+	if (info)
+		*info = reg2;
+	return reg1;
+}
+
+/**
  * ap_test_queue(): Test adjunct processor queue.
  * @qid: The AP queue number
  * @tbit: Test facilities bit
@@ -54,10 +98,57 @@ struct ap_queue_status {
  *
  * Returns AP queue status structure.
  */
-struct ap_queue_status ap_test_queue(ap_qid_t qid,
-				     int tbit,
-				     unsigned long *info);
+static inline struct ap_queue_status ap_test_queue(ap_qid_t qid,
+						   int tbit,
+						   unsigned long *info)
+{
+	if (tbit)
+		qid |= 1UL << 23; /* set T bit*/
+	return ap_tapq(qid, info);
+}
 
+/**
+ * ap_pqap_rapq(): Reset adjunct processor queue.
+ * @qid: The AP queue number
+ *
+ * Returns AP queue status structure.
+ */
+static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
+{
+	register unsigned long reg0 asm ("0") = qid | (1UL << 24);
+	register struct ap_queue_status reg1 asm ("1");
+
+	asm volatile(
+		".long 0xb2af0000"		/* PQAP(RAPQ) */
+		: "=d" (reg1)
+		: "d" (reg0)
+		: "cc");
+	return reg1;
+}
+
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
+/**
+ * struct ap_config_info - convenience struct for AP crypto
+ * config info as returned by the ap_qci() function.
+ */
 struct ap_config_info {
 	unsigned int apsc	 : 1;	/* S bit */
 	unsigned int apxa	 : 1;	/* N bit */
@@ -74,50 +165,189 @@ struct ap_config_info {
 	unsigned char _reserved4[16];
 } __aligned(8);
 
-/*
- * ap_query_configuration(): Fetch cryptographic config info
+/**
+ * ap_qci(): Get AP configuration data
  *
- * Returns the ap configuration info fetched via PQAP(QCI).
- * On success 0 is returned, on failure a negative errno
- * is returned, e.g. if the PQAP(QCI) instruction is not
- * available, the return value will be -EOPNOTSUPP.
+ * Returns 0 on success, or -EOPNOTSUPP.
  */
-int ap_query_configuration(struct ap_config_info *info);
+static inline int ap_qci(struct ap_config_info *config)
+{
+	register unsigned long reg0 asm ("0") = 4UL << 24;
+	register unsigned long reg1 asm ("1") = -EOPNOTSUPP;
+	register struct ap_config_info *reg2 asm ("2") = config;
+
+	asm volatile(
+		".long 0xb2af0000\n"		/* PQAP(QCI) */
+		"0: la    %0,0\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "+d" (reg1)
+		: "d" (reg0), "d" (reg2)
+		: "cc", "memory");
+
+	return reg1;
+}
 
 /*
  * struct ap_qirq_ctrl - convenient struct for easy invocation
- * of the ap_queue_irq_ctrl() function. This struct is passed
- * as GR1 parameter to the PQAP(AQIC) instruction. For details
- * please see the AR documentation.
+ * of the ap_aqic() function. This struct is passed as GR1
+ * parameter to the PQAP(AQIC) instruction. For details please
+ * see the AR documentation.
  */
 struct ap_qirq_ctrl {
 	unsigned int _res1 : 8;
-	unsigned int zone  : 8;  /* zone info */
-	unsigned int ir    : 1;  /* ir flag: enable (1) or disable (0) irq */
+	unsigned int zone  : 8;	/* zone info */
+	unsigned int ir    : 1;	/* ir flag: enable (1) or disable (0) irq */
 	unsigned int _res2 : 4;
-	unsigned int gisc  : 3;  /* guest isc field */
+	unsigned int gisc  : 3;	/* guest isc field */
 	unsigned int _res3 : 6;
-	unsigned int gf    : 2;  /* gisa format */
+	unsigned int gf    : 2;	/* gisa format */
 	unsigned int _res4 : 1;
-	unsigned int gisa  : 27; /* gisa origin */
+	unsigned int gisa  : 27;	/* gisa origin */
 	unsigned int _res5 : 1;
-	unsigned int isc   : 3;  /* irq sub class */
+	unsigned int isc   : 3;	/* irq sub class */
 };
 
 /**
- * ap_queue_irq_ctrl(): Control interruption on a AP queue.
+ * ap_aqic(): Control interruption for a specific AP.
  * @qid: The AP queue number
- * @qirqctrl: struct ap_qirq_ctrl, see above
+ * @qirqctrl: struct ap_qirq_ctrl (64 bit value)
  * @ind: The notification indicator byte
  *
  * Returns AP queue status.
+ */
+static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
+					     struct ap_qirq_ctrl qirqctrl,
+					     void *ind)
+{
+	register unsigned long reg0 asm ("0") = qid | (3UL << 24);
+	register struct ap_qirq_ctrl reg1_in asm ("1") = qirqctrl;
+	register struct ap_queue_status reg1_out asm ("1");
+	register void *reg2 asm ("2") = ind;
+
+	asm volatile(
+		".long 0xb2af0000"		/* PQAP(AQIC) */
+		: "=d" (reg1_out)
+		: "d" (reg0), "d" (reg1_in), "d" (reg2)
+		: "cc");
+	return reg1_out;
+}
+
+/*
+ * union ap_qact_ap_info - used together with the
+ * ap_aqic() function to provide a convenient way
+ * to handle the ap info needed by the qact function.
+ */
+union ap_qact_ap_info {
+	unsigned long val;
+	struct {
+		unsigned int	  : 3;
+		unsigned int mode : 3;
+		unsigned int	  : 26;
+		unsigned int cat  : 8;
+		unsigned int	  : 8;
+		unsigned char ver[2];
+	};
+};
+
+/**
+ * ap_qact(): Query AP combatibility type.
+ * @qid: The AP queue number
+ * @apinfo: On input the info about the AP queue. On output the
+ *	    alternate AP queue info provided by the qact function
+ *	    in GR2 is stored in.
  *
- * Control interruption on the given AP queue.
- * Just a simple wrapper function for the low level PQAP(AQIC)
- * instruction available for other kernel modules.
+ * Returns AP queue status. Check response_code field for failures.
  */
-struct ap_queue_status ap_queue_irq_ctrl(ap_qid_t qid,
-					 struct ap_qirq_ctrl qirqctrl,
-					 void *ind);
+static inline struct ap_queue_status ap_qact(ap_qid_t qid, int ifbit,
+					     union ap_qact_ap_info *apinfo)
+{
+	register unsigned long reg0 asm ("0") = qid | (5UL << 24)
+		| ((ifbit & 0x01) << 22);
+	register unsigned long reg1_in asm ("1") = apinfo->val;
+	register struct ap_queue_status reg1_out asm ("1");
+	register unsigned long reg2 asm ("2");
+
+	asm volatile(
+		".long 0xb2af0000"		/* PQAP(QACT) */
+		: "+d" (reg1_in), "=d" (reg1_out), "=d" (reg2)
+		: "d" (reg0)
+		: "cc");
+	apinfo->val = reg2;
+	return reg1_out;
+}
+
+/**
+ * ap_nqap(): Send message to adjunct processor queue.
+ * @qid: The AP queue number
+ * @psmid: The program supplied message identifier
+ * @msg: The message text
+ * @length: The message length
+ *
+ * Returns AP queue status structure.
+ * Condition code 1 on NQAP can't happen because the L bit is 1.
+ * Condition code 2 on NQAP also means the send is incomplete,
+ * because a segment boundary was reached. The NQAP is repeated.
+ */
+static inline struct ap_queue_status ap_nqap(ap_qid_t qid,
+					     unsigned long long psmid,
+					     void *msg, size_t length)
+{
+	register unsigned long reg0 asm ("0") = qid | 0x40000000UL;
+	register struct ap_queue_status reg1 asm ("1");
+	register unsigned long reg2 asm ("2") = (unsigned long) msg;
+	register unsigned long reg3 asm ("3") = (unsigned long) length;
+	register unsigned long reg4 asm ("4") = (unsigned int) (psmid >> 32);
+	register unsigned long reg5 asm ("5") = psmid & 0xffffffff;
+
+	asm volatile (
+		"0: .long 0xb2ad0042\n"		/* NQAP */
+		"   brc   2,0b"
+		: "+d" (reg0), "=d" (reg1), "+d" (reg2), "+d" (reg3)
+		: "d" (reg4), "d" (reg5)
+		: "cc", "memory");
+	return reg1;
+}
+
+/**
+ * ap_dqap(): Receive message from adjunct processor queue.
+ * @qid: The AP queue number
+ * @psmid: Pointer to program supplied message identifier
+ * @msg: The message text
+ * @length: The message length
+ *
+ * Returns AP queue status structure.
+ * Condition code 1 on DQAP means the receive has taken place
+ * but only partially.	The response is incomplete, hence the
+ * DQAP is repeated.
+ * Condition code 2 on DQAP also means the receive is incomplete,
+ * this time because a segment boundary was reached. Again, the
+ * DQAP is repeated.
+ * Note that gpr2 is used by the DQAP instruction to keep track of
+ * any 'residual' length, in case the instruction gets interrupted.
+ * Hence it gets zeroed before the instruction.
+ */
+static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
+					     unsigned long long *psmid,
+					     void *msg, size_t length)
+{
+	register unsigned long reg0 asm("0") = qid | 0x80000000UL;
+	register struct ap_queue_status reg1 asm ("1");
+	register unsigned long reg2 asm("2") = 0UL;
+	register unsigned long reg4 asm("4") = (unsigned long) msg;
+	register unsigned long reg5 asm("5") = (unsigned long) length;
+	register unsigned long reg6 asm("6") = 0UL;
+	register unsigned long reg7 asm("7") = 0UL;
+
+
+	asm volatile(
+		"0: .long 0xb2ae0064\n"		/* DQAP */
+		"   brc   6,0b\n"
+		: "+d" (reg0), "=d" (reg1), "+d" (reg2),
+		  "+d" (reg4), "+d" (reg5), "+d" (reg6), "+d" (reg7)
+		: : "cc", "memory");
+	*psmid = (((unsigned long long) reg6) << 32) + reg7;
+	return reg1;
+}
 
 #endif /* _ASM_S390_AP_H_ */
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 35a0c2b..aa1bbe6 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -36,7 +36,6 @@
 #include <linux/debugfs.h>
 
 #include "ap_bus.h"
-#include "ap_asm.h"
 #include "ap_debug.h"
 
 /*
@@ -174,24 +173,6 @@ static inline int ap_qact_available(void)
 	return 0;
 }
 
-/**
- * ap_test_queue(): Test adjunct processor queue.
- * @qid: The AP queue number
- * @tbit: Test facilities bit
- * @info: Pointer to queue descriptor
- *
- * Returns AP queue status structure.
- */
-struct ap_queue_status ap_test_queue(ap_qid_t qid,
-				     int tbit,
-				     unsigned long *info)
-{
-	if (tbit)
-		qid |= 1UL << 23; /* set T bit*/
-	return ap_tapq(qid, info);
-}
-EXPORT_SYMBOL(ap_test_queue);
-
 /*
  * ap_query_configuration(): Fetch cryptographic config info
  *
@@ -200,7 +181,7 @@ struct ap_queue_status ap_test_queue(ap_qid_t qid,
  * is returned, e.g. if the PQAP(QCI) instruction is not
  * available, the return value will be -EOPNOTSUPP.
  */
-int ap_query_configuration(struct ap_config_info *info)
+static inline int ap_query_configuration(struct ap_config_info *info)
 {
 	if (!ap_configuration_available())
 		return -EOPNOTSUPP;
@@ -1220,7 +1201,7 @@ static int __init ap_module_init(void)
 	if (rc)
 		return rc;
 
-	if (ap_instructions_available() != 0) {
+	if (!ap_instructions_available()) {
 		pr_warn("The hardware system does not support AP instructions\n");
 		return -ENODEV;
 	}
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 6a273c5..9365419 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -15,6 +15,7 @@
 
 #include <linux/device.h>
 #include <linux/types.h>
+#include <asm/isc.h>
 #include <asm/ap.h>
 
 #define AP_DEVICES 256		/* Number of AP devices. */
diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index 2c726df..c13e432 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -14,7 +14,6 @@
 #include <asm/facility.h>
 
 #include "ap_bus.h"
-#include "ap_asm.h"
 
 /*
  * AP card related attributes.
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index ba3a2e1..d83c1fa 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -14,7 +14,6 @@
 #include <asm/facility.h>
 
 #include "ap_bus.h"
-#include "ap_asm.h"
 
 /**
  * ap_queue_irq_ctrl(): Control interruption on a AP queue.
-- 
1.7.1
