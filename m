Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB501F153C
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727096; cv=none; b=i0xKbZrBEuljqHUMrTJDoQxBlW3LRVXr5u7j8Uq88kZXnQ75U0PAmhw8rGnupX95+86qi4VM64M9nIMB7JGSMvq24iMyiUNtXuNRIgoGhGts55heJKMO3TATM95gf5mbP8Rq5zM4XEZFHQTxpieEwFn4hknAtAfZOSAB3XCKDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727096; c=relaxed/simple;
	bh=M/CihbpymVeG2xsJrPAZyxvn0Dcebo9mOWwj6XQB8Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzY/5gZio4maS+BFg6mh7O4DAL5QISg3KMTl3zIZBnebEgz4Yp/RT7CMlJnviBO2HGYl8WLxUqjeNBqf0DWvS15utesFPEnbT6IgvnXivspR+GhygCbc7eXcfg705k9XibWVIuilVrPWMPJrmB7Y/ZHRMwxkDOgJrL0yEq5b5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mcLccAia; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mcLccAia"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAKAj1004736;
	Tue, 15 Apr 2025 14:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T7WkMhQ8AOZGOLGMV
	9HZDODJTy3iO623qXi/z7LzlLk=; b=mcLccAiaTDEDBmcV70zUMyC1bLP3CtK40
	16s1OfCSAMBt5aCbtIDZO41eAEPQiKOSkD6hE8VoOEteWHtqmQv2qUi/TbXxj8eF
	bG9fBCKEYO+Z/A+YRw4Kka7wKIbGLPpMdu5HHgOJJuvlZ0PQ/bVOwjF1Y9ajOGC3
	X1cR90Rz/iKX2yNf0WopBt+Qrm6xe5UBcuhpm+lpW8b3y5rts/uFydnXylKSZwG/
	hl5svhrF4HTv9jhrlkS15tz/jnYx0c6Q4ETRO5A+XrqBQ2duWzZRMQu3Ooen1qkr
	8i3nb/Hvi/K9lwarE6eX7yonNmgtxQIlmMW5cIGJO/YkFlV7cMXrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4619xfv9d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAGALV017204;
	Tue, 15 Apr 2025 14:24:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kucf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOlrR39321922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEA2C2004D;
	Tue, 15 Apr 2025 14:24:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8159A2004E;
	Tue, 15 Apr 2025 14:24:47 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:47 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 20/25] s390/pkey: Rework EP11 pkey handler to use stack for small memory allocs
Date: Tue, 15 Apr 2025 16:24:33 +0200
Message-ID: <20250415142438.118474-21-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _8MMkT3Uund6t6kmMJbS5GxZy1rLokUX
X-Proofpoint-GUID: _8MMkT3Uund6t6kmMJbS5GxZy1rLokUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

There have been some places in the EP11 handler code where relatively
small amounts of memory have been allocated an freed at the end
of the function. This code has been reworked to use the stack instead.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c | 43 ++++++++-------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index 38aa0c7807c2..429c08facbfe 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -186,7 +186,7 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 			    u8 *protkey, u32 *protkeylen, u32 *protkeytype)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -223,14 +223,10 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = ep11_apqns4key(key, keylen, 0, local_apqns, &nr_apqns);
+		rc = ep11_apqns4key(key, keylen, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -259,7 +255,6 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -278,7 +273,7 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			u32 keybitsize, u32 flags,
 			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 	const u32 xflags = 0;
 
@@ -315,15 +310,10 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = ep11_apqns4type(subtype, NULL, NULL, 0,
-				     local_apqns, &nr_apqns);
+		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -333,7 +323,6 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -353,7 +342,7 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			const u8 *clrkey, u32 clrkeylen,
 			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 
 	/* check keytype, subtype, clrkeylen, keybitsize */
@@ -394,15 +383,10 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = ep11_apqns4type(subtype, NULL, NULL, 0,
-				     local_apqns, &nr_apqns);
+		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -412,7 +396,6 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -502,8 +485,8 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 {
 	const struct keytoken_header *hdr = (const struct keytoken_header *)key;
 	const struct clearkeytoken *t = (const struct clearkeytoken *)key;
+	u8 tmpbuf[MAXEP11AESKEYBLOBSIZE]; /* 336 bytes */
 	u32 tmplen, keysize = 0;
-	u8 *tmpbuf;
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -515,11 +498,6 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 	if (!keysize || t->len != keysize)
 		return -EINVAL;
 
-	/* alloc tmp key buffer */
-	tmpbuf = kmalloc(MAXEP11AESKEYBLOBSIZE, GFP_ATOMIC);
-	if (!tmpbuf)
-		return -ENOMEM;
-
 	/* try two times in case of failure */
 	for (i = 0, rc = -ENODEV; i < 2 && rc; i++) {
 		tmplen = MAXEP11AESKEYBLOBSIZE;
@@ -534,7 +512,6 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 		pr_debug("ep11_key2protkey()=%d\n", rc);
 	}
 
-	kfree(tmpbuf);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
-- 
2.43.0

