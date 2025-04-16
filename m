Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3B2192FB
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811906; cv=none; b=dUrdgbshOg11FitMzAX948y0Oz1QzAfp5E92NFPUHQ34zYGGrOgrsY834HYb395rSHGGgo/fQ49QV0Z5qyyYlj4eRsop3/hNsHrA63Awh0SL6xVRD1chPivD8vVJWBis3vJY+O2/9IrKg0eeQBJ1ft03KPXwOZbiFpbVh1xLCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811906; c=relaxed/simple;
	bh=f6jcIqT+JsYnrezf5LeEU+5Dka+j50OVfXs9ZpBrvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWku2N6TkpN9RQnUuunXlfjhfonVx6E2T8CNa7zcZ6cZm1DxFOXUlltFCi65DHY0Zu0XBXUr+OTqjDgMHc5uh1UY6vmq/c2gZWVhkKUeGt0ZhaHJ7DAC0yj8beDOg1cXPCDmEaN5VwR3uD2h7P5czX430kEJ/KKbW1/T1h4J5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MJTGgHfj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MJTGgHfj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GA3k2b028742;
	Wed, 16 Apr 2025 13:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h23wedpUjHTyWPCtF
	3UkOaPF4PfUB53x8ns+m87CGdo=; b=MJTGgHfjdk5het9w8GiNRzOUMcljsbZt+
	2V45FGqQe5/42trphq+Z0B8aVD+0tFqtUQIjeccxI3P7live6A94Cu+G438vU+gy
	QKHAK5TKpGRYRoRKahaKUnSdc/967d9M+8TfY6IaPgC7rTKymZEQ3w3BhZx/9grE
	/INIrs0jWg3ozI+PidOLnhkZQP5TFIMM1HjB1RgwPZsVSVRWik81vC4UOhm+sJVA
	JM3433OxO//Ez5SHAZtN/d9ELqT/DP7x8FlKLL58nFLmD58hTo+pwzOXrGW8H6r7
	iQh7lbW34c0tHCrgMZNECr4if+vdnYZ5pcx1k9bJa1hEPCQovSHEw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462aff97jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GDawZD001265;
	Wed, 16 Apr 2025 13:58:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w00sq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwHQb51183888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97E620040;
	Wed, 16 Apr 2025 13:58:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F6A2004B;
	Wed, 16 Apr 2025 13:58:17 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 25/25] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Wed, 16 Apr 2025 15:58:00 +0200
Message-ID: <20250416135801.133909-26-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GJLwSTRn6McG-b69el8sLZCYU5ozW4Im
X-Proofpoint-GUID: GJLwSTRn6McG-b69el8sLZCYU5ozW4Im
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160111

Add a new parameter xflags to the in-kernel API function
pkey_key2protkey(). Currently there is only one flag supported:

* PKEY_XFLAG_NOMEMALLOC:
  If this flag is given in the xflags parameter, the pkey
  implementation is not allowed to allocate memory but instead should
  fall back to use preallocated memory or simple fail with -ENOMEM.
  This flag is for protected key derive within a cipher or similar
  which must not allocate memory which would cause io operations - see
  also the CRYPTO_ALG_ALLOCATES_MEMORY flag in crypto.h.

The one and only user of this in-kernel API - the skcipher
implementations PAES in paes_s390.c set this flag upon request
to derive a protected key from the given raw key material.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 arch/s390/crypto/paes_s390.c   | 6 +++---
 arch/s390/include/asm/pkey.h   | 5 ++++-
 drivers/s390/crypto/pkey_api.c | 3 +--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 511093713a6f..1f62a9460405 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -182,14 +182,14 @@ static inline int __paes_keyblob2pkey(const u8 *key, unsigned int keylen,
 {
 	int i, rc = -EIO;
 
-	/* try three times in case of busy card */
+	/* try three times in case of busy card or no mem */
 	for (i = 0; rc && i < 3; i++) {
-		if (rc == -EBUSY && in_task()) {
+		if ((rc == -EBUSY || rc == -ENOMEM) && in_task()) {
 			if (msleep_interruptible(1000))
 				return -EINTR;
 		}
 		rc = pkey_key2protkey(key, keylen, pk->protkey, &pk->len,
-				      &pk->type);
+				      &pk->type, PKEY_XFLAG_NOMEMALLOC);
 	}
 
 	return rc;
diff --git a/arch/s390/include/asm/pkey.h b/arch/s390/include/asm/pkey.h
index a709a72be79a..c0e7f8c25e9f 100644
--- a/arch/s390/include/asm/pkey.h
+++ b/arch/s390/include/asm/pkey.h
@@ -20,10 +20,13 @@
  * @param key pointer to a buffer containing the key blob
  * @param keylen size of the key blob in bytes
  * @param protkey pointer to buffer receiving the protected key
+ * @param xflags additional execution flags (see PKEY_XFLAG_* definitions below)
+ *        As of now the only supported flag is PKEY_XFLAG_NOMEMALLOC.
  * @return 0 on success, negative errno value on failure
  */
 int pkey_key2protkey(const u8 *key, u32 keylen,
-		     u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+		     u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		     u32 xflags);
 
 /*
  * If this flag is given in the xflags parameter, the pkey implementation
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 55a4e70b866b..cef60770f68b 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -53,10 +53,9 @@ static int key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
  * In-Kernel function: Transform a key blob (of any type) into a protected key
  */
 int pkey_key2protkey(const u8 *key, u32 keylen,
-		     u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+		     u8 *protkey, u32 *protkeylen, u32 *protkeytype, u32 xflags)
 {
 	int rc;
-	const u32 xflags = 0;
 
 	rc = key2protkey(NULL, 0, key, keylen,
 			 protkey, protkeylen, protkeytype, xflags);
-- 
2.43.0

