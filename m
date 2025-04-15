Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97A1F4614
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727091; cv=none; b=i8W2CTorUiJUnh9YtjvIFVimbvoOLtpraAtd72jxgh2n5tdVC0ETt1IpK3ON2splDOlMNGMLQyECWsoS8ReebVz3T4nJV5RNuGjx0VM9M89Ndm6nFBiaokckpiKFKKSwoqj9RBDZLfCSJKH5PTQCPvgssXGKuzsQUool0ZrEVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727091; c=relaxed/simple;
	bh=3HMkOCnev757rEJS0a+eoiPbFZw7JVntSFhi1Et1Km0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnSgmWLpZbYqpGnpm+nWtwyWPQkaO7/yNJsth5bD7lbFIkzGFE4lKlhczQc16pDHZVhUBdSxuUqVDKLwPpxDFlSMfTF7hTby/uqhJyYnfRL52ZgLD2GTsnN1dv2CNe2mgSqhX4adc65abdB2dG2TdFrZu293fEI/BURBWvi4sRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LOJv1C2p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LOJv1C2p"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6sP0c002826;
	Tue, 15 Apr 2025 14:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Je3BX5UzUpZJ6IcvT
	mGVNCqTUlFKlHJ658EFlYyIfBc=; b=LOJv1C2pQz5VgK31OVlpW6/3bu8eRW7wR
	l77fLTHQ1bhPneLCYiywT9O8tDtNl7U6WJjew7HNnwMA5DOJP/sV91sGhYbYclmz
	OxEbKp6qJKRScZt8CHNzNlQB+mspMpxWnmx1QpX1svvArRAoGOZTQPcxX49XACkb
	o+74u4GPvwUdhYtPBbLq+uNprLVZUtz76QVHgD4vmctU5ChC846iwWPhfppHVRwX
	hS4oWZY+WyPcR7fpMjgTMP5X7iwObh89Xk98Ob8lsA0jSonk7s+bnz/CLf6vsLXh
	EL+KAIQoxQmQmvINteNexm+W+qxzw/Rl85HX+DOlIPetvYnEUFblw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4619xfv9bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FDiuag031061;
	Tue, 15 Apr 2025 14:24:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnkje5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOfxm28574104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30EB220040;
	Tue, 15 Apr 2025 14:24:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D771A2004E;
	Tue, 15 Apr 2025 14:24:40 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:40 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 04/25] s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
Date: Tue, 15 Apr 2025 16:24:17 +0200
Message-ID: <20250415142438.118474-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415142438.118474-1-freude@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NQE3fYDBsMO3DKt-VEvLKLyX1vGkskDP
X-Proofpoint-GUID: NQE3fYDBsMO3DKt-VEvLKLyX1vGkskDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

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

