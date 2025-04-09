Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7425F788
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207405; cv=none; b=lvMzX3Ui/rAwdp9wUJQCcOs2T3Uzc8fil0mWXkOR/1LJycIW6jAGIR+quGpqJTpcwdwhVrvTagtQP7OnjB1fyITn0uTxADmJyRdmKJxKgucpHK3Zovsb4mBVmumRf+CrIv2U1v77pIZb0Z+qPUsC2/Gc9T7TYUp+eH9UL98MOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207405; c=relaxed/simple;
	bh=RnVFoGKjobtjWn4DHqeh5PzcVasQYUrV5LBvcmJuspY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Malw0h0zD0aOIhOmwBWHgD+On0Lw/fEzbk1fHKtLNLN7dKEsxmOIwvmJ0CMFUVuuFP5WN4RVJqvFdOXJ1jdb5xGbsNTxkshJfZHF9HvB0NSI7bRSMuXbp2f1U7dg1aI9XKleR2TVehDVtqCU3mDXPdFTX80j61vIgruw/uT/p7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MiibW0t2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MiibW0t2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539CS2e5017398;
	Wed, 9 Apr 2025 14:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vLk9pFxGXGyWYPyXM
	pPNJWZ06Q5h5JicobFZ4W3cVwM=; b=MiibW0t2nl/czNsUrPUXCLBBoDJ3DfC7a
	OQubHKmKQ/+s155s3I+7XW9FlX6xnemt18pjMd0Ud029uzhmIRzc7G5pzZSIygwZ
	hhh/7Ra0H15svXQKO+/FJY5cZiG5asbzBJDX9BCEr5eIyRbnlRlQHFRBgVM8CdO9
	I9fs9mBhVvK5ugNONzUCjniiqQIDrTG8X33ulBj6bqzXy8YWxX+u4pe8f3inu/Lb
	cLB8nk/1P+TpDv8R9nycIhMIeKlWSrAHDr/gFrTzu2k8T+Bcto+yUqvlu/3+X6It
	lMdiQ/3jfT662wPONh8U5loeI6bZGr3KS6jzFwSrqRwL2rlwTr2wQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wrx2rhmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539E2U1S025598;
	Wed, 9 Apr 2025 14:03:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkyy4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3GfX51773848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9073420063;
	Wed,  9 Apr 2025 14:03:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB3EA2004F;
	Wed,  9 Apr 2025 14:03:15 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:15 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 15/24] s390/zcrypt: Rework cca misc functions kmallocs to use the cprb mempool
Date: Wed,  9 Apr 2025 16:02:56 +0200
Message-ID: <20250409140305.58900-16-freude@linux.ibm.com>
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
X-Proofpoint-GUID: EqCx5HyUcxKxPs4SZExvtcXmqgLSlxcA
X-Proofpoint-ORIG-GUID: EqCx5HyUcxKxPs4SZExvtcXmqgLSlxcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090082

Rework two places in the zcrypt cca misc code using kmalloc() for
ephemeral memory allocation. As there is anyway now a cprb mempool
let's use this pool instead to satisfy these short term memory
allocations.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 42 +++++++++++++++++++---------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 15731eb250fb..88f3c7708c2a 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1128,20 +1128,29 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		      const u8 *clrkey, u8 *keybuf, u32 *keybufsize)
 {
 	int rc;
-	u8 *token;
+	void *mem;
 	int tokensize;
-	u8 exorbuf[32];
+	u8 *token, exorbuf[32];
 	struct cipherkeytoken *t;
+	u32 xflags = 0;
 
 	/* fill exorbuf with random data */
 	get_random_bytes(exorbuf, sizeof(exorbuf));
 
-	/* allocate space for the key token to build */
-	token = kmalloc(MAXCCAVLSCTOKENSIZE, GFP_KERNEL);
-	if (!token)
+	/*
+	 * Allocate space for the key token to build.
+	 * Also we only need up to MAXCCAVLSCTOKENSIZE bytes for this
+	 * we use the already existing cprb mempool to solve this
+	 * short term memory requirement.
+	 */
+	mem = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_KERNEL);
+	if (!mem)
 		return -ENOMEM;
 
 	/* prepare the token with the key skeleton */
+	token = (u8 *)mem;
 	tokensize = SIZEOF_SKELETON;
 	memcpy(token, aes_cipher_key_skeleton, tokensize);
 
@@ -1198,7 +1207,7 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
-	kfree(token);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2cipherkey);
@@ -1629,10 +1638,12 @@ EXPORT_SYMBOL(cca_query_crypto_facility);
  */
 static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 {
+	void *mem;
 	int rc, found = 0;
 	size_t rlen, vlen;
-	u8 *rarray, *varray, *pg;
+	u8 *rarray, *varray;
 	struct zcrypt_device_status_ext devstat;
+	u32 xflags = 0;
 
 	memset(ci, 0, sizeof(*ci));
 
@@ -1642,12 +1653,17 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 		return rc;
 	ci->hwtype = devstat.hwtype;
 
-	/* prep page for rule array and var array use */
-	pg = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!pg)
+	/*
+	 * Prep memory for rule array and var array use.
+	 * Use the cprb mempool for this.
+	 */
+	mem = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_KERNEL);
+	if (!mem)
 		return -ENOMEM;
-	rarray = pg;
-	varray = pg + PAGE_SIZE / 2;
+	rarray = (u8 *)mem;
+	varray = (u8 *)mem + PAGE_SIZE / 2;
 	rlen = vlen = PAGE_SIZE / 2;
 
 	/* QF for this card/domain */
@@ -1694,7 +1710,7 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 	}
 
 out:
-	free_page((unsigned long)pg);
+	mempool_free(mem, cprb_mempool);
 	return found == 2 ? 0 : -ENOENT;
 }
 
-- 
2.43.0

