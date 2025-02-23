Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0233201269
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304515; cv=none; b=cFH/tZImzACzU171NiymitZ3RPs/w5flYQ8H3miDGaoOoVofqMp0t4k4zJt4PNg0ow+ALvByy5hwmuxqz6zWVrBioZ/6MIHLfnrT2T8rkzgE//YmNmvytNT33DSmtC62xX9q9z2VsYtWlRXlmo8GL3PfXsAJ3WlZv2H21+IGb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304515; c=relaxed/simple;
	bh=XVzO/5XnhELh/edgKsaIeMeoGfQK51FqaFLvZHKp9wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnJxCwf7KBmHCEIY4XtAexJuBC2jzplvNnDDyD5JTyMPFK8EQuOuX3PNjJpD29djOhIqsi1SkJm+yDTn8DZ3w05cnfoq6iWpBs2nh1RQxLEp4PPaCOUpGKWQlNzJBIMvANkTX57v307VIyNoqiwYdxiqMIyGMd+nh3BvzKKbHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kvX50mcu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kvX50mcu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N5WcHW013943;
	Sun, 23 Feb 2025 09:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D22o6qL8INNkrM3el
	0RJ0UEdphvSBpjwrjDAl350r5s=; b=kvX50mcuhDhmr5C5gq1fK0rOOucm+VJ1p
	Rux0GdVThAVphTJfAT4qUqmhM3kU/xRx1ahbLrdQ27OLcWiaD3tRiqgp/OD6CxYI
	MidbpcDopnFFKMHhKUpDNS09EBR+LdUj8khmF3DJ0AKKyAeAOKTSFtKuRG2s3rGi
	O64IZOKgJMAq4Buqj5yPFG2EaadnpDGAN0/GiDXrRTyXeXBUu/VDYaPWXmmyrJmh
	/2V8nsXw/s6eThtm8knxs7IfKPZNUAkIoYP56ucJDV2F3RjxkEBqBoWi+TBGv28s
	JDzV4Sx6MDpCFOadttCPNMshBi25t2wXOUfkMwtfztUOeORkcKfQw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yth016e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6Strb027487;
	Sun, 23 Feb 2025 09:55:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk1kyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t6lH57082154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8506F20040;
	Sun, 23 Feb 2025 09:55:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43E662004B;
	Sun, 23 Feb 2025 09:55:06 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 16/20] s390/zcrypt: Add small mempool for ep11 card info list entries
Date: Sun, 23 Feb 2025 10:54:55 +0100
Message-ID: <20250223095459.43058-17-freude@linux.ibm.com>
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
X-Proofpoint-GUID: D6eHeyZts1kVkIkyMsSKerIkZBHxIVz6
X-Proofpoint-ORIG-GUID: D6eHeyZts1kVkIkyMsSKerIkZBHxIVz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502230073

Add a small memory pool for (pre-)allocating ep11 card info list
entries. These entries are rather small and the pool is a simple
way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 48 ++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 467449adb5ae..a6ac0cac0c45 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -65,6 +65,10 @@ struct card_list_entry {
 static LIST_HEAD(card_list);
 static DEFINE_SPINLOCK(card_list_lock);
 
+/* memory pool for card_list_entry entries */
+#define INFO_ENTRY_MEMPOOL_MIN_ITEMS 4
+static mempool_t *info_mempool;
+
 static int card_cache_fetch(u16 cardnr, struct ep11_card_info *ci)
 {
 	int rc = -ENOENT;
@@ -83,7 +87,8 @@ static int card_cache_fetch(u16 cardnr, struct ep11_card_info *ci)
 	return rc;
 }
 
-static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci)
+static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci,
+			      u32 xflags)
 {
 	int found = 0;
 	struct card_list_entry *ptr;
@@ -97,7 +102,9 @@ static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci)
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
@@ -117,7 +124,7 @@ static void card_cache_scrub(u16 cardnr)
 	list_for_each_entry(ptr, &card_list, list) {
 		if (ptr->cardnr == cardnr) {
 			list_del(&ptr->list);
-			kfree(ptr);
+			mempool_free(ptr, info_mempool);
 			break;
 		}
 	}
@@ -131,7 +138,7 @@ static void __exit card_cache_free(void)
 	spin_lock_bh(&card_list_lock);
 	list_for_each_entry_safe(ptr, pnext, &card_list, list) {
 		list_del(&ptr->list);
-		kfree(ptr);
+		mempool_free(ptr, info_mempool);
 	}
 	spin_unlock_bh(&card_list_lock);
 }
@@ -773,7 +780,7 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info,
 			(pmqi->FW_major_vers << 8) + pmqi->FW_minor_vers;
 		memcpy(info->serial, pmqi->serial, sizeof(info->serial));
 		info->op_mode = pmqi->op_mode;
-		card_cache_update(card, info);
+		card_cache_update(card, info, xflags);
 	}
 
 out:
@@ -1711,6 +1718,8 @@ EXPORT_SYMBOL(ep11_findcard2);
 
 int __init zcrypt_ep11misc_init(void)
 {
+	int rc = -ENOMEM;
+
 	/* Pre-allocate a small memory pool for ep11 cprbs. */
 	cprb_mempool = mempool_create_kmalloc_pool(CPRB_MEMPOOL_MIN_ITEMS,
 						   CPRB_MEMPOOL_ITEM_SIZE);
@@ -1718,19 +1727,39 @@ int __init zcrypt_ep11misc_init(void)
 		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
 			       __func__, CPRB_MEMPOOL_MIN_ITEMS,
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
 	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT2_SIZE, GFP_KERNEL);
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
@@ -1738,4 +1767,5 @@ void zcrypt_ep11misc_exit(void)
 	card_cache_free();
 	kvfree(dev_status_mem);
 	mempool_destroy(cprb_mempool);
+	mempool_destroy(info_mempool);
 }
-- 
2.43.0

