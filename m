Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6752D4B54
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108893; cv=none; b=Bhy98Lfa4F68hGhnesI0dGSEUGvFsyAzWpnZ52lN87XlW0rIjkMmXqQCS+BqoBNS9c/3qMbJvKhIJbSHAtXAx7Ku39XA6KVZe3wpMaQ8OhbhXyqTr6klshwVhPVZyv3umIoV2yx+CdwGm9GRbJkA5BQjTNgH5COFXh2Bs8RTSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108893; c=relaxed/simple;
	bh=1xbcXoag+Av77J4Glycuk7rDSXEdIRBpQ2wFSf5/6H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFhfZOOzGvG2K4U+oRArTyiWYjdbqR9NocR4/02u+1FPvCNzhfrnVzZX2GLUBuWfxC7gjgnhtUw+ARiHfh25n066cdT3Uu+GJ9SfRFUIDEnMg3i6cd1tMUpGDJd+usNpfH8rinPE3oB3Nex+iO4SgHwOWl4iEhLY5ixwJ5ZSe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UoUaMwgh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UoUaMwgh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524GEPPa023631;
	Tue, 4 Mar 2025 17:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FiOUyV6Pa0h1g6NNR
	S0JbjZ9diRhI/S2E/TwYRA4NvE=; b=UoUaMwghL85JZON9cPH7a7k0nVhaakrFY
	OANn0xSkUMlCcZI4LdAKQyAvTVIObyZ4R0nYUyKNFKbAHMY3TZGHNxUY5YqdvvYP
	Q6x28zBSYAL7jYlHfRFq12wLTuyfiNkL5zFz7seU6twUfatTB0IEvrIGX3kSzPuZ
	Y4eLxQx1y3HGYU291Jib3ZTOPX78zTUUZbm2wC11uqD61uCH6NSdhPqVRht4rFQ8
	Nzlmh0aiBLT0NkZfaGlUqAeA/o+5UPtU8vtbmEpkHWYEbLBhE7Lo6L/FFF15APQo
	gfQ1ercTCpVkn7LH/llLmhxQgfivLCCJpX1UbIApg9ffxetUDwa1A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku559tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524G4vc0013743;
	Tue, 4 Mar 2025 17:21:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kpep9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLOgH19595606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0640B20040;
	Tue,  4 Mar 2025 17:21:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5C020043;
	Tue,  4 Mar 2025 17:21:23 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 13/20] s390/zcrypt: Add small mempool for cca info list entries
Date: Tue,  4 Mar 2025 18:21:09 +0100
Message-ID: <20250304172116.85374-14-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: J7inR4cO1cMc0I_4asvtRg5QAPoQAl3t
X-Proofpoint-GUID: J7inR4cO1cMc0I_4asvtRg5QAPoQAl3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

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
index ff7ba2622484..e4ec922aae0d 100644
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
  * Cprb memory pool held for urgent cases where no memory
  * can be allocated via kmalloc. This pool is only used
@@ -1662,7 +1666,7 @@ static int cca_info_cache_fetch(u16 cardnr, u16 domain, struct cca_info *ci)
 }
 
 static void cca_info_cache_update(u16 cardnr, u16 domain,
-				  const struct cca_info *ci)
+				  const struct cca_info *ci, u32 xflags)
 {
 	int found = 0;
 	struct cca_info_list_entry *ptr;
@@ -1677,7 +1681,9 @@ static void cca_info_cache_update(u16 cardnr, u16 domain,
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
@@ -1699,7 +1705,7 @@ static void cca_info_cache_scrub(u16 cardnr, u16 domain)
 		if (ptr->cardnr == cardnr &&
 		    ptr->domain == domain) {
 			list_del(&ptr->list);
-			kfree(ptr);
+			mempool_free(ptr, info_mempool);
 			break;
 		}
 	}
@@ -1713,7 +1719,7 @@ static void __exit mkvp_cache_free(void)
 	spin_lock_bh(&cca_info_list_lock);
 	list_for_each_entry_safe(ptr, pnext, &cca_info_list, list) {
 		list_del(&ptr->list);
-		kfree(ptr);
+		mempool_free(ptr, info_mempool);
 	}
 	spin_unlock_bh(&cca_info_list_lock);
 }
@@ -1721,14 +1727,14 @@ static void __exit mkvp_cache_free(void)
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
 
@@ -1802,15 +1808,15 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
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
@@ -1828,6 +1834,7 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 	u16 card, dom;
 	struct cca_info ci;
 	int i, rc, oi = -1;
+	u32 xflg = 0; /* xflags */
 
 	/* mkvp must not be zero, minhwtype needs to be >= 0 */
 	if (mkvp == 0 || minhwtype < 0)
@@ -1859,8 +1866,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
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
@@ -1882,8 +1889,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
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
@@ -1955,6 +1962,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 	u32 _nr_apqns = 0;
+	u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1985,7 +1993,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		if (domain != 0xFFFF && dom != domain)
 			continue;
 		/* get cca info on this apqn */
-		if (cca_get_info(card, dom, &ci, verify))
+		if (cca_get_info(card, dom, &ci, verify, xflags))
 			continue;
 		/* current master key needs to be valid */
 		if (mktype == AES_MK_SET && ci.cur_aes_mk_state != '2')
@@ -2037,6 +2045,8 @@ EXPORT_SYMBOL(cca_findcard2);
 
 int __init zcrypt_ccamisc_init(void)
 {
+	int rc = -ENOMEM;
+
 	/* Pre-allocate a small memory pool for cca cprbs. */
 	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_cca_cprbpool_min_items,
 						   CPRB_MEMPOOL_ITEM_SIZE);
@@ -2044,19 +2054,39 @@ int __init zcrypt_ccamisc_init(void)
 		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
 			       __func__, zcrypt_cca_cprbpool_min_items,
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
 
 void zcrypt_ccamisc_exit(void)
@@ -2064,4 +2094,5 @@ void zcrypt_ccamisc_exit(void)
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

