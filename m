Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16725F965
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108890; cv=none; b=CcdsiD2GkEQa/LudJYIvV3SD37Bc4OYHrK+FFBCynWx7irs8Zj1XWvbCtcGDTRvAime2ax+a/UcBvFITLh/10uRFqYTahTnS+jUsNvb1fzJikfqsnS94Sy/azLCCbi9aPRCKYplz/OPrHW+t2IPxX7yp97Av/Hfl0IW9v0V6RhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108890; c=relaxed/simple;
	bh=lcS32z8a9UG+Xd3Dpgeft3nNfD/eZDHmZHpEnHf34Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5FvL5U800qEAV6SAxEjdndPiHNi5v7lp8B5xEn2oLDlQYGzwoVLIo6U2p9C/xqEScup+agjgx0ndugAGSG++nTrsE5ftZehkSwlzKaJxkyfoOpBvHxp/umsrT2+9d4pFtrUFVrHL9LsQ9mcIb1dCe4/vqhxECxeyiDMq5J4d+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mTVULWrI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mTVULWrI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524DKadb021798;
	Tue, 4 Mar 2025 17:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PlnTP4F0+bilDuGsx
	MV7zUUhhml1f7+dLF9eOZy53qk=; b=mTVULWrIjvRtGzRHtcvbXKUNbdTexNrAw
	DpkGckvOcVEpdQ2WIpAsshnKJ8mbIUza9lWCz6PEmubS66gGtAYMQbQUUJu0YSHy
	Jd3Ee+IqntVFQ8QBZna6vh8CFybQ2dZwxP8V2LNobtmXAM/QFbf0GzekLBu/eu3T
	rk4sq/TfuYBqCeHzDLU89ZTz96VyGNLvOPeR3T+GqmF7SdtDC82KA+bbLJzcZuyJ
	CysW3i0oBuLP4lUgGJfVfsQdBXl2Z4BXWrVSMoISP3aOmRTK1pwtRA1wqmN//y7k
	q0B4FYcTQHbBUH0hJCMNLkRddHFtRP5Nv3aWHaVAA/AkAowPim+5g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7kugt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524EdNwY032216;
	Tue, 4 Mar 2025 17:21:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjsxrms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLJTU32964994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9028720040;
	Tue,  4 Mar 2025 17:21:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C882004B;
	Tue,  4 Mar 2025 17:21:19 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 04/20] s390/ap/zcrypt: New xflag parameter and extension of the ap msg flags
Date: Tue,  4 Mar 2025 18:21:00 +0100
Message-ID: <20250304172116.85374-5-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DfWxETLv9JJWzAPIyw5pwCjf2eMoCExc
X-Proofpoint-GUID: DfWxETLv9JJWzAPIyw5pwCjf2eMoCExc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Introduce a new flag parameter for the both cprb send functions
zcrypt_send_cprb() and zcrypt_send_ep11_cprb(). This new
xflags parameter ("execution flags") shall be used to provide
execution hints and flags for this crypto request.

There are two flags implemented to be used with these functions:
* ZCRYPT_XFLAG_USERSPACE - indicates to the lower layers that
  all the ptrs address userspace. So when construction the ap msg
  copy_from_user() is to be used. If this flag is NOT set, the ptrs
  address kernel memory and thus memcpy() is to be used.
* ZCRYPT_XFLAG_NOMEMALLOC - indicates that this task must not
  allocate memory which may be allocated with io operations.
  For the zcrypt layer this limits the number of EP11 targets
  to 16 APQNs. But as this flag is passed down the stack, it
  may induce further restrictions.

For the AP bus and zcrypt message layer this means:
* The ZCRYPT_XFLAG_USERSPACE is mapped to the AP flag
  AP_MSG_FLAG_USERSPACE stored into the flags field of each
  ap message in the ap_message struct. This replaces the extra
  function parameter "userspace" and makes some function
  invocations simpler.
* The ZCRYPT_XFLAG_NOMEMALLOC causes the AP message buffer to
  use buffer space from the AP message mempool instead of
  allocating memory via kmalloc. Note that the buffer space
  from the AP message mem pool is limited to 12KB per item.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          |  6 +-
 drivers/s390/crypto/ap_bus.h          | 11 ++--
 drivers/s390/crypto/zcrypt_api.c      | 90 +++++++++++++++------------
 drivers/s390/crypto/zcrypt_api.h      | 36 +++++++----
 drivers/s390/crypto/zcrypt_ccamisc.c  | 16 ++---
 drivers/s390/crypto/zcrypt_ep11misc.c | 10 +--
 drivers/s390/crypto/zcrypt_msgtype6.c | 12 ++--
 drivers/s390/crypto/zcrypt_msgtype6.h |  4 +-
 8 files changed, 107 insertions(+), 78 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 75dbab9dff4a..7b092fb82ac3 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -569,18 +569,18 @@ static void ap_poll_thread_stop(void)
  * Initialize struct ap_message and allocate buffer to construct
  * the ap message.
  */
-int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool)
+int ap_init_apmsg(struct ap_message *ap_msg, u32 flags)
 {
 	unsigned int maxmsgsize;
 
 	memset(ap_msg, 0, sizeof(*ap_msg));
+	ap_msg->flags = flags;
 
-	if (use_mempool) {
+	if (flags & AP_MSG_FLAG_MEMPOOL) {
 		ap_msg->msg = mempool_alloc_preallocated(ap_msg_pool);
 		if (!ap_msg->msg)
 			return -ENOMEM;
 		ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
-		ap_msg->flags |= AP_MSG_FLAG_MEMPOOL;
 		return 0;
 	}
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index a7bd44e5cc76..5581fb13af73 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -233,12 +233,13 @@ struct ap_message {
 			struct ap_message *);
 };
 
-#define AP_MSG_FLAG_SPECIAL  0x0001   /* flag msg as 'special' with NQAP */
-#define AP_MSG_FLAG_USAGE    0x0002   /* CCA, EP11: usage (no admin) msg */
-#define AP_MSG_FLAG_ADMIN    0x0004   /* CCA, EP11: admin (=control) msg */
-#define AP_MSG_FLAG_MEMPOOL  0x0008   /* ap msg buffer allocated from mempool */
+#define AP_MSG_FLAG_SPECIAL    0x0001  /* flag msg as 'special' with NQAP */
+#define AP_MSG_FLAG_USAGE      0x0002  /* CCA, EP11: usage (no admin) msg */
+#define AP_MSG_FLAG_ADMIN      0x0004  /* CCA, EP11: admin (=control) msg */
+#define AP_MSG_FLAG_MEMPOOL    0x0008  /* ap msg buffer allocated from mempool */
+#define AP_MSG_FLAG_USERSPACE  0x0010  /* pointers address userspace memory */
 
-int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
+int ap_init_apmsg(struct ap_message *ap_msg, u32 flags);
 void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ad09c5306e28..659fe7afb67e 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, AP_MSG_FLAG_USERSPACE);
 	if (rc)
 		goto out;
 
@@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, AP_MSG_FLAG_USERSPACE);
 	if (rc)
 		goto out;
 
@@ -844,7 +844,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	return rc;
 }
 
-static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
+static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 			      struct zcrypt_track *tr,
 			      struct ica_xcRB *xcrb)
 {
@@ -856,16 +856,19 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	unsigned short *domain, tdom;
 	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
+	u32 flags;
 
 	trace_s390_zcrypt_req(xcrb, TB_ZSECSENDCPRB);
 
 	xcrb->status = 0;
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	flags = (xflags & ZCRYPT_XFLAG_USERSPACE ? AP_MSG_FLAG_USERSPACE : 0) |
+		(xflags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0);
+	rc = ap_init_apmsg(&ap_msg, flags);
 	if (rc)
 		goto out;
 
-	rc = prep_cca_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
+	rc = prep_cca_ap_msg(xcrb, &ap_msg, &func_code, &domain);
 	if (rc)
 		goto out;
 	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
@@ -956,7 +959,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	if (*domain == AUTOSEL_DOM)
 		*domain = AP_QID_QUEUE(qid);
 
-	rc = pref_zq->ops->send_cprb(userspace, pref_zq, xcrb, &ap_msg);
+	rc = pref_zq->ops->send_cprb(pref_zq, xcrb, &ap_msg);
 	if (!rc) {
 		print_hex_dump_debug("ccarpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
 				     ap_msg.msg, ap_msg.len, false);
@@ -977,7 +980,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	return rc;
 }
 
-long zcrypt_send_cprb(struct ica_xcRB *xcrb)
+long zcrypt_send_cprb(struct ica_xcRB *xcrb, u32 xflags)
 {
 	struct zcrypt_track tr;
 	int rc;
@@ -985,13 +988,13 @@ long zcrypt_send_cprb(struct ica_xcRB *xcrb)
 	memset(&tr, 0, sizeof(tr));
 
 	do {
-		rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb);
+		rc = _zcrypt_send_cprb(xflags, &ap_perms, &tr, xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb);
+			rc = _zcrypt_send_cprb(xflags, &ap_perms, &tr, xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1029,52 +1032,58 @@ static bool is_desired_ep11_queue(unsigned int dev_qid,
 	return false;
 }
 
-static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
+static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 				   struct zcrypt_track *tr,
 				   struct ep11_urb *xcrb)
 {
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
-	struct ep11_target_dev *targets;
+	struct ep11_target_dev targetbuf[16], *targets = NULL;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
 	unsigned int func_code = 0, domain;
 	struct ap_message ap_msg;
 	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
+	u32 flags;
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	flags = (xflags & ZCRYPT_XFLAG_USERSPACE ? AP_MSG_FLAG_USERSPACE : 0) |
+		(xflags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0);
+	rc = ap_init_apmsg(&ap_msg, flags);
 	if (rc)
 		goto out;
 
 	target_num = (unsigned short)xcrb->targets_num;
 
 	/* empty list indicates autoselect (all available targets) */
-	targets = NULL;
+	rc = -ENOMEM;
 	if (target_num != 0) {
 		struct ep11_target_dev __user *uptr;
 
-		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
-		if (!targets) {
-			func_code = 0;
-			rc = -ENOMEM;
+		if (target_num <= ARRAY_SIZE(targetbuf)) {
+			targets = targetbuf;
+		} else if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
 			goto out;
+		} else {
+			targets = kcalloc(target_num,
+					  sizeof(*targets), GFP_KERNEL);
+			if (!targets)
+				goto out;
 		}
 
 		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
-		if (z_copy_from_user(userspace, targets, uptr,
-				     target_num * sizeof(*targets))) {
-			func_code = 0;
+		if (z_copy_from_user(xflags & ZCRYPT_XFLAG_USERSPACE, targets,
+				     uptr, target_num * sizeof(*targets))) {
 			rc = -EFAULT;
-			goto out_free;
+			goto out;
 		}
 	}
 
-	rc = prep_ep11_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
+	rc = prep_ep11_ap_msg(xcrb, &ap_msg, &func_code, &domain);
 	if (rc)
-		goto out_free;
+		goto out;
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
@@ -1082,11 +1091,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
-				goto out_free;
+				goto out;
 			}
 		} else if ((ap_msg.flags & AP_MSG_FLAG_USAGE) == 0) {
 			rc = -EOPNOTSUPP;
-			goto out_free;
+			goto out;
 		}
 	}
 
@@ -1154,11 +1163,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 			pr_debug("no match for address ff.ffff => ENODEV\n");
 		}
 		rc = -ENODEV;
-		goto out_free;
+		goto out;
 	}
 
 	qid = pref_zq->queue->qid;
-	rc = pref_zq->ops->send_ep11_cprb(userspace, pref_zq, xcrb, &ap_msg);
+	rc = pref_zq->ops->send_ep11_cprb(pref_zq, xcrb, &ap_msg);
 	if (!rc) {
 		print_hex_dump_debug("ep11rpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
 				     ap_msg.msg, ap_msg.len, false);
@@ -1168,9 +1177,9 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	zcrypt_drop_queue(pref_zc, pref_zq, mod, wgt);
 	spin_unlock(&zcrypt_list_lock);
 
-out_free:
-	kfree(targets);
 out:
+	if (targets && targets != targetbuf)
+		kfree(targets);
 	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
@@ -1181,7 +1190,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	return rc;
 }
 
-long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
+long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb, u32 xflags)
 {
 	struct zcrypt_track tr;
 	int rc;
@@ -1189,13 +1198,13 @@ long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
 	memset(&tr, 0, sizeof(tr));
 
 	do {
-		rc = _zcrypt_send_ep11_cprb(false, &ap_perms, &tr, xcrb);
+		rc = _zcrypt_send_ep11_cprb(xflags, &ap_perms, &tr, xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_ep11_cprb(false, &ap_perms, &tr, xcrb);
+			rc = _zcrypt_send_ep11_cprb(xflags, &ap_perms, &tr, xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1219,7 +1228,7 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
@@ -1532,6 +1541,7 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	int rc;
 	struct ica_xcRB xcrb;
 	struct zcrypt_track tr;
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct ica_xcRB __user *uxcrb = (void __user *)arg;
 
 	memset(&tr, 0, sizeof(tr));
@@ -1539,13 +1549,13 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
 		return -EFAULT;
 
 	do {
-		rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb);
+		rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb);
+			rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1562,6 +1572,7 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	int rc;
 	struct ep11_urb xcrb;
 	struct zcrypt_track tr;
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct ep11_urb __user *uxcrb = (void __user *)arg;
 
 	memset(&tr, 0, sizeof(tr));
@@ -1569,13 +1580,13 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
 		return -EFAULT;
 
 	do {
-		rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb);
+		rc = _zcrypt_send_ep11_cprb(xflags, perms, &tr, &xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb);
+			rc = _zcrypt_send_ep11_cprb(xflags, perms, &tr, &xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1836,6 +1847,7 @@ static long trans_xcrb32(struct ap_perms *perms, struct file *filp,
 			 unsigned int cmd, unsigned long arg)
 {
 	struct compat_ica_xcrb __user *uxcrb32 = compat_ptr(arg);
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct compat_ica_xcrb xcrb32;
 	struct zcrypt_track tr;
 	struct ica_xcRB xcrb64;
@@ -1865,13 +1877,13 @@ static long trans_xcrb32(struct ap_perms *perms, struct file *filp,
 	xcrb64.priority_window = xcrb32.priority_window;
 	xcrb64.status = xcrb32.status;
 	do {
-		rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb64);
+		rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb64);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb64);
+			rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb64);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 4ed481df57ca..8550a1eceb05 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -76,17 +76,29 @@ struct zcrypt_track {
 #define TRACK_AGAIN_CARD_WEIGHT_PENALTY  1000
 #define TRACK_AGAIN_QUEUE_WEIGHT_PENALTY 10000
 
+/*
+ * xflags - to be used with zcrypt_send_cprb() and
+ * zcrypt_send_ep11_cprb() for the xflags parameter.
+ */
+#define ZCRYPT_XFLAG_USERSPACE  0x0001  /* data ptrs address userspace */
+#define ZCRYPT_XFLAG_NOMEMALLOC 0x0002  /* do not allocate fresh memory */
+
 struct zcrypt_ops {
-	long (*rsa_modexpo)(struct zcrypt_queue *, struct ica_rsa_modexpo *,
-			    struct ap_message *);
-	long (*rsa_modexpo_crt)(struct zcrypt_queue *,
-				struct ica_rsa_modexpo_crt *,
-				struct ap_message *);
-	long (*send_cprb)(bool userspace, struct zcrypt_queue *, struct ica_xcRB *,
-			  struct ap_message *);
-	long (*send_ep11_cprb)(bool userspace, struct zcrypt_queue *, struct ep11_urb *,
-			       struct ap_message *);
-	long (*rng)(struct zcrypt_queue *, char *, struct ap_message *);
+	long (*rsa_modexpo)(struct zcrypt_queue *zq,
+			    struct ica_rsa_modexpo *icamodexp,
+			    struct ap_message *apmsg);
+	long (*rsa_modexpo_crt)(struct zcrypt_queue *zq,
+				struct ica_rsa_modexpo_crt *icacrt,
+				struct ap_message *apmsg);
+	long (*send_cprb)(struct zcrypt_queue *zq,
+			  struct ica_xcRB *icaxcrb,
+			  struct ap_message *apmsg);
+	long (*send_ep11_cprb)(struct zcrypt_queue *zq,
+			       struct ep11_urb *ep11urb,
+			       struct ap_message *apmsg);
+	long (*rng)(struct zcrypt_queue *zq,
+		    char *buffer,
+		    struct ap_message *apmsg);
 	struct list_head list;		/* zcrypt ops list. */
 	struct module *owner;
 	int variant;
@@ -161,8 +173,8 @@ void zcrypt_msgtype_unregister(struct zcrypt_ops *);
 struct zcrypt_ops *zcrypt_msgtype(unsigned char *, int);
 int zcrypt_api_init(void);
 void zcrypt_api_exit(void);
-long zcrypt_send_cprb(struct ica_xcRB *xcRB);
-long zcrypt_send_ep11_cprb(struct ep11_urb *urb);
+long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
+long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
 void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstatus);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 43a27cb3db84..521baaea06ff 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -379,7 +379,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, errno %d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -517,7 +517,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -644,7 +644,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -872,7 +872,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1038,7 +1038,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1249,7 +1249,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1412,7 +1412,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1526,7 +1526,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index cb7e6da43602..b60e262bcaa3 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -636,7 +636,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 		 req, sizeof(*req) + sizeof(*req_pl),
 		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -892,7 +892,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1049,7 +1049,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + rep_pl_size);
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1212,7 +1212,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1372,7 +1372,7 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 76972027edfd..8ffe7505b994 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1057,11 +1057,12 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
  * ap_msg->bufsize is available within ap_msg. Also the caller has
  * to make sure ap_release_apmsg() is always called even on failure.
  */
-int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
+int prep_cca_ap_msg(struct ica_xcRB *xcrb,
 		    struct ap_message *ap_msg,
 		    unsigned int *func_code, unsigned short **dom)
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
+	bool userspace = ap_msg->flags & AP_MSG_FLAG_USERSPACE;
 
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
@@ -1077,11 +1078,12 @@ int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
  *	CEXxC device to the request distributor
  * @xcrb: pointer to the send_cprb request buffer
  */
-static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
+static long zcrypt_msgtype6_send_cprb(struct zcrypt_queue *zq,
 				      struct ica_xcRB *xcrb,
 				      struct ap_message *ap_msg)
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
+	bool userspace = ap_msg->flags & AP_MSG_FLAG_USERSPACE;
 	struct {
 		struct type6_hdr hdr;
 		struct CPRBX cprbx;
@@ -1147,11 +1149,12 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
  * ap_msg->bufsize is available within ap_msg. Also the caller has
  * to make sure ap_release_apmsg() is always called even on failure.
  */
-int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
+int prep_ep11_ap_msg(struct ep11_urb *xcrb,
 		     struct ap_message *ap_msg,
 		     unsigned int *func_code, unsigned int *domain)
 {
 	struct ap_response_type *resp_type = &ap_msg->response;
+	bool userspace = ap_msg->flags & AP_MSG_FLAG_USERSPACE;
 
 	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
 	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
@@ -1168,12 +1171,13 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
  *	  CEX4P device to the request distributor
  * @xcrb: pointer to the ep11 user request block
  */
-static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *zq,
+static long zcrypt_msgtype6_send_ep11_cprb(struct zcrypt_queue *zq,
 					   struct ep11_urb *xcrb,
 					   struct ap_message *ap_msg)
 {
 	int rc;
 	unsigned int lfmt;
+	bool userspace = ap_msg->flags & AP_MSG_FLAG_USERSPACE;
 	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.h b/drivers/s390/crypto/zcrypt_msgtype6.h
index 6f5ced8d6cda..b2944f5b2d18 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.h
+++ b/drivers/s390/crypto/zcrypt_msgtype6.h
@@ -94,10 +94,10 @@ struct type86_fmt2_ext {
 	unsigned int	  offset4;	/* 0x00000000			*/
 } __packed;
 
-int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
+int prep_cca_ap_msg(struct ica_xcRB *xcrb,
 		    struct ap_message *ap_msg,
 		    unsigned int *fc, unsigned short **dom);
-int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
+int prep_ep11_ap_msg(struct ep11_urb *xcrb,
 		     struct ap_message *ap_msg,
 		     unsigned int *fc, unsigned int *dom);
 int prep_rng_ap_msg(struct ap_message *ap_msg,
-- 
2.43.0

