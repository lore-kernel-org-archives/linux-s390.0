Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7820127F
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304510; cv=none; b=Aed5G/W8Vo6AGjUxqMrLLkGoUUWHKfX9zwz4NCL8rMB5IKGe5CV6G1vs8n/OoUMOhT+LXPYrS03Of/yXDGrH/oQ9ajnitrybHKBScFFO0KCjjpX12O3FKpQVpLdDFi8TfijopcS0zStge/TaRZRaHfSsWYfq61Iq7NFi/xVhw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304510; c=relaxed/simple;
	bh=vQhL4DZhToSdbgsfSbOBMNS2WPHC+4ZSV+n6TJpeutM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpLuP6FcShgH8U9ocZT0qcgymminjivOoooNQC/rrTerzJJJGVa0oGzxbV/Zu/clYdt5T2UT0sE7OH1Vpj/cAvS1XGW1n0G70Uo28ze3ghL/VFwcUhW8S9yQ8ia5uODi2jhbWtgC+SLVovcU4FiWiHlYQiP1hFileUL6ngG8ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XK1PS9FE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XK1PS9FE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N8qnKR006122;
	Sun, 23 Feb 2025 09:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DdCSz8842OnPKHhRN
	EGnwhU+gxVW+ZjvVbXMMvdYg5w=; b=XK1PS9FEWeMi2uFDCY0X1LZgY8FHwFCIw
	f3oOrwxrooFq9f+7ljh9uyh0MqWdiXNxCglf8RyBJMfadFlo2NOIeiDOLbsPG8VD
	5wRrxBhBCysdPtriBn3Ye0+47OeM5UxWkpG93I2ikwlfetcHlzFhUAnXCvsbSoni
	qCWi1hxepUvZwfFK90ZjFJl6ccEzrTkXAN89y17w8NdfHOW8Jo0afVI4j0+4V4tj
	30wZ5e8LR0NswG8YeLMTaQRx8DVxOcVnM2GfrUkekj4YSAThCxpLoanuwiF6ql8R
	60k4xe+tk7SfmUr07KWaL9HWPD+m8svfLzk2nU+K0375ksektSgsg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yycnrbuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N9ASch012499;
	Sun, 23 Feb 2025 09:55:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y1wg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t1nw33882528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 124CC20040;
	Sun, 23 Feb 2025 09:55:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB89120049;
	Sun, 23 Feb 2025 09:55:00 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 02/20] s390/ap/zcrypt: Rework AP message buffer allocation
Date: Sun, 23 Feb 2025 10:54:41 +0100
Message-ID: <20250223095459.43058-3-freude@linux.ibm.com>
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
X-Proofpoint-GUID: tGhBqIA2VeY_wceqx5lpNN_s2LPDizzE
X-Proofpoint-ORIG-GUID: tGhBqIA2VeY_wceqx5lpNN_s2LPDizzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Slight rework on the way how AP message buffers are allocated.
Instead of having multiple places with kmalloc() calls all
the AP message buffers are now allocated and freed on exactyl
one place ap_init_apmsg() allocates the current AP bus max
limit of ap_max_msg_size (defaults to 12KB). The preparation
functions only check for their payload to fit in. The AP
message buffer is freed in ap_release_apmsg().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c           | 30 ++++++++++++++++
 drivers/s390/crypto/ap_bus.h           | 21 ++---------
 drivers/s390/crypto/zcrypt_api.c       | 49 +++++++++++++++-----------
 drivers/s390/crypto/zcrypt_msgtype50.c | 22 ++++++------
 drivers/s390/crypto/zcrypt_msgtype6.c  | 46 ++++++++++++------------
 5 files changed, 96 insertions(+), 72 deletions(-)

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
index a5d8f805625f..3956a5e945bd 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -241,25 +241,8 @@ struct ap_message {
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
index 222deb4040f3..098cf5496f06 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -449,6 +449,10 @@ static atomic_t zcrypt_step = ATOMIC_INIT(0);
  * @zq: pointer to zcrypt_queue structure that identifies the
  *	CEXxA device to the request distributor
  * @mex: pointer to the modexpo request buffer
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_max_msg_size is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 				     struct ica_rsa_modexpo *mex,
@@ -456,11 +460,8 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
 {
 	int rc;
 
-	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
-	if (!ap_msg->msg)
-		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < MSGTYPE50_CRB3_MAX_MSG_SIZE)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype50_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
@@ -497,6 +498,10 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
  * @zq: pointer to zcrypt_queue structure that identifies the
  *	CEXxA device to the request distributor
  * @crt: pointer to the modexpoc_crt request buffer
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_max_msg_size is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 					 struct ica_rsa_modexpo_crt *crt,
@@ -504,11 +509,8 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
 {
 	int rc;
 
-	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
-	if (!ap_msg->msg)
-		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < MSGTYPE50_CRB3_MAX_MSG_SIZE)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype50_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 		atomic_inc_return(&zcrypt_step);
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 21ee311cf33d..0e91d403a93c 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1046,22 +1046,20 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
  * Prepare a CCA AP msg: fetch the required data from userspace,
  * prepare the AP msg, fill some info into the ap_message struct,
  * extract some data from the CPRB and give back to the caller.
- * This function may allocate memory if the ap_msg msg buffer is
- * not preallocated and needs an ap_msg prepared by the caller
- * with ap_init_message(). Also the caller has to make sure
- * ap_release_message() is always called even on failure.
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_max_msg_size is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
 		    struct ap_message *ap_msg,
 		    unsigned int *func_code, unsigned short **dom)
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
+	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
 
-	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
-	if (!ap_msg->msg)
-		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < maxmsgsize)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
@@ -1141,22 +1139,20 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
  * Prepare an EP11 AP msg: fetch the required data from userspace,
  * prepare the AP msg, fill some info into the ap_message struct,
  * extract some data from the CPRB and give back to the caller.
- * This function may allocate memory if the ap_msg msg buffer is
- * not preallocated and needs an ap_msg prepared by the caller
- * with ap_init_message(). Also the caller has to make sure
- * ap_release_message() is always called even on failure.
+ * This function assumes that ap_msg has been initialized with
+ * ap_init_apmsg() and thus a valid buffer with the size of
+ * ap_max_msg_size is available within ap_msg. Also the caller has
+ * to make sure ap_release_apmsg() is always called even on failure.
  */
 int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 		     struct ap_message *ap_msg,
 		     unsigned int *func_code, unsigned int *domain)
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
+	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
 
-	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
-	if (!ap_msg->msg)
-		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < maxmsgsize)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
@@ -1257,16 +1253,20 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
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
-	if (!ap_msg->msg)
-		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
-	if (!ap_msg->msg)
-		return -ENOMEM;
+	if (ap_msg->bufsize < AP_DEFAULT_MAX_MSG_SIZE)
+		return -EMSGSIZE;
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-- 
2.43.0

