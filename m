Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942B1A3056
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727094; cv=none; b=MkWd25ufVUy4iY2jQISdzB+enS7cLqoT31mzI92tSoD3Djo2i2LfodNcfnoxaJXMosG7BDLnby/7UhvPsMtCSFjw6bQ9A68gdJIEDY+vrmg6iSgo6aoFbzSVGw+MAM6lvTKaVE8J9cS+H+dH7bLWQptoSRVtvPkfaWaxf/EvL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727094; c=relaxed/simple;
	bh=OWy5F50V0svAsaU6CddAqZKtioXe/cAhv0GF7t9JfRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyOHtuDmdnkY7d+RGiP8p10wtfpUw32TW9o0z57lE9C+B6gTvuZ1RbmIlCCp11IWRmWRB+rPmZgNEI2DC4aCdC/9kmoyOuOoEoOsRzXnGfKca7OaUxjAkrViwshEsKRYwzhHmVTD6xXSmltKM1Pn3ikpmxijwrdLs7nE/Eb2rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HNKD7Fe+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HNKD7Fe+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FB8NUD000660;
	Tue, 15 Apr 2025 14:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9x5DHBtoe7hS9BG3E
	89vsPLb2Ngk6q3cnDmMosSrye0=; b=HNKD7Fe+K4KMcOg5MgWApw3mX49p+0XGD
	oqcG2hghSDfWZoHxZwcn4wQZxt0pF0v1LTW9BvDuGUsZkKwYtssOm4d4QC3gx0Wz
	eQkM4qA9awxlw0D5exCql8LO8w2ZNDlcgULIcXyHlMJDaVGuUTaLo/wFb0aQAgqs
	X8kDMm3u/oEwMupxqxfLiK7rUXwddad5qTdsCyHnHDRkhB9OIFsjca2oGn+lJP87
	kISiFzxhThtgJ6co0uLyGdr95UbV63bDUYaU7J/Fc82AfqXJx0puBedNvcFH3GIQ
	+eZznoI8CN1Py4Wz1EjEOcyzvGdQUiYc44EcvDffRwp0aHcA+YmJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461cax3jhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FD2uJw000901;
	Tue, 15 Apr 2025 14:24:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyupu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOjE417563934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 043C22004E;
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01B420040;
	Tue, 15 Apr 2025 14:24:44 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:44 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 13/25] s390/zcrypt: Rework cca findcard() implementation and callers
Date: Tue, 15 Apr 2025 16:24:26 +0200
Message-ID: <20250415142438.118474-14-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415142438.118474-1-freude@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WsRVGh58Mpn3aLXRQazt4x3SZdCQQdYZ
X-Proofpoint-GUID: WsRVGh58Mpn3aLXRQazt4x3SZdCQQdYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=994
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504150099

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
index 832f5a291f76..48954e87742c 100644
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

