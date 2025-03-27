Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA289460
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086394; cv=none; b=sy1vutwnT9z8Il5zUJdInZ2qRdJW5qsXUkzmDanynScFjGBTVcnH2WEDb7uwgCdgqr115JCzfGLJuIGKmQjIRPxuXjmlHQlT/5BTZcXku4t465Ib41kdbQvyd0fuPKbHfzsW1ZQ3kcOqIe8Qr6cukH5H4YsBYZu93YfMt0WwcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086394; c=relaxed/simple;
	bh=xZFdpZy63O8WaMuOaJKCNq7i7F88NOVkDsTnLuJ8cGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu91r/4AifVBfYaeOk7kLa6poR9b9HitlTlgNa36X1XLUBuNtnu7MtSnU/jsTs95u3NbJlIoT3PFrASAA6usvUvwrt1f2k6JklTQv9iVNBu4RNHeTudV6/wtYn0JCyZ1SX01ItdcjYX1qSC3ueQXkF42DvPjlexiWLXTaZWW9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+Yz8CXL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+Yz8CXL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8KRXu011821;
	Thu, 27 Mar 2025 14:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FXaQ+gE2JNfkLKjC3
	FLaw8VyIT8Mq/8LfxVqc9jlpUQ=; b=L+Yz8CXLckLRjYBDtqorkQ/3XI6kpqqqG
	KoRK5YhcubG9XcNDrr0yoamTq3Tq+mz54N8ozWkmsZA5Hm0x/9cTho8Hw7j7HaAp
	K7Bg5qyKU1SZh3rwZMEjEyM8Wwb4yZVSgDtMnWv66DaXAcrHwjr9Gh6xDSBg6d4m
	4LckDYCE5oiLcQ5p49cMu4/3P673vCJk/D2gU9eiN49a41Cbp3iUWuCSNUjpyhqA
	62cmpCdm1EkV100af0AcjLkVOMyijPH4y4wYiYSwRUADbgaDyM9cFbRf91uyjvHG
	X877cQ11yA1zzfHiV4XloLgzIv0jQiCWyFQyAlyj8sSMNCfjbCY1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrt04dyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RC0tXc020001;
	Thu, 27 Mar 2025 14:39:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp5ret-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdhe947513996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D0520040;
	Thu, 27 Mar 2025 14:39:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F44F20043;
	Thu, 27 Mar 2025 14:39:43 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:43 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 02/21] s390/ap/zcrypt: Rework AP message buffer allocation
Date: Thu, 27 Mar 2025 15:39:22 +0100
Message-ID: <20250327143941.45507-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WzUTInIM-VtrdwCAhMw7hGM7BM7EB7K3
X-Proofpoint-GUID: WzUTInIM-VtrdwCAhMw7hGM7BM7EB7K3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

Slight rework on the way how AP message buffers are allocated.
Instead of having multiple places with kmalloc() calls all
the AP message buffers are now allocated and freed on exactly
one place: ap_init_apmsg() allocates the current AP bus max
limit of ap_max_msg_size (defaults to 12KB). The AP message
buffer is then freed in ap_release_apmsg().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c           | 30 ++++++++++++++++
 drivers/s390/crypto/ap_bus.h           | 21 ++---------
 drivers/s390/crypto/zcrypt_api.c       | 49 +++++++++++++++-----------
 drivers/s390/crypto/zcrypt_msgtype50.c | 20 ++++++-----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 35 +++++++++---------
 5 files changed, 90 insertions(+), 65 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 26e1ea1940ec..4940eaf538e9 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -546,6 +546,36 @@ static void ap_poll_thread_stop(void)
 #define is_card_dev(x) ((x)->parent == ap_root_device)
 #define is_queue_dev(x) ((x)->parent != ap_root_device)
 
+/**
+ * ap_init_apmsg() - Initialize ap_message.
+ * Initialize a message before using. Otherwise this might result in
+ * unexpected behaviour.
+ */
+int ap_init_apmsg(struct ap_message *ap_msg)
+{
+	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
+
+	memset(ap_msg, 0, sizeof(*ap_msg));
+	ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
+	if (!ap_msg->msg)
+		return -ENOMEM;
+	ap_msg->bufsize = maxmsgsize;
+
+	return 0;
+}
+EXPORT_SYMBOL(ap_init_apmsg);
+
+/**
+ * ap_release_apmsg() - Release ap_message.
+ * Releases all memory used internal within the ap_message struct
+ * Currently this is the message and private field.
+ */
+void ap_release_apmsg(struct ap_message *ap_msg)
+{
+	kfree_sensitive(ap_msg->msg);
+}
+EXPORT_SYMBOL(ap_release_apmsg);
+
 /**
  * ap_bus_match()
  * @dev: Pointer to device
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 7fd24c207bdf..483231bcdea6 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -237,25 +237,8 @@ struct ap_message {
 #define AP_MSG_FLAG_USAGE    0x0002	/* CCA, EP11: usage (no admin) msg */
 #define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
 
-/**
- * ap_init_message() - Initialize ap_message.
- * Initialize a message before using. Otherwise this might result in
- * unexpected behaviour.
- */
-static inline void ap_init_message(struct ap_message *ap_msg)
-{
-	memset(ap_msg, 0, sizeof(*ap_msg));
-}
-
-/**
- * ap_release_message() - Release ap_message.
- * Releases all memory used internal within the ap_message struct
- * Currently this is the message and private field.
- */
-static inline void ap_release_message(struct ap_message *ap_msg)
-{
-	kfree_sensitive(ap_msg->msg);
-}
+int ap_init_apmsg(struct ap_message *ap_msg);
+void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
 enum ap_sm_wait ap_sm_event_loop(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 5020696f1379..78df25da0b95 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -642,16 +642,17 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 	struct zcrypt_queue *zq, *pref_zq;
 	struct ap_message ap_msg;
 	unsigned int wgt = 0, pref_wgt = 0;
-	unsigned int func_code;
-	int cpen, qpen, qid = 0, rc = -ENODEV;
+	unsigned int func_code = 0;
+	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	ap_init_message(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg);
+	if (rc)
+		goto out;
 
 	if (mex->outputdatalength < mex->inputdatalength) {
-		func_code = 0;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -728,7 +729,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 	spin_unlock(&zcrypt_list_lock);
 
 out:
-	ap_release_message(&ap_msg);
+	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
 		tr->last_qid = qid;
@@ -746,16 +747,17 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	struct zcrypt_queue *zq, *pref_zq;
 	struct ap_message ap_msg;
 	unsigned int wgt = 0, pref_wgt = 0;
-	unsigned int func_code;
-	int cpen, qpen, qid = 0, rc = -ENODEV;
+	unsigned int func_code = 0;
+	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	ap_init_message(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg);
+	if (rc)
+		goto out;
 
 	if (crt->outputdatalength < crt->inputdatalength) {
-		func_code = 0;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -832,7 +834,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	spin_unlock(&zcrypt_list_lock);
 
 out:
-	ap_release_message(&ap_msg);
+	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
 		tr->last_qid = qid;
@@ -850,15 +852,18 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	struct zcrypt_queue *zq, *pref_zq;
 	struct ap_message ap_msg;
 	unsigned int wgt = 0, pref_wgt = 0;
-	unsigned int func_code;
+	unsigned int func_code = 0;
 	unsigned short *domain, tdom;
-	int cpen, qpen, qid = 0, rc = -ENODEV;
+	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
 
 	trace_s390_zcrypt_req(xcrb, TB_ZSECSENDCPRB);
 
 	xcrb->status = 0;
-	ap_init_message(&ap_msg);
+
+	rc = ap_init_apmsg(&ap_msg);
+	if (rc)
+		goto out;
 
 	rc = prep_cca_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
 	if (rc)
@@ -962,7 +967,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	spin_unlock(&zcrypt_list_lock);
 
 out:
-	ap_release_message(&ap_msg);
+	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
 		tr->last_qid = qid;
@@ -1033,14 +1038,16 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	struct ep11_target_dev *targets;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
-	unsigned int func_code, domain;
+	unsigned int func_code = 0, domain;
 	struct ap_message ap_msg;
-	int cpen, qpen, qid = 0, rc = -ENODEV;
+	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	ap_init_message(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg);
+	if (rc)
+		goto out;
 
 	target_num = (unsigned short)xcrb->targets_num;
 
@@ -1164,7 +1171,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 out_free:
 	kfree(targets);
 out:
-	ap_release_message(&ap_msg);
+	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
 		tr->last_qid = qid;
@@ -1212,7 +1219,9 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	ap_init_message(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg);
+	if (rc)
+		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
 	if (rc)
 		goto out;
@@ -1258,7 +1267,7 @@ static long zcrypt_rng(char *buffer)
 	spin_unlock(&zcrypt_list_lock);
 
 out:
-	ap_release_message(&ap_msg);
+	ap_release_apmsg(&ap_msg);
 	trace_s390_zcrypt_rep(buffer, func_code, rc,
 			      AP_QID_CARD(qid), AP_QID_QUEUE(qid));
 	return rc;
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index 47c401f5409b..fc0a2a053dc2 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -449,6 +449,10 @@ static atomic_t zcrypt_step = ATOMIC_INIT(0);
  * @zq: pointer to zcrypt_queue structure that identifies the
  *	CEXxA device to the request distributor
  * @mex: pointer to the modexpo request buffer
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_msg->bufsize is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 				     struct ica_rsa_modexpo *mex,
@@ -456,10 +460,8 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 {
 	int rc;
 
-	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < MSGTYPE50_CRB3_MAX_MSG_SIZE)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype50_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
@@ -496,6 +498,10 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
  * @zq: pointer to zcrypt_queue structure that identifies the
  *	CEXxA device to the request distributor
  * @crt: pointer to the modexpoc_crt request buffer
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_msg->bufsize is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 					 struct ica_rsa_modexpo_crt *crt,
@@ -503,10 +509,8 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 {
 	int rc;
 
-	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < MSGTYPE50_CRB3_MAX_MSG_SIZE)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype50_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 09ef91af1e2a..9cefbb30960f 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1050,9 +1050,10 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
  * Prepare a CCA AP msg: fetch the required data from userspace,
  * prepare the AP msg, fill some info into the ap_message struct,
  * extract some data from the CPRB and give back to the caller.
- * This function allocates memory and needs an ap_msg prepared
- * by the caller with ap_init_message(). Also the caller has to
- * make sure ap_release_message() is always called even on failure.
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_msg->bufsize is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
 		    struct ap_message *ap_msg,
@@ -1060,10 +1061,6 @@ int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
 
-	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
@@ -1143,9 +1140,10 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
  * Prepare an EP11 AP msg: fetch the required data from userspace,
  * prepare the AP msg, fill some info into the ap_message struct,
  * extract some data from the CPRB and give back to the caller.
- * This function allocates memory and needs an ap_msg prepared
- * by the caller with ap_init_message(). Also the caller has to
- * make sure ap_release_message() is always called even on failure.
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_msg->bufsize is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 		     struct ap_message *ap_msg,
@@ -1153,10 +1151,6 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
 
-	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
 	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
@@ -1257,15 +1251,20 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 	return rc;
 }
 
+/*
+ * Prepare a CEXXC get random request ap message.
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_max_msg_size is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
+ */
 int prep_rng_ap_msg(struct ap_message *ap_msg, int *func_code,
 		    unsigned int *domain)
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
 
-	ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
-	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < AP_DEFAULT_MAX_MSG_SIZE)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-- 
2.43.0

