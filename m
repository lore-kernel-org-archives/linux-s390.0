Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938925F788
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207402; cv=none; b=TSrqCTXkvudL0Z0U8MAOl2Nb8UIuqm8W3pGjb7NFZClZbZuqMxqKcWfyok3Qi5Rit3mCo82BZiy9oc4c4DGY2pTaQuPl22A3rbLpo419jLZ7eUMnc5ksXA/grH+JjLz5uK8tKKDcaFRE9jKkZtTcmMzP6TJ0NNr3uSaQNgq6ceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207402; c=relaxed/simple;
	bh=Q4hByIujQ+KUucI0tN3X15ApnJp16VRytsWnR1bVKsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKf9yb29WV45rjkZ7HyFSA798W9WS7I4Lb/eRHcgmQJyReseQ5chnR6J7nFdBwEQFrtm/g+IJLAukJcy1HhyYTgPTx8jezIQz00/J6ZqXgSADF951fNvOzRPbxn19Z0O6/uGkV0187cwOrutYsHR5gcCataexPBG0GVG7ijMEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GC+a4Xkl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GC+a4Xkl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399prSE027294;
	Wed, 9 Apr 2025 14:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gOSz6jWOiux4gIuaz
	3ZGW9mxIEizwSf/s4BROZdQiDk=; b=GC+a4Xkle3Bkv9mXkI4jJKUUQQX5R5TH6
	0hiFmsA5t4KkEdKL1sC9+qy70Y886U9poAAwLo1IMTz5Rf1j1MHOplIXZzMIo9zE
	YLHhwe7vRfmeyM/yc+uE9Rmucwo1EGDe1On7AGU7XDRGHQKo2RqQ/P94MtcVnZQY
	hp/JwiwsDSE7x4Lgaw6IvKzhnkC9plFxbD0A54WDXdWSrF7LKK6UzcAfTA7emXod
	M3bGjuk8rByZaLXsl3nbhnvaBHQB47atWZ1AIjH0aMr7YVVEr26smmiWjJzBn3uR
	8IV2ZTMQEAShstTHh4mfMbRPQbregj+tAQl0PZDX3k6XAWmVqUCMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10m0e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539Cr7Nk024616;
	Wed, 9 Apr 2025 14:03:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutg780-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3Dvj42271186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4FFC2004F;
	Wed,  9 Apr 2025 14:03:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AF8220040;
	Wed,  9 Apr 2025 14:03:13 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:13 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 11/24] s390/zcrypt: Remove unused functions from cca misc
Date: Wed,  9 Apr 2025 16:02:52 +0200
Message-ID: <20250409140305.58900-12-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CCSWWrdXAckYrKSRIqfiUpUpS9ThxIBn
X-Proofpoint-GUID: CCSWWrdXAckYrKSRIqfiUpUpS9ThxIBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

The static function findcard() and the zcrypt cca_findcard()
function are both not used any more. Remove this outdated
code and an internal function only called by these.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 142 ---------------------------
 drivers/s390/crypto/zcrypt_ccamisc.h |   9 --
 2 files changed, 151 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index f2af3cb7a917..3a6a5b785a0d 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1682,22 +1682,6 @@ static void cca_info_cache_update(u16 cardnr, u16 domain,
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
@@ -1802,132 +1786,6 @@ int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
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

