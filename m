Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB0356749
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730594; cv=none; b=U20fb4kfmiHtJ/EHbO381NdBJAaitjkfyoVQo5uzA5PlBQqv3QadvQQnz9EpJMqBZphvcuPame0eVKlVfA+AlbNL6i4P7BVswOMsRXQdrxODktTiNOa5NGRTZnU9KTSLCjY1YechYDyL3KQP/i9x/m0X55bH1bp9NohKOe5dJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730594; c=relaxed/simple;
	bh=c/IOeGKKgZoLuKF0dlvBcQ3bqZ5sdFAvu76p+i+L/0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np1DJjK6YbWz5Abn4pdILshUcKjwWC5IdYVFTTwj2nZOdTbemwQKiOCRshyq3Le622LllzE3o6hhWFeg1H8dnS159L81GW3D3eodfDshW5WMoTy8PRWU8vpWgtQ4MjN8a4RnBgBu7EWagEvtz4svkUt99K5sL1uUKMJ3SNDjjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jCOYqe3d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jCOYqe3d"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfjn84182054
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NEyTuBSx6msw/3QjT
	FN/EtUhPEF1jXE8vdIxzDRpxaE=; b=jCOYqe3deEfiEDC29FAxCqK769DMQW7WR
	hHK5xeNoW593RJP3RfJqw2Wk2eDxdamFPTqjomdqUDPKIezHQ3uP1uF6YafT4fsU
	HxXkqGKg4aMf87uRy0Tmy9ksUsvUZhvEbC9neGwzfap4ciRhHubS2LA0NLC21/Qb
	6X7sG68txflvJtCAtQOKkoDJIWecZQzmGDjN94GgD1jMeaWwSX9u9HZWjXS8bnvE
	OeZ+aT6mad/1GgpgAF2sYd/puZ4LzbBHm6KGUjXLdidcWCQNpAFXiOird2BtzqaF
	JVCIhpcXuGgCJj33Wlvq2nZXlyu8+Hhrei/SmYV5vAAwc/3rR5WXQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78ga5k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MEJgSv023105
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq7vx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66METkt546596510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 14:29:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA0A20040;
	Wed, 22 Jul 2026 14:29:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D7A2004F;
	Wed, 22 Jul 2026 14:29:46 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.200.113])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 14:29:46 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v5 1/1] s390/pkey: Rework ioctl functions error paths
Date: Wed, 22 Jul 2026 16:29:47 +0200
Message-ID: <20260722142947.109588-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722142947.109588-1-freude@linux.ibm.com>
References: <20260722142947.109588-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzOSBTYWx0ZWRfXw3EwqVjUMT48
 xNMF9hzLfQoOvSmHyibkROSogMqFDuwahWFWRSf+68KpZ1Q0iTiBA68Ehd74R5kYZ87ZPTn0dM4
 rXeyxdr97TZjoaHaiufZGLaQpCjbrz168cYWY6wcZOfxCn2fUL9zh8d6a1firhqKp5xymOlW9Wr
 N2qfDETYDRKMf54y1mFQSTYfg4EhASQuBIRE7isNIMDDEBVNc8OIwwwkTcSIpuyuB8H2C20gRP1
 DLghHsmc2bsfLbu2027NdoDprjn/o+O1upqYXu+H3Uk9OcnvwPeycHCjEqoDrQ6sjuN7nj+fXUK
 7A4xwUEGBhE5zrJYgy9L+nDI+E+uks5QT7PM2Oh0lnSv2n5aVNQBE+zR6LBGFnYAcsBTrsILhuJ
 F6hCGBns8BaVGQyhf/LCiN+JVfRgT5vAEy3n8zBd29ycofjIrYbKwV8eHfBsm5Gnwse5CC7syfa
 y4qfejFPkMluxPW6b8A==
X-Proofpoint-GUID: ysz2VHpj4BDwvA8HVOWG8f3oXwaI1b3I
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60d3df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EjqAg5dvKiW42E2nAsQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzOSBTYWx0ZWRfXyefnDJK9t/xP
 Iz0LeWH0BhN3kssKwG8eoihXZuZDsGOZhFMkmWnTZz2akY2GNrAJQay4KdZiqxbUe/ECuZL8QYU
 tB8d34axeIXkP5BAC4E13gknh9V80s0=
X-Proofpoint-ORIG-GUID: ysz2VHpj4BDwvA8HVOWG8f3oXwaI1b3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220139

With the pkey rework there was the suggestion to rework the error and
free paths of the pkey ioctl functions. The complain was especially to
rewrite the failure handling with goto instead of all repeat the
nearly same code (kfree(), kfree_sensitive(), memzero_explicit()) for
each path. This patch removes all this duplicated code and introduces
one code block at the end of the functions which is jumped into via
goto out or executed on regular exit. As some helper functions return
an error pointer value (which is NOT NULL) make sure on the error path
there is not by accident kfree() or similar called on such ptr values.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 drivers/s390/crypto/pkey_api.c | 288 ++++++++++++++++++---------------
 1 file changed, 157 insertions(+), 131 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 5d8f63f390a8..0530b1ce228e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -169,8 +169,8 @@ static int pkey_ioctl_clr2protk(struct pkey_clr2protk __user *ucp)
 {
 	struct pkey_clr2protk kcp;
 	struct clearkeytoken *t;
+	u8 *tmpbuf = NULL;
 	u32 keylen;
-	u8 *tmpbuf;
 	int rc;
 
 	if (copy_from_user(&kcp, ucp, sizeof(kcp)))
@@ -181,13 +181,13 @@ static int pkey_ioctl_clr2protk(struct pkey_clr2protk __user *ucp)
 	if (!keylen) {
 		PKEY_DBF_ERR("%s unknown/unsupported keytype %u\n",
 			     __func__, kcp.keytype);
-		memzero_explicit(&kcp, sizeof(kcp));
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 	tmpbuf = kzalloc(sizeof(*t) + keylen, GFP_KERNEL);
 	if (!tmpbuf) {
-		memzero_explicit(&kcp, sizeof(kcp));
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 	t = (struct clearkeytoken *)tmpbuf;
 	t->type = TOKTYPE_NON_CCA;
@@ -202,20 +202,22 @@ static int pkey_ioctl_clr2protk(struct pkey_clr2protk __user *ucp)
 			 kcp.protkey.protkey,
 			 &kcp.protkey.len, &kcp.protkey.type, 0);
 	pr_debug("key2protkey()=%d\n", rc);
+	if (rc)
+		goto out;
 
-	kfree_sensitive(tmpbuf);
-
-	if (!rc && copy_to_user(ucp, &kcp, sizeof(kcp)))
+	if (copy_to_user(ucp, &kcp, sizeof(kcp)))
 		rc = -EFAULT;
-	memzero_explicit(&kcp, sizeof(kcp));
 
+out:
+	memzero_explicit(&kcp, sizeof(kcp));
+	kfree_sensitive(tmpbuf);
 	return rc;
 }
 
 static int pkey_ioctl_findcard(struct pkey_findcard __user *ufc)
 {
+	struct pkey_apqn *apqns = NULL;
 	struct pkey_findcard kfc;
-	struct pkey_apqn *apqns;
 	size_t nr_apqns;
 	int rc;
 
@@ -224,8 +226,10 @@ static int pkey_ioctl_findcard(struct pkey_findcard __user *ufc)
 
 	nr_apqns = MAXAPQNSINLIST;
 	apqns = kmalloc_objs(struct pkey_apqn, nr_apqns);
-	if (!apqns)
-		return -ENOMEM;
+	if (!apqns) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	rc = pkey_handler_apqns_for_key(kfc.seckey.seckey,
 					sizeof(kfc.seckey.seckey),
@@ -237,17 +241,18 @@ static int pkey_ioctl_findcard(struct pkey_findcard __user *ufc)
 						PKEY_FLAGS_MATCH_ALT_MKVP,
 						apqns, &nr_apqns, 0);
 	pr_debug("apqns_for_key()=%d\n", rc);
-	if (rc) {
-		kfree(apqns);
-		return rc;
-	}
+	if (rc)
+		goto out;
+
 	kfc.cardnr = apqns[0].card;
 	kfc.domain = apqns[0].domain;
-	kfree(apqns);
+
 	if (copy_to_user(ufc, &kfc, sizeof(kfc)))
-		return -EFAULT;
+		rc = -EFAULT;
 
-	return 0;
+out:
+	kfree(apqns);
+	return rc;
 }
 
 static int pkey_ioctl_skey2pkey(struct pkey_skey2pkey __user *usp)
@@ -327,7 +332,7 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 {
 	struct pkey_verifyprotk kvp;
 	struct protaeskeytoken *t;
-	u8 *tmpbuf;
+	u8 *tmpbuf = NULL;
 	int rc;
 
 	if (copy_from_user(&kvp, uvp, sizeof(kvp)))
@@ -336,15 +341,15 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 	if (kvp.protkey.len > sizeof(kvp.protkey.protkey)) {
 		PKEY_DBF_ERR("%s protkey length %u exceeds protkey buffer size\n",
 			     __func__, kvp.protkey.len);
-		memzero_explicit(&kvp, sizeof(kvp));
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	/* build a 'protected key token' from the raw protected key */
 	tmpbuf = kzalloc(sizeof(*t), GFP_KERNEL);
 	if (!tmpbuf) {
-		memzero_explicit(&kvp, sizeof(kvp));
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 	t = (struct protaeskeytoken *)tmpbuf;
 	t->type = TOKTYPE_NON_CCA;
@@ -357,42 +362,48 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 				     NULL, NULL, NULL, NULL, NULL, 0);
 	pr_debug("verify_key()=%d\n", rc);
 
-	kfree_sensitive(tmpbuf);
+out:
 	memzero_explicit(&kvp, sizeof(kvp));
-
+	kfree_sensitive(tmpbuf);
 	return rc;
 }
 
 static int pkey_ioctl_kblob2protk(struct pkey_kblob2pkey __user *utp)
 {
 	struct pkey_kblob2pkey ktp;
-	u8 *kkey;
+	u8 *kkey = NULL;
 	int rc;
 
 	if (copy_from_user(&ktp, utp, sizeof(ktp)))
 		return -EFAULT;
 	kkey = _copy_key_from_user(ktp.key, ktp.keylen);
-	if (IS_ERR(kkey))
-		return PTR_ERR(kkey);
+	if (IS_ERR(kkey)) {
+		rc = PTR_ERR(kkey);
+		kkey = NULL;
+		goto out;
+	}
 	ktp.protkey.len = sizeof(ktp.protkey.protkey);
 	rc = key2protkey(NULL, 0, kkey, ktp.keylen,
 			 ktp.protkey.protkey, &ktp.protkey.len,
 			 &ktp.protkey.type, 0);
 	pr_debug("key2protkey()=%d\n", rc);
-	kfree_sensitive(kkey);
-	if (!rc && copy_to_user(utp, &ktp, sizeof(ktp)))
+	if (rc)
+		goto out;
+	if (copy_to_user(utp, &ktp, sizeof(ktp)))
 		rc = -EFAULT;
-	memzero_explicit(&ktp, sizeof(ktp));
 
+out:
+	memzero_explicit(&ktp, sizeof(ktp));
+	kfree_sensitive(kkey);
 	return rc;
 }
 
 static int pkey_ioctl_genseck2(struct pkey_genseck2 __user *ugs)
 {
+	struct pkey_apqn *apqns = NULL;
 	u32 klen = KEYBLOBBUFSIZE;
 	struct pkey_genseck2 kgs;
-	struct pkey_apqn *apqns;
-	u8 *kkey;
+	u8 *kkey = NULL;
 	int rc;
 	u32 u;
 
@@ -405,46 +416,48 @@ static int pkey_ioctl_genseck2(struct pkey_genseck2 __user *ugs)
 		return -EINVAL;
 	}
 	apqns = _copy_apqns_from_user(kgs.apqns, kgs.apqn_entries);
-	if (IS_ERR(apqns))
-		return PTR_ERR(apqns);
+	if (IS_ERR(apqns)) {
+		rc = PTR_ERR(apqns);
+		apqns = NULL;
+		goto out;
+	}
 	kkey = kzalloc(klen, GFP_KERNEL);
 	if (!kkey) {
-		kfree(apqns);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 	rc = pkey_handler_gen_key(apqns, kgs.apqn_entries,
 				  u, kgs.type, kgs.size, kgs.keygenflags,
 				  kkey, &klen, NULL, 0);
 	pr_debug("gen_key()=%d\n", rc);
-	kfree(apqns);
-	if (rc) {
-		kfree_sensitive(kkey);
-		return rc;
-	}
+	if (rc)
+		goto out;
 	if (kgs.key) {
 		if (kgs.keylen < klen) {
-			kfree_sensitive(kkey);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		if (copy_to_user(kgs.key, kkey, klen)) {
-			kfree_sensitive(kkey);
-			return -EFAULT;
+			rc = -EFAULT;
+			goto out;
 		}
 	}
 	kgs.keylen = klen;
 	if (copy_to_user(ugs, &kgs, sizeof(kgs)))
 		rc = -EFAULT;
-	kfree_sensitive(kkey);
 
+out:
+	kfree_sensitive(kkey);
+	kfree(apqns);
 	return rc;
 }
 
 static int pkey_ioctl_clr2seck2(struct pkey_clr2seck2 __user *ucs)
 {
+	struct pkey_apqn *apqns = NULL;
 	u32 klen = KEYBLOBBUFSIZE;
 	struct pkey_clr2seck2 kcs;
-	struct pkey_apqn *apqns;
-	u8 *kkey;
+	u8 *kkey = NULL;
 	int rc;
 	u32 u;
 
@@ -454,49 +467,45 @@ static int pkey_ioctl_clr2seck2(struct pkey_clr2seck2 __user *ucs)
 	if (!u) {
 		PKEY_DBF_ERR("%s unknown/unsupported keybitsize %d\n",
 			     __func__, kcs.size);
-		memzero_explicit(&kcs, sizeof(kcs));
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 	apqns = _copy_apqns_from_user(kcs.apqns, kcs.apqn_entries);
 	if (IS_ERR(apqns)) {
-		memzero_explicit(&kcs, sizeof(kcs));
-		return PTR_ERR(apqns);
+		rc = PTR_ERR(apqns);
+		apqns = NULL;
+		goto out;
 	}
 	kkey = kzalloc(klen, GFP_KERNEL);
 	if (!kkey) {
-		kfree(apqns);
-		memzero_explicit(&kcs, sizeof(kcs));
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 	rc = pkey_handler_clr_to_key(apqns, kcs.apqn_entries,
 				     u, kcs.type, kcs.size, kcs.keygenflags,
 				     kcs.clrkey.clrkey, kcs.size / 8,
 				     kkey, &klen, NULL, 0);
 	pr_debug("clr_to_key()=%d\n", rc);
-	kfree(apqns);
-	if (rc) {
-		kfree_sensitive(kkey);
-		memzero_explicit(&kcs, sizeof(kcs));
-		return rc;
-	}
+	if (rc)
+		goto out;
 	if (kcs.key) {
 		if (kcs.keylen < klen) {
-			kfree_sensitive(kkey);
-			memzero_explicit(&kcs, sizeof(kcs));
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		if (copy_to_user(kcs.key, kkey, klen)) {
-			kfree_sensitive(kkey);
-			memzero_explicit(&kcs, sizeof(kcs));
-			return -EFAULT;
+			rc = -EFAULT;
+			goto out;
 		}
 	}
 	kcs.keylen = klen;
 	if (copy_to_user(ucs, &kcs, sizeof(kcs)))
 		rc = -EFAULT;
+
+out:
 	memzero_explicit(&kcs, sizeof(kcs));
 	kfree_sensitive(kkey);
-
+	kfree(apqns);
 	return rc;
 }
 
@@ -509,18 +518,23 @@ static int pkey_ioctl_verifykey2(struct pkey_verifykey2 __user *uvk)
 	if (copy_from_user(&kvk, uvk, sizeof(kvk)))
 		return -EFAULT;
 	kkey = _copy_key_from_user(kvk.key, kvk.keylen);
-	if (IS_ERR(kkey))
-		return PTR_ERR(kkey);
+	if (IS_ERR(kkey)) {
+		rc = PTR_ERR(kkey);
+		kkey = NULL;
+		goto out;
+	}
 
 	rc = pkey_handler_verify_key(kkey, kvk.keylen,
 				     &kvk.cardnr, &kvk.domain,
 				     &kvk.type, &kvk.size, &kvk.flags, 0);
 	pr_debug("verify_key()=%d\n", rc);
+	if (rc)
+		goto out;
+	if (copy_to_user(uvk, &kvk, sizeof(kvk)))
+		rc = -EFAULT;
 
+out:
 	kfree_sensitive(kkey);
-	if (!rc && copy_to_user(uvk, &kvk, sizeof(kvk)))
-		return -EFAULT;
-
 	return rc;
 }
 
@@ -528,30 +542,37 @@ static int pkey_ioctl_kblob2protk2(struct pkey_kblob2pkey2 __user *utp)
 {
 	struct pkey_apqn *apqns = NULL;
 	struct pkey_kblob2pkey2 ktp;
-	u8 *kkey;
+	u8 *kkey = NULL;
 	int rc;
 
 	if (copy_from_user(&ktp, utp, sizeof(ktp)))
 		return -EFAULT;
 	apqns = _copy_apqns_from_user(ktp.apqns, ktp.apqn_entries);
-	if (IS_ERR(apqns))
-		return PTR_ERR(apqns);
+	if (IS_ERR(apqns)) {
+		rc = PTR_ERR(apqns);
+		apqns = NULL;
+		goto out;
+	}
 	kkey = _copy_key_from_user(ktp.key, ktp.keylen);
 	if (IS_ERR(kkey)) {
-		kfree(apqns);
-		return PTR_ERR(kkey);
+		rc = PTR_ERR(kkey);
+		kkey = NULL;
+		goto out;
 	}
 	ktp.protkey.len = sizeof(ktp.protkey.protkey);
 	rc = key2protkey(apqns, ktp.apqn_entries, kkey, ktp.keylen,
 			 ktp.protkey.protkey, &ktp.protkey.len,
 			 &ktp.protkey.type, 0);
 	pr_debug("key2protkey()=%d\n", rc);
-	kfree(apqns);
-	kfree_sensitive(kkey);
-	if (!rc && copy_to_user(utp, &ktp, sizeof(ktp)))
+	if (rc)
+		goto out;
+	if (copy_to_user(utp, &ktp, sizeof(ktp)))
 		rc = -EFAULT;
-	memzero_explicit(&ktp, sizeof(ktp));
 
+out:
+	memzero_explicit(&ktp, sizeof(ktp));
+	kfree_sensitive(kkey);
+	kfree(apqns);
 	return rc;
 }
 
@@ -560,7 +581,7 @@ static int pkey_ioctl_apqns4k(struct pkey_apqns4key __user *uak)
 	struct pkey_apqn *apqns = NULL;
 	struct pkey_apqns4key kak;
 	size_t nr_apqns, len;
-	u8 *kkey;
+	u8 *kkey = NULL;
 	int rc;
 
 	if (copy_from_user(&kak, uak, sizeof(kak)))
@@ -568,40 +589,42 @@ static int pkey_ioctl_apqns4k(struct pkey_apqns4key __user *uak)
 	nr_apqns = kak.apqn_entries;
 	if (nr_apqns) {
 		apqns = kmalloc_objs(struct pkey_apqn, nr_apqns);
-		if (!apqns)
-			return -ENOMEM;
+		if (!apqns) {
+			rc = -ENOMEM;
+			goto out;
+		}
 	}
 	kkey = _copy_key_from_user(kak.key, kak.keylen);
 	if (IS_ERR(kkey)) {
-		kfree(apqns);
-		return PTR_ERR(kkey);
+		rc = PTR_ERR(kkey);
+		kkey = NULL;
+		goto out;
 	}
 	rc = pkey_handler_apqns_for_key(kkey, kak.keylen, kak.flags,
 					apqns, &nr_apqns, 0);
 	pr_debug("apqns_for_key()=%d\n", rc);
-	kfree_sensitive(kkey);
-	if (rc && rc != -ENOSPC) {
-		kfree(apqns);
-		return rc;
-	}
+	if (rc && rc != -ENOSPC)
+		goto out;
 	if (!rc && kak.apqns) {
 		if (nr_apqns > kak.apqn_entries) {
-			kfree(apqns);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		len = nr_apqns * sizeof(struct pkey_apqn);
 		if (len) {
 			if (copy_to_user(kak.apqns, apqns, len)) {
-				kfree(apqns);
-				return -EFAULT;
+				rc = -EFAULT;
+				goto out;
 			}
 		}
 	}
 	kak.apqn_entries = nr_apqns;
 	if (copy_to_user(uak, &kak, sizeof(kak)))
 		rc = -EFAULT;
-	kfree(apqns);
 
+out:
+	kfree_sensitive(kkey);
+	kfree(apqns);
 	return rc;
 }
 
@@ -617,87 +640,90 @@ static int pkey_ioctl_apqns4kt(struct pkey_apqns4keytype __user *uat)
 	nr_apqns = kat.apqn_entries;
 	if (nr_apqns) {
 		apqns = kmalloc_objs(struct pkey_apqn, nr_apqns);
-		if (!apqns)
-			return -ENOMEM;
+		if (!apqns) {
+			rc = -ENOMEM;
+			goto out;
+		}
 	}
 	rc = pkey_handler_apqns_for_keytype(kat.type,
 					    kat.cur_mkvp, kat.alt_mkvp,
 					    kat.flags, apqns, &nr_apqns, 0);
 	pr_debug("apqns_for_keytype()=%d\n", rc);
-	if (rc && rc != -ENOSPC) {
-		kfree(apqns);
-		return rc;
-	}
+	if (rc && rc != -ENOSPC)
+		goto out;
 	if (!rc && kat.apqns) {
 		if (nr_apqns > kat.apqn_entries) {
-			kfree(apqns);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		len = nr_apqns * sizeof(struct pkey_apqn);
 		if (len) {
 			if (copy_to_user(kat.apqns, apqns, len)) {
-				kfree(apqns);
-				return -EFAULT;
+				rc = -EFAULT;
+				goto out;
 			}
 		}
 	}
 	kat.apqn_entries = nr_apqns;
 	if (copy_to_user(uat, &kat, sizeof(kat)))
 		rc = -EFAULT;
-	kfree(apqns);
 
+out:
+	kfree(apqns);
 	return rc;
 }
 
 static int pkey_ioctl_kblob2protk3(struct pkey_kblob2pkey3 __user *utp)
 {
 	u32 protkeylen = PROTKEYBLOBBUFSIZE;
+	u8 *kkey = NULL, *protkey = NULL;
 	struct pkey_apqn *apqns = NULL;
 	struct pkey_kblob2pkey3 ktp;
-	u8 *kkey, *protkey;
 	int rc;
 
 	if (copy_from_user(&ktp, utp, sizeof(ktp)))
 		return -EFAULT;
 	apqns = _copy_apqns_from_user(ktp.apqns, ktp.apqn_entries);
-	if (IS_ERR(apqns))
-		return PTR_ERR(apqns);
+	if (IS_ERR(apqns)) {
+		rc = PTR_ERR(apqns);
+		apqns = NULL;
+		goto out;
+	}
 	kkey = _copy_key_from_user(ktp.key, ktp.keylen);
 	if (IS_ERR(kkey)) {
-		kfree(apqns);
-		return PTR_ERR(kkey);
+		rc = PTR_ERR(kkey);
+		kkey = NULL;
+		goto out;
 	}
 	protkey = kmalloc(protkeylen, GFP_KERNEL);
 	if (!protkey) {
-		kfree(apqns);
-		kfree_sensitive(kkey);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 	rc = key2protkey(apqns, ktp.apqn_entries, kkey, ktp.keylen,
 			 protkey, &protkeylen, &ktp.pkeytype, 0);
 	pr_debug("key2protkey()=%d\n", rc);
-	kfree(apqns);
-	kfree_sensitive(kkey);
-	if (rc) {
-		kfree_sensitive(protkey);
-		return rc;
-	}
+	if (rc)
+		goto out;
 	if (ktp.pkey && ktp.pkeylen) {
 		if (protkeylen > ktp.pkeylen) {
-			kfree_sensitive(protkey);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		if (copy_to_user(ktp.pkey, protkey, protkeylen)) {
-			kfree_sensitive(protkey);
-			return -EFAULT;
+			rc = -EFAULT;
+			goto out;
 		}
 	}
-	kfree_sensitive(protkey);
 	ktp.pkeylen = protkeylen;
 	if (copy_to_user(utp, &ktp, sizeof(ktp)))
-		return -EFAULT;
+		rc = -EFAULT;
 
-	return 0;
+out:
+	kfree_sensitive(protkey);
+	kfree_sensitive(kkey);
+	kfree(apqns);
+	return rc;
 }
 
 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
-- 
2.43.0

