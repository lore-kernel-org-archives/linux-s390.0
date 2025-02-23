Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D017204080
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304515; cv=none; b=OfN0tqgJujl9cBnnLvcLPSnAaR7eTyGrrj+Y66tV17Ro1KhuLHgMHSLY/sChvYyf1lvLDaXuMw59J+TyNxbnaLcAEax/13eFdq2GqBP5U/vjDLRm03rxxAYRcCEluojkVy0MNtCZkBH1n2ijB8KuAHzcSyzddwZQCSwH63lh1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304515; c=relaxed/simple;
	bh=f4OEk6SKOELfXlgM1iYe+lZqPag3j6lgvH+Q6G5fNV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7z9sEwXJt0xdPSXCaLk+VvqPPyZNqMdVaIm1CvzDMEeGl7rzuWYjzkI/7tirktdp5qoYPgkbv48nJzoFPO8uHNUEkNtPTcxD8Ngjx2073jRSr8e1MLAVnsmnUMrCyIzqwuq5mRLclopNa+74zPUj145gs8l665axcdjluT1Ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=izDKwqZ+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="izDKwqZ+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6Q3ML009739;
	Sun, 23 Feb 2025 09:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gV53VD7mLfWFaG+OB
	HrhCA2QovFZofoummopLT9enBo=; b=izDKwqZ+ZJum4oSmhukuFfvIugTBWBbG9
	Rmb9eyv757BQKf4fRlvWB3ZpQiUMuSyK8KG04eGouzQUMmCi1hfalAfSAwp+Tk6m
	JS+Hym1yFg6CcufTAiipLKsq7Berj5viv9zXRxCMsSYt4gPtyf+e4NgCRBA26+Mv
	Zcs3ouhSdvjhofG5NOBKAA8jVeyuuw1fXfZfMKcwZqZQX+MMpJJUQMwZtqdgQeTb
	rvmL7jTwGhRhyKS+3ByUZYwnncqNnHg2RzXAniWQtRLfRRU9UlwILRzxvaNqh7VB
	6Mj31Sg5A0bwz6rVCjVqXsttsfWaRsKxy0+dnaByGhUtleF4tDuow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gjfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N78Yvb002570;
	Sun, 23 Feb 2025 09:55:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4j9ed4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t6M357082152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3240B20040;
	Sun, 23 Feb 2025 09:55:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B191A20049;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 15/20] s390/zcrypt: Rework ep11 misc functions to use cprb mempool
Date: Sun, 23 Feb 2025 10:54:54 +0100
Message-ID: <20250223095459.43058-16-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Mc0tvS3K3pzaRY6ffH4EXDZmVe5_Kqbc
X-Proofpoint-GUID: Mc0tvS3K3pzaRY6ffH4EXDZmVe5_Kqbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

There are two places in the ep11 misc code where a short term
memory buffer is needed. Rework this code to use the cprb mempool
to satisfy this ephemeral memory requirements.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c       |   3 +-
 drivers/s390/crypto/zcrypt_cex4.c     |  12 +--
 drivers/s390/crypto/zcrypt_ep11misc.c | 104 ++++++++++++++++----------
 drivers/s390/crypto/zcrypt_ep11misc.h |   8 +-
 4 files changed, 78 insertions(+), 49 deletions(-)

diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index b970f0be84be..38aa0c7807c2 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -280,6 +280,7 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 {
 	struct pkey_apqn *local_apqns = NULL;
 	int i, len, rc;
+	const u32 xflags = 0;
 
 	/* check keytype, subtype, keybitsize */
 	switch (keytype) {
@@ -328,7 +329,7 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
 		rc = ep11_genaeskey(apqns[i].card, apqns[i].domain,
 				    keybitsize, flags,
-				    keybuf, keybuflen, subtype);
+				    keybuf, keybuflen, subtype, xflags);
 	}
 
 out:
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 49a638d373fa..83e277d18844 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -216,7 +216,7 @@ static ssize_t ep11_api_ordinalnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci, zc->online, 0);
 
 	if (ci.API_ord_nr > 0)
 		return sysfs_emit(buf, "%u\n", ci.API_ord_nr);
@@ -237,7 +237,7 @@ static ssize_t ep11_fw_version_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci, zc->online, 0);
 
 	if (ci.FW_version > 0)
 		return sysfs_emit(buf, "%d.%d\n",
@@ -260,7 +260,7 @@ static ssize_t ep11_serialnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci, zc->online, 0);
 
 	if (ci.serial[0])
 		return sysfs_emit(buf, "%16.16s\n", ci.serial);
@@ -298,7 +298,7 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci, zc->online);
+	ep11_get_card_info(ac->id, &ci, zc->online, 0);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (ci.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
@@ -348,7 +348,7 @@ static ssize_t ep11_mkvps_show(struct device *dev,
 	if (zq->online)
 		ep11_get_domain_info(AP_QID_CARD(zq->queue->qid),
 				     AP_QID_QUEUE(zq->queue->qid),
-				     &di);
+				     &di, 0);
 
 	if (di.cur_wk_state == '0') {
 		n = sysfs_emit(buf, "WK CUR: %s -\n",
@@ -395,7 +395,7 @@ static ssize_t ep11_queue_op_modes_show(struct device *dev,
 	if (zq->online)
 		ep11_get_domain_info(AP_QID_CARD(zq->queue->qid),
 				     AP_QID_QUEUE(zq->queue->qid),
-				     &di);
+				     &di, 0);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (di.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index ef5f69bda6c2..467449adb5ae 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -630,7 +630,7 @@ static int check_reply_cprb(const struct ep11_cprb *rep, const char *func)
  * Helper function which does an ep11 query with given query type.
  */
 static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
-			   size_t buflen, u8 *buf)
+			   size_t buflen, u8 *buf, u32 xflags)
 {
 	struct ep11_info_req_pl {
 		struct pl_head head;
@@ -654,7 +654,6 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	struct ep11_target_dev target;
 	struct ep11_urb urb;
 	int api = EP11_API_V1, rc = -ENOMEM;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req = alloc_cprbmem(sizeof(struct ep11_info_req_pl), xflags);
@@ -721,7 +720,8 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
+int ep11_get_card_info(u16 card, struct ep11_card_info *info,
+		       int verify, u32 xflags)
 {
 	int rc;
 	struct ep11_module_query_info {
@@ -753,12 +753,15 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
 
 	rc = card_cache_fetch(card, info);
 	if (rc || verify) {
-		pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
+		/* use the cprb mempool to satisfy this short term mem alloc */
+		pmqi = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+			mempool_alloc_preallocated(cprb_mempool) :
+			mempool_alloc(cprb_mempool, GFP_KERNEL);
 		if (!pmqi)
 			return -ENOMEM;
 		rc = ep11_query_info(card, AUTOSEL_DOM,
 				     0x01 /* module info query */,
-				     sizeof(*pmqi), (u8 *)pmqi);
+				     sizeof(*pmqi), (u8 *)pmqi, xflags);
 		if (rc) {
 			if (rc == -ENODEV)
 				card_cache_scrub(card);
@@ -774,7 +777,7 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
 	}
 
 out:
-	kfree(pmqi);
+	mempool_free(pmqi, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_get_card_info);
@@ -782,7 +785,8 @@ EXPORT_SYMBOL(ep11_get_card_info);
 /*
  * Provide information about a domain within an EP11 card.
  */
-int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
+int ep11_get_domain_info(u16 card, u16 domain,
+			 struct ep11_domain_info *info, u32 xflags)
 {
 	int rc;
 	struct ep11_domain_query_info {
@@ -794,7 +798,8 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
 	} __packed dom_query_info;
 
 	rc = ep11_query_info(card, domain, 0x03 /* domain info query */,
-			     sizeof(dom_query_info), (u8 *)&dom_query_info);
+			     sizeof(dom_query_info), (u8 *)&dom_query_info,
+			     xflags);
 	if (rc)
 		goto out;
 
@@ -828,7 +833,7 @@ EXPORT_SYMBOL(ep11_get_domain_info);
 
 static int _ep11_genaeskey(u16 card, u16 domain,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct keygen_req_pl {
 		struct pl_head head;
@@ -866,7 +871,6 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	switch (keybitsize) {
 	case 128:
@@ -970,7 +974,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 }
 
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, u32 *keybufsize, u32 keybufver)
+		   u8 *keybuf, u32 *keybufsize, u32 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -991,7 +995,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		return rc;
 
 	rc = _ep11_genaeskey(card, domain, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -1011,7 +1015,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 			    u16 mode, u32 mech, const u8 *iv,
 			    const u8 *key, size_t keysize,
 			    const u8 *inbuf, size_t inbufsize,
-			    u8 *outbuf, size_t *outbufsize)
+			    u8 *outbuf, size_t *outbufsize,
+			    u32 xflags)
 {
 	struct crypt_req_pl {
 		struct pl_head head;
@@ -1042,7 +1047,6 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	size_t req_pl_size, rep_pl_size;
 	int n, api = EP11_API_V1, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* the simple asn1 coding used has length limits */
 	if (keysize > 0xFFFF || inbufsize > 0xFFFF)
@@ -1142,7 +1146,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 			   const u8 *enckey, size_t enckeysize,
 			   u32 mech, const u8 *iv,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct uw_req_pl {
 		struct pl_head head;
@@ -1182,7 +1186,6 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	api = (!keygenflags || keygenflags & 0x00200000) ?
@@ -1291,7 +1294,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 			  u32 mech, const u8 *iv,
 			  u32 keybitsize, u32 keygenflags,
 			  u8 *keybuf, u32 *keybufsize,
-			  u8 keybufver)
+			  u8 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -1305,7 +1308,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 
 	rc = _ep11_unwrapkey(card, domain, kek, keksize, enckey, enckeysize,
 			     mech, iv, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -1324,7 +1327,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 static int _ep11_wrapkey(u16 card, u16 domain,
 			 const u8 *key, size_t keysize,
 			 u32 mech, const u8 *iv,
-			 u8 *databuf, size_t *datasize)
+			 u8 *databuf, size_t *datasize, u32 xflags)
 {
 	struct wk_req_pl {
 		struct pl_head head;
@@ -1357,7 +1360,6 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
@@ -1448,8 +1450,10 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		     u32 keytype)
 {
 	int rc;
-	u8 encbuf[64], *kek = NULL;
+	void *mem;
+	u8 encbuf[64], *kek;
 	size_t clrkeylen, keklen, encbuflen = sizeof(encbuf);
+	const u32 xflags = 0;
 
 	if (keybitsize == 128 || keybitsize == 192 || keybitsize == 256) {
 		clrkeylen = keybitsize / 8;
@@ -1459,18 +1463,24 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		return -EINVAL;
 	}
 
-	/* allocate memory for the temp kek */
+	/*
+	 * Allocate space for the temp kek.
+	 * Also we only need up to MAXEP11AESKEYBLOBSIZE bytes for this
+	 * we use the already existing cprb mempool to solve this
+	 * short term memory requirement.
+	 */
+	mem = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+	kek = (u8 *)mem;
 	keklen = MAXEP11AESKEYBLOBSIZE;
-	kek = kmalloc(keklen, GFP_ATOMIC);
-	if (!kek) {
-		rc = -ENOMEM;
-		goto out;
-	}
 
 	/* Step 1: generate AES 256 bit random kek key */
 	rc = _ep11_genaeskey(card, domain, 256,
 			     0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
-			     kek, &keklen);
+			     kek, &keklen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s generate kek key failed, rc=%d\n",
 			       __func__, rc);
@@ -1479,7 +1489,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 
 	/* Step 2: encrypt clear key value with the kek key */
 	rc = ep11_cryptsingle(card, domain, 0, 0, def_iv, kek, keklen,
-			      clrkey, clrkeylen, encbuf, &encbuflen);
+			      clrkey, clrkeylen, encbuf, &encbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s encrypting key value with kek key failed, rc=%d\n",
 			       __func__, rc);
@@ -1489,7 +1499,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	/* Step 3: import the encrypted key value as a new key */
 	rc = ep11_unwrapkey(card, domain, kek, keklen,
 			    encbuf, encbuflen, 0, def_iv,
-			    keybitsize, 0, keybuf, keybufsize, keytype);
+			    keybitsize, 0, keybuf, keybufsize, keytype, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
@@ -1497,7 +1507,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 out:
-	kfree(kek);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_clr2keyblob);
@@ -1520,6 +1530,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	} __packed * wki;
 	u8 *wkbuf = NULL;
 	int rc = -EIO;
+	const u32 xflags = 0;
 
 	if (ep11_kb_decode((u8 *)keyblob, keybloblen, &hdr, NULL, &key, &keylen))
 		return -EINVAL;
@@ -1530,15 +1541,29 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	}
 	/* !!! hdr is no longer a valid header !!! */
 
-	/* alloc temp working buffer */
+	/* need a temp working buffer */
 	wkbuflen = (keylen + AES_BLOCK_SIZE) & (~(AES_BLOCK_SIZE - 1));
-	wkbuf = kmalloc(wkbuflen, GFP_ATOMIC);
-	if (!wkbuf)
-		return -ENOMEM;
+	if (wkbuflen > CPRB_MEMPOOL_ITEM_SIZE) {
+		/* this should never happen */
+		rc = -ENOMEM;
+		ZCRYPT_DBF_ERR("%s wkbuflen %d > cprb mempool item size %d, rc=%d\n",
+			       __func__, (int)wkbuflen, CPRB_MEMPOOL_ITEM_SIZE, rc);
+		return rc;
+	}
+	/* use the cprb mempool to satisfy this short term mem allocation */
+	wkbuf = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_ATOMIC);
+	if (!wkbuf) {
+		rc = -ENOMEM;
+		ZCRYPT_DBF_ERR("%s allocating tmp buffer via cprb mempool failed, rc=%d\n",
+			       __func__, rc);
+		return rc;
+	}
 
 	/* ep11 secure key -> protected key + info */
 	rc = _ep11_wrapkey(card, dom, (u8 *)key, keylen,
-			   0, def_iv, wkbuf, &wkbuflen);
+			   0, def_iv, wkbuf, &wkbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s rewrapping ep11 key to pkey failed, rc=%d\n",
 			       __func__, rc);
@@ -1605,7 +1630,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	*protkeylen = wki->pkeysize;
 
 out:
-	kfree(wkbuf);
+	mempool_free(wkbuf, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_kblob2protkey);
@@ -1618,6 +1643,7 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 	u32 _nr_apqns = 0;
+	const u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1650,14 +1676,14 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 			continue;
 		/* check min api version if given */
 		if (minapi > 0) {
-			if (ep11_get_card_info(card, &eci, 0))
+			if (ep11_get_card_info(card, &eci, 0, xflags))
 				continue;
 			if (minapi > eci.API_ord_nr)
 				continue;
 		}
 		/* check wkvp if given */
 		if (wkvp) {
-			if (ep11_get_domain_info(card, dom, &edi))
+			if (ep11_get_domain_info(card, dom, &edi, xflags))
 				continue;
 			if (edi.cur_wk_state != '1')
 				continue;
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index cbd615547bc2..7ef036759dc8 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -104,18 +104,20 @@ struct ep11_domain_info {
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify);
+int ep11_get_card_info(u16 card, struct ep11_card_info *info,
+		       int verify, u32 xflags);
 
 /*
  * Provide information about a domain within an EP11 card.
  */
-int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info);
+int ep11_get_domain_info(u16 card, u16 domain,
+			 struct ep11_domain_info *info, u32 xflags);
 
 /*
  * Generate (random) EP11 AES secure key.
  */
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, u32 *keybufsize, u32 keybufver);
+		   u8 *keybuf, u32 *keybufsize, u32 keybufver, u32 xflags);
 
 /*
  * Generate EP11 AES secure key with given clear key value.
-- 
2.43.0

