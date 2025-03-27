Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B11218596
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086398; cv=none; b=gzqNqfW1DMWXbzidc8JyBOyRGjPPENT2cabHyl6YNIOPwXy5+TqYBf3m1ll9Gdh11j0oCq25h5U90U9/SIt93cDyuJQCi8hap/pia85LBU09sH0wrgKAxFrK0zzH2TA5/iZCRxofslC+Vq8ZRaUtg7JoSlQodUxtXkDGHceaFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086398; c=relaxed/simple;
	bh=XO679hTSQyQK7ikuIuefh+dSaZ9Flv+rGSZcX6L6NtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km2j3plL3Llc4WWP2mVxQXHvcQw3nu9uXQaVYkgamOJxaTALupfZHorloYIy7qzI51FoteuxPKfoj23PDeE0TeCDCXcK41G42BpF2iPiygtrx0RFNftwt2AsxI9i2VgOLpyn2LADgxFX7VIr80obfk5ph3rpAhV/QcxIRhAJ79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dNKvl1KG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dNKvl1KG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R99RIV009034;
	Thu, 27 Mar 2025 14:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8ieelAvP+fhnhCuZI
	eU3eS08m2GYv0+dRGL+pkIEfSw=; b=dNKvl1KGWG81eEIH2TztNj/fNcAZj+ZQ6
	sNib3nsQ+sbGN0VhnfLF/KYvDvmoRHtDXlOeI+4lfXi35IBHdUCFzgb9wGhPU5++
	njKseB2T/JuJJeBbzJhr+xrTfOt/z5hPFCD9OLYbiU6bOb+EyiiIBHpI+jZk2l0+
	yxc2fO6KOCR1IRrywh43XX0X8Z0gihB0vKaCfWB3WqaR9f9Ea2JA/7p1jT9MRRV4
	uTKPORDvUikQoi7+jMtYf+s8Z8DxL0/2gvd6Qzf4OczEkLfx2ZsLAqM2hGByrUAi
	w+elvj83GC/crkuuYI+IPSKC9xnhcy/xAk6o+iwdAanIrf8ECy1AA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrrq4ehu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDVk0S005865;
	Thu, 27 Mar 2025 14:39:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82nfbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdmsu51511704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D2B2004D;
	Thu, 27 Mar 2025 14:39:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42DAA20043;
	Thu, 27 Mar 2025 14:39:48 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 11/21] s390/zcrypt: Remove CCA and EP11 card and domain info caches
Date: Thu, 27 Mar 2025 15:39:31 +0100
Message-ID: <20250327143941.45507-12-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QbMm5tyNZsTpUGKHs6iDHUBwsWnk1TaL
X-Proofpoint-GUID: QbMm5tyNZsTpUGKHs6iDHUBwsWnk1TaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270099

Remove the caching of the CCA and EP11 card and domain info.
In nearly all places where the card or domain info is fetched
the verify param was enabled and thus the cache was bypassed.
The only real place where info from the cache was used was
in the sysfs pseudo files in cases where the card/queue was
switched to "offline". All other callers insisted on getting
fresh info and thus a communication to the card was enforced.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/pkey_cca.c        |  16 ++--
 drivers/s390/crypto/zcrypt_ccamisc.c  |  89 +------------------
 drivers/s390/crypto/zcrypt_ccamisc.h  |   8 +-
 drivers/s390/crypto/zcrypt_cex4.c     |  35 ++++----
 drivers/s390/crypto/zcrypt_ep11misc.c | 120 ++++----------------------
 drivers/s390/crypto/zcrypt_ep11misc.h |   2 +-
 6 files changed, 46 insertions(+), 224 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index cda22db31f6c..83b02a466346 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -109,7 +109,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 		}
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -128,7 +128,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 		}
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -173,7 +173,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			minhwtype = ZCRYPT_CEX6;
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -186,7 +186,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			old_mkvp = *((u64 *)alt_mkvp);
 		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp);
 		if (rc)
 			goto out;
 
@@ -480,13 +480,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = t->bitsize;
 		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX3C, AES_MK_SET,
-				   t->mkvp, 0, 1);
+				   t->mkvp, 0);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
 			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX3C, AES_MK_SET,
-					   0, t->mkvp, 1);
+					   0, t->mkvp);
 			if (!rc)
 				*flags = PKEY_FLAGS_MATCH_ALT_MKVP;
 		}
@@ -513,13 +513,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			*keybitsize = PKEY_SIZE_AES_256;
 		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX6, AES_MK_SET,
-				   t->mkvp0, 0, 1);
+				   t->mkvp0, 0);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
 			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX6, AES_MK_SET,
-					   0, t->mkvp0, 1);
+					   0, t->mkvp0);
 			if (!rc)
 				*flags = PKEY_FLAGS_MATCH_ALT_MKVP;
 		}
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index da920df99f3c..094f8d8eec21 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -30,17 +30,6 @@
 /* Size of vardata block used for some of the cca requests/replies */
 #define VARDATASIZE 4096
 
-struct cca_info_list_entry {
-	struct list_head list;
-	u16 cardnr;
-	u16 domain;
-	struct cca_info info;
-};
-
-/* a list with cca_info_list_entry entries */
-static LIST_HEAD(cca_info_list);
-static DEFINE_SPINLOCK(cca_info_list_lock);
-
 /*
  * Cprb memory pool held for urgent cases where no memory
  * can be allocated via kmalloc. This pool is only used
@@ -1635,65 +1624,6 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(cca_query_crypto_facility);
 
-static int cca_info_cache_fetch(u16 cardnr, u16 domain, struct cca_info *ci)
-{
-	int rc = -ENOENT;
-	struct cca_info_list_entry *ptr;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry(ptr, &cca_info_list, list) {
-		if (ptr->cardnr == cardnr && ptr->domain == domain) {
-			memcpy(ci, &ptr->info, sizeof(*ci));
-			rc = 0;
-			break;
-		}
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-
-	return rc;
-}
-
-static void cca_info_cache_update(u16 cardnr, u16 domain,
-				  const struct cca_info *ci)
-{
-	int found = 0;
-	struct cca_info_list_entry *ptr;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry(ptr, &cca_info_list, list) {
-		if (ptr->cardnr == cardnr &&
-		    ptr->domain == domain) {
-			memcpy(&ptr->info, ci, sizeof(*ci));
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		ptr = kmalloc(sizeof(*ptr), GFP_ATOMIC);
-		if (!ptr) {
-			spin_unlock_bh(&cca_info_list_lock);
-			return;
-		}
-		ptr->cardnr = cardnr;
-		ptr->domain = domain;
-		memcpy(&ptr->info, ci, sizeof(*ci));
-		list_add(&ptr->list, &cca_info_list);
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-}
-
-static void __exit mkvp_cache_free(void)
-{
-	struct cca_info_list_entry *ptr, *pnext;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry_safe(ptr, pnext, &cca_info_list, list) {
-		list_del(&ptr->list);
-		kfree(ptr);
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-}
-
 /*
  * Fetch cca_info values via query_crypto_facility from adapter.
  */
@@ -1771,24 +1701,14 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 /*
  * Fetch cca information about a CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci)
 {
-	int rc;
-
-	rc = cca_info_cache_fetch(card, dom, ci);
-	if (rc || verify) {
-		rc = fetch_cca_info(card, dom, ci);
-		if (rc == 0)
-			cca_info_cache_update(card, dom, ci);
-	}
-
-	return rc;
+	return fetch_cca_info(card, dom, ci);
 }
 EXPORT_SYMBOL(cca_get_info);
 
 int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
-		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
-		  int verify)
+		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp)
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
@@ -1829,7 +1749,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		if (domain != 0xFFFF && dom != domain)
 			continue;
 		/* get cca info on this apqn */
-		if (cca_get_info(card, dom, &ci, verify))
+		if (cca_get_info(card, dom, &ci))
 			continue;
 		/* current master key needs to be valid */
 		if (mktype == AES_MK_SET && ci.cur_aes_mk_state != '2')
@@ -1908,7 +1828,6 @@ int __init zcrypt_ccamisc_init(void)
 
 void zcrypt_ccamisc_exit(void)
 {
-	mkvp_cache_free();
 	mutex_lock(&dev_status_mem_mutex);
 	kvfree(dev_status_mem);
 	mutex_unlock(&dev_status_mem_mutex);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 0662fe39e425..cc7d362a2bad 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -215,9 +215,6 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
  * - if minhwtype > 0 only apqns with hwtype >= minhwtype
  * - if cur_mkvp != 0 only apqns where cur_mkvp == mkvp
  * - if old_mkvp != 0 only apqns where old_mkvp == mkvp
- * - if verify is enabled and a cur_mkvp and/or old_mkvp
- *   value is given, then refetch the cca_info and make sure the current
- *   cur_mkvp or old_mkvp values of the apqn are used.
  * The mktype determines which set of master keys to use:
  *   0 = AES_MK_SET - AES MK set, 1 = APKA MK_SET - APKA MK set
  * The array of apqn entries is allocated with kmalloc and returned in *apqns;
@@ -228,8 +225,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
  * -ENODEV is returned.
  */
 int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
-		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
-		  int verify);
+		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp);
 
 #define AES_MK_SET  0
 #define APKA_MK_SET 1
@@ -261,7 +257,7 @@ struct cca_info {
 /*
  * Fetch cca information about an CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify);
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci);
 
 int zcrypt_ccamisc_init(void);
 void zcrypt_ccamisc_exit(void);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 64df7d2f6266..ecf1fcc6315e 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -79,14 +79,13 @@ static ssize_t cca_serialnr_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct cca_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct cca_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
 	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, zc->online);
+		cca_get_info(ac->id, ap_domain_index, &ci);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }
@@ -110,17 +109,17 @@ static ssize_t cca_mkvps_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
+	static const char * const new_state[] = { "empty", "partial", "full" };
+	static const char * const cao_state[] = { "invalid", "valid" };
 	struct zcrypt_queue *zq = dev_get_drvdata(dev);
-	int n = 0;
 	struct cca_info ci;
-	static const char * const cao_state[] = { "invalid", "valid" };
-	static const char * const new_state[] = { "empty", "partial", "full" };
+	int n = 0;
 
 	memset(&ci, 0, sizeof(ci));
 
 	cca_get_info(AP_QID_CARD(zq->queue->qid),
 		     AP_QID_QUEUE(zq->queue->qid),
-		     &ci, zq->online);
+		     &ci);
 
 	if (ci.new_aes_mk_state >= '1' && ci.new_aes_mk_state <= '3')
 		n += sysfs_emit_at(buf, n, "AES NEW: %s 0x%016llx\n",
@@ -210,13 +209,12 @@ static ssize_t ep11_api_ordinalnr_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	if (ci.API_ord_nr > 0)
 		return sysfs_emit(buf, "%u\n", ci.API_ord_nr);
@@ -231,13 +229,12 @@ static ssize_t ep11_fw_version_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	if (ci.FW_version > 0)
 		return sysfs_emit(buf, "%d.%d\n",
@@ -254,13 +251,12 @@ static ssize_t ep11_serialnr_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	if (ci.serial[0])
 		return sysfs_emit(buf, "%16.16s\n", ci.serial);
@@ -291,14 +287,13 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct zcrypt_card *zc = dev_get_drvdata(dev);
-	int i, n = 0;
-	struct ep11_card_info ci;
 	struct ap_card *ac = to_ap_card(dev);
+	struct ep11_card_info ci;
+	int i, n = 0;
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (ci.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 0ff6514b9b0b..42963640d035 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -55,86 +55,6 @@ static mempool_t *cprb_mempool;
 static void *dev_status_mem;
 static DEFINE_MUTEX(dev_status_mem_mutex);
 
-/* ep11 card info cache */
-struct card_list_entry {
-	struct list_head list;
-	u16 cardnr;
-	struct ep11_card_info info;
-};
-static LIST_HEAD(card_list);
-static DEFINE_SPINLOCK(card_list_lock);
-
-static int card_cache_fetch(u16 cardnr, struct ep11_card_info *ci)
-{
-	int rc = -ENOENT;
-	struct card_list_entry *ptr;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry(ptr, &card_list, list) {
-		if (ptr->cardnr == cardnr) {
-			memcpy(ci, &ptr->info, sizeof(*ci));
-			rc = 0;
-			break;
-		}
-	}
-	spin_unlock_bh(&card_list_lock);
-
-	return rc;
-}
-
-static void card_cache_update(u16 cardnr, const struct ep11_card_info *ci)
-{
-	int found = 0;
-	struct card_list_entry *ptr;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry(ptr, &card_list, list) {
-		if (ptr->cardnr == cardnr) {
-			memcpy(&ptr->info, ci, sizeof(*ci));
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		ptr = kmalloc(sizeof(*ptr), GFP_ATOMIC);
-		if (!ptr) {
-			spin_unlock_bh(&card_list_lock);
-			return;
-		}
-		ptr->cardnr = cardnr;
-		memcpy(&ptr->info, ci, sizeof(*ci));
-		list_add(&ptr->list, &card_list);
-	}
-	spin_unlock_bh(&card_list_lock);
-}
-
-static void card_cache_scrub(u16 cardnr)
-{
-	struct card_list_entry *ptr;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry(ptr, &card_list, list) {
-		if (ptr->cardnr == cardnr) {
-			list_del(&ptr->list);
-			kfree(ptr);
-			break;
-		}
-	}
-	spin_unlock_bh(&card_list_lock);
-}
-
-static void __exit card_cache_free(void)
-{
-	struct card_list_entry *ptr, *pnext;
-
-	spin_lock_bh(&card_list_lock);
-	list_for_each_entry_safe(ptr, pnext, &card_list, list) {
-		list_del(&ptr->list);
-		kfree(ptr);
-	}
-	spin_unlock_bh(&card_list_lock);
-}
-
 static int ep11_kb_split(const u8 *kb, size_t kblen, u32 kbver,
 			 struct ep11kblob_header **kbhdr, size_t *kbhdrsize,
 			 u8 **kbpl, size_t *kbplsize)
@@ -720,7 +640,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
+int ep11_get_card_info(u16 card, struct ep11_card_info *info)
 {
 	int rc;
 	struct ep11_module_query_info {
@@ -750,27 +670,20 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
 		u32 max_CP_index;
 	} __packed * pmqi = NULL;
 
-	rc = card_cache_fetch(card, info);
-	if (rc || verify) {
-		pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
-		if (!pmqi)
-			return -ENOMEM;
-		rc = ep11_query_info(card, AUTOSEL_DOM,
-				     0x01 /* module info query */,
-				     sizeof(*pmqi), (u8 *)pmqi);
-		if (rc) {
-			if (rc == -ENODEV)
-				card_cache_scrub(card);
-			goto out;
-		}
-		memset(info, 0, sizeof(*info));
-		info->API_ord_nr = pmqi->API_ord_nr;
-		info->FW_version =
-			(pmqi->FW_major_vers << 8) + pmqi->FW_minor_vers;
-		memcpy(info->serial, pmqi->serial, sizeof(info->serial));
-		info->op_mode = pmqi->op_mode;
-		card_cache_update(card, info);
-	}
+	pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
+	if (!pmqi)
+		return -ENOMEM;
+	rc = ep11_query_info(card, AUTOSEL_DOM,
+			     0x01 /* module info query */,
+			     sizeof(*pmqi), (u8 *)pmqi);
+	if (rc)
+		goto out;
+
+	memset(info, 0, sizeof(*info));
+	info->API_ord_nr = pmqi->API_ord_nr;
+	info->FW_version = (pmqi->FW_major_vers << 8) + pmqi->FW_minor_vers;
+	memcpy(info->serial, pmqi->serial, sizeof(info->serial));
+	info->op_mode = pmqi->op_mode;
 
 out:
 	kfree(pmqi);
@@ -1657,7 +1570,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 			continue;
 		/* check min api version if given */
 		if (minapi > 0) {
-			if (ep11_get_card_info(card, &eci, 0))
+			if (ep11_get_card_info(card, &eci))
 				continue;
 			if (minapi > eci.API_ord_nr)
 				continue;
@@ -1720,7 +1633,6 @@ int __init zcrypt_ep11misc_init(void)
 
 void zcrypt_ep11misc_exit(void)
 {
-	card_cache_free();
 	mutex_lock(&dev_status_mem_mutex);
 	kvfree(dev_status_mem);
 	mutex_unlock(&dev_status_mem_mutex);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index a4b98eca8431..dc1e418a6db1 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -104,7 +104,7 @@ struct ep11_domain_info {
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify);
+int ep11_get_card_info(u16 card, struct ep11_card_info *info);
 
 /*
  * Provide information about a domain within an EP11 card.
-- 
2.43.0

