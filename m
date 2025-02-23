Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7F20371A
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304512; cv=none; b=DfR49LjC0sCUZ92t65GoxRMLPuulUOHUWarC/oYrlES+8RRLeSqTvLJoAvcMGDWqvTCM9F7gwezZDAjPa9sRHUylZi3CAqWeGEz99csElZee0lWqYxsgJ357u5CahLisdFalhCxL+Bd4ELg844zrFazI4lIe1ixVJR3qTFOrlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304512; c=relaxed/simple;
	bh=mI5f/wEj+Q9Wfh6ESYSgUPFaK7/F/4nrgUgWZu4FMb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEENUR52+iGy/ceMK5cpzRP83ECBRXRNKpljreSpeUlEvWiCguq5Ec498Z+uFi1K3RHkOvt0rfXSdYrksLIV9x0K0i+fs07juoYtAt9+wDaLYSDeDh5WHdnY8h2H/qyczYo+ydDhoD/SCVSUJpMAMHFUpyf0Tl3jOlof3GXtgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJ4x+3TL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJ4x+3TL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N5qaIU029310;
	Sun, 23 Feb 2025 09:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7+sismb3DCtKmfT+H
	UF6SH9RNWCBy/UkXhTXXx5jPX0=; b=nJ4x+3TL2NMSlJZJZkwd6iBkNUoiYsYBn
	OSrKNvUKYMag/sU/jYe4zrsVswWyFCN5g7jFFviPV+CxNn2qvRmkaYEzN9NSVKIs
	MotSfHUkwprjI4Lwa2CVjoXidHx1FaHuf++dEaGm4jAhOFuYedfIDVptCob9a4y2
	Idt4k6WBHJOz790g3lUjFLkAx6P0XEVLRaHSq57OSLX2LgwhXIjpiELbhBezkw2o
	+Rqq3JwhJW6KamwGsN6E4kEDIw6raEOOe9iBtXaq4trOYc3lWC9g2xxIvma84+7k
	0zC07iTw90wccnsnr/JNMzuW+91OxDpU/id/6ckkV+yzB1RQWwBUQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ywg7rqb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6MQ6e027390;
	Sun, 23 Feb 2025 09:55:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk1kyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t3tG13173186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5624220049;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0951120040;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 08/20] s390/zcrypt: Introduce pre-allocated device status array for cca misc
Date: Sun, 23 Feb 2025 10:54:47 +0100
Message-ID: <20250223095459.43058-9-freude@linux.ibm.com>
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
X-Proofpoint-GUID: hB4a3o5SUwFRxsPybhXZ3ZSkjlZGnJ6O
X-Proofpoint-ORIG-GUID: hB4a3o5SUwFRxsPybhXZ3ZSkjlZGnJ6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502230073

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the two findcard()
functions. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 89 +++++++++++++++++++---------
 1 file changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index e604a69e40fc..71cad7cf8656 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -52,6 +52,22 @@ static DEFINE_SPINLOCK(cca_info_list_lock);
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
+#define ZCRYPT_DEV_STATUS_EXT2_SIZE (ZCRYPT_DEV_STATUS_ENTRIES * \
+		sizeof(struct zcrypt_device_status_ext))
+static void *dev_status_mem;
+static DEFINE_MUTEX(dev_status_mem_mutex);
+
 /*
  * Simple check if the token is a valid CCA secure AES data key
  * token. If keybitsize is given, the bitsize of the key is
@@ -1800,16 +1816,18 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 	if (mkvp == 0 || minhwtype < 0)
 		return -EINVAL;
 
-	/* fetch status of all crypto cards */
-	device_status = kvcalloc(MAX_ZDEV_ENTRIES_EXT,
-				 sizeof(struct zcrypt_device_status_ext),
-				 GFP_KERNEL);
-	if (!device_status)
-		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+	/* occupy the device status memory */
+	mutex_lock(&dev_status_mem_mutex);
+	memset(dev_status_mem, 0, ZCRYPT_DEV_STATUS_EXT2_SIZE);
+	device_status = (struct zcrypt_device_status_ext *)dev_status_mem;
+
+	/* fetch crypto device status into this struct */
+	zcrypt_device_status_mask_ext2(device_status,
+				       ZCRYPT_DEV_STATUS_CARD_MAX,
+				       ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
 	/* walk through all crypto cards */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		if (device_status[i].online &&
@@ -1836,9 +1854,9 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
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
@@ -1858,23 +1876,25 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
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
 
-	kvfree(device_status);
+	/* release the device status memory */
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 
@@ -1913,26 +1933,26 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, curmatch, oldmatch, rc = 0;
+	int i, card, dom, curmatch, oldmatch, rc = -ENOMEM;
 	struct cca_info ci;
 
-	/* fetch status of all crypto cards */
-	device_status = kvcalloc(MAX_ZDEV_ENTRIES_EXT,
-				 sizeof(struct zcrypt_device_status_ext),
-				 GFP_KERNEL);
-	if (!device_status)
-		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+	/* occupy the device status memory */
+	mutex_lock(&dev_status_mem_mutex);
+	memset(dev_status_mem, 0, ZCRYPT_DEV_STATUS_EXT2_SIZE);
+	device_status = (struct zcrypt_device_status_ext *)dev_status_mem;
+
+	/* fetch crypto device status into this struct */
+	zcrypt_device_status_mask_ext2(device_status,
+				       ZCRYPT_DEV_STATUS_CARD_MAX,
+				       ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
-	if (!_apqns) {
-		kvfree(device_status);
-		return -ENOMEM;
-	}
+	if (!_apqns)
+		goto out;
 
 	/* walk through all the crypto apqnss */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		/* check online state */
@@ -1993,7 +2013,10 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
-	kvfree(device_status);
+out:
+	/* release the device status memory */
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(cca_findcard2);
@@ -2010,11 +2033,21 @@ int __init zcrypt_ccamisc_init(void)
 		cprb_mempool = NULL;
 		return -ENOMEM;
 	}
+
+	/* Pre-allocate one crypto status card struct used in findcard() */
+	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT2_SIZE, GFP_KERNEL);
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

