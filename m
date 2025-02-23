Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E9204085
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304514; cv=none; b=bvwbAJ9K201gSgJmr2SVqRLbBI6pnM5Q18Bmx3SJpp20UMdGB7IEdxVlQn5+9ZmAkQtGfCBddrsqlCsXMQmHmvJwHioxtqjgzo5uZ6s64yvx3Hywyw0VsQCMT0Y0yd1a7CxbDCPlGtpMOZQ+4lC3zsKej/IMfSTf9CFpCobpMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304514; c=relaxed/simple;
	bh=Mj1SOuadYNzeTaUl7Y9VwBV6tl2kQf/dFuLLW8Imgg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S26dSd2DtsWVTL/dLJb7LDb4EJRl43+eTZwvMtVwsViQnVWNBrL9XeQsAzcfls0BXwUdPiN9Al3+WTJ9HPX1dazOp8ZvkLh6v7ysCB3MRkWNAfdXkgYSzxXlk1ZfhWEj64GuSVMRRcAFUhSRoLNqh3viObAWxp9G8MNsjLiTt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J4euPHwD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J4euPHwD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6U3ck017805;
	Sun, 23 Feb 2025 09:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yP4CIZcfNe7Ax5gGb
	r8o+cz3aANHGu+n4FVOjsJ1UpQ=; b=J4euPHwDEHAPb+YZz8QPlANuQP6fEbxPP
	fdFFTmD2n2D+M+Btbh91jmNBi6y00/V2lYagLiIjzMmKlHmKWgSWGLhs6T4tNxkQ
	ktsRb5lnABAtfldLXlNcSmp7ZgEedEfCuhZOi82A3eP2OVGuGfRfK4LOs4bTDWy1
	dUedOLEzN17jAnXquG6usA5pcrWqY4Zuh4wEMSzBjB33e5ed3739wjnxcdOXAux3
	EaWJwdNl1PRHkRifiBY9Z6MGmxr2ivh/fbp4xJplWCgetLRXjHK2ld6KRBXEmYxY
	PBHbO737b0Mx0lCH+q/XBGww1pw3fJWLTBtdBTK0KTeItGhwSpsxQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gjfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7nPno027344;
	Sun, 23 Feb 2025 09:55:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1haq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t4Sq33096110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89A9B20040;
	Sun, 23 Feb 2025 09:55:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F8352004B;
	Sun, 23 Feb 2025 09:55:04 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:04 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 11/20] s390/zcrypt/pkey: Rework ep11 findcard() implementation and callers
Date: Sun, 23 Feb 2025 10:54:50 +0100
Message-ID: <20250223095459.43058-12-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 8Kw3YGk0X52xgJ6GM-GNxbeuYTCW3n94
X-Proofpoint-GUID: 8Kw3YGk0X52xgJ6GM-GNxbeuYTCW3n94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Rework the memory usage of the ep11 findcard() implementation:
- findcard does not allocate memory for the list of apqns
  any more.
- the callers are now responsible to provide an array of
  apqns to store the matching apqns into.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c       | 19 ++++++++-----------
 drivers/s390/crypto/zcrypt_ep11misc.c | 19 +++++--------------
 drivers/s390/crypto/zcrypt_ep11misc.h | 12 +++++-------
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index 5b033ca3e828..b970f0be84be 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -73,7 +73,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			  struct pkey_apqn *apqns, size_t *nr_apqns)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	u32 _nr_apqns, *_apqns = NULL;
+	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
 
 	if (!flags)
@@ -98,7 +98,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			minhwtype = ZCRYPT_CEX7;
 			api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		}
-		rc = ep11_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				    minhwtype, api, kb->wkvp);
 		if (rc)
 			goto out;
@@ -115,7 +115,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			minhwtype = ZCRYPT_CEX7;
 			api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		}
-		rc = ep11_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				    minhwtype, api, kb->wkvp);
 		if (rc)
 			goto out;
@@ -135,7 +135,6 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 	*nr_apqns = _nr_apqns;
 
 out:
-	kfree(_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -144,7 +143,7 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 			   u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
 			   struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	u32 _nr_apqns, *_apqns = NULL;
+	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
 
 	zcrypt_wait_api_operational();
@@ -158,7 +157,7 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 		if (flags & PKEY_FLAGS_MATCH_CUR_MKVP)
 			wkvp = cur_mkvp;
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
-		rc = ep11_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				    ZCRYPT_CEX7, api, wkvp);
 		if (rc)
 			goto out;
@@ -178,7 +177,6 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 	*nr_apqns = _nr_apqns;
 
 out:
-	kfree(_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -423,7 +421,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 			  u32 *keytype, u32 *keybitsize, u32 *flags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	u32 nr_apqns, *apqns = NULL;
+	u32 apqns[MAXAPQNSINLIST], nr_apqns = ARRAY_SIZE(apqns);
 	int rc;
 
 	if (keylen < sizeof(*hdr))
@@ -443,7 +441,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = kb->head.bitlen;
 
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
-		rc = ep11_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = ep11_findcard2(apqns, &nr_apqns, *card, *dom,
 				    ZCRYPT_CEX7, api,
 				    ep11_kb_wkvp(key, keylen));
 		if (rc)
@@ -467,7 +465,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = kh->bitlen;
 
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
-		rc = ep11_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = ep11_findcard2(apqns, &nr_apqns, *card, *dom,
 				    ZCRYPT_CEX7, api,
 				    ep11_kb_wkvp(key, keylen));
 		if (rc)
@@ -484,7 +482,6 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 	}
 
 out:
-	kfree(apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index e9a705329ff8..09b5ab0d7174 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1615,14 +1615,14 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 }
 EXPORT_SYMBOL(ep11_kblob2protkey);
 
-int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		   int minhwtype, int minapi, const u8 *wkvp)
 {
 	struct zcrypt_device_status_ext *device_status;
-	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, rc = -ENOMEM;
+	int i, card, dom, rc;
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
+	u32 _nr_apqns = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1634,11 +1634,6 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
@@ -1675,22 +1670,18 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
 	mutex_unlock(&dev_status_mem_mutex);
 
 	return rc;
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index a4b98eca8431..cbd615547bc2 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -136,14 +136,12 @@ int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
  *   key for this domain. When a wkvp is given there will always be a re-fetch
  *   of the domain info for the potential apqn - so this triggers an request
  *   reply to each apqn eligible.
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
-int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		   int minhwtype, int minapi, const u8 *wkvp);
 
 /*
-- 
2.43.0

