Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5E26562A
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207401; cv=none; b=aT5smDAm9mktP3pjNJfLyJTBu7GIobtK+zG1oM0B1fjJ3P0qRfdX2hXSx77eJiRrUn4KZThNq3gkvcE1YfdY31tm8IwSxVEZDRVBnqz16hhwiNYG0YG03CCskDDtGfrAQMdQZPg7mYnuzvpTqn+8HBjiQNJ42FFqNYGwYB8GkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207401; c=relaxed/simple;
	bh=rmxx5OUCKc/d0afpl3zidbbuqH5M4s0PgP/oT/jmVs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=re5AOrZjPPjFxrIGIXED1lp0/pn5xBv3BkCaM+6m4ukVCdFMmJwuPxiOPshMIZ8xz9pZx23gjR0VswO5vo12Twltsz5U5j6cfovd/UVDZ0RS/X2zVpoLsyESJzEu/mzbmr/HQakxlhxsivfF53DbdRUnFPGosAJRJ87pG2iThJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JyP8LUO2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JyP8LUO2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539DGpYw003736;
	Wed, 9 Apr 2025 14:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d/E8S+EPiA2Ybgvr8
	4pHEFngC0F+juQOQOqjv1814Ns=; b=JyP8LUO2ivJyj7W17JyEcbAhU3kZeyjRD
	fWgiSh24pu16pAPO2nNvYysgFwwF2elLvR+P1GCxERRJcngvheIYWw+9rBLROhnu
	59faQLvSx81doYb4Jk1GQPJjxffCiQ6HHCp415Vdqg2CecGm3klbaxlhjQcC/9Z8
	HsLKeQ7htZdezv/Nql2Ke9C2lmJ9eG4DnrCYPeZ+JIgkstBacqmvA26UtCumbYAa
	Sjyj4eP5tGFLib5Ct9BqWCdQn3SgK7GBbmVmIPqg9saX4joMGsFG2//7jhwd5kZ0
	6GOu3GZGDfCrH/8vK/vi1boy1zxE7reY/UDIVcd2kQTM2YBaqyHyA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w7yxd073-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539Cgw7c011326;
	Wed, 9 Apr 2025 14:03:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yr5h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3Cw529557474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C62320071;
	Wed,  9 Apr 2025 14:03:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECDB620043;
	Wed,  9 Apr 2025 14:03:11 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:11 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 09/24] s390/zcrypt: Introduce pre-allocated device status array for cca misc
Date: Wed,  9 Apr 2025 16:02:50 +0200
Message-ID: <20250409140305.58900-10-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gWRFS5eWB7MpB7LUW2ePOY6uwlJoClK0
X-Proofpoint-GUID: gWRFS5eWB7MpB7LUW2ePOY6uwlJoClK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the findcard2()
function. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 49 ++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 0d3bf6b1fcb4..f2af3cb7a917 100644
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
@@ -2018,11 +2035,23 @@ int __init zcrypt_ccamisc_init(void)
 				CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
 		return -ENOMEM;
 	}
+
+	/* Pre-allocate one crypto status card struct used in findcard() */
+	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);
+	if (!dev_status_mem) {
+		ZCRYPT_DBF_WARN("%s allocation of dev_status_mem failed\n", __func__);
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

