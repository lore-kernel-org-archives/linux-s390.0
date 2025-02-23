Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C7200100
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304510; cv=none; b=BJ0p2+VyeIOWji/KiPOp2PCZzI5RY5gQEMDYmnPkW0VSPC3903xmhDcLy/F4QFX34rq/CrBXYV4MX8nKYMMcKTj9jocx9340npQg892jBlSoc58jYwdVBPyTI058o+eHDOtXAwYCS9ul34Z5P17Fyzz+uA0ijZIH00TUqSkUrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304510; c=relaxed/simple;
	bh=FapUxCD/Nug1dO3/DWoPnUSlZB92zkO5IPL1JWWBg0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjpDESbpNaKdvPF4kab/HuLGYs3bFuzCLDlGa61UgM+XUokRcLPEl41xMda1uhsv3BH5I7UvddTmtiExYHrnnbcOxOcQgIJEvepbPT/BeSExlgwFFiFU0A+8NuQT07F/yngoBQxfLoqZTXWVD4FWhHNQjMZq/LYbVSM95RfAMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PwnnAwcC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PwnnAwcC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7XLqH026896;
	Sun, 23 Feb 2025 09:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9ulQ9eCtK69sECoJD
	zL7KMxwTM5OAZ7wB+RUPqiAHcs=; b=PwnnAwcCrPuuJTBlgHcPq7FNubsUFX4Je
	iKxak7WvFqYZ0xyRTaljW1ctwrhmGGQJLTX0xguG7dU5kETYowuSUPb1yArF4WCG
	LLKgy1UM/dJFbx2yMCtfYFUmOPUsFesD+XLcnQl1yvbvwuUw0DYc9iQjcUbcPnoi
	4q3CYTatL7tbq1zuCLLflssw0IdwAs8E8+00bW/VDISWu74iiQpmT5M9YimrwAnp
	7RquHbUWjNG4KAS+vUrbDCapuNBYWV5EW9G/OpvMJFnikzYTAzrDYBbIXHMJvh4s
	aZueOkgAysk4rYoc4mLcFS4yRkoG+egeBEuc91SdJNFBkwU2GkSlg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yycnrbux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6LXki026964;
	Sun, 23 Feb 2025 09:55:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk1kyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t0fp35259064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A951120040;
	Sun, 23 Feb 2025 09:55:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D8D42004B;
	Sun, 23 Feb 2025 09:55:00 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 01/20] s390/ap: Move response_type struct into ap_msg struct
Date: Sun, 23 Feb 2025 10:54:40 +0100
Message-ID: <20250223095459.43058-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223095459.43058-1-freude@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -AJq_7sqxpn2afqvUdZq86jtspJ0M81H
X-Proofpoint-ORIG-GUID: -AJq_7sqxpn2afqvUdZq86jtspJ0M81H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Move the very small response_type struct into struct ap_msg.
So there is no need to kmalloc this tiny struct with each
ap message preparation.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.h           |  12 ++-
 drivers/s390/crypto/zcrypt_msgtype50.c |  22 +++---
 drivers/s390/crypto/zcrypt_msgtype6.c  | 101 ++++++++++---------------
 3 files changed, 59 insertions(+), 76 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index f4622ee4d894..a5d8f805625f 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -214,6 +214,15 @@ struct ap_queue {
 
 typedef enum ap_sm_wait (ap_func_t)(struct ap_queue *queue);
 
+struct ap_response_type {
+	struct completion work;
+	int type;
+};
+
+#define CEXXC_RESPONSE_TYPE_ICA  1
+#define CEXXC_RESPONSE_TYPE_XCRB 2
+#define CEXXC_RESPONSE_TYPE_EP11 3
+
 struct ap_message {
 	struct list_head list;		/* Request queueing. */
 	unsigned long psmid;		/* Message id. */
@@ -222,7 +231,7 @@ struct ap_message {
 	size_t bufsize;			/* allocated msg buffer size */
 	u16 flags;			/* Flags, see AP_MSG_FLAG_xxx */
 	int rc;				/* Return code for this message */
-	void *private;			/* ap driver private pointer. */
+	struct ap_response_type response;
 	/* receive is called from tasklet context */
 	void (*receive)(struct ap_queue *, struct ap_message *,
 			struct ap_message *);
@@ -250,7 +259,6 @@ static inline void ap_init_message(struct ap_message *ap_msg)
 static inline void ap_release_message(struct ap_message *ap_msg)
 {
 	kfree_sensitive(ap_msg->msg);
-	kfree_sensitive(ap_msg->private);
 }
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index adc65eddaa1e..222deb4040f3 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -438,7 +438,7 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
 		msg->len = sizeof(error_reply);
 	}
 out:
-	complete((struct completion *)msg->private);
+	complete(&msg->response.work);
 }
 
 static atomic_t zcrypt_step = ATOMIC_INIT(0);
@@ -454,25 +454,24 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 				     struct ica_rsa_modexpo *mex,
 				     struct ap_message *ap_msg)
 {
-	struct completion work;
 	int rc;
 
 	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
+	if (!ap_msg->msg)
+		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype50_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
-	ap_msg->private = &work;
 	rc = ICAMEX_msg_to_type50MEX_msg(zq, ap_msg, mex);
 	if (rc)
 		goto out;
-	init_completion(&work);
+	init_completion(&ap_msg->response.work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible(&work);
+	rc = wait_for_completion_interruptible(&ap_msg->response.work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
@@ -485,7 +484,6 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 	}
 
 out:
-	ap_msg->private = NULL;
 	if (rc)
 		pr_debug("send me cprb at dev=%02x.%04x rc=%d\n",
 			 AP_QID_CARD(zq->queue->qid),
@@ -504,25 +502,24 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 					 struct ica_rsa_modexpo_crt *crt,
 					 struct ap_message *ap_msg)
 {
-	struct completion work;
 	int rc;
 
 	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
+	if (!ap_msg->msg)
+		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype50_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
-	ap_msg->private = &work;
 	rc = ICACRT_msg_to_type50CRT_msg(zq, ap_msg, crt);
 	if (rc)
 		goto out;
-	init_completion(&work);
+	init_completion(&ap_msg->response.work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible(&work);
+	rc = wait_for_completion_interruptible(&ap_msg->response.work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
@@ -535,7 +532,6 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 	}
 
 out:
-	ap_msg->private = NULL;
 	if (rc)
 		pr_debug("send crt cprb at dev=%02x.%04x rc=%d\n",
 			 AP_QID_CARD(zq->queue->qid),
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index b64c9d9fc613..21ee311cf33d 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -31,15 +31,6 @@
 
 #define CEIL4(x) ((((x) + 3) / 4) * 4)
 
-struct response_type {
-	struct completion work;
-	int type;
-};
-
-#define CEXXC_RESPONSE_TYPE_ICA  0
-#define CEXXC_RESPONSE_TYPE_XCRB 1
-#define CEXXC_RESPONSE_TYPE_EP11 2
-
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("Cryptographic Coprocessor (message type 6), " \
 		   "Copyright IBM Corp. 2001, 2023");
@@ -856,7 +847,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct response_type *resp_type = msg->private;
+	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
 	int len;
 
@@ -920,7 +911,7 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct response_type *resp_type = msg->private;
+	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
 	int len;
 
@@ -967,9 +958,7 @@ static long zcrypt_msgtype6_modexpo(struct zcrypt_queue *zq,
 				    struct ica_rsa_modexpo *mex,
 				    struct ap_message *ap_msg)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_ICA,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 	int rc;
 
 	ap_msg->msg = (void *)get_zeroed_page(GFP_KERNEL);
@@ -979,15 +968,15 @@ static long zcrypt_msgtype6_modexpo(struct zcrypt_queue *zq,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
-	ap_msg->private = &resp_type;
 	rc = icamex_msg_to_type6mex_msgx(zq, ap_msg, mex);
 	if (rc)
 		goto out_free;
-	init_completion(&resp_type.work);
+	resp_type->type = CEXXC_RESPONSE_TYPE_ICA;
+	init_completion(&resp_type->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out_free;
-	rc = wait_for_completion_interruptible(&resp_type.work);
+	rc = wait_for_completion_interruptible(&resp_type->work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
@@ -1001,7 +990,6 @@ static long zcrypt_msgtype6_modexpo(struct zcrypt_queue *zq,
 
 out_free:
 	free_page((unsigned long)ap_msg->msg);
-	ap_msg->private = NULL;
 	ap_msg->msg = NULL;
 	return rc;
 }
@@ -1017,9 +1005,7 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
 					struct ica_rsa_modexpo_crt *crt,
 					struct ap_message *ap_msg)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_ICA,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 	int rc;
 
 	ap_msg->msg = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1029,15 +1015,15 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
-	ap_msg->private = &resp_type;
 	rc = icacrt_msg_to_type6crt_msgx(zq, ap_msg, crt);
 	if (rc)
 		goto out_free;
-	init_completion(&resp_type.work);
+	resp_type->type = CEXXC_RESPONSE_TYPE_ICA;
+	init_completion(&resp_type->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out_free;
-	rc = wait_for_completion_interruptible(&resp_type.work);
+	rc = wait_for_completion_interruptible(&resp_type->work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
@@ -1051,7 +1037,6 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
 
 out_free:
 	free_page((unsigned long)ap_msg->msg);
-	ap_msg->private = NULL;
 	ap_msg->msg = NULL;
 	return rc;
 }
@@ -1061,28 +1046,26 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
  * Prepare a CCA AP msg: fetch the required data from userspace,
  * prepare the AP msg, fill some info into the ap_message struct,
  * extract some data from the CPRB and give back to the caller.
- * This function allocates memory and needs an ap_msg prepared
- * by the caller with ap_init_message(). Also the caller has to
- * make sure ap_release_message() is always called even on failure.
+ * This function may allocate memory if the ap_msg msg buffer is
+ * not preallocated and needs an ap_msg prepared by the caller
+ * with ap_init_message(). Also the caller has to make sure
+ * ap_release_message() is always called even on failure.
  */
 int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
 		    struct ap_message *ap_msg,
 		    unsigned int *func_code, unsigned short **dom)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_XCRB,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 
 	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
+	if (!ap_msg->msg)
+		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
-	if (!ap_msg->private)
-		return -ENOMEM;
+	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
 	return xcrb_msg_to_type6cprb_msgx(userspace, ap_msg, xcrb, func_code, dom);
 }
 
@@ -1097,7 +1080,7 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 				      struct ica_xcRB *xcrb,
 				      struct ap_message *ap_msg)
 {
-	struct response_type *rtype = ap_msg->private;
+	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
 		struct CPRBX cprbx;
@@ -1128,11 +1111,11 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 		msg->hdr.fromcardlen1 -= delta;
 	}
 
-	init_completion(&rtype->work);
+	init_completion(&resp_type->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible(&rtype->work);
+	rc = wait_for_completion_interruptible(&resp_type->work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
@@ -1158,28 +1141,26 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
  * Prepare an EP11 AP msg: fetch the required data from userspace,
  * prepare the AP msg, fill some info into the ap_message struct,
  * extract some data from the CPRB and give back to the caller.
- * This function allocates memory and needs an ap_msg prepared
- * by the caller with ap_init_message(). Also the caller has to
- * make sure ap_release_message() is always called even on failure.
+ * This function may allocate memory if the ap_msg msg buffer is
+ * not preallocated and needs an ap_msg prepared by the caller
+ * with ap_init_message(). Also the caller has to make sure
+ * ap_release_message() is always called even on failure.
  */
 int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 		     struct ap_message *ap_msg,
 		     unsigned int *func_code, unsigned int *domain)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_EP11,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 
 	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
+	if (!ap_msg->msg)
+		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
-	if (!ap_msg->private)
-		return -ENOMEM;
+	resp_type->type = CEXXC_RESPONSE_TYPE_EP11;
 	return xcrb_msg_to_type6_ep11cprb_msgx(userspace, ap_msg, xcrb,
 					       func_code, domain);
 }
@@ -1197,7 +1178,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 {
 	int rc;
 	unsigned int lfmt;
-	struct response_type *rtype = ap_msg->private;
+	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
 		struct ep11_cprb cprbx;
@@ -1251,11 +1232,11 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 	msg->hdr.fromcardlen1 = zq->reply.bufsize -
 		sizeof(struct type86_hdr) - sizeof(struct type86_fmt2_ext);
 
-	init_completion(&rtype->work);
+	init_completion(&resp_type->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible(&rtype->work);
+	rc = wait_for_completion_interruptible(&resp_type->work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
@@ -1279,20 +1260,18 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 int prep_rng_ap_msg(struct ap_message *ap_msg, int *func_code,
 		    unsigned int *domain)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_XCRB,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 
 	ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
+	if (!ap_msg->msg)
+		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
-	if (!ap_msg->private)
-		return -ENOMEM;
+
+	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
 
 	rng_type6cprb_msgx(ap_msg, ZCRYPT_RNG_BUFFER_SIZE, domain);
 
@@ -1319,16 +1298,16 @@ static long zcrypt_msgtype6_rng(struct zcrypt_queue *zq,
 		short int verb_length;
 		short int key_length;
 	} __packed * msg = ap_msg->msg;
-	struct response_type *rtype = ap_msg->private;
+	struct ap_response_type *resp_type = &ap_msg->response;
 	int rc;
 
 	msg->cprbx.domain = AP_QID_QUEUE(zq->queue->qid);
 
-	init_completion(&rtype->work);
+	init_completion(&resp_type->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible(&rtype->work);
+	rc = wait_for_completion_interruptible(&resp_type->work);
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
-- 
2.43.0

