Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F701F2C44
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403360; cv=none; b=GYoP38Wm7L9uESqkoQZt27XelTmrxJSjZsdeEkaF2JTFDy5dfAcnMquDuqTbDKZxYpNfy7lh53CXrzb91TdImiTkOdkaIBhvARzMJYz73WK2d9V+ZPZ0gb11EwN5+vMBLx3ODzFiibrHMrCvjirPpW7+VN5alRL/VTztUUREeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403360; c=relaxed/simple;
	bh=f6jcIqT+JsYnrezf5LeEU+5Dka+j50OVfXs9ZpBrvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOeazEMv2amhab31hGKLLLg0rTJnfpBOhEOlm3d1EIVyPIXH6+ae0AO3k8ko+dw7YtiaaVLmrQTbMrpcePD9s9rzeh0boodg7QUxkuaRxsSCKsS6v3izQRKtRDtU5ZonFdoimiKJsaRp/i5ldu6Dzfa1Nw7m5KuCFzDQ4P7m6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qfKb4XAQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qfKb4XAQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fkMA007171;
	Wed, 23 Apr 2025 10:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h23wedpUjHTyWPCtF
	3UkOaPF4PfUB53x8ns+m87CGdo=; b=qfKb4XAQXx4hjA0n4jZBuPDJHt3Lld/0Z
	5c78TsuGuZdV4GvRWLViePZ72ufjBRW6r4ASQXz5LPW8RstKLuFpKXF4//PCD4OK
	F2tPdPgpvE2jDYKEex2VEfc4lZP3HWSVnkVFjF4Criv0i+1/p3TLlLF//AZbxzyJ
	N21kB9lyZ285jUH3+gTfED6l7eUlewdOwn1ZGKBW9Ot1ow5BmBVdCWZK1dRF5eM3
	BTKB5Zq7tfFrcFRF0+PKeFpEDBfrKDGGv1do8uHfmvG1gDEf+5k1WRfjhXTa0Gls
	m7de9N/yhRAoMwWdBXsVBoxLOr9E0U2a5Dv8tWJUopNt2oKWiDinQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnstna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6gk0j028446;
	Wed, 23 Apr 2025 10:15:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvjhe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFpZE47055282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B6D20049;
	Wed, 23 Apr 2025 10:15:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D0852004E;
	Wed, 23 Apr 2025 10:15:50 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:50 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 25/25] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Wed, 23 Apr 2025 12:15:34 +0200
Message-ID: <20250423101535.143137-26-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GX2HEDe18LriKrqXfG8juf-QIcg_e4TD
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808bddb cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=PJCvTKg1WW3ThAoDuw0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfXyYhDJpF9AZ3x EikfbJ2Ib8n9h2n13m6fgkMnoQB0kxDURfQPTWuF9Bhy5v/iuCn5V0LgtKe256eLGKa1bEChcJi 8z1JnE3xilB3/aGD0ba/gi2SBszVNpWNzS8/5HssngM45BFKbuA4H9leIWu/VR2hhl6KXQI9hVc
 m91eZgvaO8ZBGO6yzpmy0S1SxzMX6LNhlNmQAyA+h5gWExyHr9lhkTP8aaB3g2qPwkpjBtOVM49 3x+SqUMVPfis1XKJAQ/dYU00bVl5XBTcxGcVG590lSHpiDxOPmwwwyIIhOtiMurTOTNHnOA29bn EyntjRW/MlEzmsYdqtwBqrPG9OXmm6h1r6TWC8ffzcprjMk71j+pE5ULIZXZ0dZb4ZFA7KaXmD2
 n1RZy0TUWtqnh6+TWYD1IKmqo0B+GeVaX+kNCd1EFCsC2ZUi6BLH/8Zr1i+YWfsje8c+VZb8
X-Proofpoint-ORIG-GUID: GX2HEDe18LriKrqXfG8juf-QIcg_e4TD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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

