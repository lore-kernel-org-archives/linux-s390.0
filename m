Return-Path: <linux-kernel-owner+w=401wt.eu-S1756243AbZKMPSm@vger.kernel.org>
Message-Id: <20091113150912.104663517@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/52] [PATCH] zcrypt: special command support for cex3 exploitation
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=115-cex3-special-command.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Ralph Wuerthner <ralph.wuerthner@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Support for special command is implemented in the AP Bus in the NQAP
function __ap_send. This is extended for a further parameter special.
When set, the special bit, in GR0 will be set. Therefor the ap_message
struct is extended for a further bit. Thus calling functions of
__ap_send can use the special parameter in ap_message to give to
__ap_send. Affected is in the first place ap_queue_message, which is
called by the actual card driver. The second part of this support is
that the card driver for the CEX3C needs to set this special bit, when
an according CPRB is sent to the driver.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c        |   20 +++++++++++++++-----
 drivers/s390/crypto/ap_bus.h        |    3 +++
 drivers/s390/crypto/zcrypt_pcixcc.c |    5 +++++
 3 files changed, 23 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c	2009-11-13 16:08:15.000000000 +0100
@@ -282,6 +282,7 @@
  * @psmid: The program supplied message identifier
  * @msg: The message text
  * @length: The message length
+ * @special: Special Bit
  *
  * Returns AP queue status structure.
  * Condition code 1 on NQAP can't happen because the L bit is 1.
@@ -289,7 +290,8 @@
  * because a segment boundary was reached. The NQAP is repeated.
  */
 static inline struct ap_queue_status
-__ap_send(ap_qid_t qid, unsigned long long psmid, void *msg, size_t length)
+__ap_send(ap_qid_t qid, unsigned long long psmid, void *msg, size_t length,
+	  unsigned int special)
 {
 	typedef struct { char _[length]; } msgblock;
 	register unsigned long reg0 asm ("0") = qid | 0x40000000UL;
@@ -299,6 +301,9 @@
 	register unsigned long reg4 asm ("4") = (unsigned int) (psmid >> 32);
 	register unsigned long reg5 asm ("5") = (unsigned int) psmid;
 
+	if (special == 1)
+		reg0 |= 0x400000UL;
+
 	asm volatile (
 		"0: .long 0xb2ad0042\n"		/* DQAP */
 		"   brc   2,0b"
@@ -312,13 +317,15 @@
 {
 	struct ap_queue_status status;
 
-	status = __ap_send(qid, psmid, msg, length);
+	status = __ap_send(qid, psmid, msg, length, 0);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 		return 0;
 	case AP_RESPONSE_Q_FULL:
 	case AP_RESPONSE_RESET_IN_PROGRESS:
 		return -EBUSY;
+	case AP_RESPONSE_REQ_FAC_NOT_INST:
+		return -EINVAL;
 	default:	/* Device is gone. */
 		return -ENODEV;
 	}
@@ -1008,7 +1015,7 @@
 	}
 
 	status = __ap_send(ap_dev->qid, 0x0102030405060708ULL,
-			   msg, sizeof(msg));
+			   msg, sizeof(msg), 0);
 	if (status.response_code != AP_RESPONSE_NORMAL) {
 		rc = -ENODEV;
 		goto out_free;
@@ -1243,7 +1250,7 @@
 	/* Start the next request on the queue. */
 	ap_msg = list_entry(ap_dev->requestq.next, struct ap_message, list);
 	status = __ap_send(ap_dev->qid, ap_msg->psmid,
-			   ap_msg->message, ap_msg->length);
+			   ap_msg->message, ap_msg->length, ap_msg->special);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 		atomic_inc(&ap_poll_requests);
@@ -1261,6 +1268,7 @@
 		*flags |= 2;
 		break;
 	case AP_RESPONSE_MESSAGE_TOO_BIG:
+	case AP_RESPONSE_REQ_FAC_NOT_INST:
 		return -EINVAL;
 	default:
 		return -ENODEV;
@@ -1302,7 +1310,8 @@
 	if (list_empty(&ap_dev->requestq) &&
 	    ap_dev->queue_count < ap_dev->queue_depth) {
 		status = __ap_send(ap_dev->qid, ap_msg->psmid,
-				   ap_msg->message, ap_msg->length);
+				   ap_msg->message, ap_msg->length,
+				   ap_msg->special);
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 			list_add_tail(&ap_msg->list, &ap_dev->pendingq);
@@ -1317,6 +1326,7 @@
 			ap_dev->requestq_count++;
 			ap_dev->total_request_count++;
 			return -EBUSY;
+		case AP_RESPONSE_REQ_FAC_NOT_INST:
 		case AP_RESPONSE_MESSAGE_TOO_BIG:
 			ap_dev->drv->receive(ap_dev, ap_msg, ERR_PTR(-EINVAL));
 			return -EINVAL;
Index: quilt-2.6/drivers/s390/crypto/ap_bus.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.h	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/ap_bus.h	2009-11-13 16:08:15.000000000 +0100
@@ -87,6 +87,7 @@
 #define AP_RESPONSE_INDEX_TOO_BIG	0x11
 #define AP_RESPONSE_NO_FIRST_PART	0x13
 #define AP_RESPONSE_MESSAGE_TOO_BIG	0x15
+#define AP_RESPONSE_REQ_FAC_NOT_INST	0x16
 
 /*
  * Known device types
@@ -161,6 +162,7 @@
 	size_t length;			/* Message length. */
 
 	void *private;			/* ap driver private pointer. */
+	unsigned int special:1;		/* Used for special commands. */
 };
 
 #define AP_DEVICE(dt)					\
@@ -176,6 +178,7 @@
 {
 	ap_msg->psmid = 0;
 	ap_msg->length = 0;
+	ap_msg->special = 0;
 }
 
 /*
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:15.000000000 +0100
@@ -326,6 +326,11 @@
 	function_code = ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
 	memcpy(msg->hdr.function_code, function_code, sizeof(msg->hdr.function_code));
 
+	if (memcmp(function_code, "US", 2) == 0)
+		ap_msg->special = 1;
+	else
+		ap_msg->special = 0;
+
 	/* copy data block */
 	if (xcRB->request_data_length &&
 	    copy_from_user(req_data, xcRB->request_data_address,
