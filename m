Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9A204080
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304513; cv=none; b=e6lxL8w3u2Hz1rxWLxE1xDDdkFv6G09p3jm8N3hT0vU3K4mnhRpSaw4Rw/HCYKDdpvy5glbYiXE9BFiMaALXevMHMOTauuOSRd3rlLr4bbaI6E3J7v5LgmStETaTyZad6YqCX8I8MGWHLOVBasCjOZ7/5Stdl5sHbTM+lfqkCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304513; c=relaxed/simple;
	bh=6KEYGNC1HSQQI7Or2pZE4pgfqOZSk5gSj6JSv0wUZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/Wlvw5Ws/suj3ys8f8imkLMrlKpYfioOksGUd2feT0qzsB4Adh4gtvZCyCuOMvfcn5JOO/Ic220UI3J0OJ9wC56ai94m2AkRfD1/2jjPrdMCOOJVbVJqsH0Tz0D8amlkM3M2mSB5KVktd8ydKa7fGPHHSPtOi9cuLX+bl1kTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/C3zi1h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/C3zi1h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N2NZiZ019511;
	Sun, 23 Feb 2025 09:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AltlSUea6hFgn0g2+
	W37I2Z9GfDhXtKXF7rdDppYTGU=; b=h/C3zi1h844BwaGKC6AEdlpdBJUvk1CQA
	VryyhfWZ3XPRDL8wNa2+dJgEKsZ10IxnGdG9sqiB8TmW5+FYoogof/dsFOU0Zwl5
	gSEuf53DQ2TA3RBbSEu1d4pyyqvIObph9pioD+VzIt/l3IbrDJpU/2e9WYhbvqLM
	LJuxn6OWYqSEbB1EIDCxgXhP/15CvxDaRbSfNSKC+WBKJUN6LxKiIfpZmtTtrGWf
	HTOsSmxs1Xm+KGhEXy/i0bnF4tktRFJARn3cxyJxkVbM6v3iB9w7/OZI6iVT83Jz
	GRgCfSze0xDoFZ3PuGTLm3rWwc2jfc6z0g/bCYIy0EmyAdEnjyi0A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9sapr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N906W1012100;
	Sun, 23 Feb 2025 09:55:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y1wgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t4HR33096108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D9A520040;
	Sun, 23 Feb 2025 09:55:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9BD920049;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:03 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 10/20] s390/zcrypt/pkey: Rework cca findcard() implementation and callers
Date: Sun, 23 Feb 2025 10:54:49 +0100
Message-ID: <20250223095459.43058-11-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: y64sKJ1dxjq2wvKxy6wzEvY8CKQr1ai3
X-Proofpoint-GUID: y64sKJ1dxjq2wvKxy6wzEvY8CKQr1ai3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=944 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502230073

Rework the memory usage of the cca findcard() implementation:
- findcard does not allocate memory for the list of apqns
  any more.
- the callers are now responsible to provide an array of
  apqns to store the matching apqns into.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/pkey_cca.c       | 25 +++++++++++--------------
 drivers/s390/crypto/zcrypt_ccamisc.c | 19 +++++--------------
 drivers/s390/crypto/zcrypt_ccamisc.h | 12 +++++-------
 3 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index cda22db31f6c..8c9a0c5ca630 100644
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
 				   cur_mkvp, old_mkvp, 1);
 		if (rc)
@@ -126,7 +126,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			/* unknown CCA internal 2 token type */
 			return -EINVAL;
 		}
-		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
 				   cur_mkvp, old_mkvp, 1);
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
 				   cur_mkvp, old_mkvp, 1);
 		if (rc)
@@ -184,7 +183,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			cur_mkvp = *((u64 *)cur_mkvp);
 		if (flags & PKEY_FLAGS_MATCH_ALT_MKVP)
 			old_mkvp = *((u64 *)alt_mkvp);
-		rc = cca_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
 				   cur_mkvp, old_mkvp, 1);
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
 				   t->mkvp, 0, 1);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
-			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX3C, AES_MK_SET,
 					   0, t->mkvp, 1);
 			if (!rc)
@@ -511,13 +509,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			*keybitsize = PKEY_SIZE_AES_192;
 		else if (!t->plfver && t->wpllen == 640)
 			*keybitsize = PKEY_SIZE_AES_256;
-		rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX6, AES_MK_SET,
 				   t->mkvp0, 0, 1);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
-			rc = cca_findcard2(&apqns, &nr_apqns, *card, *dom,
+			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX6, AES_MK_SET,
 					   0, t->mkvp0, 1);
 			if (!rc)
@@ -535,7 +533,6 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 	}
 
 out:
-	kfree(apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 71cad7cf8656..4fcc45048ee5 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1927,14 +1927,14 @@ int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify)
 }
 EXPORT_SYMBOL(cca_findcard);
 
-int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
 		  int verify)
 {
 	struct zcrypt_device_status_ext *device_status;
-	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, curmatch, oldmatch, rc = -ENOMEM;
+	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
+	u32 _nr_apqns = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1946,11 +1946,6 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				       ZCRYPT_DEV_STATUS_CARD_MAX,
 				       ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
-	/* allocate 1k space for up to 256 apqns */
-	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
-	if (!_apqns)
-		goto out;
-
 	/* walk through all the crypto apqnss */
 	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
@@ -1998,22 +1993,18 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				continue;
 		}
 		/* apqn passed all filtering criterons, add to the array */
-		if (_nr_apqns < 256)
-			_apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
+		if (_nr_apqns < *nr_apqns)
+			apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
 	}
 
 	/* nothing found ? */
 	if (!_nr_apqns) {
-		kfree(_apqns);
 		rc = -ENODEV;
 	} else {
-		/* no re-allocation, simple return the _apqns array */
-		*apqns = _apqns;
 		*nr_apqns = _nr_apqns;
 		rc = 0;
 	}
 
-out:
 	/* release the device status memory */
 	mutex_unlock(&dev_status_mem_mutex);
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 273edf2bb036..bed647a42eb2 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -229,14 +229,12 @@ int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify);
  *   cur_mkvp or old_mkvp values of the apqn are used.
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
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
 		  int verify);
 
-- 
2.43.0

