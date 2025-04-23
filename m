Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB622F77F
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403356; cv=none; b=YhD7+tAA4zDgzw/w4svH12p97huHTmlSktVDjBSSo/OwmmcHCGakNlbPWR14MX6nv8gmGXgHTzR7VziqILOR/JK1KNJjf9Ho7tmCwZVnp4T2Q70RDOX7+LUpyy+JTfpFxXWByOyqBMe15LbS0VLNbGrPI/wfLdanjEwdZIovMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403356; c=relaxed/simple;
	bh=06epHebl000E2Em+mpWzvm7jqNB3uuiBZ92gwd3YuNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmTSfpNyFuwaWTQ1Cvu7tnxoIj4yA4C1sn11RmYZIo3kuBqhq8SGgzAD8pMRBbROY+Sista+3LOl131/mntcNIatfPYndbR12sx+mbYGAtajqg1AxqhIJZrYLx58mAFlFvpgyASF3IphlfGb1ZC1o5d1MB2CiKMCgmDBJx6xGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FX5lWkns; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FX5lWkns"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fjjc007115;
	Wed, 23 Apr 2025 10:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Esb1wN8EYF0y8shUS
	283FluY4sD9lN8fQlabwYbQPNo=; b=FX5lWknsNHTK3g539rKZBVsFumI5SGL0E
	uESVokdZ7YN7zUNYIFCKtXlDT0HHSBMZpUir4/SYWf8QBzLsW5PJZBDNli6HfnxZ
	vlQWja3HSLb//yfUJzL65wL/5kxBh9HuY5gunWg1GJZUOO2U9G8aZHfbEvITP2jO
	P9ve/w90KJvcVDLn8TNd/y3gR9KzDAdV+g+ANTGCHYBEag3Chc3qVbnKkWLw5uio
	LS+V8wWBKtujrup8gBo7eHGQ1qCKYvud3Sbvwic4/slfupsbBgrLQpNuRlirSTbe
	YFvtP0JljHAw/RK95m2oTz4OYBB4HbJJz2r0l1CrXJJzUjq4rmPuQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnstn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6YZ0Z022266;
	Wed, 23 Apr 2025 10:15:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxah5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFkiZ54591824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD4042004F;
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CF4720049;
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 18/25] s390/zcrypt: Rework ep11 misc functions to use cprb mempool
Date: Wed, 23 Apr 2025 12:15:27 +0200
Message-ID: <20250423101535.143137-19-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z57HvvjemhnnIiawDn8Nbienp_yhpIPx
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808bdd7 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=uT_iiDmZClQAR4kWP5sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX0HRxmilBG6sM IC+WkhFs+Xj3h7Ei7D/lwaHOSHCsCP+4qa6PyJqkwdx99WD+viBH1R+jVXw9xWPH6c9xx2FETu/ xTCkQuhoSknRq4XACPmb8scRv/PYQJdOfCuz9Am+flr9KdFExYtMRBW0nrgSibrt4z8nPCesVLZ
 YyZk9sTkl61FCkg9CwnEdEloHXS2PMz6tD/CGPKVxg/C0Ilg1EyeXK/BjCvwL2Nu7TqE1KAEkVg 3rJXNaBKpSz+Eg9wJn+t+cN8rZzcgsJ16mwhr9Z5mbXt9kTy4j0BrpY35PKMICUJd8rHDApvs3h 2YcBohodIuATiZs0qlTTds60TgOZR21XO8ZUulgsu1cURFEUwuX0yvISqLVu0mNCK0kzCV4QRpk
 OfqymK7ha1knjzNUJrya+007ObMOht9KklATwVgQCoALn32Ut8hqReXlnDGLldJ/OWl2caCc
X-Proofpoint-ORIG-GUID: Z57HvvjemhnnIiawDn8Nbienp_yhpIPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

There are two places in the ep11 misc code where a short term
memory buffer is needed. Rework this code to use the cprb mempool
to satisfy this ephemeral memory requirements.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c       |   3 +-
 drivers/s390/crypto/zcrypt_cex4.c     |  12 +--
 drivers/s390/crypto/zcrypt_ep11misc.c | 103 ++++++++++++++++----------
 drivers/s390/crypto/zcrypt_ep11misc.h |   7 +-
 4 files changed, 76 insertions(+), 49 deletions(-)

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
index 84cbcbab2741..6ba7fbddd3f7 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -214,7 +214,7 @@ static ssize_t ep11_api_ordinalnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	if (ci.API_ord_nr > 0)
 		return sysfs_emit(buf, "%u\n", ci.API_ord_nr);
@@ -234,7 +234,7 @@ static ssize_t ep11_fw_version_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	if (ci.FW_version > 0)
 		return sysfs_emit(buf, "%d.%d\n",
@@ -256,7 +256,7 @@ static ssize_t ep11_serialnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	if (ci.serial[0])
 		return sysfs_emit(buf, "%16.16s\n", ci.serial);
@@ -293,7 +293,7 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (ci.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
@@ -343,7 +343,7 @@ static ssize_t ep11_mkvps_show(struct device *dev,
 	if (zq->online)
 		ep11_get_domain_info(AP_QID_CARD(zq->queue->qid),
 				     AP_QID_QUEUE(zq->queue->qid),
-				     &di);
+				     &di, 0);
 
 	if (di.cur_wk_state == '0') {
 		n = sysfs_emit(buf, "WK CUR: %s -\n",
@@ -390,7 +390,7 @@ static ssize_t ep11_queue_op_modes_show(struct device *dev,
 	if (zq->online)
 		ep11_get_domain_info(AP_QID_CARD(zq->queue->qid),
 				     AP_QID_QUEUE(zq->queue->qid),
-				     &di);
+				     &di, 0);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (di.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index b4c97cf25fa9..268eb87bbd2b 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -549,7 +549,7 @@ static int check_reply_cprb(const struct ep11_cprb *rep, const char *func)
  * Helper function which does an ep11 query with given query type.
  */
 static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
-			   size_t buflen, u8 *buf)
+			   size_t buflen, u8 *buf, u32 xflags)
 {
 	struct ep11_info_req_pl {
 		struct pl_head head;
@@ -573,7 +573,6 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	struct ep11_target_dev target;
 	struct ep11_urb urb;
 	int api = EP11_API_V1, rc = -ENOMEM;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req = alloc_cprbmem(sizeof(struct ep11_info_req_pl), xflags);
@@ -639,7 +638,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info)
+int ep11_get_card_info(u16 card, struct ep11_card_info *info, u32 xflags)
 {
 	int rc;
 	struct ep11_module_query_info {
@@ -669,12 +668,15 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info)
 		u32 max_CP_index;
 	} __packed * pmqi = NULL;
 
-	pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
+	/* use the cprb mempool to satisfy this short term mem alloc */
+	pmqi = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_KERNEL);
 	if (!pmqi)
 		return -ENOMEM;
 	rc = ep11_query_info(card, AUTOSEL_DOM,
 			     0x01 /* module info query */,
-			     sizeof(*pmqi), (u8 *)pmqi);
+			     sizeof(*pmqi), (u8 *)pmqi, xflags);
 	if (rc)
 		goto out;
 
@@ -685,7 +687,7 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info)
 	info->op_mode = pmqi->op_mode;
 
 out:
-	kfree(pmqi);
+	mempool_free(pmqi, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_get_card_info);
@@ -693,7 +695,8 @@ EXPORT_SYMBOL(ep11_get_card_info);
 /*
  * Provide information about a domain within an EP11 card.
  */
-int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
+int ep11_get_domain_info(u16 card, u16 domain,
+			 struct ep11_domain_info *info, u32 xflags)
 {
 	int rc;
 	struct ep11_domain_query_info {
@@ -705,7 +708,8 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
 	} __packed dom_query_info;
 
 	rc = ep11_query_info(card, domain, 0x03 /* domain info query */,
-			     sizeof(dom_query_info), (u8 *)&dom_query_info);
+			     sizeof(dom_query_info), (u8 *)&dom_query_info,
+			     xflags);
 	if (rc)
 		goto out;
 
@@ -739,7 +743,7 @@ EXPORT_SYMBOL(ep11_get_domain_info);
 
 static int _ep11_genaeskey(u16 card, u16 domain,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct keygen_req_pl {
 		struct pl_head head;
@@ -777,7 +781,6 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	switch (keybitsize) {
 	case 128:
@@ -880,7 +883,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 }
 
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, u32 *keybufsize, u32 keybufver)
+		   u8 *keybuf, u32 *keybufsize, u32 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -901,7 +904,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		return rc;
 
 	rc = _ep11_genaeskey(card, domain, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -921,7 +924,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 			    u16 mode, u32 mech, const u8 *iv,
 			    const u8 *key, size_t keysize,
 			    const u8 *inbuf, size_t inbufsize,
-			    u8 *outbuf, size_t *outbufsize)
+			    u8 *outbuf, size_t *outbufsize,
+			    u32 xflags)
 {
 	struct crypt_req_pl {
 		struct pl_head head;
@@ -952,7 +956,6 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	size_t req_pl_size, rep_pl_size;
 	int n, api = EP11_API_V1, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* the simple asn1 coding used has length limits */
 	if (keysize > 0xFFFF || inbufsize > 0xFFFF)
@@ -1051,7 +1054,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 			   const u8 *enckey, size_t enckeysize,
 			   u32 mech, const u8 *iv,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct uw_req_pl {
 		struct pl_head head;
@@ -1091,7 +1094,6 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	api = (!keygenflags || keygenflags & 0x00200000) ?
@@ -1199,7 +1201,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 			  u32 mech, const u8 *iv,
 			  u32 keybitsize, u32 keygenflags,
 			  u8 *keybuf, u32 *keybufsize,
-			  u8 keybufver)
+			  u8 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -1213,7 +1215,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 
 	rc = _ep11_unwrapkey(card, domain, kek, keksize, enckey, enckeysize,
 			     mech, iv, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -1232,7 +1234,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 static int _ep11_wrapkey(u16 card, u16 domain,
 			 const u8 *key, size_t keysize,
 			 u32 mech, const u8 *iv,
-			 u8 *databuf, size_t *datasize)
+			 u8 *databuf, size_t *datasize, u32 xflags)
 {
 	struct wk_req_pl {
 		struct pl_head head;
@@ -1265,7 +1267,6 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
@@ -1355,8 +1356,10 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
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
@@ -1366,18 +1369,24 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
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
@@ -1386,7 +1395,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 
 	/* Step 2: encrypt clear key value with the kek key */
 	rc = ep11_cryptsingle(card, domain, 0, 0, def_iv, kek, keklen,
-			      clrkey, clrkeylen, encbuf, &encbuflen);
+			      clrkey, clrkeylen, encbuf, &encbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s encrypting key value with kek key failed, rc=%d\n",
 			       __func__, rc);
@@ -1396,7 +1405,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	/* Step 3: import the encrypted key value as a new key */
 	rc = ep11_unwrapkey(card, domain, kek, keklen,
 			    encbuf, encbuflen, 0, def_iv,
-			    keybitsize, 0, keybuf, keybufsize, keytype);
+			    keybitsize, 0, keybuf, keybufsize, keytype, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
@@ -1404,7 +1413,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 out:
-	kfree(kek);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_clr2keyblob);
@@ -1427,6 +1436,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	} __packed * wki;
 	u8 *wkbuf = NULL;
 	int rc = -EIO;
+	const u32 xflags = 0;
 
 	if (ep11_kb_decode((u8 *)keyblob, keybloblen, &hdr, NULL, &key, &keylen))
 		return -EINVAL;
@@ -1437,15 +1447,29 @@ int ep11_kblob2protkey(u16 card, u16 dom,
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
+		ZCRYPT_DBF_WARN("%s wkbuflen %d > cprb mempool item size %d, rc=%d\n",
+				__func__, (int)wkbuflen, CPRB_MEMPOOL_ITEM_SIZE, rc);
+		return rc;
+	}
+	/* use the cprb mempool to satisfy this short term mem allocation */
+	wkbuf = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_ATOMIC);
+	if (!wkbuf) {
+		rc = -ENOMEM;
+		ZCRYPT_DBF_WARN("%s allocating tmp buffer via cprb mempool failed, rc=%d\n",
+				__func__, rc);
+		return rc;
+	}
 
 	/* ep11 secure key -> protected key + info */
 	rc = _ep11_wrapkey(card, dom, (u8 *)key, keylen,
-			   0, def_iv, wkbuf, &wkbuflen);
+			   0, def_iv, wkbuf, &wkbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s rewrapping ep11 key to pkey failed, rc=%d\n",
 			       __func__, rc);
@@ -1512,7 +1536,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	*protkeylen = wki->pkeysize;
 
 out:
-	kfree(wkbuf);
+	mempool_free(wkbuf, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_kblob2protkey);
@@ -1525,6 +1549,7 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_card_info eci;
 	u32 _nr_apqns = 0;
 	int i, card, dom;
+	const u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1557,14 +1582,14 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 			continue;
 		/* check min api version if given */
 		if (minapi > 0) {
-			if (ep11_get_card_info(card, &eci))
+			if (ep11_get_card_info(card, &eci, xflags))
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
index 2abd77aa16cf..e875af369caf 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -104,18 +104,19 @@ struct ep11_domain_info {
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info);
+int ep11_get_card_info(u16 card, struct ep11_card_info *info, u32 xflags);
 
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

