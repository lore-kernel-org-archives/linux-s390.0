Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408A219A79
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811902; cv=none; b=O/NpCB7SPpqk1JBghrmwsAOP7hpuxBb0wgqIQu1X+ozcw9ofMtMpJ42PCY0HiMFyg/SI+1I8HfkVtxMV8v9EA5YdqhWmZR1+XcM2daYkWjcrlTa2BbuT6JJLE/ZzNFYciapHSo3HwQ30P5qRCs50bNwNmKSg+0RFCbKFvaxIg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811902; c=relaxed/simple;
	bh=bUjmygEbaKVCAdim7d7RDKelyqhAlf4DfbQvbK8Sp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCc3HMP9ejXBTY9ratfsLeDYCY3MvQYruslr2beX4m/2+shr4+9EEE6WdDNIewW/mlzrYodAGO1HcS40tHu90HEMx5KIMMtFjfEqs5UmYUYGE2/ph2kkINbmXWId5iuDvFgj99fOx/LDmz6Y8PSbg0rLZe9AvloASD/J+r60ip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LTk6/FnR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LTk6/FnR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GBPvjx018980;
	Wed, 16 Apr 2025 13:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sxPYmdP8dEfnJ6gwk
	+Hs3YHDgbG5KiDXMF2Rh8hmguo=; b=LTk6/FnRIdcHDfBOzrLzR/2awavwqGH2w
	kbBnckufkuSmvIV8nM8xejB3oBzUH9PZqiT2S/J4kt7kbRq6CvToA4qEaK9597U8
	8UWHA21UgLq0wmIxcvf3Jo9kHHPLqSOXz+OAmS094nujVIuIuRCTJPeV3qRtuuDv
	Q73htE4WPF1L0INg+bvU07z3y1CA9H9m4qb2CHpxLjAcr6NRCA/7/llaP5Y8vzkv
	vq9WYfsd5Zh8CMeasZ2yQKbl/Kxl0HJ2bduD4fWWrgTS/KRyqbAz3sMUFZkVi8PL
	Tp1CcSJhSCZP2fdfwgqNiglx0g/NNJcqiBKSXN0RA6HduEyCzof9A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461yj542n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GDK9xh024892;
	Wed, 16 Apr 2025 13:58:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtgwtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwE0147251906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B8A20040;
	Wed, 16 Apr 2025 13:58:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86EF920043;
	Wed, 16 Apr 2025 13:58:13 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:13 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 19/25] s390/pkey: Rework CCA pkey handler to use stack for small memory allocs
Date: Wed, 16 Apr 2025 15:57:54 +0200
Message-ID: <20250416135801.133909-20-freude@linux.ibm.com>
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
X-Proofpoint-GUID: _AGLfZzvVbBe7AOVDUwsCtTab3FRuRFM
X-Proofpoint-ORIG-GUID: _AGLfZzvVbBe7AOVDUwsCtTab3FRuRFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160111

There have been some places in the CCA handler code where relatively
small amounts of memory have been allocated an freed at the end
of the function. This code has been reworked to use the stack instead.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_cca.c | 43 ++++++++--------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index 5b1f4c571c88..6986611fcde5 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -213,7 +213,7 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 			   u8 *protkey, u32 *protkeylen, u32 *protkeytype)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -251,14 +251,10 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = cca_apqns4key(key, keylen, 0, local_apqns, &nr_apqns);
+		rc = cca_apqns4key(key, keylen, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -283,7 +279,6 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -302,7 +297,7 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       u32 keybitsize, u32 flags,
 		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 
 	/* check keytype, subtype, keybitsize */
@@ -338,15 +333,10 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = cca_apqns4type(subtype, NULL, NULL, 0,
-				    local_apqns, &nr_apqns);
+		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -363,7 +353,6 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -383,7 +372,7 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       const u8 *clrkey, u32 clrkeylen,
 		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 
 	/* check keytype, subtype, clrkeylen, keybitsize */
@@ -424,15 +413,10 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = cca_apqns4type(subtype, NULL, NULL, 0,
-				    local_apqns, &nr_apqns);
+		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -449,7 +433,6 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -552,8 +535,8 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 {
 	const struct keytoken_header *hdr = (const struct keytoken_header *)key;
 	const struct clearkeytoken *t = (const struct clearkeytoken *)key;
+	u8 tmpbuf[SECKEYBLOBSIZE]; /* 64 bytes */
 	u32 tmplen, keysize = 0;
-	u8 *tmpbuf;
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -565,11 +548,6 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 	if (!keysize || t->len != keysize)
 		return -EINVAL;
 
-	/* alloc tmp key buffer */
-	tmpbuf = kmalloc(SECKEYBLOBSIZE, GFP_ATOMIC);
-	if (!tmpbuf)
-		return -ENOMEM;
-
 	/* try two times in case of failure */
 	for (i = 0, rc = -ENODEV; i < 2 && rc; i++) {
 		tmplen = SECKEYBLOBSIZE;
@@ -584,7 +562,6 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 		pr_debug("cca_key2protkey()=%d\n", rc);
 	}
 
-	kfree(tmpbuf);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
-- 
2.43.0

