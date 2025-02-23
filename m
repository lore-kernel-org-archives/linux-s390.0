Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48420371B
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304512; cv=none; b=hHMOOuMWOByrBh4LQ1HD9IP2SiidmWWJj+g4hKR0V8hnY7Ck7cz3qxWIM1j3Am9SKyo/nbbG5evKugKYGGH0qa5caMv7voRThtkEBfUBluIyh0QgkKQTBepon52zvWESkjKoi5/cJ1uvhCnqJJaIoaVqMejypBMmlyUOBzSItIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304512; c=relaxed/simple;
	bh=2WbNipmrx5HF5c2FlciA0sr+yZ7BPl50TBgM4DcM68g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlwH+MXeklWYeOrbQmGJbFs8GBMsdfQWG7QpYfWg+Us2gC+IrTkfPhudeLeWV5jZ2VWMV04rOOnGgiQLx2ADvBYDQeoNDBupbvff95WmMS06U5Kdui8RBUUVf8A/SNPJJG0igJiqvlLba9Uw7DMHjpSIK2FW+3uALFfpiIzeyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AtCdbfwh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AtCdbfwh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N9qWrS009100;
	Sun, 23 Feb 2025 09:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7gExNU9h9xWR5az3e
	0/rhwBActGZSU15lr99NUV8gMc=; b=AtCdbfwhhC26W8bnurbfpum/4IYQHg/if
	i6arq+/+v0k28o8Xz+EJoPvv1di/12MzGMYM3jr8RCAuwWoQnA/fN4HVNu5t6MNh
	enhI1hwUzafY8dWq3uPHeLOyY0Js/2VrpwTlWgHHniUn/uub8uiensEg2SkJExnO
	rp1y++2uI9LuI4dyR03T6GINjWmz42Gy9pf/2Po4ROL5Yz0KzFc5tiRTAYKJH3Dn
	0bL6RSdtp67sBuLA10PyOahuLGDYM6Hv1MafDh6zEsN9kWUJMq8g5m6t/T7vRD/K
	nG06tB7eAyg88HK4nFo7GXLBDccmMAwjqmlxkFYK6uwxHnEd22RdQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gjfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N78DNQ002545;
	Sun, 23 Feb 2025 09:55:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4j9ecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t3gb20119964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B848020040;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 688B32004B;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 09/20] s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
Date: Sun, 23 Feb 2025 10:54:48 +0100
Message-ID: <20250223095459.43058-10-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ud6xyBH9vNDWUfs_SLOqplul8H789zGU
X-Proofpoint-GUID: Ud6xyBH9vNDWUfs_SLOqplul8H789zGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the findcard()
function. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 54 ++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 3d96bd236c16..e9a705329ff8 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -40,6 +40,22 @@ static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
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
+#define ZCRYPT_DEV_STATUS_EXT2_SIZE (ZCRYPT_DEV_STATUS_ENTRIES * \
+		sizeof(struct zcrypt_device_status_ext))
+static void *dev_status_mem;
+static DEFINE_MUTEX(dev_status_mem_mutex);
+
 /* ep11 card info cache */
 struct card_list_entry {
 	struct list_head list;
@@ -1608,23 +1624,23 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 
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
@@ -1674,7 +1690,9 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
-	kvfree(device_status);
+out:
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(ep11_findcard2);
@@ -1691,11 +1709,21 @@ int __init zcrypt_ep11misc_init(void)
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
 
 void zcrypt_ep11misc_exit(void)
 {
 	card_cache_free();
+	kvfree(dev_status_mem);
 	mempool_destroy(cprb_mempool);
 }
-- 
2.43.0

