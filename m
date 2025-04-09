Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46826560D
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207411; cv=none; b=WRujUUag46C4Mb64GF0uBo1Mkv4b/t8LAw4a9sHGCcVNjNGw3zBDZGjiEZQxl4W5VNutlorRE+G/R05XGZy1VEYpqwhhid836lQ1cUi3co3kYjNSLiaze/gmiaDp/+6H/WgUwSqN6N2LDPu/tK1VFYLEEj0FZN+i+KHpb61B5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207411; c=relaxed/simple;
	bh=n3CfPqXwnuSsAuUwk96BN6gJGzrTBqd0aGlx/lppxnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FifTDyvULR9Y/LTpLZGmJ5sZcxdIxqhzuSW/jXLxBHwt8qep3B39y5fZafe3AI0ha5hkWCiL5Iy5BVlS2jCDBjo+ZlPJ12uooMU7HjdYSizLuR8PXuejR0oA0rX/eh8n/VyecJYBZpD+10Wg5Eef9PCz392l1dlxS2K/G6d/kKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTk62rdJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTk62rdJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399IV3H027285;
	Wed, 9 Apr 2025 14:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EwPYLHxor6WAUrQT5
	DRBwJAj65VYA+rDXfr3p/Y0s9g=; b=sTk62rdJpCKi2WaC5fepY8oOZKFIiOqAy
	NVVw/xP6ZpWe4bU02c3jiNN5Z4ZnCYImQhF9xVzKmYRcVPaCjaaOeGkzpp8XZl+s
	1s1eO2Cq+tJQUSfTwpB3kJ0SVwNvM2DHUxrSeTzvi37rjiDS3u5v/r6YOMlQThhD
	v6c+WmmsQ+pWUSG4yhKc6ZCqaeY9kJ6kqE/LpMpV7HgiKb5Ld/XfE7VoefXu4iYv
	XHKI7Gq1JMw0/+thuBAsYpEzI6ciwVYujyER8fKnpRhM+bWLgzj9mm2obC4rD00T
	PtyYaqU3PpkgOpbjW8qei/1dh84Ndij4QyWobuvLU31KJ4UZTGEMQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10m0fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539E1TL2018432;
	Wed, 9 Apr 2025 14:03:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kqucy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3MDA34538214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEC52005A;
	Wed,  9 Apr 2025 14:03:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12BDD20040;
	Wed,  9 Apr 2025 14:03:22 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:22 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 24/24] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Wed,  9 Apr 2025 16:03:05 +0200
Message-ID: <20250409140305.58900-25-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409140305.58900-1-freude@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PH-7Z2TkL5TH9fPEaXCzTjELPenpwXMH
X-Proofpoint-GUID: PH-7Z2TkL5TH9fPEaXCzTjELPenpwXMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=997 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

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
 arch/s390/crypto/paes_s390.c   |  6 +++---
 arch/s390/include/asm/pkey.h   | 15 ++++++++++++++-
 drivers/s390/crypto/pkey_api.c | 11 +++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

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

