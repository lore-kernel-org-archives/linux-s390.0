Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5314D2BB
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501792; cv=none; b=ZErRsIG14QzCGCRAJS9XpoHU032zavrX+dwU19S7rlNo/y705YxyorsFgYpfv6oXKtk3Gq+3ELldS/W5pZxiTINk7E4I3FKiK61O4wfY5Ff9ccZJrcekrDsYUWkc8xHVEgQMRZYOfhnjHvufzFFCsttiz7bT1TYvaFFQLkt1vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501792; c=relaxed/simple;
	bh=UicVPelamysnXbAkH3Tfho97qT7BZVO/tXl4i2S4ue0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu+AsWWD3/pFjk9CFpH92FwL8BA4N5rKp/S2ozxBEGaW9jQmdqoA81qr480ZShcTNFK92lau6WlY0dbKIdQCnepcygjSyzRb5sCqI4O+8QzuwmE7t2+clwTM/mZCQ353QX+VZwCsAsC59fne/8ooN/7yFlees+8t9mdxoaQFvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rv6YVPOV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rv6YVPOV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBYFgR005907;
	Thu, 24 Apr 2025 13:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/OGRyDydf72usZEFN
	OtiWCusMEAT2s8bbMDVcrY+RF0=; b=rv6YVPOVGZc5QRkWdQAvL0Jv6cWfhgZ1l
	IEgi4IHDnohNEo5+HOvtM1wCcXb+6psOgIZYK5DhVYMuqFZirT1lUIJ0wpn2qjQa
	hvUPbCRKprD9QtN7DogGcrkIXiCxJ52w3NkMLHWjxK1eNm+/mqAnoHvAdAppprpq
	pwzzJ+VrafcISUxzkZtwGPRs2IxFnq8amMdiwdbnoxGsOLTP/d2U8lEQoOjEGMmk
	p3yc9iuXqfQX/6JUEk3Wpfz8L1RRsckkXO+VFZSCLE0W4cCf5qf2xHs7Q2pMdoTq
	l+PLg9CPeQTQTOCDqDcLhJVOv2y3wGuJkqUn6RHf3HNEGc59zfUxg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467a60u8wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBOb0t028447;
	Thu, 24 Apr 2025 13:36:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvrcgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaNtA51380570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305DC2004D;
	Thu, 24 Apr 2025 13:36:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B056920043;
	Thu, 24 Apr 2025 13:36:22 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:22 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 06/25] s390/zcrypt: Introduce cprb mempool for cca misc functions
Date: Thu, 24 Apr 2025 15:36:00 +0200
Message-ID: <20250424133619.16495-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q47S452a c=1 sm=1 tr=0 ts=680a3e5b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=s06wtcrjarc6v0j-KaQA:9
X-Proofpoint-GUID: SPL_9DfbBkvn4I8jZuM-D4CWBB2bIODx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4OCBTYWx0ZWRfX+rLFiJbrd9P3 kwqw8Nh7fCcChAcXRXh65vGhqsXwnjQJFjp3Sd/4Hl3IDZVCHYmAzB3IusQJEcamv77Yco4RJmn nbps+o1YMbTGYXYu20ZqYoI8DhBpyAdZViHBFmxCg09PXIBqlifBz/LGf+LGJzYbwsFkmhwPXGp
 bz5jETwtZ1prqtUYS1hgKWuBm3MMONj9XszzIi7lreB2dlZeMOzCBYQK4w1hQJP4PM3i+BvypJ4 /CWZd3PsyxVPiO5dgVemeGrrwH/HUFkvhBjXa79IGfHd92YnlWH7spCmd7fMY/4dYkY1kOxuo9Y xlTkNBpeE/s4T8WuSeGHevkAgRjek+W2XbXI0Zb2stt7jU0ZwQJx6QV4/HiGEK+5QHyqcEptef+
 D+Fti6DgGz5zwKXJT2JyIJUDxqBtIfQHnrIgWOVsGd3v/Mz1nEzTbUxpT8bLi53gXzYo1mtR
X-Proofpoint-ORIG-GUID: SPL_9DfbBkvn4I8jZuM-D4CWBB2bIODx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240088

Introduce a new module parameter "zcrypt_mempool_threshold"
for the zcrypt module. This parameter controls the minimal
amount of mempool items which are pre-allocated for urgent
requests/replies and will be used with the support for the
new xflag ZCRYPT_XFLAG_NOMEMALLOC. The default value of 5
shall provide enough memory items to support up to 5 requests
(and their associated reply) in parallel. The minimum value
is 1 and is checked in zcrypt module init().

If the mempool is depleted upon one cca misc functions is called
with the named xflag set, the function will fail with -ENOMEM
and the caller is responsible for taking further actions.

For CCA each mempool item is 16KB, as a CCA CPRB needs to
hold the request and the reply. The pool items only support
requests/replies with a limit of about 8KB.
So by default the CCA mempool consumes
  5 * 16KB = 80KB

This is only part of an rework to support a new xflag
ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c     |  19 ++++-
 drivers/s390/crypto/zcrypt_api.h     |   2 +
 drivers/s390/crypto/zcrypt_ccamisc.c | 113 +++++++++++++++++++--------
 drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
 4 files changed, 103 insertions(+), 32 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 3a75c3b6c004..57d819966dad 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -50,6 +50,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor interface, " \
 		   "Copyright IBM Corp. 2001, 2012");
 MODULE_LICENSE("GPL");
 
+unsigned int zcrypt_mempool_threshold = 5;
+module_param_named(mempool_threshold, zcrypt_mempool_threshold, uint, 0440);
+MODULE_PARM_DESC(mempool_threshold, "CCA and EP11 request/reply mempool minimal items (min: 1)");
+
 /*
  * zcrypt tracepoint functions
  */
@@ -2144,13 +2148,23 @@ int __init zcrypt_api_init(void)
 {
 	int rc;
 
+	/* make sure the mempool threshold is >= 1 */
+	if (zcrypt_mempool_threshold < 1) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	rc = zcrypt_debug_init();
 	if (rc)
 		goto out;
 
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
@@ -2163,7 +2177,10 @@ int __init zcrypt_api_init(void)
 	return 0;
 
 out_misc_register_failed:
+	zcrypt_ccamisc_exit();
+out_ccamisc_init_failed:
 	zcdn_exit();
+out_zcdn_init_failed:
 	zcrypt_debug_exit();
 out:
 	return rc;
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 94dffb01942f..84d636fd14a4 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -139,6 +139,8 @@ extern atomic_t zcrypt_rescan_req;
 extern spinlock_t zcrypt_list_lock;
 extern struct list_head zcrypt_card_list;
 
+extern unsigned int zcrypt_mempool_threshold;
+
 #define for_each_zcrypt_card(_zc) \
 	list_for_each_entry(_zc, &zcrypt_card_list, list)
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 521baaea06ff..d51ab5a0c58f 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/init.h>
+#include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/random.h>
@@ -40,6 +41,16 @@ struct cca_info_list_entry {
 static LIST_HEAD(cca_info_list);
 static DEFINE_SPINLOCK(cca_info_list_lock);
 
+/*
+ * Cprb memory pool held for urgent cases where no memory
+ * can be allocated via kmalloc. This pool is only used
+ * when alloc_and_prep_cprbmem() is called with the xflag
+ * ZCRYPT_XFLAG_NOMEMALLOC. The cprb memory needs to hold
+ * space for request AND reply!
+ */
+#define CPRB_MEMPOOL_ITEM_SIZE (16 * 1024)
+static mempool_t *cprb_mempool;
+
 /*
  * Simple check if the token is a valid CCA secure AES data key
  * token. If keybitsize is given, the bitsize of the key is
@@ -219,19 +230,27 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
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
+	size_t len = 2 * cprbplusparamblen;
 	struct CPRBX *preqcblk, *prepcblk;
 
 	/*
 	 * allocate consecutive memory for request CPRB, request param
 	 * block, reply CPRB and reply param block
 	 */
-	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		if (len <= CPRB_MEMPOOL_ITEM_SIZE)
+			cprbmem = mempool_alloc_preallocated(cprb_mempool);
+	} else {
+		cprbmem = kmalloc(len, GFP_KERNEL);
+	}
 	if (!cprbmem)
 		return -ENOMEM;
+	memset(cprbmem, 0, len);
 
 	preqcblk = (struct CPRBX *)cprbmem;
 	prepcblk = (struct CPRBX *)(cprbmem + cprbplusparamblen);
@@ -261,11 +280,15 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
  * with zeros before freeing (useful if there was some
  * clear key material in there).
  */
-static void free_cprbmem(void *mem, size_t paramblen, int scrub)
+static void free_cprbmem(void *mem, size_t paramblen, bool scrub, u32 xflags)
 {
-	if (scrub)
+	if (mem && scrub)
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
@@ -1959,7 +1998,19 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(cca_findcard2);
 
-void __exit zcrypt_ccamisc_exit(void)
+int __init zcrypt_ccamisc_init(void)
+{
+	/* Pre-allocate a small memory pool for cca cprbs. */
+	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_mempool_threshold,
+						   CPRB_MEMPOOL_ITEM_SIZE);
+	if (!cprb_mempool)
+		return -ENOMEM;
+
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

