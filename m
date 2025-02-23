Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80C204589
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304514; cv=none; b=AGdAA3CvfaobvCnoPRp3b4bvetrN7aJxqiM9cl7ON6w4qbmRkudicg8XC8jPxShYgnT704aGnjnYe7gN60hrq1edDxp7bb42E44RKX88n/S3M1jhOifPqouENkUfzW5+sYZN+I8t/lARo/16opjai1NYFUBP7WjNEuU6Tdsn5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304514; c=relaxed/simple;
	bh=wmvCS43tlyk4S7H23C7P6iigbxBckCJizeULgzFS3io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK/GiS2sWvShidMoXs/naOhVDEv42yxC4+V3Ra7xENYgPLRGmgg/aFoWN3rKY2/VRpgsS/RPzCUXgM8d2/uqBgKw99MPThLTFwVp5CJxVrhdW+PMGhinbXb0qYDBaNm3Qvo2JJcGJ49J39uPWrLnXux6+cpJ7WCteIGoiupPTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eI5i/+Go; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eI5i/+Go"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MMoQ9G003877;
	Sun, 23 Feb 2025 09:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0/n9URm9HPfU/jI6r
	cFewKjwQ2/l6bidvF+n7rtvNUU=; b=eI5i/+Go/g4Xye2tCzrEjCbXpID5Didnd
	qoKyu1ho1YmkadmQ2FueSAlLpOdPIDSOs7TiyhB0WgfvQ3Zxe6cg6TpuLWu2ypoo
	pBOL/P2Bjzw+rqKg8S7/yPURw4aozOhCd2nSQNvAFCJT/OwQkdCdPnY22tbKXXLe
	/UiTbDpkLjn717/X5RyktQEMyecWpDJ6YaNLgD19JYaJU8TvWbD5e5vsEgyj1rBh
	kCrN+b0PXuWUC18poTSOX4ItPxZZrPG9l8bEC7A84PNaF41SwA62Mj9VRhGNQpFD
	WNpqP/zr9CDKHW6nQbWzeiYr4EMUsRNd4AvWD2fypn/AA7X9M5lqw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yqqa1p88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N8mV6q012470;
	Sun, 23 Feb 2025 09:55:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsa0hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t5ul42140060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE7D20040;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 004A720049;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:04 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 13/20] s390/zcrypt: Add small mempool for cca info list entries
Date: Sun, 23 Feb 2025 10:54:52 +0100
Message-ID: <20250223095459.43058-14-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: KvnZalSTop-7runYxOrDnEyPKhv6p6Ok
X-Proofpoint-GUID: KvnZalSTop-7runYxOrDnEyPKhv6p6Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Add a small memory pool for (pre-)allocating cca info list
entries. These entries are rather small and the pool is a simple
way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 67 ++++++++++++++++++++--------
 drivers/s390/crypto/zcrypt_ccamisc.h |  3 +-
 drivers/s390/crypto/zcrypt_cex4.c    |  4 +-
 3 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index c1c255e45873..ccf8206ae42d 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -41,6 +41,10 @@ struct cca_info_list_entry {
 static LIST_HEAD(cca_info_list);
 static DEFINE_SPINLOCK(cca_info_list_lock);
 
+/* memory pool for cca_info_list entries */
+#define INFO_ENTRY_MEMPOOL_MIN_ITEMS 8
+static mempool_t *info_mempool;
+
 /*
  * Cprb memory pool held for urgend cases where no memory
  * can be allocated via kmalloc. This pool is only used
@@ -1661,7 +1665,7 @@ static int cca_info_cache_fetch(u16 cardnr, u16 domain, struct cca_info *ci)
 }
 
 static void cca_info_cache_update(u16 cardnr, u16 domain,
-				  const struct cca_info *ci)
+				  const struct cca_info *ci, u32 xflags)
 {
 	int found = 0;
 	struct cca_info_list_entry *ptr;
@@ -1676,7 +1680,9 @@ static void cca_info_cache_update(u16 cardnr, u16 domain,
 		}
 	}
 	if (!found) {
-		ptr = kmalloc(sizeof(*ptr), GFP_ATOMIC);
+		ptr = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+			mempool_alloc_preallocated(info_mempool) :
+			mempool_alloc(info_mempool, GFP_ATOMIC);
 		if (!ptr) {
 			spin_unlock_bh(&cca_info_list_lock);
 			return;
@@ -1698,7 +1704,7 @@ static void cca_info_cache_scrub(u16 cardnr, u16 domain)
 		if (ptr->cardnr == cardnr &&
 		    ptr->domain == domain) {
 			list_del(&ptr->list);
-			kfree(ptr);
+			mempool_free(ptr, info_mempool);
 			break;
 		}
 	}
@@ -1712,7 +1718,7 @@ static void __exit mkvp_cache_free(void)
 	spin_lock_bh(&cca_info_list_lock);
 	list_for_each_entry_safe(ptr, pnext, &cca_info_list, list) {
 		list_del(&ptr->list);
-		kfree(ptr);
+		mempool_free(ptr, info_mempool);
 	}
 	spin_unlock_bh(&cca_info_list_lock);
 }
@@ -1720,14 +1726,14 @@ static void __exit mkvp_cache_free(void)
 /*
  * Fetch cca_info values via query_crypto_facility from adapter.
  */
-static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
+static int fetch_cca_info(u16 cardnr, u16 domain,
+			  struct cca_info *ci, u32 xflags)
 {
 	void *mem;
 	int rc, found = 0;
 	size_t rlen, vlen;
 	u8 *rarray, *varray;
 	struct zcrypt_device_status_ext devstat;
-	u32 xflags = 0;
 
 	memset(ci, 0, sizeof(*ci));
 
@@ -1801,15 +1807,15 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 /*
  * Fetch cca information about a CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify, u32 xflags)
 {
 	int rc;
 
 	rc = cca_info_cache_fetch(card, dom, ci);
 	if (rc || verify) {
-		rc = fetch_cca_info(card, dom, ci);
+		rc = fetch_cca_info(card, dom, ci, xflags);
 		if (rc == 0)
-			cca_info_cache_update(card, dom, ci);
+			cca_info_cache_update(card, dom, ci, xflags);
 	}
 
 	return rc;
@@ -1827,6 +1833,7 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 	u16 card, dom;
 	struct cca_info ci;
 	int i, rc, oi = -1;
+	u32 xflg = 0; /* xflags */
 
 	/* mkvp must not be zero, minhwtype needs to be >= 0 */
 	if (mkvp == 0 || minhwtype < 0)
@@ -1856,8 +1863,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 				if (!verify)
 					break;
 				/* verify: refresh card info */
-				if (fetch_cca_info(card, dom, &ci) == 0) {
-					cca_info_cache_update(card, dom, &ci);
+				if (fetch_cca_info(card, dom, &ci, xflg) == 0) {
+					cca_info_cache_update(card, dom, &ci, xflg);
 					if (ci.hwtype >= minhwtype &&
 					    ci.cur_aes_mk_state == '2' &&
 					    ci.cur_aes_mkvp == mkvp)
@@ -1879,8 +1886,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 			card = AP_QID_CARD(device_status[i].qid);
 			dom = AP_QID_QUEUE(device_status[i].qid);
 			/* fresh fetch mkvp from adapter */
-			if (fetch_cca_info(card, dom, &ci) == 0) {
-				cca_info_cache_update(card, dom, &ci);
+			if (fetch_cca_info(card, dom, &ci, xflg) == 0) {
+				cca_info_cache_update(card, dom, &ci, xflg);
 				if (ci.hwtype >= minhwtype &&
 				    ci.cur_aes_mk_state == '2' &&
 				    ci.cur_aes_mkvp == mkvp)
@@ -1951,6 +1958,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 	u32 _nr_apqns = 0;
+	u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1979,7 +1987,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		if (domain != 0xFFFF && dom != domain)
 			continue;
 		/* get cca info on this apqn */
-		if (cca_get_info(card, dom, &ci, verify))
+		if (cca_get_info(card, dom, &ci, verify, xflags))
 			continue;
 		/* current master key needs to be valid */
 		if (mktype == AES_MK_SET && ci.cur_aes_mk_state != '2')
@@ -2030,6 +2038,8 @@ EXPORT_SYMBOL(cca_findcard2);
 
 int __init zcrypt_ccamisc_init(void)
 {
+	int rc = -ENOMEM;
+
 	/* Pre-allocate a small memory pool for cca cprbs. */
 	cprb_mempool = mempool_create_kmalloc_pool(CPRB_MEMPOOL_MIN_ITEMS,
 						   CPRB_MEMPOOL_ITEM_SIZE);
@@ -2037,19 +2047,39 @@ int __init zcrypt_ccamisc_init(void)
 		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
 			       __func__, CPRB_MEMPOOL_MIN_ITEMS,
 			       CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
+		rc = PTR_ERR(cprb_mempool);
 		cprb_mempool = NULL;
-		return -ENOMEM;
+		goto out;
+	}
+
+	/* Pre-allocate a small memory pool for cca info list entries */
+	info_mempool = mempool_create_kmalloc_pool(INFO_ENTRY_MEMPOOL_MIN_ITEMS,
+						   sizeof(struct cca_info_list_entry));
+	if (IS_ERR(info_mempool)) {
+		ZCRYPT_DBF_ERR("%s info entry mempool_create(%d,%d) failed: %ld\n",
+			       __func__, INFO_ENTRY_MEMPOOL_MIN_ITEMS,
+			       (int)sizeof(struct cca_info_list_entry),
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
 
 void zcrypt_ccamisc_exit(void)
@@ -2057,4 +2087,5 @@ void zcrypt_ccamisc_exit(void)
 	mkvp_cache_free();
 	kvfree(dev_status_mem);
 	mempool_destroy(cprb_mempool);
+	mempool_destroy(info_mempool);
 }
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index bed647a42eb2..966f0eaf3c4c 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -268,7 +268,8 @@ struct cca_info {
 /*
  * Fetch cca information about an CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify);
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci,
+		 int verify, u32 xflags);
 
 int zcrypt_ccamisc_init(void);
 void zcrypt_ccamisc_exit(void);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 64df7d2f6266..49a638d373fa 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -86,7 +86,7 @@ static ssize_t cca_serialnr_show(struct device *dev,
 	memset(&ci, 0, sizeof(ci));
 
 	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, zc->online);
+		cca_get_info(ac->id, ap_domain_index, &ci, zc->online, 0);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }
@@ -120,7 +120,7 @@ static ssize_t cca_mkvps_show(struct device *dev,
 
 	cca_get_info(AP_QID_CARD(zq->queue->qid),
 		     AP_QID_QUEUE(zq->queue->qid),
-		     &ci, zq->online);
+		     &ci, zq->online, 0);
 
 	if (ci.new_aes_mk_state >= '1' && ci.new_aes_mk_state <= '3')
 		n += sysfs_emit_at(buf, n, "AES NEW: %s 0x%016llx\n",
-- 
2.43.0

