Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9C2192FB
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811900; cv=none; b=ajQeW6d8kNPXyj+0MUb12pion60E5K+EasA7LQzYRdfo22zjuQGOEddzOIg5u3YQSEwW2t8zmIhNX2H6dNBNKtH2S0m/GH3okzxB+yIAkL8VGj/vljT2WcPkXg2NM17neoPB7r8EgyTak7gWEQFjQvVIWMsMKFS/dW+BJJmHnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811900; c=relaxed/simple;
	bh=IoV73Vwl4hKbPbPvWlG2ASVtgbm7kQEoViWBwsHINQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6C91MtKDKZwNC7P0T2fTvPRybP/pv8mu4y8FNRaAiOszwzNAWr/GZbHQm3Q/8/ZGuYQN97nNAZyzvVJruUP0cSKcOd6bsUYcvKHdhIO6z3tuUdGw4HrCjQJUZ5Fx/TH1EN7GOYcAjdYEu/Yjhsh7swn59jcbSuuQaBAmCkSXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bk50qMUp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bk50qMUp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GA3s4Y028866;
	Wed, 16 Apr 2025 13:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e84DMjTn65pFZ20ri
	WL4cmNPkRDerl3UeScbV8lWlQ4=; b=Bk50qMUpHSlp/hUn7TMgHZF+cBqLF8IXk
	4OKagl0u45vWz5wb9cjnp6Ns7pIVCjSyt79zO5IlIK0WMUoyZbNdTLgvWYDXyUDr
	IzJ0/COMTn7INeIJmDXTpFTwPGtzYBdEDCQmVrOQKvjgXcUUozbeLAE4fHDPDajn
	89Ic3erK6osfzIgzYhUP5Kk5oocC79WSsvfCCuuBg+9v40hcdAmLykiwx5S3doJ2
	FEbsTfjsJnhq5qS3J7Dn+jwWERKAe/B1gD2DuNop4kiTQFTYRN3R3419AYStz4JD
	aM+aExjCwGBVSPiN3kG0YjwX92/ScPgJzA+R6fSEGk2XN1q8SlG6A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462aff97hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GCDKqi010438;
	Wed, 16 Apr 2025 13:58:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk8b2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwBn318546974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F6920040;
	Wed, 16 Apr 2025 13:58:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1538A20043;
	Wed, 16 Apr 2025 13:58:11 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:10 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 15/25] s390/zcrypt: Rework cca misc functions kmallocs to use the cprb mempool
Date: Wed, 16 Apr 2025 15:57:50 +0200
Message-ID: <20250416135801.133909-16-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ihah2QF31cdHFz-Wo5evmbn1OITj678T
X-Proofpoint-GUID: Ihah2QF31cdHFz-Wo5evmbn1OITj678T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160111

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
index 6abfa3da7607..33e4deafadd3 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1126,20 +1126,29 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
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
 
@@ -1196,7 +1205,7 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
-	kfree(token);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2cipherkey);
@@ -1628,10 +1637,12 @@ EXPORT_SYMBOL(cca_query_crypto_facility);
  */
 int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
 {
+	void *mem;
 	int rc, found = 0;
 	size_t rlen, vlen;
-	u8 *rarray, *varray, *pg;
+	u8 *rarray, *varray;
 	struct zcrypt_device_status_ext devstat;
+	u32 xflags = 0;
 
 	memset(ci, 0, sizeof(*ci));
 
@@ -1641,12 +1652,17 @@ int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
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
@@ -1693,7 +1709,7 @@ int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
 	}
 
 out:
-	free_page((unsigned long)pg);
+	mempool_free(mem, cprb_mempool);
 	return found == 2 ? 0 : -ENOENT;
 }
 EXPORT_SYMBOL(cca_get_info);
-- 
2.43.0

