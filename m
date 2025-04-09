Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD0265CB0
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207404; cv=none; b=HjgNEUYaHgeuRXrCZJa3t58QnZd3759/PSs0grSsc5VoBDHbn7UL4RN2pK03fHs7jaRJfz1neBJvtkNjJKUL0WLRAlvlUwdbe2vsMLoEV9xBwnfXTcJ1MlfJK4el7q73PlEAPbjiOJco4WfAqszsEI9m6IlPpypFOcSQTKhY0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207404; c=relaxed/simple;
	bh=pz378y1S86Edorcp8hj2BnRhZghr1/phvAzoqvvpZNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqcKtcEsHhJ7PwBl2hzLIcB94bNPvrdKAYKUY671MjEHQHrWkzPxuxw6KbSJjN9V7znZTuqFyyGU248vbXbC/Emj+YoWE464TbT7zme9PtrhLg+7CmkACdK69o9A8PgCEkhuEd5EEdtf6ZI+46ADy39cZTs9nKThat+wlcH0LSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qN6gUzD6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qN6gUzD6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539A4AAm026996;
	Wed, 9 Apr 2025 14:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qXOK6EyeDwPsSqaKx
	Ueg3p22s/VGOfiS+BemEWalEh0=; b=qN6gUzD6skjKK3XIGyALJQ2YOps15kVnf
	FjYQ/ycrwvWBe8SCmqr+jtsL80TwYUjwzetpVzz8VFAMVPLuexvWIiojndx+vf2W
	uGbqjPOrulWhgIbMH+ENJOdhYBg/AZ+MXSUTXRfNJdiLUJw7SA/7tN3GLNc2p6do
	0+PqQHPYr/rfBJm6TXfBrdlQ/PMMFek7sNmq5jSrSTddE+tjyw0F+wp4pUSVBrqZ
	b8k14umCRpVYdar5qv+hzlAdoKusr31Q43HnBGe/YSpCEIO9ka0qBuGCeBaZ48YW
	BiHs27Y1iQdG443hQmdPJXlAxEFq/UwcmE2FIIWD9A5awSmc/tMbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10m0ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539DcciF013860;
	Wed, 9 Apr 2025 14:03:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunr046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3FCV23003490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3341720040;
	Wed,  9 Apr 2025 14:03:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A102320082;
	Wed,  9 Apr 2025 14:03:14 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 13/24] s390/zcrypt/pkey: Rework cca findcard() implementation and callers
Date: Wed,  9 Apr 2025 16:02:54 +0200
Message-ID: <20250409140305.58900-14-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: UCLeuw9Q_cu7p2JBgM-emHegC0oC2I5y
X-Proofpoint-GUID: UCLeuw9Q_cu7p2JBgM-emHegC0oC2I5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=976 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

Rework the memory usage of the cca findcard() implementation:
- findcard does not allocate memory for the list of apqns
  any more.
- the callers are now responsible to provide an array of
  apqns to store the matching apqns into.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
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
index 7e24b78d4e56..15731eb250fb 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1707,13 +1707,13 @@ int cca_get_info(u16 card, u16 dom, struct cca_info *ci)
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
@@ -1725,13 +1725,6 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
@@ -1779,26 +1772,16 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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

