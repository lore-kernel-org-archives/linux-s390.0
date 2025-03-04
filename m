Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7E2D4B5D
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108894; cv=none; b=SeK1t9RgfknDtdLdJ0QBJhTvWQSCLkhACOuxbLr9e/QuyWG5JaumrXx0p6OEbgEVNxC+AGR76hyKxf0xKvtsXu2rOnwRrPduT1h8wykKNC80eqz1Oq1wYuC0L1ClcGNU+3bD2ucLCL3vIsQQsVBqdT0d82drIVLL1HcuyG1l/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108894; c=relaxed/simple;
	bh=00loAwqQ+kjZS1ikDil9HXnHwaMOEYLySFQRBbekV/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj2gSWIF9W4f9N4OozFBq6WThHUhvRkevSaLlcxm3JZd0ikYiR8Dqc2YcK6f93YGY2VG2ooAEDID7HZ+yP4ZjFoI8ijgBbpJLsANyIhAd+4ME6BrdvKlVOBR7snJ0J2J0ZRI0zz/lDPHYuOLgO1COm3DyPgkMnTqpmVSQpuNNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ha0PK2PE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ha0PK2PE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524A7IMA023526;
	Tue, 4 Mar 2025 17:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uUZE/gLUZWxWme+Q8
	gptTpex6jZBPL7CkWQatPESqts=; b=Ha0PK2PEkzyiIl0NOtguFBMEdYwod/EeZ
	24vPSO9G11jbNviX5DciPcC6+HdKLpJ+Ye2HDnPfJkHp7MhTip3nSAx/PjCB5ng0
	pysbIw+xUOcXc4CMJ1NW/uJt+nRJHHiobqq8VESjCAZi2bv8ONr8TIm4MgLEJriU
	OFeFGBkzHFRwjHFfKaono8KISL9riXoQZwkF+EG6dP2CVOMBjPG7V4ERfJNZp+OQ
	NSFQwT8WZ+qeDkRpObeqHjtV/DIhjYX+23t+ad2tHcmLT1gMRkEcqiEZbmcGoPts
	PHTYOKBxolCgSSsNyqrpG4OmW9GRtxVDZW5LWVPLa/NCfGbTA12ew==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku559tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524GaDVV020873;
	Tue, 4 Mar 2025 17:21:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjx795-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLPID48496970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B8ED20040;
	Tue,  4 Mar 2025 17:21:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1240520043;
	Tue,  4 Mar 2025 17:21:25 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 16/20] s390/zcrypt: Add small mempool for ep11 card info list entries
Date: Tue,  4 Mar 2025 18:21:12 +0100
Message-ID: <20250304172116.85374-17-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: N7STNozzrrY9C4ti8sRUvnq4MtduOkZV
X-Proofpoint-GUID: N7STNozzrrY9C4ti8sRUvnq4MtduOkZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Add a small memory pool for (pre-)allocating ep11 card info list
entries. These entries are rather small and the pool is a simple
way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 48 ++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index af59d66bff33..a9a6fdc32464 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -64,6 +64,10 @@ struct card_list_entry {
 static LIST_HEAD(card_list);
 static DEFINE_SPINLOCK(card_list_lock);
 
+/* memory pool for card_list_entry entries */
+#define INFO_ENTRY_MEMPOOL_MIN_ITEMS 4
+static mempool_t *info_mempool;
+
 static int card_cache_fetch(u16 cardnr, struct ep11_card_info *ci)
 {
 	int rc = -ENOENT;
@@ -82,7 +86,8 @@ static int card_cache_fetch(u16 cardnr, struct ep11_card_info *ci)
 	return rc;
 }
 
-static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci)
+static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci,
+			      u32 xflags)
 {
 	int found = 0;
 	struct card_list_entry *ptr;
@@ -96,7 +101,9 @@ static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci)
 		}
 	}
 	if (!found) {
-		ptr = kmalloc(sizeof(*ptr), GFP_ATOMIC);
+		ptr = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+			mempool_alloc_preallocated(info_mempool) :
+			mempool_alloc(info_mempool, GFP_ATOMIC);
 		if (!ptr) {
 			spin_unlock_bh(&card_list_lock);
 			return;
@@ -116,7 +123,7 @@ static void card_cache_scrub(u16 cardnr)
 	list_for_each_entry(ptr, &card_list, list) {
 		if (ptr->cardnr == cardnr) {
 			list_del(&ptr->list);
-			kfree(ptr);
+			mempool_free(ptr, info_mempool);
 			break;
 		}
 	}
@@ -130,7 +137,7 @@ static void __exit card_cache_free(void)
 	spin_lock_bh(&card_list_lock);
 	list_for_each_entry_safe(ptr, pnext, &card_list, list) {
 		list_del(&ptr->list);
-		kfree(ptr);
+		mempool_free(ptr, info_mempool);
 	}
 	spin_unlock_bh(&card_list_lock);
 }
@@ -772,7 +779,7 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info,
 			(pmqi->FW_major_vers << 8) + pmqi->FW_minor_vers;
 		memcpy(info->serial, pmqi->serial, sizeof(info->serial));
 		info->op_mode = pmqi->op_mode;
-		card_cache_update(card, info);
+		card_cache_update(card, info, xflags);
 	}
 
 out:
@@ -1713,6 +1720,8 @@ EXPORT_SYMBOL(ep11_findcard2);
 
 int __init zcrypt_ep11misc_init(void)
 {
+	int rc = -ENOMEM;
+
 	/* Pre-allocate a small memory pool for ep11 cprbs. */
 	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_ep11_cprbpool_min_items,
 						   CPRB_MEMPOOL_ITEM_SIZE);
@@ -1720,19 +1729,39 @@ int __init zcrypt_ep11misc_init(void)
 		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
 			       __func__, zcrypt_ep11_cprbpool_min_items,
 			       CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
+		rc = PTR_ERR(cprb_mempool);
 		cprb_mempool = NULL;
-		return -ENOMEM;
+		goto out;
+	}
+
+	/* Pre-allocate a very small memory pool for card info entries */
+	info_mempool = mempool_create_kmalloc_pool(INFO_ENTRY_MEMPOOL_MIN_ITEMS,
+						   sizeof(struct card_list_entry));
+	if (IS_ERR(info_mempool)) {
+		ZCRYPT_DBF_ERR("%s card info entry mempool_create(%d,%d) failed: %ld\n",
+			       __func__, INFO_ENTRY_MEMPOOL_MIN_ITEMS,
+			       (int)sizeof(struct card_list_entry),
+			       PTR_ERR(info_mempool));
+		rc = PTR_ERR(info_mempool);
+		info_mempool = NULL;
+		goto out;
 	}
 
 	/* Pre-allocate one crypto status card struct used in findcard() */
 	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);
 	if (!dev_status_mem) {
 		ZCRYPT_DBF_ERR("%s allocation of dev_status_mem failed\n", __func__);
-		mempool_destroy(cprb_mempool);
-		return -ENOMEM;
+		goto out;
 	}
 
-	return 0;
+	rc = 0;
+
+out:
+	if (rc) {
+		mempool_destroy(cprb_mempool);
+		mempool_destroy(info_mempool);
+	}
+	return rc;
 }
 
 void zcrypt_ep11misc_exit(void)
@@ -1740,4 +1769,5 @@ void zcrypt_ep11misc_exit(void)
 	card_cache_free();
 	kvfree(dev_status_mem);
 	mempool_destroy(cprb_mempool);
+	mempool_destroy(info_mempool);
 }
-- 
2.43.0

