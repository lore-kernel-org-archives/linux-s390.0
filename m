Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56A1922E7
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501826; cv=none; b=hzQrGEDcxBnuOzOKqGtpcEAzliuBbJB7oqTbidcaLGhwUnEkvNRDGQ83eQmIO2338tgZiwymHjAoMEvfsPX72lollbCHZiSVfnOsIn+hJzZyLUArZc3hvPE/PYDHW9rzB/jqTe+e26U+bqkjhPy/ZGOTqzxtu2sXg/v0exs7VW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501826; c=relaxed/simple;
	bh=8YPW/qm4oZwOak9VVlE0cJBVju3BiJJCJ5uXqtmSzvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwm7gdFNP8sM4n33fL2Eo2u3sL436wmAx+Nrlt1SjoS6+hz7XE8gBckinlZAM5Q8hgM8kGphVb62YvLsls3vAlkIwPuCx5AcFmWgPGM2YL4/DM8wu0lKE7ycV10oGVvxjHd8m6t9l56Pz06rFo2i5lSwlvouxQTiRYu1e2Axufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j/nzVY6r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j/nzVY6r"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8bnmG013583;
	Thu, 24 Apr 2025 13:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8XCSBj+eRhXv/bLE0
	bwch2bISIvCfRWXl1lRxQG380o=; b=j/nzVY6r4foX55iZ4SSGKyoUlieqd2vD2
	+01JaZgJSYdNT2gvgBHP/XdyAY7aX0GjkPUtLsg4Nx7I+r4tMgu977n03oUhzx18
	MEBwNf5PxU7oK5iMZDnrKKrUoR4ShPE4Qlkj/YiZF/fP/3m6BKIsAHTZRC47Xk18
	t31TXQfggexaWub/RW13YGdbbikCi4cmtBHjcTGBTBr3fMZ1q0SlAlMsua2jc0WK
	eNfl9RpWbom5FNcltULNNlgWZqwUUh2TViYM3EvXhuJKG2AUHoz+5BvwjdDT7r7O
	XhTHHydYoMzSzVotYuaqLKSS6LMf5cMBAOY6iSnDZALk3nyv9bTwA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678bwbq1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:37:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBSV4Q004098;
	Thu, 24 Apr 2025 13:36:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg00deh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaMc029884800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A12912004B;
	Thu, 24 Apr 2025 13:36:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28D762004D;
	Thu, 24 Apr 2025 13:36:22 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:22 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 05/25] s390/ap/zcrypt: New xflag parameter
Date: Thu, 24 Apr 2025 15:35:59 +0200
Message-ID: <20250424133619.16495-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX7+0jZZrqdagZ 3RTY2MN75+nqPw3wtlkWJj08SYBgBrNr27kwLiJTlgtC1Fh2dawndnjpJYtdP1E3IVfeMHvxFOp xuxGqd6NGHRSp3t7TnpxC2mzMwL/qZjQaQmQvjhLarRn1l+4RNH5FYbiFlZnqG1aFVk3SnIaQNI
 yfxR/h25FaqKJ5ULwIa6pld0lYvWnINAcs3x3A7xvfBrtYFU0/MR6LXwqosjnQXZjl0v03i9U2H 1tqSFNH4sc26daGBt+TI6PTZCAHKEHsc/r2GWZHXDlUDXgesz9kZSr+9uYbTDJlhYGuqgcmIzrM MnVvhKbTp8d+01RgaMC3BPSBzUSt2S9L3VOfgNtc8ituASni3NM1VJNVKDrkXOQs4hlbmiO1j7V
 GDTCD1H6M4vXZel6M5nQZPvsGlIdoxb7fdjYx3904bv6cgHVnSq787ESGbmovampb2Mem+Qd
X-Proofpoint-ORIG-GUID: JQ8xcQyxPhR0PMRAgRf1xSgpBgin0-DH
X-Authority-Analysis: v=2.4 cv=KZzSsRYD c=1 sm=1 tr=0 ts=680a3e7c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=c0krd4Ji88AqmSlRtW4A:9
X-Proofpoint-GUID: JQ8xcQyxPhR0PMRAgRf1xSgpBgin0-DH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

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

For the AP bus and zcrypt message layer this means:
* The ZCRYPT_XFLAG_USERSPACE is mapped to the already existing
  bool variable "userspace" which is propagated to the zcrypt
  proto implementations.
* The ZCRYPT_XFLAG_NOMEMALLOC results in setting the AP flag
  AP_MSG_FLAG_MEMPOOL when the AP msg buffer is initialized.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          |  6 ++--
 drivers/s390/crypto/ap_bus.h          |  2 +-
 drivers/s390/crypto/zcrypt_api.c      | 45 ++++++++++++++++-----------
 drivers/s390/crypto/zcrypt_api.h      | 11 +++++--
 drivers/s390/crypto/zcrypt_ccamisc.c  | 16 +++++-----
 drivers/s390/crypto/zcrypt_ep11misc.c | 10 +++---
 6 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 1e4784e9efd1..288734cd8f4b 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -572,18 +572,18 @@ static void ap_poll_thread_stop(void)
 /*
  * ap_init_apmsg() - Initialize ap_message.
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
index 60c41d8116ad..88b625ba1978 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -238,7 +238,7 @@ struct ap_message {
 #define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
 #define AP_MSG_FLAG_MEMPOOL  0x0008 /* ap msg buffer allocated via mempool */
 
-int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
+int ap_init_apmsg(struct ap_message *ap_msg, u32 flags);
 void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index b299cdb73826..3a75c3b6c004 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -844,10 +844,11 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	return rc;
 }
 
-static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
+static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 			      struct zcrypt_track *tr,
 			      struct ica_xcRB *xcrb)
 {
+	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
 	struct ap_message ap_msg;
@@ -861,7 +862,8 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 
 	xcrb->status = 0;
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
+			   AP_MSG_FLAG_MEMPOOL : 0);
 	if (rc)
 		goto out;
 
@@ -977,7 +979,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	return rc;
 }
 
-long zcrypt_send_cprb(struct ica_xcRB *xcrb)
+long zcrypt_send_cprb(struct ica_xcRB *xcrb, u32 xflags)
 {
 	struct zcrypt_track tr;
 	int rc;
@@ -985,13 +987,13 @@ long zcrypt_send_cprb(struct ica_xcRB *xcrb)
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
@@ -1029,10 +1031,11 @@ static bool is_desired_ep11_queue(unsigned int dev_qid,
 	return false;
 }
 
-static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
+static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 				   struct zcrypt_track *tr,
 				   struct ep11_urb *xcrb)
 {
+	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
 	struct ep11_target_dev *targets = NULL;
@@ -1045,7 +1048,8 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
+			   AP_MSG_FLAG_MEMPOOL : 0);
 	if (rc)
 		goto out;
 
@@ -1177,7 +1181,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	return rc;
 }
 
-long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
+long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb, u32 xflags)
 {
 	struct zcrypt_track tr;
 	int rc;
@@ -1185,13 +1189,13 @@ long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
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
@@ -1215,7 +1219,7 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
@@ -1528,6 +1532,7 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	int rc;
 	struct ica_xcRB xcrb;
 	struct zcrypt_track tr;
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct ica_xcRB __user *uxcrb = (void __user *)arg;
 
 	memset(&tr, 0, sizeof(tr));
@@ -1535,13 +1540,13 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
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
@@ -1558,6 +1563,7 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	int rc;
 	struct ep11_urb xcrb;
 	struct zcrypt_track tr;
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct ep11_urb __user *uxcrb = (void __user *)arg;
 
 	memset(&tr, 0, sizeof(tr));
@@ -1565,13 +1571,13 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
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
@@ -1832,6 +1838,7 @@ static long trans_xcrb32(struct ap_perms *perms, struct file *filp,
 			 unsigned int cmd, unsigned long arg)
 {
 	struct compat_ica_xcrb __user *uxcrb32 = compat_ptr(arg);
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct compat_ica_xcrb xcrb32;
 	struct zcrypt_track tr;
 	struct ica_xcRB xcrb64;
@@ -1861,13 +1868,13 @@ static long trans_xcrb32(struct ap_perms *perms, struct file *filp,
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
index 4ed481df57ca..94dffb01942f 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -76,6 +76,13 @@ struct zcrypt_track {
 #define TRACK_AGAIN_CARD_WEIGHT_PENALTY  1000
 #define TRACK_AGAIN_QUEUE_WEIGHT_PENALTY 10000
 
+/*
+ * xflags - to be used with zcrypt_send_cprb() and
+ * zcrypt_send_ep11_cprb() for the xflags parameter.
+ */
+#define ZCRYPT_XFLAG_USERSPACE  0x0001  /* data ptrs address userspace */
+#define ZCRYPT_XFLAG_NOMEMALLOC 0x0002  /* do not allocate memory via kmalloc */
+
 struct zcrypt_ops {
 	long (*rsa_modexpo)(struct zcrypt_queue *, struct ica_rsa_modexpo *,
 			    struct ap_message *);
@@ -161,8 +168,8 @@ void zcrypt_msgtype_unregister(struct zcrypt_ops *);
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
-- 
2.43.0

