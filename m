Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18A202F9A
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304516; cv=none; b=EM6LiXL0XG0P/d1yXuddYBnZ9f+MxP7c+HOFrAIAyUUwMuF2u8fJR6LdkjwoJJ3I3Z5gzXLYz8ntmaPXzKjr/lMmJTsSm2dLB/Seagmd6M0o9uqXNRzel7ijeMXMBalxslleEi2VMD1i6OnJ84tiIihlPOGjQc0EAxYLlK5W2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304516; c=relaxed/simple;
	bh=xTPrJ8JNvsjO8CJCC/x0n9j7ZeZWFyF1QITKTxCUPy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic9/QGtaXYdUiJtlsSssLSyYYPxFBNMuwP3/ajhkEd9Nw3sRM9bAQA66FzSBFTcv13jDU/omFiEOB6zO62je+RqGHYVJNtMqJwLeY3g0gRZhg0maI/ou0kU8RXrJphpKvm60lZcSCPViKj7MABwcvcIcchHQaUPg6lHUdpHkO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m/5nS/ci; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/5nS/ci"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N4gOEj004922;
	Sun, 23 Feb 2025 09:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6TWGVLXzL219/8/aE
	3DGqmNEhY3zFUfZiu2IOlWaK88=; b=m/5nS/civV/prj1/10mbl1TuWwCzt2gUp
	EQCrKUitaFmGx0baTp2bxXJ+gx0rpROoSazw3XwLgxsQKscuPcwN4236cbuY7IwR
	2XMmoSHCfZT9Dg9vMXJTAq4v4ZB1IhpCxMtvjdkx2j89ZS9YUNsfOIXlqMNrgg3Z
	+M8zk7SFIXv79pvu8JRj+/a12m4m+3XbKS3iOEbNisMZ2yCTKQDdLBn0Z64dkJhk
	MiXKhpz/H/nj9yNtFiJ8G3EB07mtIw7UjzAqziKEBuSdNHzIBr2QlytrW0gDk912
	o8H2JAL4wA9MzTB0SSPSZFOpM/9ewcM1Zr6p9jvx2xoFq0+0JiLtQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9sapu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N5v8E2026354;
	Sun, 23 Feb 2025 09:55:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswn1pyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t8pb33882532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0360F20049;
	Sun, 23 Feb 2025 09:55:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3FA020040;
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 20/20] s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
Date: Sun, 23 Feb 2025 10:54:59 +0100
Message-ID: <20250223095459.43058-21-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223095459.43058-1-freude@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tHJ-7NtDvimCv2WMw90jdVl4q2qMAh_v
X-Proofpoint-GUID: tHJ-7NtDvimCv2WMw90jdVl4q2qMAh_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502230073

Add a new parameter xflags to the in-kernel API function
pkey_key2protkey(). Currently there is only one flag supported:

  * PKEY_XFLAG_NOMEMALLOC - If this flag is given in the xflags
    parameter, the pkey implementation is not allowed to allocate
    memory but instead should fail with -ENOMEM. This flag is for
    protected key derive within a cipher or similar which must not
    allocate memory - see also the CRYPTO_ALG_ALLOCATES_MEMORY
    flag in crypto.h.

The one and only user of this in-kernel API - the skcipher
implementations PAES in paes_s390.c set this flag upon request
to derive a protected key from the given raw key material.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/crypto/paes_s390.c     |  2 +-
 arch/s390/include/asm/pkey.h     | 13 ++++++++++++-
 drivers/s390/crypto/pkey_api.c   |  3 +--
 drivers/s390/crypto/zcrypt_api.h | 10 +++++++---
 4 files changed, 21 insertions(+), 7 deletions(-)

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
index 5dca1a46a9f6..2bd344cbc2ec 100644
--- a/arch/s390/include/asm/pkey.h
+++ b/arch/s390/include/asm/pkey.h
@@ -20,9 +20,20 @@
  * @param key pointer to a buffer containing the key blob
  * @param keylen size of the key blob in bytes
  * @param protkey pointer to buffer receiving the protected key
+ * @param xflags additional execution flags (see PKEY_XFLAG_* definitions below)
  * @return 0 on success, negative errno value on failure
  */
 int pkey_key2protkey(const u8 *key, u32 keylen,
-		     u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+		     u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		     u32 xflags);
+
+/*
+ * If this flag is given in the xflags parameter, the pkey implementation
+ * is not allowed to allocate memory but instead should fail with -ENOMEM.
+ * This flag is for protected key derive within a cipher or similar
+ * which must not allocate memory - see also the CRYPTO_ALG_ALLOCATES_MEMORY
+ * flag in crypto.h.
+ */
+#define PKEY_XFLAG_NOMEMALLOC 0x0001
 
 #endif /* _KAPI_PKEY_H */
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
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 92027304f0d8..f6d84751631f 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <asm/debug.h>
+#include <asm/pkey.h>
 #include <asm/zcrypt.h>
 #include "ap_bus.h"
 
@@ -79,10 +80,13 @@ struct zcrypt_track {
 /*
  * Do not allocate memory xflag. To be used with
  * zcrypt_send_cprb() and zcrypt_send_ep11_cprb().
- * Currently only available and used for the in-kernel
- * zcrpyt api.
+ * But also used within the cca and ep11 misc functions
+ * and the pkey layer exposes this as a PKEY_XFLAG_
+ * via the in-kernel-api for protected key support.
+ * ZCRYPT_XFLAG_NOMEMALLOC and PKEY_XFLAG_NOMEMALLOC
+ * should have same value to avoid unnecessary conversions.
  */
-#define ZCRYPT_XFLAG_NOMEMALLOC 0x0001
+#define ZCRYPT_XFLAG_NOMEMALLOC PKEY_XFLAG_NOMEMALLOC
 
 struct zcrypt_ops {
 	long (*rsa_modexpo)(struct zcrypt_queue *, struct ica_rsa_modexpo *,
-- 
2.43.0

