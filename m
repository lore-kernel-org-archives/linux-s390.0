Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A831ACECF
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811896; cv=none; b=qoX2rim1C61m6ProIjxmMf7cYL1avJAcKrZ3iZNQpy9xhIn0b2j3rpPb644S8yznHDa+rBhsnP+WdB3jR8v5jU10w5ZcjveDeWq8xsqY3Cymza9E4mHwXlPwlXwHEs6DtF8cT0VEHbu988ZIj5XbtzXOt04A4r7c4aYxwbjxWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811896; c=relaxed/simple;
	bh=3HMkOCnev757rEJS0a+eoiPbFZw7JVntSFhi1Et1Km0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD2HB/BiHbnV5QtxBa1PvTTkFxnaqa6zG7moeJETIxzmhPRgxaj6MkRufHt7uGgob4lGZgp0KHKypnsx1HiVifN7FIQwyw7HKUPxyZKXYKVRYIQJwlkyIMGJwnqH82OYl6+8/6OcIavdXotWxYTGbK/JApdWwr5ygZ8K+NdvimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eEJu9l1P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eEJu9l1P"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GBhvTe031321;
	Wed, 16 Apr 2025 13:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Je3BX5UzUpZJ6IcvT
	mGVNCqTUlFKlHJ658EFlYyIfBc=; b=eEJu9l1PrAl/8gvDxjBE2Z5FaibV4rDca
	UHwx5udvnvD4iiLIE9jwOeRlDUYxE/2vR7JFlj9I2L17Tzy5jjAysbw+YDSTR0PC
	cws4QrGxIrl+R2pdPnshfllgrgRiQjLPD3wlazmdRm2um+m23iLd9gzZ6ppMNIoj
	H8xRP6QY11XPzhddQEPNhseRJtPnamGfNrI9Ri6ZAqe4cBpV502fspyMWxQLTQ9v
	HZORNRNOzaTNdnh2u8Mm/eH3TAuriM258rlCqhbefw5NSB2Y2WaT+Ukx0RSrkvDC
	53jyCjocxOkuMluHV7HmdZJ56A6eNLRgjb6nGljZHrhha9HCSQJQw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dxbg4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GCTERm016697;
	Wed, 16 Apr 2025 13:58:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572882p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDw4l022544786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F04C20043;
	Wed, 16 Apr 2025 13:58:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A60920040;
	Wed, 16 Apr 2025 13:58:04 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:04 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 04/25] s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
Date: Wed, 16 Apr 2025 15:57:39 +0200
Message-ID: <20250416135801.133909-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135801.133909-1-freude@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l3fwUL6lKRE4DchdgV72Jz890Kdei_sb
X-Proofpoint-GUID: l3fwUL6lKRE4DchdgV72Jz890Kdei_sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160111

If there is a target list of APQNs given when an CPRB is
to be send via zcrypt_send_ep11_cprb() there is always a
kmalloc() done and the targets are copied via z_copy_from_user.

As there are callers from kernel space (zcrypt_ep11misc.c)
which signal this via the userspace parameter improve this
code to directly use the given target list in case of
kernelspace thus removing the unnecessary memory alloc
and mem copy.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c | 41 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ad09c5306e28..f96f596e578f 100644
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
@@ -1052,29 +1052,28 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
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
+			uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
+			if (copy_from_user(targets, uptr,
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
 
@@ -1082,11 +1081,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
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
 
@@ -1154,7 +1153,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 			pr_debug("no match for address ff.ffff => ENODEV\n");
 		}
 		rc = -ENODEV;
-		goto out_free;
+		goto out;
 	}
 
 	qid = pref_zq->queue->qid;
@@ -1168,9 +1167,9 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
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

