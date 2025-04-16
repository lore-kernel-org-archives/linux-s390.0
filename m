Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6F1AA1D5
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811898; cv=none; b=klCha3yCdNa/SyVQdTjAGDLkWUkNp0UhAVYsfNd0KnltaYrARqbvDQH6nyAW5X6r9d+Mo4cuOtnDzNWz3RcRr1YHOur7+40TNuqs7np1IL7y+JPmeGbxpRVdKGbsBjTghDUJ0I7UwdxJhPAZrNZtmumZjAKdIsj3LR+CyYgOPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811898; c=relaxed/simple;
	bh=Tlu5HnPefaBAkE5/Yb/FLpZrwDySRYynpPekouVMHYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTyGfkTIQMA27+OnVK8OsGbj6FtyjYg8gqXyujT2E51onxi0dp5YUlhW0NlrLwYy3h2YjsRV4zjb+hH/v4VKQVXoNjfUH4VfD08a3mHi2cKTg8UwyVEH7fAas61H1k7KxJFn3CX9CoqW/cf5eOHC1TZr/RDAY177Ioy3EkSJEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hwRvjkFh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hwRvjkFh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GAB7dt017233;
	Wed, 16 Apr 2025 13:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k/OrhDQzp4VXSCGEp
	DGIkz1jA54+khfqYp0bjr7P3DE=; b=hwRvjkFhB1CBHWzr0jZ+Lk/0KQLKXrsPr
	QT1U0Hv+BmvAGiqUosk6BiMyawR4buAIrisqNmL3F/fS47mw7Q91/iiVRh8YMTSp
	ytmxOHCHsnmdLok2jsxCfGv+i2fTilPZ1Q8GO9GMgHT1IwBWYiX3ltXdI5QOG8WS
	v7PUKIsVHWDPgiJ6Ur5/E9D0q5TeT/hWqxmGoQyrrpffjgcFc3mR8R0hbdELltNK
	WZI3VILrq6aHU9cvBmoUF2bk7xQlpyFxxHpdtiWmJspWADxXdgOeYd2PalPfV2Tk
	8WhQjhpRbTdrisNTCA6ooBBbmGc1TOvORjB/XrutuvbDWlcMsa4zg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461y1gc5yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GATsaP030943;
	Wed, 16 Apr 2025 13:58:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnrnc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDw9BT34996600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E533220040;
	Wed, 16 Apr 2025 13:58:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A23920043;
	Wed, 16 Apr 2025 13:58:08 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 11/25] s390/zcrypt: Remove unused functions from cca misc
Date: Wed, 16 Apr 2025 15:57:46 +0200
Message-ID: <20250416135801.133909-12-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135801.133909-1-freude@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l_YzBtgGG_Fn53Ae7z-wzSA3qFb-taLo
X-Proofpoint-GUID: l_YzBtgGG_Fn53Ae7z-wzSA3qFb-taLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160111

The static function findcard() and the zcrypt cca_findcard()
function are both not used any more. Remove this outdated
code and an internal function only called by these.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 142 ---------------------------
 drivers/s390/crypto/zcrypt_ccamisc.h |   9 --
 2 files changed, 151 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 0c06b748f4b6..13f553a723cb 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1680,22 +1680,6 @@ static void cca_info_cache_update(u16 cardnr, u16 domain,
 	spin_unlock_bh(&cca_info_list_lock);
 }
 
-static void cca_info_cache_scrub(u16 cardnr, u16 domain)
-{
-	struct cca_info_list_entry *ptr;
-
-	spin_lock_bh(&cca_info_list_lock);
-	list_for_each_entry(ptr, &cca_info_list, list) {
-		if (ptr->cardnr == cardnr &&
-		    ptr->domain == domain) {
-			list_del(&ptr->list);
-			kfree(ptr);
-			break;
-		}
-	}
-	spin_unlock_bh(&cca_info_list_lock);
-}
-
 static void __exit mkvp_cache_free(void)
 {
 	struct cca_info_list_entry *ptr, *pnext;
@@ -1800,132 +1784,6 @@ int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
 }
 EXPORT_SYMBOL(cca_get_info);
 
-/*
- * Search for a matching crypto card based on the
- * Master Key Verification Pattern given.
- */
-static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
-		    int verify, int minhwtype)
-{
-	struct zcrypt_device_status_ext *device_status;
-	u16 card, dom;
-	struct cca_info ci;
-	int i, rc, oi = -1;
-
-	/* mkvp must not be zero, minhwtype needs to be >= 0 */
-	if (mkvp == 0 || minhwtype < 0)
-		return -EINVAL;
-
-	/* fetch status of all crypto cards */
-	device_status = kvcalloc(MAX_ZDEV_ENTRIES_EXT,
-				 sizeof(struct zcrypt_device_status_ext),
-				 GFP_KERNEL);
-	if (!device_status)
-		return -ENOMEM;
-
-	zcrypt_device_status_mask_ext(device_status,
-				      MAX_ZDEV_CARDIDS_EXT,
-				      MAX_ZDEV_DOMAINS_EXT);
-
-	/* walk through all crypto cards */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
-		card = AP_QID_CARD(device_status[i].qid);
-		dom = AP_QID_QUEUE(device_status[i].qid);
-		if (device_status[i].online &&
-		    device_status[i].functions & 0x04) {
-			/* enabled CCA card, check current mkvp from cache */
-			if (cca_info_cache_fetch(card, dom, &ci) == 0 &&
-			    ci.hwtype >= minhwtype &&
-			    ci.cur_aes_mk_state == '2' &&
-			    ci.cur_aes_mkvp == mkvp) {
-				if (!verify)
-					break;
-				/* verify: refresh card info */
-				if (fetch_cca_info(card, dom, &ci) == 0) {
-					cca_info_cache_update(card, dom, &ci);
-					if (ci.hwtype >= minhwtype &&
-					    ci.cur_aes_mk_state == '2' &&
-					    ci.cur_aes_mkvp == mkvp)
-						break;
-				}
-			}
-		} else {
-			/* Card is offline and/or not a CCA card. */
-			/* del mkvp entry from cache if it exists */
-			cca_info_cache_scrub(card, dom);
-		}
-	}
-	if (i >= MAX_ZDEV_ENTRIES_EXT) {
-		/* nothing found, so this time without cache */
-		for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
-			if (!(device_status[i].online &&
-			      device_status[i].functions & 0x04))
-				continue;
-			card = AP_QID_CARD(device_status[i].qid);
-			dom = AP_QID_QUEUE(device_status[i].qid);
-			/* fresh fetch mkvp from adapter */
-			if (fetch_cca_info(card, dom, &ci) == 0) {
-				cca_info_cache_update(card, dom, &ci);
-				if (ci.hwtype >= minhwtype &&
-				    ci.cur_aes_mk_state == '2' &&
-				    ci.cur_aes_mkvp == mkvp)
-					break;
-				if (ci.hwtype >= minhwtype &&
-				    ci.old_aes_mk_state == '2' &&
-				    ci.old_aes_mkvp == mkvp &&
-				    oi < 0)
-					oi = i;
-			}
-		}
-		if (i >= MAX_ZDEV_ENTRIES_EXT && oi >= 0) {
-			/* old mkvp matched, use this card then */
-			card = AP_QID_CARD(device_status[oi].qid);
-			dom = AP_QID_QUEUE(device_status[oi].qid);
-		}
-	}
-	if (i < MAX_ZDEV_ENTRIES_EXT || oi >= 0) {
-		if (pcardnr)
-			*pcardnr = card;
-		if (pdomain)
-			*pdomain = dom;
-		rc = (i < MAX_ZDEV_ENTRIES_EXT ? 0 : 1);
-	} else {
-		rc = -ENODEV;
-	}
-
-	kvfree(device_status);
-	return rc;
-}
-
-/*
- * Search for a matching crypto card based on the Master Key
- * Verification Pattern provided inside a secure key token.
- */
-int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify)
-{
-	u64 mkvp;
-	int minhwtype = 0;
-	const struct keytoken_header *hdr = (struct keytoken_header *)key;
-
-	if (hdr->type != TOKTYPE_CCA_INTERNAL)
-		return -EINVAL;
-
-	switch (hdr->version) {
-	case TOKVER_CCA_AES:
-		mkvp = ((struct secaeskeytoken *)key)->mkvp;
-		break;
-	case TOKVER_CCA_VLSC:
-		mkvp = ((struct cipherkeytoken *)key)->mkvp0;
-		minhwtype = AP_DEVICE_TYPE_CEX6;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return findcard(mkvp, pcardnr, pdomain, verify, minhwtype);
-}
-EXPORT_SYMBOL(cca_findcard);
-
 int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
 		  int verify)
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 273edf2bb036..0662fe39e425 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -207,15 +207,6 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 			      u8 *rarray, size_t *rarraylen,
 			      u8 *varray, size_t *varraylen);
 
-/*
- * Search for a matching crypto card based on the Master Key
- * Verification Pattern provided inside a secure key.
- * Works with CCA AES data and cipher keys.
- * Returns < 0 on failure, 0 if CURRENT MKVP matches and
- * 1 if OLD MKVP matches.
- */
-int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify);
-
 /*
  * Build a list of cca apqns meeting the following constrains:
  * - apqn is online and is in fact a CCA apqn
-- 
2.43.0

