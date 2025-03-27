Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A5218589
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086397; cv=none; b=eJJ/jwlNAXOoSx+NfLa2gq7q8DhlLWJyPHJbXXFitb3jODpizmZV18cVLpvVnsdRxC61cWgKo289HAcPTg9M7NnjYjScvqu+cUytQgmVklHmaM8wKkJ6VMUlmyy7CboUIo7/Gb/Qo3p+stOzo9MtjiQBLSiaqlwMoGx9MgfB9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086397; c=relaxed/simple;
	bh=lUNE4TNTFUPpDuN96fWQtIrypQSUgO/Sm1JE7qKD3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9Twc8jL4+NcKoo14DhGedyOitK+cU+vDofmEOmfUbLqM/KpMTknWcUl3x5NAapMMMgdcX5lRdkzXr4DQtD2+7KH6E62mK+5m9NxbKg+s9lDVVn669KLrK6z6AOVohFLOlpxGUvlZpY8cJjUX7UHaY892vxxbbRGqAfFETsk/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EiHyzPb4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EiHyzPb4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBrio7029684;
	Thu, 27 Mar 2025 14:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KRR8jIiqqUvsl/XNI
	zFo+2JOc0bL2xCynMkPkbwsPTg=; b=EiHyzPb4YJuW/KZg6waNPaj+gVIaaXUHO
	uhCFto2vQ4NG0jNxE5iTy26gPaQPnQWG4BXyYmNZDkqkTXvR8Na2fXf784mbXime
	r4xelANL2jiMLmsxM+I8uah559BJoGk2nsP6261hGv4UvifDjx7Ep92LWTSIYIiD
	KHnEerJXg7pJFXzJLBxgZe2YnjUo9672VDbIyogoIgLC3GBcTFdIK7yXki6j9gq6
	d6uwydE5MrTzRackWFd0upYBszu//DKPs5vfCGZWGWTfjEv3WHORvLTabX6NLOiq
	4ztZzlabieMZcYY/p1GlFouYeRu6F4LI7dJ1Y9Fp/xYQcTRgGScvA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29b5wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDAD4k005782;
	Thu, 27 Mar 2025 14:39:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82nfba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdl8339518552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E1F20040;
	Thu, 27 Mar 2025 14:39:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B0220043;
	Thu, 27 Mar 2025 14:39:47 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:47 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 09/21] s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
Date: Thu, 27 Mar 2025 15:39:29 +0100
Message-ID: <20250327143941.45507-10-freude@linux.ibm.com>
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
X-Proofpoint-GUID: SZi9I1MzS12HWy6HbkV8nlbaqHFJyqGE
X-Proofpoint-ORIG-GUID: SZi9I1MzS12HWy6HbkV8nlbaqHFJyqGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the findcard()
function. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 48 +++++++++++++++++++++------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 504064c27a8b..0ff6514b9b0b 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -39,6 +39,22 @@ static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
 #define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
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
 /* ep11 card info cache */
 struct card_list_entry {
 	struct list_head list;
@@ -1603,16 +1619,15 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 
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
@@ -1622,7 +1637,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 	/* walk through all the crypto apqnss */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		/* check online state */
@@ -1673,7 +1688,8 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 out:
-	kvfree(device_status);
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(ep11_findcard2);
@@ -1690,11 +1706,23 @@ int __init zcrypt_ep11misc_init(void)
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
 
 void zcrypt_ep11misc_exit(void)
 {
 	card_cache_free();
+	mutex_lock(&dev_status_mem_mutex);
+	kvfree(dev_status_mem);
+	mutex_unlock(&dev_status_mem_mutex);
 	mempool_destroy(cprb_mempool);
 }
-- 
2.43.0

