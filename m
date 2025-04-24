Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB31624EA
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501820; cv=none; b=lDneFlERWD3olqx7tLHTj9z90E2rkhRLgSR0amfkscnr/nveEZu/DDGGPxScTd7UazAakdCbGA/AjRFCp2N8CYTPVm0KPicSF3eXp5D7INJa3fU2AvJt9WYLYRqRhO15DTjTwk0reE8GF9AqVUuvIni65IckDumPUCNchJvaAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501820; c=relaxed/simple;
	bh=9tIPSW4TuAk2RvP/EFaURdqZNXi1pmDQ0Rzaov4pcjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz5QBNYaNCfCu5RCD8vj6QhRy4EOEmmqQET6+T3NWTl9zxkHLumoDMF73Ci0heF4GnsvPpA7oQf66sLPLQGnL1/MpuH9wahYew46cvUkrJ6VB8RsZHyjLaLJT9u1MByVehCawEzeRgN5/wxlEBDYQdrEEnQPHd+DIRrKRcosDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n4wK6en5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n4wK6en5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAGbGK011487;
	Thu, 24 Apr 2025 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oGbsWkXguKQnJRypa
	SL4ktFCjUoj60Zx65DK34/IfhI=; b=n4wK6en5N1754/SrwfgFP4Jp16fQCezQI
	iGA/ZKmehtELVUcFZJS4rco0MOsL9dVE9LJ0lRb5w8QBxaX+6zsY+s9fegK2XH/A
	+Jdnt+aAtUzJIH7USwN/+r3coelaAUbHnRxkWsqc1wyOmFLHW0PxvM0fU9B4z2ax
	UTHUqJJQmTIyftQ2TMHI3sQkrdCEVW4pukqdrvyxUGMY3ltkSbJzBikJouYpLEae
	yYAoaG4Nb7dG3epA7vIDUphiQtQQVYh5lUJCGvHTZG/a8QEaBhr3LfZMRynrfUaQ
	O6fIeCGeqCbb4SXgr7BiEv2WBG45Gw5kK17JFOTw7AQ8tXfA2ydpg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4677sm3ymr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBXtSP022288;
	Thu, 24 Apr 2025 13:36:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxgded-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaQiR28836202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AFB620040;
	Thu, 24 Apr 2025 13:36:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AEDE2004D;
	Thu, 24 Apr 2025 13:36:26 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:26 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 13/25] s390/zcrypt: Rework cca findcard() implementation and callers
Date: Thu, 24 Apr 2025 15:36:07 +0200
Message-ID: <20250424133619.16495-14-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX771Py1GNGl0e 6Jmb8eG/zSTEd874fcL/Wi2adcyV1q0kan1pUBKRw3oYitAwBDH8SZFWfhr9ACWRiseyEbLhACc ZSlaU8rZBW9NRNd/PcFnBBQHb0C4XXs4Rhe+D+PtNPOZzw4JpD+HlbQeWK86YDiSug95ZdWkau6
 DvP2r+6VlOHOQ7qbXMkwmAT+O6LgiK6e0DB7yKa9zrQJ6YWgmqkj2H76mEg9jBTDD8M7/CXo0Sv fDujr/HvYcsvrgVd0fsl/653ZZyCNwB/8PYVav/zzMFtaFB+LVmYimlpEdxMkiYDLwYQHPXEjQ3 y6psBbd7UzOiAFLJAoXoMr2/csCl3bSV84uMyC0avgg1eyjb53gQ+dev+qHMyRutjoeS9M0rq/0
 bUFp2UbGWfgA1hjWvUYBRNBokp/x9UEanTtvjg0EIYzRSJ3J0jZwHoFEtoRDm6wHOf659+vu
X-Proofpoint-GUID: irBrjldWi2G8YKCvcZzwmUDnHPRY2PBo
X-Proofpoint-ORIG-GUID: irBrjldWi2G8YKCvcZzwmUDnHPRY2PBo
X-Authority-Analysis: v=2.4 cv=CcMI5Krl c=1 sm=1 tr=0 ts=680a3e78 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=6oLPvYvohar7nzJKScgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=994 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

Rework the memory usage of the cca findcard() implementation:
- findcard does not allocate memory for the list of apqns
  any more.
- the callers are now responsible to provide an array of
  apqns to store the matching apqns into.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_cca.c       | 25 ++++++++++------------
 drivers/s390/crypto/zcrypt_ccamisc.c | 31 +++++++---------------------
 drivers/s390/crypto/zcrypt_ccamisc.h | 12 +++++------
 3 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index 83b02a466346..5b1f4c571c88 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -73,7 +73,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			 struct pkey_apqn *apqns, size_t *nr_apqns)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	u32 _nr_apqns, *_apqns = NULL;
+	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
 
 	if (!flags)
@@ -107,7 +107,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			/* unknown CCA internal token type */
 			return -EINVAL;
 		}
-		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
 				   cur_mkvp, old_mkvp);
 		if (rc)
@@ -126,7 +126,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			/* unknown CCA internal 2 token type */
 			return -EINVAL;
 		}
-		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
 				   cur_mkvp, old_mkvp);
 		if (rc)
@@ -147,7 +147,6 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 	*nr_apqns = _nr_apqns;
 
 out:
-	kfree(_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -156,7 +155,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			  u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
 			  struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	u32 _nr_apqns, *_apqns = NULL;
+	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
 
 	zcrypt_wait_api_operational();
@@ -171,7 +170,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			old_mkvp = *((u64 *)alt_mkvp);
 		if (ktype == PKEY_TYPE_CCA_CIPHER)
 			minhwtype = ZCRYPT_CEX6;
-		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
 				   cur_mkvp, old_mkvp);
 		if (rc)
@@ -184,7 +183,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			cur_mkvp = *((u64 *)cur_mkvp);
 		if (flags & PKEY_FLAGS_MATCH_ALT_MKVP)
 			old_mkvp = *((u64 *)alt_mkvp);
-		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
 				   cur_mkvp, old_mkvp);
 		if (rc)
@@ -205,7 +204,6 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 	*nr_apqns = _nr_apqns;
 
 out:
-	kfree(_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -461,7 +459,7 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			 u32 *keytype, u32 *keybitsize, u32 *flags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	u32 nr_apqns, *apqns = NULL;
+	u32 apqns[MAXAPQNSINLIST], nr_apqns = ARRAY_SIZE(apqns);
 	int rc;
 
 	if (keylen < sizeof(*hdr))
@@ -478,13 +476,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			goto out;
 		*keytype = PKEY_TYPE_CCA_DATA;
 		*keybitsize = t->bitsize;
-		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX3C, AES_MK_SET,
 				   t->mkvp, 0);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
-			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX3C, AES_MK_SET,
 					   0, t->mkvp);
 			if (!rc)
@@ -511,13 +509,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			*keybitsize = PKEY_SIZE_AES_192;
 		else if (!t->plfver && t->wpllen == 640)
 			*keybitsize = PKEY_SIZE_AES_256;
-		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX6, AES_MK_SET,
 				   t->mkvp0, 0);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
-			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX6, AES_MK_SET,
 					   0, t->mkvp0);
 			if (!rc)
@@ -535,7 +533,6 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 	}
 
 out:
-	kfree(apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 1f4e14905ee5..b2ad377e1877 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1698,13 +1698,13 @@ int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
 }
 EXPORT_SYMBOL(cca_get_info);
 
-int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp)
 {
 	struct zcrypt_device_status_ext *device_status;
-	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, curmatch, oldmatch, rc;
+	int i, card, dom, curmatch, oldmatch;
 	struct cca_info ci;
+	u32 _nr_apqns = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1716,13 +1716,6 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				      ZCRYPT_DEV_STATUS_CARD_MAX,
 				      ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
-	/* allocate 1k space for up to 256 apqns */
-	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
-	if (!_apqns) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	/* walk through all the crypto apqnss */
 	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
@@ -1770,26 +1763,16 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				continue;
 		}
 		/* apqn passed all filtering criterons, add to the array */
-		if (_nr_apqns < 256)
-			_apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
+		if (_nr_apqns < *nr_apqns)
+			apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
 	}
 
-	/* nothing found ? */
-	if (!_nr_apqns) {
-		kfree(_apqns);
-		rc = -ENODEV;
-	} else {
-		/* no re-allocation, simple return the _apqns array */
-		*apqns = _apqns;
-		*nr_apqns = _nr_apqns;
-		rc = 0;
-	}
+	*nr_apqns = _nr_apqns;
 
-out:
 	/* release the device status memory */
 	mutex_unlock(&dev_status_mem_mutex);
 
-	return rc;
+	return _nr_apqns ? 0 : -ENODEV;
 }
 EXPORT_SYMBOL(cca_findcard2);
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index cc7d362a2bad..ca41a675dd3b 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -217,14 +217,12 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
  * - if old_mkvp != 0 only apqns where old_mkvp == mkvp
  * The mktype determines which set of master keys to use:
  *   0 = AES_MK_SET - AES MK set, 1 = APKA MK_SET - APKA MK set
- * The array of apqn entries is allocated with kmalloc and returned in *apqns;
- * the number of apqns stored into the list is returned in *nr_apqns. One apqn
- * entry is simple a 32 bit value with 16 bit cardnr and 16 bit domain nr and
- * may be casted to struct pkey_apqn. The return value is either 0 for success
- * or a negative errno value. If no apqn meeting the criteria is found,
- * -ENODEV is returned.
+ * The caller should set *nr_apqns to the nr of elements available in *apqns.
+ * On return *nr_apqns is then updated with the nr of apqns filled into *apqns.
+ * The return value is either 0 for success or a negative errno value.
+ * If no apqn meeting the criteria is found, -ENODEV is returned.
  */
-int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp);
 
 #define AES_MK_SET  0
-- 
2.43.0

