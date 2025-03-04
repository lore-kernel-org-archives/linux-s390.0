Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360E2C374D
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108890; cv=none; b=dwMEb8m4HHOA2N6rL1I/qLrpyK4BAM8a7ImkWUKSGXPtcfFAcO8QmWbY9tY3ksFGQvQ+W78NX1hsHuTpdlbPswxmDtbKyzPx/DTW8hqbC/eolQScaQ1bqaB1JC1ID6KOw109+dqJbNOo6Iy6rNRG+RXYqSxVw4eRojT5qFiZ2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108890; c=relaxed/simple;
	bh=Xc5IVwSUBFe34X27I13PlHGPxXrpaB6yCz30nSUvbzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG4YHMR3/uq3bSRatb7ZtbjMB7BynpF8dgqiKmGEd7021lsFLUEaflCsfGD14rM6NVKfaecWx3uzqhPvf1VuXTJuqEzMGQCLMGxH+2cStKu8Hw1h14PInNbj35TAASOkdE1yLkb7+cpxWCzB3bwRWhWvDyhODrdGDu8gSbCKaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=izDciSWI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="izDciSWI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CS4Bt006540;
	Tue, 4 Mar 2025 17:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zY1GlZoAIVuefaXbt
	LiFOIbm5/xKR/FjWMwabxzSjwY=; b=izDciSWIBZyBbzhfXOnLMdiKW7C8NZ3vR
	2WOLhFaJaKB6gWr4NerIb+rcJHhPlQlvDEJgDQ2m5GWTPaBZQEskZgob7IYe5C8l
	G9+mARhCnzeN4jU8jU+9mxAkJYS9tlUJtVaQTPVYnKiOpqtIoNAwU1dtUastBwxo
	YsoI8ap7aJj6ks2Wm+agv7pbf9cJZnc/5T0P5QQFmPbAKQAcg/d/LTUTdfjqbHGM
	RlJG1xrBjAg3ScdihYs6wB/68aTm1Vg8eCjMjbHh69htaYTpgV1FLhNBG+78txSq
	F0UlleY//DKGqBBUVBsp1lI+wTuVw4xqt4EGk5B78fJzYy9FV4Hfw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j31fjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Fxq7k013776;
	Tue, 4 Mar 2025 17:21:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kpep4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLL5d29491736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E15120043;
	Tue,  4 Mar 2025 17:21:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4662004D;
	Tue,  4 Mar 2025 17:21:21 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:21 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 08/20] s390/zcrypt: Introduce pre-allocated device status array for cca misc
Date: Tue,  4 Mar 2025 18:21:04 +0100
Message-ID: <20250304172116.85374-9-freude@linux.ibm.com>
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
X-Proofpoint-GUID: dHIyLT55xKPm24iQ1k_9CtX8KxL5zjeZ
X-Proofpoint-ORIG-GUID: dHIyLT55xKPm24iQ1k_9CtX8KxL5zjeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the two findcard()
functions. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 78 +++++++++++++++++++---------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 420895df70f0..65b4cdb9b478 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -51,6 +51,22 @@ static DEFINE_SPINLOCK(cca_info_list_lock);
 #define CPRB_MEMPOOL_ITEM_SIZE (16 * 1024)
 static mempool_t *cprb_mempool;
 
+/*
+ * This is a pre-allocated memory for the device status array
+ * used within the findcard() functions. It is currently
+ * 128 * 128 * 4 bytes = 64 KB big. Usage of this memory is
+ * controlled via dev_status_mem_mutex. Needs adaption if more
+ * than 128 cards or domains to be are supported.
+ */
+#define ZCRYPT_DEV_STATUS_CARD_MAX 128
+#define ZCRYPT_DEV_STATUS_QUEUE_MAX 128
+#define ZCRYPT_DEV_STATUS_ENTRIES (ZCRYPT_DEV_STATUS_CARD_MAX * \
+				   ZCRYPT_DEV_STATUS_QUEUE_MAX)
+#define ZCRYPT_DEV_STATUS_EXT_SIZE (ZCRYPT_DEV_STATUS_ENTRIES * \
+		sizeof(struct zcrypt_device_status_ext))
+static void *dev_status_mem;
+static DEFINE_MUTEX(dev_status_mem_mutex);
+
 /*
  * Simple check if the token is a valid CCA secure AES data key
  * token. If keybitsize is given, the bitsize of the key is
@@ -1801,21 +1817,20 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 	if (mkvp == 0 || minhwtype < 0)
 		return -EINVAL;
 
-	/* fetch status of all crypto cards */
-	device_status = kvcalloc(MAX_ZDEV_ENTRIES_EXT,
-				 sizeof(struct zcrypt_device_status_ext),
-				 GFP_KERNEL);
-	if (!device_status)
-		return -ENOMEM;
+	/* occupy the device status memory */
+	mutex_lock(&dev_status_mem_mutex);
+	memset(dev_status_mem, 0, ZCRYPT_DEV_STATUS_EXT_SIZE);
+	device_status = (struct zcrypt_device_status_ext *)dev_status_mem;
 
+	/* fetch crypto device status into this struct */
 	rc = zcrypt_device_status_mask_ext(device_status,
-					   MAX_ZDEV_CARDIDS_EXT,
-					   MAX_ZDEV_DOMAINS_EXT);
+					   ZCRYPT_DEV_STATUS_CARD_MAX,
+					   ZCRYPT_DEV_STATUS_QUEUE_MAX);
 	if (rc)
 		goto out;
 
 	/* walk through all crypto cards */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		if (device_status[i].online &&
@@ -1842,9 +1857,9 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 			cca_info_cache_scrub(card, dom);
 		}
 	}
-	if (i >= MAX_ZDEV_ENTRIES_EXT) {
+	if (i >= ZCRYPT_DEV_STATUS_ENTRIES) {
 		/* nothing found, so this time without cache */
-		for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+		for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 			if (!(device_status[i].online &&
 			      device_status[i].functions & 0x04))
 				continue;
@@ -1864,24 +1879,26 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 					oi = i;
 			}
 		}
-		if (i >= MAX_ZDEV_ENTRIES_EXT && oi >= 0) {
+		if (i >= ZCRYPT_DEV_STATUS_ENTRIES && oi >= 0) {
 			/* old mkvp matched, use this card then */
 			card = AP_QID_CARD(device_status[oi].qid);
 			dom = AP_QID_QUEUE(device_status[oi].qid);
 		}
 	}
-	if (i < MAX_ZDEV_ENTRIES_EXT || oi >= 0) {
+	if (i < ZCRYPT_DEV_STATUS_ENTRIES || oi >= 0) {
 		if (pcardnr)
 			*pcardnr = card;
 		if (pdomain)
 			*pdomain = dom;
-		rc = (i < MAX_ZDEV_ENTRIES_EXT ? 0 : 1);
+		rc = (i < ZCRYPT_DEV_STATUS_ENTRIES ? 0 : 1);
 	} else {
 		rc = -ENODEV;
 	}
 
 out:
-	kvfree(device_status);
+	/* release the device status memory */
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 
@@ -1923,16 +1940,15 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 
-	/* fetch status of all crypto cards */
-	device_status = kvcalloc(MAX_ZDEV_ENTRIES_EXT,
-				 sizeof(struct zcrypt_device_status_ext),
-				 GFP_KERNEL);
-	if (!device_status)
-		return -ENOMEM;
+	/* occupy the device status memory */
+	mutex_lock(&dev_status_mem_mutex);
+	memset(dev_status_mem, 0, ZCRYPT_DEV_STATUS_EXT_SIZE);
+	device_status = (struct zcrypt_device_status_ext *)dev_status_mem;
 
+	/* fetch crypto device status into this struct */
 	rc = zcrypt_device_status_mask_ext(device_status,
-					   MAX_ZDEV_CARDIDS_EXT,
-					   MAX_ZDEV_DOMAINS_EXT);
+					   ZCRYPT_DEV_STATUS_CARD_MAX,
+					   ZCRYPT_DEV_STATUS_QUEUE_MAX);
 	if (rc)
 		goto out;
 
@@ -1944,7 +1960,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 	/* walk through all the crypto apqnss */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		/* check online state */
@@ -2006,7 +2022,9 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 out:
-	kvfree(device_status);
+	/* release the device status memory */
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(cca_findcard2);
@@ -2023,11 +2041,21 @@ int __init zcrypt_ccamisc_init(void)
 		cprb_mempool = NULL;
 		return -ENOMEM;
 	}
+
+	/* Pre-allocate one crypto status card struct used in findcard() */
+	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);
+	if (!dev_status_mem) {
+		ZCRYPT_DBF_ERR("%s allocation of dev_status_mem failed\n", __func__);
+		mempool_destroy(cprb_mempool);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 void zcrypt_ccamisc_exit(void)
 {
 	mkvp_cache_free();
+	kvfree(dev_status_mem);
 	mempool_destroy(cprb_mempool);
 }
-- 
2.43.0

