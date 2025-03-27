Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFA21858D
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086396; cv=none; b=mP7WQn52o4ng4RXD1dIVhpsnGB2YPfyNX9/PZRRdbNycL7vRMrcIKxfCZwqq9lWKQBCJk1bhxlwyzCfxb1nZwAXAwEN7GnavgdFGruRSISKzrQJmoVdgsO8ZBs57SxnTnViMtcWyNcuIyJCvoLgzjOujjRCX1cpq3ij+ZfFvoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086396; c=relaxed/simple;
	bh=3mu3PtVWODmxtuzaEYqLyWnnI3tzGlyLFeN4K3prLXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecN4H7JhIvbouq/9fWx5Nin73/ZGYSZ1A2+gPJJXHM48yuOHQcGuJCAEEBTHh7lN9KTaQx1acKD9AURuz5yYcYTi7ZZDJfB/qEnfrxcZQp6PmgYg7V/WcW0kUR7fXH6kITuWsGhvRAB+DkFPZ1QcRJbW4D6qJxM5cqXQ1xU8+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhmWZFwf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhmWZFwf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RE3DhE008093;
	Thu, 27 Mar 2025 14:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RWpxu2NI8wd8Mq/8E
	d1Nx2MGPgnpSGDdhU4jZ2OIZ2o=; b=MhmWZFwfOxnYz9RC3Rb9tPGDsSwqpJVnS
	WXUmDjO5fD4poqs8S8lU5dRdb+ojY9UAMfe2lpUM7TUYwRG9Omt90y2uwoLYT7kU
	5zdhNVmqbSN+ixcUOG+JUF6Ifl33o8LNh69OBUTdP4eC1dI+5YYk0a6cLpV81/10
	QIewzbimTsw0CgE1eXsSmSwDtTCEh/MCvXR5o96w4MfYrt4A1GtGMgk8l9tvZCUT
	jAzjVrZEsGBTBkQWDJANOjXehNq0PiHl5IWtB35HeJC7Xvu2CohKGziVswY7qFCR
	nSwX1eL3eGyNCOVspu3x4s7fj+Fg0/yjmNk0dKT2FWU1hmV2bc9gQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83p8789-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RAYeOs025443;
	Thu, 27 Mar 2025 14:39:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0dw93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdlhi39518550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23C7320040;
	Thu, 27 Mar 2025 14:39:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5D7B2004D;
	Thu, 27 Mar 2025 14:39:46 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:46 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 08/21] s390/zcrypt: Introduce pre-allocated device status array for cca misc
Date: Thu, 27 Mar 2025 15:39:28 +0100
Message-ID: <20250327143941.45507-9-freude@linux.ibm.com>
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
X-Proofpoint-GUID: SJZUANY6HNHzHFtgXUcadHH44b4ZaHbX
X-Proofpoint-ORIG-GUID: SJZUANY6HNHzHFtgXUcadHH44b4ZaHbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the findcard2()
function. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 49 ++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 2d7eda7648a2..c5857e68ec17 100644
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
@@ -1921,16 +1937,15 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
 	zcrypt_device_status_mask_ext(device_status,
-				      MAX_ZDEV_CARDIDS_EXT,
-				      MAX_ZDEV_DOMAINS_EXT);
+				      ZCRYPT_DEV_STATUS_CARD_MAX,
+				      ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
@@ -1940,7 +1955,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 	/* walk through all the crypto apqnss */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		/* check online state */
@@ -2002,7 +2017,9 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 out:
-	kvfree(device_status);
+	/* release the device status memory */
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(cca_findcard2);
@@ -2019,11 +2036,23 @@ int __init zcrypt_ccamisc_init(void)
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
+	mutex_lock(&dev_status_mem_mutex);
+	kvfree(dev_status_mem);
+	mutex_unlock(&dev_status_mem_mutex);
 	mempool_destroy(cprb_mempool);
 }
-- 
2.43.0

