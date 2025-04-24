Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C050849C
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501820; cv=none; b=q6iln+9y0IlgSTzp/osqLJP05C+R3Z2M9yvd2+PkVX1bl9WbHYG8dtJMjuwi93JxX9RHMRGDm/vtmPEegbGR0m7v0tQNjLNN0RK4y5f+ZuUcy0pVcoKDhRX9XIMqWb4IYeFOZXodjSxrfDVCw5L9qPzwyiW3UplltZmFeK50K+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501820; c=relaxed/simple;
	bh=f6jcIqT+JsYnrezf5LeEU+5Dka+j50OVfXs9ZpBrvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7leMomYtYdTubkm1pKXPU3G1Hex+pTFBWIXIbqsyJ47UQVIetCsmYcdRE3UWXU661HU6wVqgztUjKAvZnfXL1jo1MTQkq6+CWv5HxzIN41e4iStU4/rJfEyN5xwrsibRyLC/eg++aSRgJfmc4iRSmrAqFgxkAXDFBXxnW2i+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dsZk9Fa4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dsZk9Fa4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAIZH5028707;
	Thu, 24 Apr 2025 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h23wedpUjHTyWPCtF
	3UkOaPF4PfUB53x8ns+m87CGdo=; b=dsZk9Fa41QAoAILKcwH09xvaH/w/a5rpe
	6bS/yrsUKsQCfmr/QzV05/kf7jDJfAi1OuMrNG3FrSOhSNIGLqpBz2fiSwp114SQ
	wZ4UcUE8EJ6RgPIsrBHNKItOumjcsYBiOigGet1WnNUxxxraJyajFWVOOObJYqJD
	9ZaBNMSEwYX48WJGVrzKpAhJj7thX4Yz6igoLV7axW38u42PyBPv8YuELciid6y1
	0irq1LaNa6oxYMq+V2sAa/vYbNXnBZr9ykkDZYgS8M5UIrESLl8isYLPIB1AUG/b
	vh9eEydz5+6+NUEcHoCxq060urL1IvdyuK/4WTjUvywTm24ux/FAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aabua0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBcFUh022313;
	Thu, 24 Apr 2025 13:36:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxgder-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaWMj29426232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD942004E;
	Thu, 24 Apr 2025 13:36:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D8F420043;
	Thu, 24 Apr 2025 13:36:31 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 25/25] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Thu, 24 Apr 2025 15:36:19 +0200
Message-ID: <20250424133619.16495-26-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX/RlvEg0XBEjJ deOVcRMLXmoZKWPMsm4WB4elAbOLEQu4xvxWZFjvs2zg58Lffnx/bdBHhQwxQB9P6LK+jX0YOSl NF+8DWq2sC9L8q6QCdYUwMxyrOeQXcqeVA1wPGVUX+l+EyYCt/fpShD1XdQoSlk9jW3+slq6MRU
 mTg4PCKSvx89RL3ZmPmC2kUuzUtrfEomWadrub3BsTMNnXY5+ecaGvW0q2fA+2toQ/FtCPmsuMD afOtlsqnl4pUcRMEArDvYWTBoLdyKTFUDstX9+EZBnOswWuvHyrbdCXDTs3GXeCz1qaGsN4/806 TKU2trKWGa8UMTZ0SUjznoGJsea8smXvZRNbNHq/tbGji4UYHJDma9Ui3ruI/muxLS8Df4Xes6x
 OXpV1Yb3cBjxzyunwyrhwIdgAqmx4Qba4M0XNGewBBnEaNTHoEm6ect6qqAlcfeWhb5sd6zv
X-Proofpoint-ORIG-GUID: 7mcINNiBTLPwX6xK4YEHL-Pm8-RXQ4kY
X-Proofpoint-GUID: 7mcINNiBTLPwX6xK4YEHL-Pm8-RXQ4kY
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=680a3e78 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=PJCvTKg1WW3ThAoDuw0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

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

