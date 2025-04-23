Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AB1FC7F1
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403351; cv=none; b=DJ3+bGByAL2sITQ8+jTyJHbG02P7HpwFhWZ60UrlcWNs0rQ+xrqm71SJXoznosgGo/oqDm4qagAoLKxbev0T1GQkkok52RAAa1I52wvKDYOGb1J2dPCP8ugBeykS5D1vOSdKxxINuDBXrPq1g7nhTEMYcbdkohdMMXcqiCwbfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403351; c=relaxed/simple;
	bh=bmd0jkMEkD/pIAW1RaiXWo3rvuyX8Ap4esh9tzuMCOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9hnjPChaknS/aeDJjkfe+QfpdnBJZ4yToXWPXkKfUk2J53hVfX3F2Tw35+rVhaQi2bxbat9JHgxXi9n1TfKFWCH8nClP8eGvU+VwZX5ZkCEJf4rETnNcZ3QZ9uN02YNtEJ3mAHKmcWsf/kD7MG/LJKCHOdu7gaCV87/8XIZEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PAV6AmtO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAV6AmtO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6frrB007355;
	Wed, 23 Apr 2025 10:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l5wTr4eZB90aeZjmH
	HX1xApiNL8ZabBfNrO2ie37riA=; b=PAV6AmtOJ1jTIR5Ilshlgw7lSPEOqxFtS
	6ydwfeMNGHmgcXMyolPlSRhDHNTvb0PIngfHGp0fzu2niOXsh45DWP06yOK9IXD8
	2Nha5Q/OsAIEpIaqK+PO7rC8P4+nLGC2dKNVjJh5wvzgk2SloVMosKRPH85kd0Px
	VN3Q5CiPtih5v62tbiaHVP0D5xxFBzya7rNJ1H6aiduutViA9VAJL4EK8Z8V/zbb
	ToPaeC19DZ9apQazO5R5qc6Lp/KPjpyt70kJ2xB1QJJ/6NV0EJUGW+lXrWDyV7B4
	0SADZHRh/gu16uhH157iteIZqmKL9Wn8uATjZ1FHL3DFR7zqHzYAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnstmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6jGpX000976;
	Wed, 23 Apr 2025 10:15:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxth3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFbDM51773796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2584720049;
	Wed, 23 Apr 2025 10:15:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F0FD2004D;
	Wed, 23 Apr 2025 10:15:36 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:36 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 02/25] s390/ap/zcrypt: Rework AP message buffer allocation
Date: Wed, 23 Apr 2025 12:15:11 +0200
Message-ID: <20250423101535.143137-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zKckr7uyG3YMG7nvR9J1Y1mixy6VngSm
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808bdcd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=6NBNJmlGsSjmlsHamvEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX3eHJ4fCWHaej nIS1zFmCAJIox+2KgD3FZxLDfX1ewOaV3Z0VCBkBTFkuAcVDd1wEx5bAyf1xuDWl1dDyWri/mmf Xx5NkaqWvLlDAjc05sd0FN68cw05IPjOAfD23jv3Ye/Sa3zMr4Kq92KRFFnOvM3zdm7ANbGImhu
 oOvWAvGAv7bqQ2QxfztOlu+tEE7S4Y6CqxPRnv6i8M52ECbRtbYI5mfQN78b4SbuEIH95h3joYx DzGtE3EzTJ/SjR0i5WupbeHaLx6LTSg0KeC+wlyfyYrCjjKuGeKb+ITPOukT9HDWhBCFNouNX5q SQ8hXKxSBABf+U6GOzpuOWOLqEZpVzh1bORhRAiCrNduwSBzw7CxU0vBKyPeiRHWtVjdtPsUxw7
 vlTDIxBaz4UQB0RiU3MwvU9wYmyhCGiZ0Su19cJmPdIEKL8IJESZ8VpuWaPC4tKmv9Pd8mXr
X-Proofpoint-ORIG-GUID: zKckr7uyG3YMG7nvR9J1Y1mixy6VngSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

Slight rework on the way how AP message buffers are allocated.
Instead of having multiple places with kmalloc() calls all
the AP message buffers are now allocated and freed on exactly
one place: ap_init_apmsg() allocates the current AP bus max
limit of ap_max_msg_size (defaults to 12KB). The AP message
buffer is then freed in ap_release_apmsg().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c           | 26 ++++++++++++++
 drivers/s390/crypto/ap_bus.h           | 21 ++---------
 drivers/s390/crypto/zcrypt_api.c       | 49 +++++++++++++++-----------
 drivers/s390/crypto/zcrypt_msgtype50.c | 20 ++++++-----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 35 +++++++++---------
 5 files changed, 86 insertions(+), 65 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 1564cd7e3f59..8935b3ee3a33 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -547,6 +547,32 @@ static void ap_poll_thread_stop(void)
 #define is_card_dev(x) ((x)->parent == ap_root_device)
 #define is_queue_dev(x) ((x)->parent != ap_root_device)
 
+/*
+ * ap_init_apmsg() - Initialize ap_message.
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
+/*
+ * ap_release_apmsg() - Release ap_message.
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

