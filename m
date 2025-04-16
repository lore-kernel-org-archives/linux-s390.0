Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD01FCF7C
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811903; cv=none; b=L0X/BTjZoaSlb3W1JYrOtOQGTYdrXc7+qyGybi6ynu0GldTrURo0WKBm5vl0AQfckmtqclsccNnHUplSEp1vTeSem+eZQfXwMQXbnw8nDbETfO4tsshw+RpWtEN4XbvrJwO1SbG/l0WlQKAHrGKLx2UiF69yI85sDaeED9c+WyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811903; c=relaxed/simple;
	bh=M/CihbpymVeG2xsJrPAZyxvn0Dcebo9mOWwj6XQB8Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG5MU27O9oWPZ+ohqdkmHycLANUHjupnscKuoEyn9tahCPdpHe3JdabgKSXBOVu++tJveaAd8C5gbrFGhrG/kaE1cDFjeVmJAYbyWfj9t75rRuCwehoAhC9DzhIXOsJczsf2uhD5tI7aFx0MBAlXv8WN6TQKc09m/E+JdyOWq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XUwrz5gY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XUwrz5gY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9EIiN018865;
	Wed, 16 Apr 2025 13:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T7WkMhQ8AOZGOLGMV
	9HZDODJTy3iO623qXi/z7LzlLk=; b=XUwrz5gYaneFpf85loG4o9NoApRYCzyQf
	l2Ry39LyKjp0g0UPTEJPTFdwNaTPAxGCmIGhir82Re6Zbsp79gZtmZO0e5hmHT4C
	0Y5twF0kggBzUUN4Km3RqCdB1DuzNjZdT43AxpeGXaGHIRWrNX+PSqaso2jxDUFf
	WhgPzs7WaxrOuf2RWv9Pc/Z8gbJ2LOfLfveeBw38p8rBsI0+Iz99zI5VwNRDHlhZ
	EUMDJny+N4U2Str/0ahAoEWwhovJlkjqQxqV4FYAyAnp8H6D8xFpnVvpZF2La6WV
	nuyz4gqIqiU5YunqZ8MSViMtoDJDIqraKrtmD7T3F+IAeD7CtlJ4w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461y1gc60b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GBFRka017183;
	Wed, 16 Apr 2025 13:58:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m0exs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwEbE46334458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94E7620040;
	Wed, 16 Apr 2025 13:58:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207EB20043;
	Wed, 16 Apr 2025 13:58:14 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 20/25] s390/pkey: Rework EP11 pkey handler to use stack for small memory allocs
Date: Wed, 16 Apr 2025 15:57:55 +0200
Message-ID: <20250416135801.133909-21-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tLIpZ1hCRpKO_gFdYLsBsIYjWoDJSorb
X-Proofpoint-GUID: tLIpZ1hCRpKO_gFdYLsBsIYjWoDJSorb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160111

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

