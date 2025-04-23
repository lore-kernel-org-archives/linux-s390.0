Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430D24466D
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403353; cv=none; b=lFntbZccqqrl1fiUl6ow6TEbHO1k4U1gtk+nBPf/otbED49tG3YJa0wLIr+TM04/UAYs1w/xdmhIw7JI0HYtRKpdqTLA46rGACfeizY+KV6SkPhbUbpAHefB7rZd3zvcD9ydgMpSXAstDCKI9GVP2vqg7HNgBmjoZazG8Y49bMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403353; c=relaxed/simple;
	bh=IoV73Vwl4hKbPbPvWlG2ASVtgbm7kQEoViWBwsHINQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmtH7sOg6TJKfSiu2WClXoEVd7PPpUEZDF3fGjGC4OqfnbzQUVVdLo3QiA+UGJgndgKHxC5g1LbA+AYCu/T8UkuqGrPN0uJLWRBh5Ms+/RqYL6Lw/Dn22oVpdsSM5wYBxPiJ5lCuP/s4zi4sPEcwgU15kyBF8v/7eU8dHECHKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rLe/BLKX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rLe/BLKX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fiww002087;
	Wed, 23 Apr 2025 10:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e84DMjTn65pFZ20ri
	WL4cmNPkRDerl3UeScbV8lWlQ4=; b=rLe/BLKXQVnTkv4b7C3xjJVt403Zf7dkR
	3x88FeEOxm8JpEAoRNuF8cPGCp0+yrwtc+uIQI0g8vkpqmV4yj3AS8wC66NMpNYC
	tFenLghn6r0MclgicMDPrrOg0tPjTdMl6lkT3bT7d1kiq7eFSoq3qsRAtEl5izi7
	JtTfrK2uEp6pO3srZ52uwFBkSdERoOeIV/8cnoxZCGlSIzuz8FIGP3+c4zO8uEYh
	iTHovfXm38844X2EpuJc9gldPK0ueCr6Bbuaj82/YIFIso2JKvdmwI2RGMMhYrRx
	gCTxQI/JzvpCvLoTrp8xL2907W6vj3fg6vS2vaExmsvle0eRrwJZg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpt2puf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6jGpY000976;
	Wed, 23 Apr 2025 10:15:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxth3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFj0Z51446124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E244D20049;
	Wed, 23 Apr 2025 10:15:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7501E2004D;
	Wed, 23 Apr 2025 10:15:44 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:44 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 15/25] s390/zcrypt: Rework cca misc functions kmallocs to use the cprb mempool
Date: Wed, 23 Apr 2025 12:15:24 +0200
Message-ID: <20250423101535.143137-16-freude@linux.ibm.com>
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
X-Proofpoint-GUID: xNrUkv01w71VD802FWyRtMSHmY0H66fy
X-Proofpoint-ORIG-GUID: xNrUkv01w71VD802FWyRtMSHmY0H66fy
X-Authority-Analysis: v=2.4 cv=a/Qw9VSF c=1 sm=1 tr=0 ts=6808bdd6 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=90Hg82fxA5viHaBFFW8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX8+6GSNdy5v7R /I3bwU+bfCkj5/zgP/kMloDcDhELNDt+UvpdmvooSXFbB3Z13Q6vuwGW4GiRf5QhJAAuKxnbDUM i2gHWgZ19McMCoKmqFenf+ZQE3TtoPvlIC7hc2SRpplrdrm6tfROfYgFlO5TFp/HInI8sfhN7CR
 vUXDlQsQP1UbdlADn6JZmtQEDlLG2X5gh2oqsdchGzFsV2BcmuzbPJrLQEWwHMV1tSobHUPZ1eY Y6A487to7LWG3HD9v3rmdpbE70Iqatm9F0tDf5eBlrFcb+x+vAS+1+6t8r6ijItnoTO3UvIhNMv BpwpY/oOo7Oa5lMxewPJOijwOIF1zBXs3HOqkqn+ZHOWtFdqWQiR1ug7QrPtSK/y3ATCrs5FmCx
 YcqNLAFlOOKf8kUQUMijaU+9Me4i4BPuckrjeOPrx3C49YydbnH0wSlehaKY3wR7OZLAK8VA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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

