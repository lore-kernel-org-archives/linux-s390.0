Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8D1FFC5E
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403347; cv=none; b=huPpVO/OEmRDXKKPltBvwhWDOrGA9PUHfXQlkBUSHkxNVPAPVTNGsdFVnX3pKO9d9YiXKwHb3jOa+0yf0X57ZTkwAOQBmOAbrPwrjOcCuvqU2Wr7E0xlJRKIMi3d6N8KpXFvoamspQWg8u7iD92vZad/XkACOs642XiENWXLm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403347; c=relaxed/simple;
	bh=ulwEfnZKRw3jCLA7bTcYxZEfDubEd2w2YYuWSdrkjJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5cnVDlKj/0vZX4g0bINZzcqgloOH6ObfOCknuGbi3s8F7LsQne1YBaaAfZJfx4OCvmka7GD/hdpjYaezIPlo+nidjnxFZfPLA1sTctoQDWUXaWSjCXp6zCXAcFakP8pklnsynb3LqrZaN+SgB2CS4T7AuYpkNoh+IThe/ny0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZxi5p3O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZxi5p3O"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NA417c024477;
	Wed, 23 Apr 2025 10:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SsDzMd98wVtHV7ihp
	OmJw0TVQIx8rB72SFXI545IFjk=; b=iZxi5p3OBgxnwnJ9PCZ5ymHmdoiczGIqC
	lEDNXo2ICkkUvbBNZFoTQvEOx2k482TPF2izFMsiYojj8w/xsjgL8S960l4q8oHC
	Sdo9LbPex9o7QaImVUBtRDBOTz3pOyXCgLywUyH9/bK8FaAVEV4w3szENmdGjMyk
	u4JUNJGWDTI2j3pHhcHvAIsTmP12dxxqmfhnjyLJFJRK6kH7KN+LmgDeNyPvjnPJ
	y1+i/LB67EZwnYfwLNL7QIiH6Of3E74jjGUtBDXCPNW71KEW9VlKK/6VSgFY1f8I
	J6WCZjzvVLoYpN3kLY4iQScupN7ZDpcJ8RbPlWykIArK3VHhT8N1g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4jr1cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6V47p005844;
	Wed, 23 Apr 2025 10:15:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxahj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFcNk39387516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A38920049;
	Wed, 23 Apr 2025 10:15:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2F492004E;
	Wed, 23 Apr 2025 10:15:37 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:37 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 04/25] s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
Date: Wed, 23 Apr 2025 12:15:13 +0200
Message-ID: <20250423101535.143137-5-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=6808bdcf cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=hVqa_wrnkZ1V3SoaiB8A:9
X-Proofpoint-GUID: RH77SjaxnGwASr52UvAoANDhQCmy6tI8
X-Proofpoint-ORIG-GUID: RH77SjaxnGwASr52UvAoANDhQCmy6tI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX0rbtF0c7n+tK 5KU/dVsCWisMzD+iQYqhfAKD6ey3ZsfIjcYdhKetfanwGdHrfF2gFGdfzOptTTy8F0ZthqsTLn0 YDWZ0qR82YVBJy97PLKPyLk/0Q5pxvt/IgdU5e9rV2AOEO8atVcxE+eH2oLNUVaIv+iMIKYSutf
 cmxKWYhCVbqQgCHnO5kUmXDpw226BTKmonMpwuGAX1WxtAvD3Wzs85nFEYik/8mEGS9FJ0VK4dX s1VGEgEwbN0Teolu+dOWCsAuCay0KkQrY93ahDtJforw7TkSs5xzB1oFvL6N/bPQ8IPx9s3dsCZ zdaVyYrBwqtU1o/xEfvTZF3Zi0rRRg1EUlL2FQOJD9Ig5BzaKPWXTqPBLWRu2Cs1Wh6JMiZVUhT
 0I9hL/3JLq67N2zMtS7D4ypcU0uzchnoUPZev2EcFk4jifKOysWOVAATTxWKa7L+TebCwfDT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

If there is a target list of APQNs given when an CPRB is
to be send via zcrypt_send_ep11_cprb() there is always a
kmalloc() done and the targets are copied via z_copy_from_user.

As there are callers from kernel space (zcrypt_ep11misc.c)
which signal this via the userspace parameter improve this
code to directly use the given target list in case of
kernelspace thus removing the unnecessary memory alloc
and mem copy.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c | 42 +++++++++++++++-----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ad09c5306e28..f95e12bbd69c 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1035,7 +1035,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 {
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
-	struct ep11_target_dev *targets;
+	struct ep11_target_dev *targets = NULL;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
 	unsigned int func_code = 0, domain;
@@ -1052,29 +1052,25 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	target_num = (unsigned short)xcrb->targets_num;
 
 	/* empty list indicates autoselect (all available targets) */
-	targets = NULL;
+	rc = -ENOMEM;
 	if (target_num != 0) {
-		struct ep11_target_dev __user *uptr;
-
-		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
-		if (!targets) {
-			func_code = 0;
-			rc = -ENOMEM;
-			goto out;
-		}
-
-		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
-		if (z_copy_from_user(userspace, targets, uptr,
-				     target_num * sizeof(*targets))) {
-			func_code = 0;
-			rc = -EFAULT;
-			goto out_free;
+		if (userspace) {
+			targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
+			if (!targets)
+				goto out;
+			if (copy_from_user(targets, xcrb->targets,
+					   target_num * sizeof(*targets))) {
+				rc = -EFAULT;
+				goto out;
+			}
+		} else {
+			targets = (struct ep11_target_dev __force __kernel *)xcrb->targets;
 		}
 	}
 
 	rc = prep_ep11_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
 	if (rc)
-		goto out_free;
+		goto out;
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
@@ -1082,11 +1078,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
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
 
@@ -1154,7 +1150,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 			pr_debug("no match for address ff.ffff => ENODEV\n");
 		}
 		rc = -ENODEV;
-		goto out_free;
+		goto out;
 	}
 
 	qid = pref_zq->queue->qid;
@@ -1168,9 +1164,9 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	zcrypt_drop_queue(pref_zc, pref_zq, mod, wgt);
 	spin_unlock(&zcrypt_list_lock);
 
-out_free:
-	kfree(targets);
 out:
+	if (userspace)
+		kfree(targets);
 	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
-- 
2.43.0

