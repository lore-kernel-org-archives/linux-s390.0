Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F4476CFF
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325220; cv=none; b=HP9kaAtgz7vIJnA00hWMvoUvUjU8Uiu5O7n7Tduzd+fV1slkdSyfdSy5TEo/Pi/860GBwTEOv9UL0PaZdS5b7h4VKVPIC6TKXYQC9V1sTVBmnJHfaeKemtBYS/ct384UK1yMzKwyJ5yzS3FKcNVsEIVtSIg2G6dVqtVpbUL/Wj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325220; c=relaxed/simple;
	bh=yx4BqS7gWRly4Mky/ihwcQqE/9mW6+djXMuQto5bW4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC59Fp4wpa31ZveD8WXhx0g/0tXwLMOcx+HWleYNhDdJ1fn/rlYsLXFzY53yoDaKo9VtvXJm1Ak4SWCc4I22oqkYQqi4mZruiG8ckipuTu3B95uo4MAYOhzkMjoQHcvlUYnTcd5+ltmGWzL0HJ2RB3uVbwM5ecgBkJ1TwNnhKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uq/sVwTy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uq/sVwTy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBI43q3956355
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i4Wr42rHL3pBvuOQJ
	bGXTvEKzTIRgkbza7lGe9Q6TOs=; b=Uq/sVwTyUi1RCydcZXQUga8XuMkqM0C4F
	od2n9OUVVzav9ocBGebLNbPQ/caeIUFtcieh3RC2L0nOupn0VGHnHOTA25ZyUOOm
	pXVsWx8g+jPiXKzvJ+cVey69f0KNEhzhkZjxOxxSDvA6FJatlPdCB6GWMtPQ4a32
	gQw/wYpPXffGZm6f1wMoEqVZNR7HuGYEQgy5xcHEoXHKFvUyW3oAyELWpAZw0VPj
	V88yP7WHpkeSbQDgY1X4q2URaVwLc4iwJfPL1hZYTAhNeYJRpfaDUES0WyvPYjDo
	QPClPuSrIoltKDoOXAyUREpZ7qLrhLkUS8wqGqadVbtojgoZ8H7NQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nsm4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBQjRr025957
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk6gcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBeAeV46858578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:40:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D393420040;
	Wed, 29 Jul 2026 11:40:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92A9B2004B;
	Wed, 29 Jul 2026 11:40:10 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:40:10 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, ifranzki@linux.ibm.com
Subject: [PATCH v4 1/1] s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
Date: Wed, 29 Jul 2026 13:40:09 +0200
Message-ID: <20260729114009.187946-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729114009.187946-1-freude@linux.ibm.com>
References: <20260729114009.187946-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX2PQGMnhTVNNz
 BudpARuAX3LcWSbDjgmDbFzHKXo1raoMhCAQYopMS5p2n47udB5uwVqjEbrKVOOpQ0JiZYuDqrj
 427SLXy0j4LutLz+yImwjS6Fkn/6kUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX0XmDS3rJlic9
 +k6aAkknQYLdlPdsT/fGwJ1Dfqvjl+VTRltK4o8N6jUnD0RK4kd/7nhiH3wIVJ/j8vLhUO+W1zv
 R2Dl2kMsRP5zkah+wdjFHbBebHeCPatGKhoEeZn09lsx+mTvNxJ56t8/XIxkvVrVqAZJpsVENeY
 6iDG9ez7ymCCjbq8oBkSE4+QXegxmxhksxvdjNXOREm54JpERRT3MTh52+QrWyqU+JB9njYQWIa
 jr0t/4+Ls7Fc7UUX5Yqf5dRbSuB5G1/yekURYVbPBOZTrUgd7iIIosWSwDcUZLocEBb4FEPmg9u
 gDWP0FhaNvA0WInnjZRojqrWUVoTgoBRSaIMltq3q/zmbYfY7b/Q34Bo9Gu7T3t31lwsZPLO3Fo
 9UT8vyjwIH9dYnC9mJXiBGiZWNuupRwyqbDUcg+k6aQz8aPzjAvH2ENcl6AcDJVtQjrBEpUpj2q
 s3ui6Cmhy/TsPL/WCtQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69e69f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ecyEnyouAVfN91ZdUdoA:9
X-Proofpoint-GUID: -rnSLV1TUR_uYpd0D0eTV5_zSm7bZ1hu
X-Proofpoint-ORIG-GUID: -rnSLV1TUR_uYpd0D0eTV5_zSm7bZ1hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290093

Add validation of both the actual key buffer size and token length
fields in all the cca_check_sec*token() functions. Additionally check
in cca_gencipherkey() for possible underflow with returned key size.

The CCA token structures contain user-controlled len fields that
were used in operations without proper validation against both the
actual buffer size and minimum token structure size. An attacker
could set this field larger than the actual buffer size, leading to
reading beyond buffer boundaries. This may result in a kernel crash or
exposure of memory via sending this as part of a request down to the
crypto card. Also an attacker could have used a very small len value
and thus enforce a buffer under-run which may produce similar effects
as a over-read.

So now a key must
- key buf length must be at least sizeof the token struct
- the key len field inside the token must fit into the range of
  sizeof key token struct ... key buf length

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/pkey_cca.c       | 15 +++----
 drivers/s390/crypto/zcrypt_ccamisc.c | 64 +++++++++++++++++++++++-----
 drivers/s390/crypto/zcrypt_ccamisc.h |  6 +--
 3 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index 4bc47952324e..e8dc2f77c137 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -236,22 +236,16 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (hdr->type == TOKTYPE_CCA_INTERNAL &&
 	    hdr->version == TOKVER_CCA_AES) {
 		/* CCA AES data key */
-		if (keylen < sizeof(struct secaeskeytoken))
-			return -EINVAL;
-		if (cca_check_secaeskeytoken(pkey_dbf_info, 3, key, 0))
+		if (cca_check_secaeskeytoken(pkey_dbf_info, 3, key, keylen, 0))
 			return -EINVAL;
 	} else if (hdr->type == TOKTYPE_CCA_INTERNAL &&
 		   hdr->version == TOKVER_CCA_VLSC) {
 		/* CCA AES cipher key */
-		if (keylen < hdr->len)
-			return -EINVAL;
 		if (cca_check_secaescipherkey(pkey_dbf_info,
-					      3, key, 0, 1))
+					      3, key, keylen, 0, 1))
 			return -EINVAL;
 	} else if (hdr->type == TOKTYPE_CCA_INTERNAL_PKA) {
 		/* CCA ECC (private) key */
-		if (keylen < sizeof(struct eccprivkeytoken))
-			return -EINVAL;
 		if (cca_check_sececckeytoken(pkey_dbf_info, 3, key, keylen, 1))
 			return -EINVAL;
 	} else {
@@ -484,7 +478,7 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 	    hdr->version == TOKVER_CCA_AES) {
 		struct secaeskeytoken *t = (struct secaeskeytoken *)key;
 
-		rc = cca_check_secaeskeytoken(pkey_dbf_info, 3, key, 0);
+		rc = cca_check_secaeskeytoken(pkey_dbf_info, 3, key, keylen, 0);
 		if (rc)
 			goto out;
 		*keytype = PKEY_TYPE_CCA_DATA;
@@ -512,7 +506,8 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		   hdr->version == TOKVER_CCA_VLSC) {
 		struct cipherkeytoken *t = (struct cipherkeytoken *)key;
 
-		rc = cca_check_secaescipherkey(pkey_dbf_info, 3, key, 0, 1);
+		rc = cca_check_secaescipherkey(pkey_dbf_info, 3,
+					       key, keylen, 0, 1);
 		if (rc)
 			goto out;
 		*keytype = PKEY_TYPE_CCA_CIPHER;
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 322677a8d320..f797786107b9 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -62,12 +62,18 @@ static DEFINE_MUTEX(dev_status_mem_mutex);
  * also checked. Returns 0 on success or errno value on failure.
  */
 int cca_check_secaeskeytoken(debug_info_t *dbg, int dbflvl,
-			     const u8 *token, int keybitsize)
+			     const u8 *token, u32 keysize, int keybitsize)
 {
 	struct secaeskeytoken *t = (struct secaeskeytoken *)token;
 
 #define DBF(...) debug_sprintf_event(dbg, dbflvl, ##__VA_ARGS__)
 
+	if (keysize < sizeof(*t)) {
+		if (dbg)
+			DBF("%s keysize %u < min token size %zu\n",
+			    __func__, keysize, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->type != TOKTYPE_CCA_INTERNAL) {
 		if (dbg)
 			DBF("%s token check failed, type 0x%02x != 0x%02x\n",
@@ -101,14 +107,20 @@ EXPORT_SYMBOL(cca_check_secaeskeytoken);
  * Returns 0 on success or errno value on failure.
  */
 int cca_check_secaescipherkey(debug_info_t *dbg, int dbflvl,
-			      const u8 *token, int keybitsize,
-			      int checkcpacfexport)
+			      const u8 *token, u32 keysize,
+			      int keybitsize, int checkcpacfexport)
 {
 	struct cipherkeytoken *t = (struct cipherkeytoken *)token;
 	bool keybitsizeok = true;
 
 #define DBF(...) debug_sprintf_event(dbg, dbflvl, ##__VA_ARGS__)
 
+	if (keysize < sizeof(*t)) {
+		if (dbg)
+			DBF("%s keysize %u < min token size %zu\n",
+			    __func__, keysize, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->type != TOKTYPE_CCA_INTERNAL) {
 		if (dbg)
 			DBF("%s token check failed, type 0x%02x != 0x%02x\n",
@@ -121,6 +133,18 @@ int cca_check_secaescipherkey(debug_info_t *dbg, int dbflvl,
 			    __func__, (int)t->version, TOKVER_CCA_VLSC);
 		return -EINVAL;
 	}
+	if (t->len > keysize) {
+		if (dbg)
+			DBF("%s token check failed, len %d > keysize %u\n",
+			    __func__, (int)t->len, keysize);
+		return -EINVAL;
+	}
+	if (t->len < sizeof(*t)) {
+		if (dbg)
+			DBF("%s token check failed, len %d < min token size %zu\n",
+			    __func__, (int)t->len, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->algtype != 0x02) {
 		if (dbg)
 			DBF("%s token check failed, algtype 0x%02x != 0x02\n",
@@ -195,6 +219,12 @@ int cca_check_sececckeytoken(debug_info_t *dbg, int dbflvl,
 
 #define DBF(...) debug_sprintf_event(dbg, dbflvl, ##__VA_ARGS__)
 
+	if (keysize < sizeof(*t)) {
+		if (dbg)
+			DBF("%s keysize %u < min token size %zu\n",
+			    __func__, keysize, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->type != TOKTYPE_CCA_INTERNAL_PKA) {
 		if (dbg)
 			DBF("%s token check failed, type 0x%02x != 0x%02x\n",
@@ -207,6 +237,12 @@ int cca_check_sececckeytoken(debug_info_t *dbg, int dbflvl,
 			    __func__, (int)t->len, keysize);
 		return -EINVAL;
 	}
+	if (t->len < sizeof(*t)) {
+		if (dbg)
+			DBF("%s token check failed, len %d < min token size %zu\n",
+			    __func__, (int)t->len, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->secid != 0x20) {
 		if (dbg)
 			DBF("%s token check failed, secid 0x%02x != 0x20\n",
@@ -443,7 +479,8 @@ int cca_genseckey(u16 cardnr, u16 domain,
 
 	/* check secure key token */
 	rc = cca_check_secaeskeytoken(zcrypt_dbf_info, DBF_ERR,
-				      prepparm->lv3.keyblock.tok, 8 * keysize);
+				      prepparm->lv3.keyblock.tok,
+				      seckeysize, 8 * keysize);
 	if (rc) {
 		rc = -EIO;
 		goto out;
@@ -582,7 +619,8 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 
 	/* check secure key token */
 	rc = cca_check_secaeskeytoken(zcrypt_dbf_info, DBF_ERR,
-				      prepparm->lv3.keyblock.tok, 8 * keysize);
+				      prepparm->lv3.keyblock.tok,
+				      seckeysize, 8 * keysize);
 	if (rc) {
 		rc = -EIO;
 		goto out;
@@ -842,6 +880,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 		} kb;
 	} __packed * prepparm;
 	struct cipherkeytoken *t;
+	u32 keybuflen;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -936,23 +975,28 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 	/* and some checks on the generated key */
+	t = (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
+	if (prepparm->kb.tlv1.len < 2 * sizeof(uint16_t) + sizeof(*t)) {
+		rc = -EIO;
+		goto out;
+	}
+	keybuflen = prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
 	rc = cca_check_secaescipherkey(zcrypt_dbf_info, DBF_ERR,
 				       prepparm->kb.tlv1.gen_key,
-				       keybitsize, 1);
+				       keybuflen, keybitsize, 1);
 	if (rc) {
 		rc = -EIO;
 		goto out;
 	}
 
 	/* copy the generated vlsc key token */
-	t = (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
 	if (keybuf) {
-		if (*keybufsize >= t->len)
-			memcpy(keybuf, t, t->len);
+		if (*keybufsize >= keybuflen)
+			memcpy(keybuf, t, keybuflen);
 		else
 			rc = -EINVAL;
 	}
-	*keybufsize = t->len;
+	*keybufsize = keybuflen;
 
 out:
 	free_cprbmem(mem, PARMBSIZE, false, xflags);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 07bbb1c20022..a4534f8b2f1d 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -136,7 +136,7 @@ struct eccprivkeytoken {
  * also checked. Returns 0 on success or errno value on failure.
  */
 int cca_check_secaeskeytoken(debug_info_t *dbg, int dbflvl,
-			     const u8 *token, int keybitsize);
+			     const u8 *token, u32 keysize, int keybitsize);
 
 /*
  * Simple check if the token is a valid CCA secure AES cipher key
@@ -146,8 +146,8 @@ int cca_check_secaeskeytoken(debug_info_t *dbg, int dbflvl,
  * Returns 0 on success or errno value on failure.
  */
 int cca_check_secaescipherkey(debug_info_t *dbg, int dbflvl,
-			      const u8 *token, int keybitsize,
-			      int checkcpacfexport);
+			      const u8 *token, u32 keysize,
+			      int keybitsize, int checkcpacfexport);
 
 /*
  * Simple check if the token is a valid CCA secure ECC private
-- 
2.43.0

