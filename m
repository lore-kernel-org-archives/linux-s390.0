Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84934502A
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086395; cv=none; b=ZhcTWrgzWvoft+yV6ZNBwF84dlOcUTK6vbHHVFFH/WDzMIg2mdJnJryWMOPqRKBV/60Sg/fZ8Zz7ujprZB6IxKfjohnD8ceBc3b63MBUF7spHDDJBo61n1wL6yjF3fhLa5HGl1OyCo1hu67xPIz4SQCUUoTluZubKfPLJZpV9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086395; c=relaxed/simple;
	bh=ADvuvOYW1uOQQCVUiyx03DYPFzguKmQt7mGgdp2Z3Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaHwCEdQic2AH6VQ/H7OJ7inVGmAG45/uygRIbJmUX8KxTJFQzmlhSjmtFoL59IsTfrrKtCQ7Dx16Sw4loA/YUc8G2u9k+B1iJJbdakDMoq5Cl/QOJzVVPC/Tt1qMzxJuSD6/MIu/JlZmmUiXLM1Qr70Kg/rkjIsGg9I64IqVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0X/uZo+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0X/uZo+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDRZsQ017760;
	Thu, 27 Mar 2025 14:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W4hnsdKzhUJe5CXgC
	nRcFxidbcw9o/bS5IhTAa/P6oc=; b=r0X/uZo+1jbOWTPO4NKglqqropmXm2KVS
	oBnB2fRE/bvjbvI3qkXL/vigXJOX7LzylnvBRP/8AiCOuWY2sSW9GSJFInFHyr2V
	VrlrtzyJxHUXX0SSgFam1g2cJMbcNPA1VnxLGrPWEWV7NTabiCWZ/NzmkbZlmO5O
	+8kKgamjVz/gbCbSFnRXOy7aa6SzFtZxdomRb0SwhKvkScysi6QUmqouz+FMgUmx
	D+GWHBkMbMzVBhtWL3XvMgzTz1R1WQuUaSI93Wrg89daZ/N8xodj+nmlZBY+ZanD
	Nb2LhEStSPRUhhzbSE5VgPKzc4YA3p5as1Tewz0AKCSH1/wCBGuSA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mnrwnfre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBsRnj020109;
	Thu, 27 Mar 2025 14:39:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp5rex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdkA149807652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F7A20040;
	Thu, 27 Mar 2025 14:39:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 917132004B;
	Thu, 27 Mar 2025 14:39:45 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:45 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 06/21] s390/zcrypt: Introduce cprb mempool for ep11 misc functions
Date: Thu, 27 Mar 2025 15:39:26 +0100
Message-ID: <20250327143941.45507-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z7mmBpr-4UI0DPnDdXdg5K49WIDeF6Wx
X-Proofpoint-ORIG-GUID: z7mmBpr-4UI0DPnDdXdg5K49WIDeF6Wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270099

Introduce a cprb mempool for the zcrypt ep11 misc functions
(zcrypt_ep11misc.*) do some preparation rework to support
a do-not-allocate path through some zcrypt ep11 misc functions.

The mempool is controlled by the zcrypt module parameter
"mempool_threshold" which shall control the minimal amount
of memory items for CCA and EP11.

The mempool shall support "mempool_threshold" requests/replies
in parallel which means for EP11 to hold a send and receive
buffer memory per request. Each of this cprb space items is
limited to 8 KB. So by default the mempool consumes
  5 * 2 * 8KB = 80KB

This is only part of an rework to support a new xflag
ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c      |   6 +
 drivers/s390/crypto/zcrypt_ep11misc.c | 154 ++++++++++++++++----------
 drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
 3 files changed, 100 insertions(+), 61 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index cca7d7fdf644..362cb56424a3 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -2167,6 +2167,10 @@ int __init zcrypt_api_init(void)
 	if (rc)
 		goto out_ccamisc_init_failed;
 
+	rc = zcrypt_ep11misc_init();
+	if (rc)
+		goto out_ep11misc_init_failed;
+
 	/* Register the request sprayer. */
 	rc = misc_register(&zcrypt_misc_device);
 	if (rc < 0)
@@ -2178,6 +2182,8 @@ int __init zcrypt_api_init(void)
 	return 0;
 
 out_misc_register_failed:
+	zcrypt_ep11misc_exit();
+out_ep11misc_init_failed:
 	zcrypt_ccamisc_exit();
 out_ccamisc_init_failed:
 	zcdn_exit();
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index b60e262bcaa3..12efcf1b54fc 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -10,9 +10,10 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/init.h>
+#include <linux/mempool.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/slab.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 #include <crypto/aes.h>
@@ -30,6 +31,14 @@
 static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
 			       0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
 
+/*
+ * Cprb memory pool held for urgent cases where no memory
+ * can be allocated via kmalloc. This pool is only used when
+ * alloc_cprbmem() is called with the xflag ZCRYPT_XFLAG_NOMEMALLOC.
+ */
+#define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
+static mempool_t *cprb_mempool;
+
 /* ep11 card info cache */
 struct card_list_entry {
 	struct list_head list;
@@ -411,12 +420,19 @@ EXPORT_SYMBOL(ep11_check_aes_key);
 /*
  * Allocate and prepare ep11 cprb plus additional payload.
  */
-static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
+static void *alloc_cprbmem(size_t payload_len, u32 xflags)
 {
 	size_t len = sizeof(struct ep11_cprb) + payload_len;
-	struct ep11_cprb *cprb;
+	struct ep11_cprb *cprb = NULL;
 
-	cprb = kzalloc(len, GFP_KERNEL);
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
+			cprb = mempool_alloc_preallocated(cprb_mempool);
+			memset(cprb, 0, len);
+		}
+	} else {
+		cprb = kzalloc(len, GFP_KERNEL);
+	}
 	if (!cprb)
 		return NULL;
 
@@ -429,6 +445,20 @@ static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
 	return cprb;
 }
 
+/*
+ * Free ep11 cprb buffer space.
+ */
+static void free_cprbmem(void *mem, size_t payload_len, bool scrub, u32 xflags)
+{
+	if (scrub)
+		memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);
+
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
+		mempool_free(mem, cprb_mempool);
+	else
+		kfree(mem);
+}
+
 /*
  * Some helper functions related to ASN1 encoding.
  * Limited to length info <= 2 byte.
@@ -489,6 +519,7 @@ static inline void prep_urb(struct ep11_urb *u,
 			    struct ep11_cprb *req, size_t req_len,
 			    struct ep11_cprb *rep, size_t rep_len)
 {
+	memset(u, 0, sizeof(*u));
 	u->targets = (u8 __user *)t;
 	u->targets_num = nt;
 	u->req = (u8 __user *)req;
@@ -605,11 +636,12 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	} __packed * rep_pl;
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	int api = EP11_API_V1, rc = -ENOMEM;
+	const u32 xflags = 0;
 
 	/* request cprb and payload */
-	req = alloc_cprb(sizeof(struct ep11_info_req_pl));
+	req = alloc_cprbmem(sizeof(struct ep11_info_req_pl), xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct ep11_info_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -621,22 +653,19 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	req_pl->query_subtype_len = sizeof(u32);
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct ep11_info_rep_pl) + buflen);
+	rep = alloc_cprbmem(sizeof(struct ep11_info_rep_pl) + buflen, xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct ep11_info_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = cardnr;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + sizeof(*req_pl),
 		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -667,9 +696,8 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	memcpy(buf, ((u8 *)rep_pl) + sizeof(*rep_pl), rep_pl->data_len);
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, 0, false, xflags);
+	free_cprbmem(rep, 0, false, xflags);
 	return rc;
 }
 
@@ -823,9 +851,10 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	size_t req_pl_size, pinblob_size = 0;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	switch (keybitsize) {
 	case 128:
@@ -851,7 +880,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 		pinblob_size = EP11_PINBLOB_V1_BYTES;
 	}
 	req_pl_size = sizeof(struct keygen_req_pl) + ASN1TAGLEN(pinblob_size);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct keygen_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -877,22 +906,19 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	*p++ = pinblob_size;
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct keygen_rep_pl));
+	rep = alloc_cprbmem(sizeof(struct keygen_rep_pl), xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct keygen_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -925,9 +951,8 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	*keybufsize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, 0, false, xflags);
+	free_cprbmem(rep, sizeof(struct keygen_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1000,10 +1025,11 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	} __packed * rep_pl;
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	size_t req_pl_size, rep_pl_size;
 	int n, api = EP11_API_V1, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	/* the simple asn1 coding used has length limits */
 	if (keysize > 0xFFFF || inbufsize > 0xFFFF)
@@ -1012,7 +1038,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct crypt_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keysize) + ASN1TAGLEN(inbufsize);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct crypt_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -1034,22 +1060,19 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 
 	/* reply cprb and payload, assume out data size <= in data size + 32 */
 	rep_pl_size = sizeof(struct crypt_rep_pl) + ASN1TAGLEN(inbufsize + 32);
-	rep = alloc_cprb(rep_pl_size);
+	rep = alloc_cprbmem(rep_pl_size, xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct crypt_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + rep_pl_size);
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1095,9 +1118,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	*outbufsize = n;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, rep_pl_size, true, xflags);
 	return rc;
 }
 
@@ -1143,9 +1165,10 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	size_t req_pl_size, pinblob_size = 0;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	api = (!keygenflags || keygenflags & 0x00200000) ?
@@ -1161,7 +1184,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	req_pl_size = sizeof(struct uw_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keksize) + ASN1TAGLEN(0)
 		+ ASN1TAGLEN(pinblob_size) + ASN1TAGLEN(enckeysize);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct uw_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -1197,22 +1220,19 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	p += asn1tag_write(p, 0x04, enckey, enckeysize);
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct uw_rep_pl));
+	rep = alloc_cprbmem(sizeof(struct uw_rep_pl), xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct uw_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1245,9 +1265,8 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	*keybufsize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, sizeof(struct uw_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1319,15 +1338,16 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	} __packed * rep_pl;
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keysize) + 4;
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	if (!mech || mech == 0x80060001)
@@ -1357,22 +1377,19 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	*p++ = 0;
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct wk_rep_pl));
+	rep = alloc_cprbmem(sizeof(struct wk_rep_pl), xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct wk_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1405,9 +1422,8 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	*datasize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, sizeof(struct wk_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1459,7 +1475,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 			    encbuf, encbuflen, 0, def_iv,
 			    keybitsize, 0, keybuf, keybufsize, keytype);
 	if (rc) {
-		ZCRYPT_DBF_ERR("%s importing key value as new key failed,, rc=%d\n",
+		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
@@ -1658,7 +1674,23 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(ep11_findcard2);
 
-void __exit zcrypt_ep11misc_exit(void)
+int __init zcrypt_ep11misc_init(void)
+{
+	/* Pre-allocate a small memory pool for ep11 cprbs. */
+	cprb_mempool = mempool_create_kmalloc_pool(2 * zcrypt_mempool_threshold,
+						   CPRB_MEMPOOL_ITEM_SIZE);
+	if (IS_ERR(cprb_mempool)) {
+		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
+			       __func__, 2 * zcrypt_mempool_threshold,
+			       CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
+		cprb_mempool = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void zcrypt_ep11misc_exit(void)
 {
 	card_cache_free();
+	mempool_destroy(cprb_mempool);
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 9f1bdffdec68..a4b98eca8431 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -152,6 +152,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 int ep11_kblob2protkey(u16 card, u16 dom, const u8 *key, u32 keylen,
 		       u8 *protkey, u32 *protkeylen, u32 *protkeytype);
 
+int zcrypt_ep11misc_init(void);
 void zcrypt_ep11misc_exit(void);
 
 #endif /* _ZCRYPT_EP11MISC_H_ */
-- 
2.43.0

