Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BF2D4B62
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108896; cv=none; b=G/WPm9Fd2FCAeUgAGpdYnDW+aNxrfD4BJ60b46PIDfgYAo7eh/WDmzl9nTZk3dYj+eICuz9Zc5f3Nf77rh8pvz2jQ0XRKwc+hry+RnqxzF4Fl45bjuCHN4lGsNdLQlLiFlEpI2VDDyGXaAFR18RaDhm1VJv5LfssWjhKPt8EUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108896; c=relaxed/simple;
	bh=UiIjUTfTrBThkcjRaDsMkgNxiQWY8TdiOwSc11HaoyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKZX6k4vSXwcSWYx68Pu/BbaPggdsOj6j4B8fX1dcY97I1RIcu3LUVjUTS/Pb5rPWGZJHgqxrHVzeyrktXYXkHu+bJxXusqHOWOJ7DZV5tq53e/01pAdDXDnPZqYU4mNUlmxD9HkYJtJEea2lYoIN2m7VpK2kU3dNev5Um8FXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LSsrAQXq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LSsrAQXq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CSboN007621;
	Tue, 4 Mar 2025 17:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wmn4/cYj8j99d41Sf
	OzQc1ik0cb/Umy1gDwsF1R4BJw=; b=LSsrAQXq+u97JLEYYttbzzsIY/rYlclfr
	aaz5qZ3dTgWAUJdbxB49PSDTKCB8F4qyT4wY/OiSLRffAJyEU/VpU5JCBkAB7DmE
	pk3Leo3wnaj4Y6ly2Mn2z4OD6ZdHjDaFTIOPEN6xrj0kL/8i4Y+7mvjb+1e5fRT2
	vTt3TIWVq/EXQbm78zWnEqA4e+XEpVU9QRZriEVmX3E7neiqgfp9YQ+/RDQ7PTrg
	VO7OlgmGAHPmrSY/1sx893by/JES2BGC2UCnyOFgBSENz20tkkEHdn3TQ16uKLgP
	rsMBj9+e6qn3qgjhmjBfmpa9vZSRnNOeExPHT4yTCLZ11wDmGdc7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j31fkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524FlLUk020871;
	Tue, 4 Mar 2025 17:21:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnej00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLSf49634158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D8920040;
	Tue,  4 Mar 2025 17:21:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D2DC2004B;
	Tue,  4 Mar 2025 17:21:27 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:27 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 20/20] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Tue,  4 Mar 2025 18:21:16 +0100
Message-ID: <20250304172116.85374-21-freude@linux.ibm.com>
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
X-Proofpoint-GUID: MDFMnSYYNVbXKbRVLIl_O9VI6wRdrMAs
X-Proofpoint-ORIG-GUID: MDFMnSYYNVbXKbRVLIl_O9VI6wRdrMAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=996 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Add a new parameter xflags to the in-kernel API function
pkey_key2protkey(). Currently there is only one flag supported:

* PKEY_XFLAG_NOMEMALLOC:
  If this flag is given in the xflags parameter, the pkey implementation
  is not allowed to allocate memory but instead should fall back to use
  preallocated memory or simple fail with -ENOMEM.
  This flag is for protected key derive within a cipher or similar
  which must not allocate memory which would cause io operations - see
  also the CRYPTO_ALG_ALLOCATES_MEMORY flag in crypto.h.

The one and only user of this in-kernel API - the skcipher
implementations PAES in paes_s390.c set this flag upon request
to derive a protected key from the given raw key material.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/crypto/paes_s390.c   |  2 +-
 arch/s390/include/asm/pkey.h   | 15 ++++++++++++++-
 drivers/s390/crypto/pkey_api.c | 11 +++++++----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 511093713a6f..646cbbf0678d 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -189,7 +189,7 @@ static inline int __paes_keyblob2pkey(const u8 *key, unsigned int keylen,
 				return -EINTR;
 		}
 		rc = pkey_key2protkey(key, keylen, pk->protkey, &pk->len,
-				      &pk->type);
+				      &pk->type, PKEY_XFLAG_NOMEMALLOC);
 	}
 
 	return rc;
diff --git a/arch/s390/include/asm/pkey.h b/arch/s390/include/asm/pkey.h
index 5dca1a46a9f6..c0e7f8c25e9f 100644
--- a/arch/s390/include/asm/pkey.h
+++ b/arch/s390/include/asm/pkey.h
@@ -20,9 +20,22 @@
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
+
+/*
+ * If this flag is given in the xflags parameter, the pkey implementation
+ * is not allowed to allocate memory but instead should fall back to use
+ * preallocated memory or simple fail with -ENOMEM.
+ * This flag is for protected key derive within a cipher or similar
+ * which must not allocate memory which would cause io operations - see
+ * also the CRYPTO_ALG_ALLOCATES_MEMORY flag in crypto.h.
+ */
+#define PKEY_XFLAG_NOMEMALLOC 0x0001
 
 #endif /* _KAPI_PKEY_H */
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 55a4e70b866b..c46b57001550 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -53,17 +53,20 @@ static int key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
  * In-Kernel function: Transform a key blob (of any type) into a protected key
  */
 int pkey_key2protkey(const u8 *key, u32 keylen,
-		     u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+		     u8 *protkey, u32 *protkeylen, u32 *protkeytype, u32 xflags)
 {
+	u32 flags;
 	int rc;
-	const u32 xflags = 0;
+
+	/* as of now only the NOMEMALLOC flag is supported */
+	flags = xflags & PKEY_XFLAG_NOMEMALLOC ? ZCRYPT_XFLAG_NOMEMALLOC : 0;
 
 	rc = key2protkey(NULL, 0, key, keylen,
-			 protkey, protkeylen, protkeytype, xflags);
+			 protkey, protkeylen, protkeytype, flags);
 	if (rc == -ENODEV) {
 		pkey_handler_request_modules();
 		rc = key2protkey(NULL, 0, key, keylen,
-				 protkey, protkeylen, protkeytype, xflags);
+				 protkey, protkeylen, protkeytype, flags);
 	}
 
 	return rc;
-- 
2.43.0

