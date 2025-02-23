Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9921202C42
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304511; cv=none; b=BVbyAUUCrOTkRTMYtPJZQ4PUJLaRjLnEIRGqhXpBiSN9YbU1wxK54ODPbQt0zY1KB2EqE8jPyHm2VL2oJMWFEM/N2+2SwMn5MF9WaUIDvGepB2jZ2VUdZVItb2hezu0hnWahiAcrUJYIGmnlUdZEjF7F4MWokDnEWQpxcVJKuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304511; c=relaxed/simple;
	bh=w2wSSBiPUpWjK7DUeWFBDWG52Hcz/F6XzVllkKvnWL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbyTPKXOqjcxUzvg6W4ximesLV7WdB00eConA6FMIKI+MXjUypyq17vKEyt2FiotKxGk4vdZ3qkXlJ9udSPhvDcR1+Wm8RCNySujU/n6gM9n1K3ivc3mvzUzjmqrvpUPMfzeEBtmK9oGepzxrPjJlSpts5LEXbKQLgrPbDSy/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aeUp+ZQh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aeUp+ZQh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N18MA2019838;
	Sun, 23 Feb 2025 09:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v/DLtqDIw07OtcVrE
	a6dsB0PFJ03cB5gIemVcBlq+N4=; b=aeUp+ZQhOB9th8FQO2FTTdSGu2dOEL7gJ
	JVYDB3D5yN0cDuLquhmrqAyVtXay6rbBgqVYhlee0/IgrHTz+9XDwn24tyHyOH65
	gB1uYNJi4u4it6RBdR/ECqvuk0YiFX2eXQK+XB9KRYbkweBUK6hmgBsmJ0KfuC8H
	hJU3Wm9q+M5tluCV0qTQgvKD4PMgLYBYGws2VEELyZhiz4nigb0t+DF5rqFMKtS9
	TZH3JnVCdPuPXukXl4kwKxlkHJT67aAE8mn3ef1egmfexJlhWKEVWp7wlkF9mlYY
	QvBDRvDn2DX5aaQV5QIMbmtL35MRRjfTUnAixDYOfbNBhak2UwiJA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9sapp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N60IMF026404;
	Sun, 23 Feb 2025 09:55:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswn1pyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t2Bf58655184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33F6720040;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD7B42004B;
	Sun, 23 Feb 2025 09:55:01 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:01 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 05/20] s390/zcrypt: Introduce cprb mempool for cca misc functions
Date: Sun, 23 Feb 2025 10:54:44 +0100
Message-ID: <20250223095459.43058-6-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: h_V4mbLscAaVytlj4VXFeBhk9lh7fjE_
X-Proofpoint-GUID: h_V4mbLscAaVytlj4VXFeBhk9lh7fjE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502230073

Intruduce a cprb mempool for the zcrypt cca misc functions
(zcrypt_ccamisc.*) do some preparation rework to support
a do-not-allocate path through some zcrypt cca misc functions.

This is only part of an rework to support a new xflag
ZCRYPT_XFLAG_NOMEMALLOC but not jet complete.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c     |   9 ++-
 drivers/s390/crypto/zcrypt_ccamisc.c | 115 ++++++++++++++++++++-------
 drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
 3 files changed, 94 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index f6deb10329e6..6be60b9dc83f 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -2154,7 +2154,11 @@ int __init zcrypt_api_init(void)
 
 	rc = zcdn_init();
 	if (rc)
-		goto out;
+		goto out_zcdn_init_failed;
+
+	rc = zcrypt_ccamisc_init();
+	if (rc)
+		goto out_ccamisc_init_failed;
 
 	/* Register the request sprayer. */
 	rc = misc_register(&zcrypt_misc_device);
@@ -2167,7 +2171,10 @@ int __init zcrypt_api_init(void)
 	return 0;
 
 out_misc_register_failed:
+	zcrypt_ccamisc_exit();
+out_ccamisc_init_failed:
 	zcdn_exit();
+out_zcdn_init_failed:
 	zcrypt_debug_exit();
 out:
 	return rc;
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 521baaea06ff..e604a69e40fc 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/init.h>
+#include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/random.h>
@@ -40,6 +41,17 @@ struct cca_info_list_entry {
 static LIST_HEAD(cca_info_list);
 static DEFINE_SPINLOCK(cca_info_list_lock);
 
+/*
+ * Cprb memory pool held for urgend cases where no memory
+ * can be allocated via kmalloc. This pool is only used
+ * when alloc_and_prep_cprbmem() is called with the xflag
+ * ZCRYPT_XFLAG_NOMEMALLOC. The cprb memory needs to hold
+ * space for request AND reply!
+ */
+#define CPRB_MEMPOOL_MIN_ITEMS 4
+#define CPRB_MEMPOOL_ITEM_SIZE (16 * 1024)
+static mempool_t *cprb_mempool;
+
 /*
  * Simple check if the token is a valid CCA secure AES data key
  * token. If keybitsize is given, the bitsize of the key is
@@ -219,9 +231,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
 static int alloc_and_prep_cprbmem(size_t paramblen,
 				  u8 **p_cprb_mem,
 				  struct CPRBX **p_req_cprb,
-				  struct CPRBX **p_rep_cprb)
+				  struct CPRBX **p_rep_cprb,
+				  u32 xflags)
 {
-	u8 *cprbmem;
+	u8 *cprbmem = NULL;
 	size_t cprbplusparamblen = sizeof(struct CPRBX) + paramblen;
 	struct CPRBX *preqcblk, *prepcblk;
 
@@ -229,7 +242,13 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 	 * allocate consecutive memory for request CPRB, request param
 	 * block, reply CPRB and reply param block
 	 */
-	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		if (cprb_mempool &&
+		    2 * cprbplusparamblen <= CPRB_MEMPOOL_ITEM_SIZE)
+			cprbmem = mempool_alloc_preallocated(cprb_mempool);
+	} else {
+		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
+	}
 	if (!cprbmem)
 		return -ENOMEM;
 
@@ -261,11 +280,15 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
  * with zeros before freeing (useful if there was some
  * clear key material in there).
  */
-static void free_cprbmem(void *mem, size_t paramblen, int scrub)
+static void free_cprbmem(void *mem, size_t paramblen, bool scrub, u32 xflags)
 {
 	if (scrub)
 		memzero_explicit(mem, 2 * (sizeof(struct CPRBX) + paramblen));
-	kfree(mem);
+
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
+		mempool_free(mem, cprb_mempool);
+	else
+		kfree(mem);
 }
 
 /*
@@ -330,9 +353,11 @@ int cca_genseckey(u16 cardnr, u16 domain,
 			} keyblock;
 		} lv3;
 	} __packed * prepparm;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -379,7 +404,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, errno %d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -424,7 +449,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	memcpy(seckey, prepparm->lv3.keyblock.tok, SECKEYBLOBSIZE);
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, false, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_genseckey);
@@ -471,9 +496,11 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 			} keyblock;
 		} lv3;
 	} __packed * prepparm;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -517,7 +544,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -563,7 +590,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 		memcpy(seckey, prepparm->lv3.keyblock.tok, SECKEYBLOBSIZE);
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 1);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2seckey);
@@ -617,9 +644,11 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 			} ckb;
 		} lv3;
 	} __packed * prepparm;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -644,7 +673,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -712,7 +741,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 		*protkeylen = prepparm->lv3.ckb.len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_sec2protkey);
@@ -811,9 +840,11 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 		} kb;
 	} __packed * prepparm;
 	struct cipherkeytoken *t;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -872,7 +903,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -923,7 +954,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	*keybufsize = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, false, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_gencipherkey);
@@ -987,9 +1018,11 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	} __packed * prepparm;
 	struct cipherkeytoken *t;
 	int complete = strncmp(rule_array_2, "COMPLETE", 8) ? 0 : 1;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -1038,7 +1071,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1077,7 +1110,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, false, xflags);
 	return rc;
 }
 
@@ -1217,9 +1250,11 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 		} kb;
 	} __packed * prepparm;
 	int keytoklen = ((struct cipherkeytoken *)ckey)->len;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -1249,7 +1284,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1323,7 +1358,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 		*protkeylen = prepparm->vud.ckb.keylen;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_cipher2protkey);
@@ -1380,9 +1415,11 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 		/* followed by a key block */
 	} __packed * prepparm;
 	int keylen = ((struct eccprivkeytoken *)key)->len;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -1412,7 +1449,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1470,7 +1507,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 		*protkeytype = PKEY_KEYTYPE_ECC;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_ecc2protkey);
@@ -1503,9 +1540,11 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 		u8  subfunc_code[2];
 		u8  lvdata[];
 	} __packed * prepparm;
+	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
-	rc = alloc_and_prep_cprbmem(parmbsize, &mem, &preqcblk, &prepcblk);
+	rc = alloc_and_prep_cprbmem(parmbsize, &mem,
+				    &preqcblk, &prepcblk, xflags);
 	if (rc)
 		return rc;
 
@@ -1526,7 +1565,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1573,7 +1612,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	}
 
 out:
-	free_cprbmem(mem, parmbsize, 0);
+	free_cprbmem(mem, parmbsize, false, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_query_crypto_facility);
@@ -1959,7 +1998,23 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(cca_findcard2);
 
-void __exit zcrypt_ccamisc_exit(void)
+int __init zcrypt_ccamisc_init(void)
+{
+	/* Pre-allocate a small memory pool for cca cprbs. */
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
+void zcrypt_ccamisc_exit(void)
 {
 	mkvp_cache_free();
+	mempool_destroy(cprb_mempool);
 }
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 26bdca702523..273edf2bb036 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -272,6 +272,7 @@ struct cca_info {
  */
 int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify);
 
+int zcrypt_ccamisc_init(void);
 void zcrypt_ccamisc_exit(void);
 
 #endif /* _ZCRYPT_CCAMISC_H_ */
-- 
2.43.0

