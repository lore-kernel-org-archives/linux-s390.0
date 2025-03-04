Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790412D4B53
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108892; cv=none; b=eVc9m2t1jQVCfiAgKkUnBfz2MHoOTKboqGZQUNQfvKufqyjkQ/S9I/f9Qh/YsDuNVPAEshZPx1yyjpTi5jDwPhD+vC/mQjNO9NQCkq740wd/2nyUrp4Yh2YUjgrl+V4ymsZGty5kdPJxUB2lnqEOmDbgZDi8kENQvC8riKfI8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108892; c=relaxed/simple;
	bh=GyQrIiTHuSFf/Hpr37sQczOC6bEJ9c4LLxJAg0K1vwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7RkjM5wU6xgkqw5QqVkFp1RzAthd9mhPy3jqLVUvwtXyQpw0mj6OZjre+CqhsVnJVNeB30d/w90iY3fqk7Xr6B4nsfiBX5S89Milx5u64mT3Ap24+tnucNLY9pA8ySAhT0G8VX0tyFvii4AYNkMMqeRqH5Hu/ogX6AI20tqiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nPxDBelY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nPxDBelY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CS7Nw006596;
	Tue, 4 Mar 2025 17:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JL+P2jSBLyuYl7icr
	we3dZNhW6iBs81nAr+DVNVlUhw=; b=nPxDBelYs8nrGCvi7Y1ZEZ+aSGbNU5cWs
	rMXcx7B91tbx+gvt+FSU1oGFAxXooU7vbrYy1WeQ9//+2vpcgQ9158OduUFK6WkP
	E1+zrMKpj098y2/XQFskBNxv4Gt7h+Mj26dmxr2e79S6UDgGmEfpg3T+gl7QBCSn
	bzG4SFWa7JwaPP4IAHpJbHwLY0RwinUkF/93XzL/cl9h8kTQytpIv0bNp/dwu0wv
	zks6/AQf9wBx/UjsCwVYssbEspcvOCJwF2TzZPpCm9rtPR3+XGjjaHASphZyY/s4
	7ZYidnuP/vl1NRgTpKY7H1vUv3r9bYDnn9FKfrZPOvMMn7h6WONTw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j31fjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524FLK0c009038;
	Tue, 4 Mar 2025 17:21:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyenr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLNE337421520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5E320040;
	Tue,  4 Mar 2025 17:21:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 252B22004E;
	Tue,  4 Mar 2025 17:21:23 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 12/20] s390/zcrypt: Rework cca misc functions kmallocs to use the cprb mempool
Date: Tue,  4 Mar 2025 18:21:08 +0100
Message-ID: <20250304172116.85374-13-freude@linux.ibm.com>
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
X-Proofpoint-GUID: eecM889RbWIFM26TNwAJvLwWNyvBmr_o
X-Proofpoint-ORIG-GUID: eecM889RbWIFM26TNwAJvLwWNyvBmr_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Rework two places in the zcrypt cca misc code using kmalloc() for
ephemeral memory allocation. As there is anyway now a cprb mempool
let's use this pool instead to satisfy these short term memory
allocations.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c     |  2 +-
 drivers/s390/crypto/zcrypt_ccamisc.c | 42 +++++++++++++++++++---------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index bd2738e3792a..d4e60d89cdce 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -50,7 +50,7 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor interface, " \
 		   "Copyright IBM Corp. 2001, 2012");
 MODULE_LICENSE("GPL");
 
-unsigned int zcrypt_cca_cprbpool_min_items = 4;
+unsigned int zcrypt_cca_cprbpool_min_items = 6;
 module_param_named(cca_cprbpool_min_items, zcrypt_cca_cprbpool_min_items, uint, 0440);
 MODULE_PARM_DESC(cca_cprbpool_min_items, "CCA CPRB pool minimal items.");
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index d3b093dcdf30..ff7ba2622484 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1138,20 +1138,29 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
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
 
@@ -1208,7 +1217,7 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
-	kfree(token);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2cipherkey);
@@ -1714,10 +1723,12 @@ static void __exit mkvp_cache_free(void)
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
 
@@ -1727,12 +1738,17 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
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
@@ -1779,7 +1795,7 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 	}
 
 out:
-	free_page((unsigned long)pg);
+	mempool_free(mem, cprb_mempool);
 	return found == 2 ? 0 : -ENOENT;
 }
 
-- 
2.43.0

