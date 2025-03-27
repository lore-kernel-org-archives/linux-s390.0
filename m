Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EE218592
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086401; cv=none; b=YtfPOHqLHUsTaK6m5Chtr1YxPTEYRP7MzecbkDjjdPKecvo29O/x5CWVL/ljDKUQejsQGBNbekzuqhLA/hU8rQBFx4PviQ6sLWEZzyAoIk1We/vVWzdqdA3C2ZMnY/0V5ObuExoT/MlakFtcVCPhXyvyphwJcNBys0TknBqduU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086401; c=relaxed/simple;
	bh=X1NtVBd1NCpFsuykhjiNa2e0PwsJmd2PIsdbdcjV3A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se+sVm2qgi54z1Ilqf/Pew9EX01XK3Kg+bggwexZA63Dx5HWCofKPEhNYnH5q/VGqMZZq44USFzO/t8aKGPQADVkQfKNZNF6E0k2OtdYWWxdC5eN4yj9dYTVJNO9v3gtprhXRSxAx2qx956QLiOLPVKoP7A6TezUwzhHhdkUu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aJHGPFpe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aJHGPFpe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCSBrk032494;
	Thu, 27 Mar 2025 14:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pa5h9L5YaIA2AH08I
	FpvfwKSWymfKEk0f7rW06XuS5M=; b=aJHGPFpepkkRfPHmDjypFwNAOjy5sOG7J
	381yNXUS8a0ccwIL8gQex/IUV4XRVGKJhWDCH404Ora3DJ2BiqUxYCTBqCkfz0TP
	vtl2zZlKHVYC4XpPgskd1n+JiAIq61KSTb9a1xCaNWlckMVaCrl2kuyLRmUz4TRF
	X1rM5jHEnOsd8CxcMXuQF80XsgJjZ7vdZ88hmLdazhWGF3ZMV7HtukaqE8ZZyZo7
	7LwvRkA2Cy6z1m1dWn70SmctPiHIq1A33TjMdeFtGWwLMbKXs6cXlqDxZWVu8rEg
	bAbEoV2qqa/ud/lmVfC7Fe9O7C/tXnd8UdAbPabh+Ml+xF/H1NoFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n6q28ss9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RD34Pb005796;
	Thu, 27 Mar 2025 14:39:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82nfbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdrRn49807682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A719A2004B;
	Thu, 27 Mar 2025 14:39:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3735F2004E;
	Thu, 27 Mar 2025 14:39:53 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:53 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 21/21] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Thu, 27 Mar 2025 15:39:41 +0100
Message-ID: <20250327143941.45507-22-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oSF8ZMMjktuzni8kb00DE9HqG4tLgQUX
X-Proofpoint-GUID: oSF8ZMMjktuzni8kb00DE9HqG4tLgQUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270099

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

