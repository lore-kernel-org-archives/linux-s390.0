Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D02D4B53
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108894; cv=none; b=ZP1LJ1jI9PuO/An/f5Sa4Yb677c0aPjLC51Q+jEOHI4xEDphP0QIDBSpYW8jZNDwJu+DNUnPaY4yXWmOx4YzCjDZX+YHebXFfzrkbX7P0RctvntHqw1aW1W7UOA6O7047Re+dcO5XCUQCH16xSXp4VAR6MN7cLY+1EH6sgdwW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108894; c=relaxed/simple;
	bh=yZZqLPYDI2o2bUsLr77IRVW15dDKZuu4C43ziToYr2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3fwJJ3ZbNr8qDmKZiS9aI2Y9wqz5N3ArPxWM3oUmZqYU8eaeWkaspJJ+rARu2fcRfL4tKKJyxBhtveZ+MKckR6aoSb0/8tiYmbwI95sDxcRwHLbW2hXXRmlozB1aMxwPMuzSDmiPqSKkCg88x97+6CxW1OmwXjwo0BJUphYw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tklm6q1y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tklm6q1y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Gh2YO018373;
	Tue, 4 Mar 2025 17:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rx5MyJfjlLwySdN9X
	OYnkyn+i3KgR3b8yk6FhwFnERE=; b=Tklm6q1yd7NCMH76V+355RrgNJn6y3PVG
	c2Za0cWXOGVTysWDrDiKmMppPSa0sMsVZjGoITgoniid7G5wQ9yw84o8+6j5r5Ry
	n4wu3KKqZWeiK0CZC7DZRJSMerTxj3chSXhudWIZEGIAwzjyzHVZseybgH54zTlH
	UBqrS4kTB8wPECmxLcAG5vgL24HvZ+XUXcxYJQK3elVXz64S0Hda6xSzJvf+gAw7
	2qZocc+idFXG7XxMpL/f6H/Oz35toR+7bs07p0n7ARBPHxwnqGxVvxPLG4GrFSwn
	d0f+HLurMbG71dujiYgvYGMzOKVmoBjAptColRqZ8AAfPhacKj+0w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyn88v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524FP4cG020936;
	Tue, 4 Mar 2025 17:21:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnehyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLPYd48496968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F20C120040;
	Tue,  4 Mar 2025 17:21:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 840752004D;
	Tue,  4 Mar 2025 17:21:24 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 15/20] s390/zcrypt: Rework ep11 misc functions to use cprb mempool
Date: Tue,  4 Mar 2025 18:21:11 +0100
Message-ID: <20250304172116.85374-16-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304172116.85374-1-freude@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g2N8NpD0GSnBNhb7lq07cOKrS7lKSoNa
X-Proofpoint-GUID: g2N8NpD0GSnBNhb7lq07cOKrS7lKSoNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

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
index 7fb55be3e943..af59d66bff33 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -629,7 +629,7 @@ static int check_reply_cprb(const struct ep11_cprb *rep, const char *func)
  * Helper function which does an ep11 query with given query type.
  */
 static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
-			   size_t buflen, u8 *buf)
+			   size_t buflen, u8 *buf, u32 xflags)
 {
 	struct ep11_info_req_pl {
 		struct pl_head head;
@@ -653,7 +653,6 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	struct ep11_target_dev target;
 	struct ep11_urb urb;
 	int api = EP11_API_V1, rc = -ENOMEM;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req = alloc_cprbmem(sizeof(struct ep11_info_req_pl), xflags);
@@ -720,7 +719,8 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
+int ep11_get_card_info(u16 card, struct ep11_card_info *info,
+		       int verify, u32 xflags)
 {
 	int rc;
 	struct ep11_module_query_info {
@@ -752,12 +752,15 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
 
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
@@ -773,7 +776,7 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info, int verify)
 	}
 
 out:
-	kfree(pmqi);
+	mempool_free(pmqi, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_get_card_info);
@@ -781,7 +784,8 @@ EXPORT_SYMBOL(ep11_get_card_info);
 /*
  * Provide information about a domain within an EP11 card.
  */
-int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
+int ep11_get_domain_info(u16 card, u16 domain,
+			 struct ep11_domain_info *info, u32 xflags)
 {
 	int rc;
 	struct ep11_domain_query_info {
@@ -793,7 +797,8 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
 	} __packed dom_query_info;
 
 	rc = ep11_query_info(card, domain, 0x03 /* domain info query */,
-			     sizeof(dom_query_info), (u8 *)&dom_query_info);
+			     sizeof(dom_query_info), (u8 *)&dom_query_info,
+			     xflags);
 	if (rc)
 		goto out;
 
@@ -827,7 +832,7 @@ EXPORT_SYMBOL(ep11_get_domain_info);
 
 static int _ep11_genaeskey(u16 card, u16 domain,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct keygen_req_pl {
 		struct pl_head head;
@@ -865,7 +870,6 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	switch (keybitsize) {
 	case 128:
@@ -969,7 +973,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 }
 
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, u32 *keybufsize, u32 keybufver)
+		   u8 *keybuf, u32 *keybufsize, u32 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -990,7 +994,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		return rc;
 
 	rc = _ep11_genaeskey(card, domain, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -1010,7 +1014,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 			    u16 mode, u32 mech, const u8 *iv,
 			    const u8 *key, size_t keysize,
 			    const u8 *inbuf, size_t inbufsize,
-			    u8 *outbuf, size_t *outbufsize)
+			    u8 *outbuf, size_t *outbufsize,
+			    u32 xflags)
 {
 	struct crypt_req_pl {
 		struct pl_head head;
@@ -1041,7 +1046,6 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	size_t req_pl_size, rep_pl_size;
 	int n, api = EP11_API_V1, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* the simple asn1 coding used has length limits */
 	if (keysize > 0xFFFF || inbufsize > 0xFFFF)
@@ -1141,7 +1145,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 			   const u8 *enckey, size_t enckeysize,
 			   u32 mech, const u8 *iv,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct uw_req_pl {
 		struct pl_head head;
@@ -1181,7 +1185,6 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	api = (!keygenflags || keygenflags & 0x00200000) ?
@@ -1290,7 +1293,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 			  u32 mech, const u8 *iv,
 			  u32 keybitsize, u32 keygenflags,
 			  u8 *keybuf, u32 *keybufsize,
-			  u8 keybufver)
+			  u8 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -1304,7 +1307,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 
 	rc = _ep11_unwrapkey(card, domain, kek, keksize, enckey, enckeysize,
 			     mech, iv, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -1323,7 +1326,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 static int _ep11_wrapkey(u16 card, u16 domain,
 			 const u8 *key, size_t keysize,
 			 u32 mech, const u8 *iv,
-			 u8 *databuf, size_t *datasize)
+			 u8 *databuf, size_t *datasize, u32 xflags)
 {
 	struct wk_req_pl {
 		struct pl_head head;
@@ -1356,7 +1359,6 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
@@ -1447,8 +1449,10 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
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
@@ -1458,18 +1462,24 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
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
@@ -1478,7 +1488,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 
 	/* Step 2: encrypt clear key value with the kek key */
 	rc = ep11_cryptsingle(card, domain, 0, 0, def_iv, kek, keklen,
-			      clrkey, clrkeylen, encbuf, &encbuflen);
+			      clrkey, clrkeylen, encbuf, &encbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s encrypting key value with kek key failed, rc=%d\n",
 			       __func__, rc);
@@ -1488,7 +1498,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	/* Step 3: import the encrypted key value as a new key */
 	rc = ep11_unwrapkey(card, domain, kek, keklen,
 			    encbuf, encbuflen, 0, def_iv,
-			    keybitsize, 0, keybuf, keybufsize, keytype);
+			    keybitsize, 0, keybuf, keybufsize, keytype, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
@@ -1496,7 +1506,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 out:
-	kfree(kek);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_clr2keyblob);
@@ -1519,6 +1529,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	} __packed * wki;
 	u8 *wkbuf = NULL;
 	int rc = -EIO;
+	const u32 xflags = 0;
 
 	if (ep11_kb_decode((u8 *)keyblob, keybloblen, &hdr, NULL, &key, &keylen))
 		return -EINVAL;
@@ -1529,15 +1540,29 @@ int ep11_kblob2protkey(u16 card, u16 dom,
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
@@ -1604,7 +1629,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	*protkeylen = wki->pkeysize;
 
 out:
-	kfree(wkbuf);
+	mempool_free(wkbuf, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_kblob2protkey);
@@ -1617,6 +1642,7 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 	u32 _nr_apqns = 0;
+	const u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1651,14 +1677,14 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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

