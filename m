Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFE2080C0
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108887; cv=none; b=e/T77DEW/na2uHhqk+gdR32yhHFo06stG5ocltYknE+1NxncZeG2X2lbfPymKZkAMHRCzcs93uWonG9N689MB90Ib02gAk+Q13bDddZrxUfxzACQCbaNL7amOZEVNj74Kn82K6ZPzb4BbrTqJ3WqQT6thVffDh2YE74jFscaip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108887; c=relaxed/simple;
	bh=dzEeTP2c6ewyxtk248D+EOeVdZRSwiFfNj3dJHbeh5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFHjHe0ECBi+WNlAmAhr/0yJkiAbN9GojJBAZSMFzZ5bqsiw+ina3cy4DgPJXUegEvm6Tac09f6lZXsuE/ogdBFreWnwJdnqhWscG7UqCUP8Ct0kc1sGWqib7THUkkjHTKldmgc27hwDJ43qgbRRoWQ2fW0xUbqtj13QNka5DVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ef9+nSVR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ef9+nSVR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249ecLL023454;
	Tue, 4 Mar 2025 17:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bEkNEfhiBi8CUv2jd
	zgtY4P5OiQdi6Dc4qRqlHvggn0=; b=Ef9+nSVRZl6eOZ9N4CZC9/wSGPgNMh2GC
	MjcpP07TVgE4zpXH0AHKHPOm8BVAISdWzACSQSM7a4WoJFZ3EUgfLeq33W4IrcSH
	uSSWFE8zz1QhdmreTYz/oJ1SLY3BlYuSOD7SThU30bhWcmxcvpG/e8SHnfaeErfg
	CAaclbenuwwtk9r75as9ENH4fmC481rb8/UUXA4fvZJQFYXEbOi0wmqG+LTTuDIz
	jaY62D3xqAQF2o45NdDn1ZUSVzRd5V7eOT03zVEI0P8HK3drXdwNHe/nUQ0Vgw4q
	sHW6L6anBStiKGjMGN65eRTmdWvzsfNUQC0YJRDD2r8FRH+dGETXQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku559t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524EN01Y000362;
	Tue, 4 Mar 2025 17:21:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjsxrmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLI2d48496956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF3A20043;
	Tue,  4 Mar 2025 17:21:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 830F320040;
	Tue,  4 Mar 2025 17:21:17 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 01/20] s390/ap: Move response_type struct into ap_msg struct
Date: Tue,  4 Mar 2025 18:20:57 +0100
Message-ID: <20250304172116.85374-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304172116.85374-1-freude@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -l-KQOP06VF7x3PXpTkk4I-YrLyVkpRf
X-Proofpoint-GUID: -l-KQOP06VF7x3PXpTkk4I-YrLyVkpRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Move the very small response_type struct into struct ap_msg.
So there is no need to kmalloc this tiny struct with each
ap message preparation.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.h           |  8 ++-
 drivers/s390/crypto/zcrypt_msgtype50.c | 16 ++----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 74 ++++++++++----------------
 3 files changed, 38 insertions(+), 60 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index f4622ee4d894..7fd24c207bdf 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -214,6 +214,11 @@ struct ap_queue {
 
 typedef enum ap_sm_wait (ap_func_t)(struct ap_queue *queue);
 
+struct ap_response_type {
+	struct completion work;
+	int type;
+};
+
 struct ap_message {
 	struct list_head list;		/* Request queueing. */
 	unsigned long psmid;		/* Message id. */
@@ -222,7 +227,7 @@ struct ap_message {
 	size_t bufsize;			/* allocated msg buffer size */
 	u16 flags;			/* Flags, see AP_MSG_FLAG_xxx */
 	int rc;				/* Return code for this message */
-	void *private;			/* ap driver private pointer. */
+	struct ap_response_type response;
 	/* receive is called from tasklet context */
 	void (*receive)(struct ap_queue *, struct ap_message *,
 			struct ap_message *);
@@ -250,7 +255,6 @@ static inline void ap_init_message(struct ap_message *ap_msg)
 static inline void ap_release_message(struct ap_message *ap_msg)
 {
 	kfree_sensitive(ap_msg->msg);
-	kfree_sensitive(ap_msg->private);
 }
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index adc65eddaa1e..47c401f5409b 100644
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
@@ -454,7 +454,6 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 				     struct ica_rsa_modexpo *mex,
 				     struct ap_message *ap_msg)
 {
-	struct completion work;
 	int rc;
 
 	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
@@ -464,15 +463,14 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
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
@@ -485,7 +483,6 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 	}
 
 out:
-	ap_msg->private = NULL;
 	if (rc)
 		pr_debug("send me cprb at dev=%02x.%04x rc=%d\n",
 			 AP_QID_CARD(zq->queue->qid),
@@ -504,7 +501,6 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 					 struct ica_rsa_modexpo_crt *crt,
 					 struct ap_message *ap_msg)
 {
-	struct completion work;
 	int rc;
 
 	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
@@ -514,15 +510,14 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
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
@@ -535,7 +530,6 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 	}
 
 out:
-	ap_msg->private = NULL;
 	if (rc)
 		pr_debug("send crt cprb at dev=%02x.%04x rc=%d\n",
 			 AP_QID_CARD(zq->queue->qid),
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index b64c9d9fc613..521cc0b39990 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -31,10 +31,7 @@
 
 #define CEIL4(x) ((((x) + 3) / 4) * 4)
 
-struct response_type {
-	struct completion work;
-	int type;
-};
+struct response_type;
 
 #define CEXXC_RESPONSE_TYPE_ICA  0
 #define CEXXC_RESPONSE_TYPE_XCRB 1
@@ -856,7 +853,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct response_type *resp_type = msg->private;
+	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
 	int len;
 
@@ -920,7 +917,7 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct response_type *resp_type = msg->private;
+	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
 	int len;
 
@@ -967,9 +964,7 @@ static long zcrypt_msgtype6_modexpo(struct zcrypt_queue *zq,
 				    struct ica_rsa_modexpo *mex,
 				    struct ap_message *ap_msg)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_ICA,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 	int rc;
 
 	ap_msg->msg = (void *)get_zeroed_page(GFP_KERNEL);
@@ -979,15 +974,15 @@ static long zcrypt_msgtype6_modexpo(struct zcrypt_queue *zq,
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
@@ -1001,7 +996,6 @@ static long zcrypt_msgtype6_modexpo(struct zcrypt_queue *zq,
 
 out_free:
 	free_page((unsigned long)ap_msg->msg);
-	ap_msg->private = NULL;
 	ap_msg->msg = NULL;
 	return rc;
 }
@@ -1017,9 +1011,7 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
 					struct ica_rsa_modexpo_crt *crt,
 					struct ap_message *ap_msg)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_ICA,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 	int rc;
 
 	ap_msg->msg = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1029,15 +1021,15 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
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
@@ -1051,7 +1043,6 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
 
 out_free:
 	free_page((unsigned long)ap_msg->msg);
-	ap_msg->private = NULL;
 	ap_msg->msg = NULL;
 	return rc;
 }
@@ -1069,9 +1060,7 @@ int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
 		    struct ap_message *ap_msg,
 		    unsigned int *func_code, unsigned short **dom)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_XCRB,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 
 	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
 	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
@@ -1080,9 +1069,7 @@ int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
-	if (!ap_msg->private)
-		return -ENOMEM;
+	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
 	return xcrb_msg_to_type6cprb_msgx(userspace, ap_msg, xcrb, func_code, dom);
 }
 
@@ -1097,7 +1084,7 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 				      struct ica_xcRB *xcrb,
 				      struct ap_message *ap_msg)
 {
-	struct response_type *rtype = ap_msg->private;
+	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
 		struct CPRBX cprbx;
@@ -1128,11 +1115,11 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
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
@@ -1166,9 +1153,7 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 		     struct ap_message *ap_msg,
 		     unsigned int *func_code, unsigned int *domain)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_EP11,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 
 	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
 	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
@@ -1177,9 +1162,7 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
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
@@ -1197,7 +1180,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 {
 	int rc;
 	unsigned int lfmt;
-	struct response_type *rtype = ap_msg->private;
+	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
 		struct ep11_cprb cprbx;
@@ -1251,11 +1234,11 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
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
@@ -1279,9 +1262,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 int prep_rng_ap_msg(struct ap_message *ap_msg, int *func_code,
 		    unsigned int *domain)
 {
-	struct response_type resp_type = {
-		.type = CEXXC_RESPONSE_TYPE_XCRB,
-	};
+	struct ap_response_type *resp_type = &ap_msg->response;
 
 	ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
 	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
@@ -1290,9 +1271,8 @@ int prep_rng_ap_msg(struct ap_message *ap_msg, int *func_code,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
-	if (!ap_msg->private)
-		return -ENOMEM;
+
+	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
 
 	rng_type6cprb_msgx(ap_msg, ZCRYPT_RNG_BUFFER_SIZE, domain);
 
@@ -1319,16 +1299,16 @@ static long zcrypt_msgtype6_rng(struct zcrypt_queue *zq,
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

