Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A1200100
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304513; cv=none; b=IjVQ/YNMWkXd7A8VFgps7LVwkvy8Vf1qQZ+5JdOASDCXJiuEY3TaoNx/UY3m5XWm5/GL4Lztr3eIxcJW1Anp76k8mFtWv3tqM2EZhHUpJMZIuYUX8F5qhmNzDdTycAj7s9+3dozFAsYLze1JOnhbt0eE4ZBlXyxkgJP0kk97G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304513; c=relaxed/simple;
	bh=qAQiEf3ldZ7hd/L3VT6/VHzYxSzCOZQkfdBuZfsj7T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gslR4XK6kwYWACdRqd1CF950GyKhdJqV/bRDluI6w5jl9kDtcKhNLgBS4cXlV1R+DV8nZiUdI5gPN6fp4tS8L+pbCQkVK4k557WkaMOa84gXAIpbeQsKzp8/+OTOjBuif7OMZmYH7b0MSMLKsklg9xJucUD8m+Nj4w0EwRkm+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MfMZ0/Ja; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MfMZ0/Ja"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N211wX019615;
	Sun, 23 Feb 2025 09:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yKqlOOLKf1xRfzJlA
	4K6SpAzqChlsC9Y/7j8OCC9Ojs=; b=MfMZ0/Jalqtp0AHclNA8D81Rg8nCFZfzp
	ISPn11f2IhqTrmbGsK8D9B7KGMIcJV6y9iaOfSG2Oi5N6pxZiERJHMlahC1xB+UT
	DJ9Fe84eF7RoNRmFN4UpBambWt6fqlJ4EQx4FvhGruQhA7S0kZLlV2BrnjwBUg8h
	doDvFVPVm2R1mst+D0mCLispe3RY8KaplkUVjmjU+Mf1f0PklLaLYC/Ry3Rrxgsj
	aWSm+O0wDdIzw5GhX2i2t+b/7TkPZXUOO0WtBheAogFIdwr8q6kKMSnlezLT5FRT
	NHYQK3H9KtW4ZayVqpS+MJMJsD69KyLYl69d8dhrubwwlEnxIrwaQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yth016dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N9E6Vg012491;
	Sun, 23 Feb 2025 09:55:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y1wgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t2a759376114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90BB92004D;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45E0D20049;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 06/20] s390/zcrypt: Introduce cprb mempool for ep11 misc functions
Date: Sun, 23 Feb 2025 10:54:45 +0100
Message-ID: <20250223095459.43058-7-freude@linux.ibm.com>
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
X-Proofpoint-GUID: OGDnZ2m2R2Bj3Il2wPDch6vSsNAli1gs
X-Proofpoint-ORIG-GUID: OGDnZ2m2R2Bj3Il2wPDch6vSsNAli1gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502230073

Introduce a cprb mempool for zcrypt ep11 misc functions
(zcrpyt_ep11misc.*) and do some preparation rework to
support a do-not-allocate memory path through some
zcrypt ep11 misc functions.

This is only part one of a rework to support a new xflag
ZCRYPT_XFLAG_NOMEMALLOC but not jet complete.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c      |   6 +
 drivers/s390/crypto/zcrypt_ep11misc.c | 159 ++++++++++++++++----------
 drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
 3 files changed, 105 insertions(+), 61 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 6be60b9dc83f..3a521e65f3fe 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -2160,6 +2160,10 @@ int __init zcrypt_api_init(void)
 	if (rc)
 		goto out_ccamisc_init_failed;
 
+	rc = zcrypt_ep11misc_init();
+	if (rc)
+		goto out_ep11misc_init_failed;
+
 	/* Register the request sprayer. */
 	rc = misc_register(&zcrypt_misc_device);
 	if (rc < 0)
@@ -2171,6 +2175,8 @@ int __init zcrypt_api_init(void)
 	return 0;
 
 out_misc_register_failed:
+	zcrypt_ep11misc_exit();
+out_ep11misc_init_failed:
 	zcrypt_ccamisc_exit();
 out_ccamisc_init_failed:
 	zcdn_exit();
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index b60e262bcaa3..3d96bd236c16 100644
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
@@ -30,6 +31,15 @@
 static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
 			       0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
 
+/*
+ * Cprb memory pool held for urgend cases where no memory
+ * can be allocated via kmalloc. This pool is only used when
+ * alloc_cprbmem() is called with the xflag ZCRYPT_XFLAG_NOMEMALLOC.
+ */
+#define CPRB_MEMPOOL_MIN_ITEMS 8
+#define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
+static mempool_t *cprb_mempool;
+
 /* ep11 card info cache */
 struct card_list_entry {
 	struct list_head list;
@@ -411,12 +421,19 @@ EXPORT_SYMBOL(ep11_check_aes_key);
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
 
@@ -429,6 +446,20 @@ static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
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
@@ -621,22 +653,20 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
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
+	memset(&urb, 0, sizeof(urb));
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
@@ -667,9 +697,8 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	memcpy(buf, ((u8 *)rep_pl) + sizeof(*rep_pl), rep_pl->data_len);
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, 0, false, xflags);
+	free_cprbmem(rep, 0, false, xflags);
 	return rc;
 }
 
@@ -823,9 +852,10 @@ static int _ep11_genaeskey(u16 card, u16 domain,
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
@@ -851,7 +881,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 		pinblob_size = EP11_PINBLOB_V1_BYTES;
 	}
 	req_pl_size = sizeof(struct keygen_req_pl) + ASN1TAGLEN(pinblob_size);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct keygen_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -877,22 +907,20 @@ static int _ep11_genaeskey(u16 card, u16 domain,
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
+	memset(&urb, 0, sizeof(urb));
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
@@ -925,9 +953,8 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	*keybufsize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, 0, false, xflags);
+	free_cprbmem(rep, sizeof(struct keygen_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1000,10 +1027,11 @@ static int ep11_cryptsingle(u16 card, u16 domain,
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
@@ -1012,7 +1040,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct crypt_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keysize) + ASN1TAGLEN(inbufsize);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct crypt_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -1034,22 +1062,20 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 
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
+	memset(&urb, 0, sizeof(urb));
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
@@ -1095,9 +1121,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	*outbufsize = n;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, rep_pl_size, true, xflags);
 	return rc;
 }
 
@@ -1143,9 +1168,10 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
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
@@ -1161,7 +1187,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	req_pl_size = sizeof(struct uw_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keksize) + ASN1TAGLEN(0)
 		+ ASN1TAGLEN(pinblob_size) + ASN1TAGLEN(enckeysize);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct uw_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -1197,22 +1223,20 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
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
+	memset(&urb, 0, sizeof(urb));
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
@@ -1245,9 +1269,8 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	*keybufsize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, sizeof(struct uw_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1319,15 +1342,16 @@ static int _ep11_wrapkey(u16 card, u16 domain,
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
@@ -1357,22 +1381,20 @@ static int _ep11_wrapkey(u16 card, u16 domain,
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
+	memset(&urb, 0, sizeof(urb));
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
@@ -1405,9 +1427,8 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	*datasize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, sizeof(struct wk_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1459,7 +1480,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 			    encbuf, encbuflen, 0, def_iv,
 			    keybitsize, 0, keybuf, keybufsize, keytype);
 	if (rc) {
-		ZCRYPT_DBF_ERR("%s importing key value as new key failed,, rc=%d\n",
+		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
@@ -1658,7 +1679,23 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(ep11_findcard2);
 
-void __exit zcrypt_ep11misc_exit(void)
+int __init zcrypt_ep11misc_init(void)
+{
+	/* Pre-allocate a small memory pool for ep11 cprbs. */
+	cprb_mempool = mempool_create_kmalloc_pool(CPRB_MEMPOOL_MIN_ITEMS,
+						   CPRB_MEMPOOL_ITEM_SIZE);
+	if (IS_ERR(cprb_mempool)) {
+		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
+			       __func__, CPRB_MEMPOOL_MIN_ITEMS,
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

