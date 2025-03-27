Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F378217F36
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086398; cv=none; b=Rcys4XWZoemEm3q+2rMutSUXlbHaU5J8XBV7G3VOpydozwWMeW4Pk5gvj9fz71JTdU0NCTDW5OoWErDrUvC23bfeoCHYloV9Id3OaDiIT+CaTGxVm8K0ifqjbtC9p7ddv6SkrGahp5ddodnBRxVo8qenCnZzEfFVs7gQIAN3mIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086398; c=relaxed/simple;
	bh=Gnl+K4MgPLVwH9FnkIdnj8RM2GYyOTkr2O4k6f6kF00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Qa33kBVQ3LPQj1kg5yKOLK+A7wLKNL2pbVz2WzUA51tmEcjYxKx1COt+sGnq1Du/BdOzojXIhn/l12tWLF1NqREMagmJdJ9eRu1YjyZCArkV+i8NdwiGi7c42hDJZ1lJf8MVgIhFlOE3PFhwpMIC65tw1+qsxMfSAMfzkZsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HdIZETtT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HdIZETtT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RE3IBV008239;
	Thu, 27 Mar 2025 14:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NvGxaTRrvoZ6EqH1m
	psF1cuCh96U3jFh0OiXDrVBUMQ=; b=HdIZETtT2PM0CvUtvamfH2h5ma1KD5mHv
	9p627UQJCXjPiAdLhD613kKab0O3vsoMEizDIrUBnrLJVN/7cjp1UiVMqvcAAf53
	ypVlNjAH1S4DwpTKdFXZRNOFFZ/4+NAZ+54OpdMVU0AvbT/6+InFJzTarppZ3RbC
	KGfglgNWz44mQCP0TC6kP/k5w/q6+a1l1kWfbASi+Se5EmR9M/VRVRMvZioE0hEk
	dCvl9feZ7/xN7ULWDLn1Yp8App3eMSMCtkp9MLztAr7DQbgOaUCiWTbEn/IQsEue
	4TIgyX38oy6zgqz76rKO/Wu02CQfLICfxqENwd0lOAOwMBIyAiavQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83p878h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RAh8g4025485;
	Thu, 27 Mar 2025 14:39:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0dw98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdoxj36372814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED542004D;
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7E1720043;
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 14/21] s390/zcrypt: Rework cca misc functions kmallocs to use the cprb mempool
Date: Thu, 27 Mar 2025 15:39:34 +0100
Message-ID: <20250327143941.45507-15-freude@linux.ibm.com>
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
X-Proofpoint-GUID: eEUqTUYrln6LB5R88pq7_alzAx58Wqx2
X-Proofpoint-ORIG-GUID: eEUqTUYrln6LB5R88pq7_alzAx58Wqx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

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
index c486c6c30960..7a3ab4f4ce2c 100644
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

