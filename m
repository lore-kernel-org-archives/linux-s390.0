Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BC265632
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207400; cv=none; b=VGzMfoYf197oSk2W/zlFx1XpdwN/J+p365tflqrbKs+xAPur3M6+BUbBIoyabFMUYA6n4vlVwnkUI6pb5gCyaDeSZihKtVukqaYUZR69ozjjPLQu6M6E6VYFUaE0Gp6ML+8kzTt1LLm8b09yUidrFr6yhJeEj/Zv7e7vaxrjDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207400; c=relaxed/simple;
	bh=Qxr9Sx8OnscEkL7VwyVXa/JwSi838ZN7qc+/vhmL8I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+dEKwSiZE6xia7OrtQGotg8VCn66xboY0W9akspko6yuUyQZQ9D/jjuJ2CE8eyDaFEh74pcV5h1/d/iVj4m+DKi4vhtAdEA5/omy+BDvEyNIwHiwMXr5JyjINo/QT4441c9MxRYXWWnmJTcRyCkwiYWutR/5AnbBapWPGedSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WsF0XZuq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WsF0XZuq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539E3EXU026335;
	Wed, 9 Apr 2025 14:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=juZYt3tS3M+qg/JTU
	y1RnfNNW/smSWUAlQltQSt25FY=; b=WsF0XZuqqC2IAC1qM731OPy2BmAPgdUhD
	hwvnnNseYOBlj7gf3d0NZsoRi8VzatRZim/7kpyhkgjfTLrQ5MP8uWtmLcuUlZkp
	P2aw2mfsjlsKvNPax7xnjOvhoW5+MH8oBmRXuzaEyNUM41m+YaKFZnVvmyUZcrEL
	iMD3yIYue/EUOyhFkqmZIKw8xmZgGWyZbYGp4hcxkWcJ/GxZEoeE2swlZkQozqL3
	skvChd2QeGcml4kNZAtgm9EfWAYkrabJvPCNDa8Dd1rLQ3j2kgMi/9uZQtWiWTY/
	QEWQBZjs5H6bBUQSLEGxePz8u4ItR5wJmXC5reUozdYidCNXJHHHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq000u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539E1jaZ025525;
	Wed, 9 Apr 2025 14:03:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkyy46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3AsW59638210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA6D20040;
	Wed,  9 Apr 2025 14:03:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D0D2004B;
	Wed,  9 Apr 2025 14:03:10 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 06/24] s390/zcrypt: Introduce cprb mempool for cca misc functions
Date: Wed,  9 Apr 2025 16:02:47 +0200
Message-ID: <20250409140305.58900-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409140305.58900-1-freude@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9j7nO61JZ9JDmEDtd9QKbAt5eDqz49On
X-Proofpoint-ORIG-GUID: 9j7nO61JZ9JDmEDtd9QKbAt5eDqz49On
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504090086

Introduce a new module parameter "zcrypt_mempool_threshold"
for the zcrypt module. This parameter controls the minimal
amount of mempool items which are pre-allocated for urgent
requests/replies and will be used with the support for the
new xflag ZCRYPT_XFLAG_NOMEMALLOC. The default value of 5
shall provide enough memory items to support up to 5 requests
(and their associated reply) in parallel. The minimum value
is 1 and is checked and maybe adjusted in the module init().

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
 drivers/s390/crypto/zcrypt_api.c     |  16 +++-
 drivers/s390/crypto/zcrypt_api.h     |   2 +
 drivers/s390/crypto/zcrypt_ccamisc.c | 116 ++++++++++++++++++++-------
 drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
 4 files changed, 104 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index f753c0403a18..888ab289bd10 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -50,6 +50,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor interface, " \
 		   "Copyright IBM Corp. 2001, 2012");
 MODULE_LICENSE("GPL");
 
+unsigned int zcrypt_mempool_threshold = 5;
+module_param_named(mempool_threshold, zcrypt_mempool_threshold, uint, 0440);
+MODULE_PARM_DESC(mempool_threshold, "CCA and EP11 request/reply mempool minimal items.");
+
 /*
  * zcrypt tracepoint functions
  */
@@ -2147,13 +2151,20 @@ int __init zcrypt_api_init(void)
 {
 	int rc;
 
+	/* make sure the mempool threshold is >= 1 */
+	zcrypt_mempool_threshold = max_t(unsigned int, zcrypt_mempool_threshold, 1);
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
@@ -2166,7 +2177,10 @@ int __init zcrypt_api_init(void)
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
index 521baaea06ff..05085b40a55c 100644
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
@@ -219,9 +230,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
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
 
@@ -229,7 +241,16 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 	 * allocate consecutive memory for request CPRB, request param
 	 * block, reply CPRB and reply param block
 	 */
-	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		size_t len = 2 * cprbplusparamblen;
+
+		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
+			cprbmem = mempool_alloc_preallocated(cprb_mempool);
+			memset(cprbmem, 0, len);
+		}
+	} else {
+		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
+	}
 	if (!cprbmem)
 		return -ENOMEM;
 
@@ -261,11 +282,15 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
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
@@ -330,9 +355,11 @@ int cca_genseckey(u16 cardnr, u16 domain,
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
 
@@ -379,7 +406,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, errno %d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -424,7 +451,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	memcpy(seckey, prepparm->lv3.keyblock.tok, SECKEYBLOBSIZE);
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, false, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_genseckey);
@@ -471,9 +498,11 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
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
 
@@ -517,7 +546,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -563,7 +592,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 		memcpy(seckey, prepparm->lv3.keyblock.tok, SECKEYBLOBSIZE);
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 1);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2seckey);
@@ -617,9 +646,11 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
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
 
@@ -644,7 +675,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -712,7 +743,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 		*protkeylen = prepparm->lv3.ckb.len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_sec2protkey);
@@ -811,9 +842,11 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
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
 
@@ -872,7 +905,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -923,7 +956,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	*keybufsize = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, false, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_gencipherkey);
@@ -987,9 +1020,11 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
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
 
@@ -1038,7 +1073,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1077,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, false, xflags);
 	return rc;
 }
 
@@ -1217,9 +1252,11 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
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
 
@@ -1249,7 +1286,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1323,7 +1360,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 		*protkeylen = prepparm->vud.ckb.keylen;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_cipher2protkey);
@@ -1380,9 +1417,11 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
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
 
@@ -1412,7 +1451,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1470,7 +1509,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 		*protkeytype = PKEY_KEYTYPE_ECC;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, true, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_ecc2protkey);
@@ -1503,9 +1542,11 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
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
 
@@ -1526,7 +1567,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb, 0);
+	rc = zcrypt_send_cprb(&xcrb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1573,7 +1614,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	}
 
 out:
-	free_cprbmem(mem, parmbsize, 0);
+	free_cprbmem(mem, parmbsize, false, xflags);
 	return rc;
 }
 EXPORT_SYMBOL(cca_query_crypto_facility);
@@ -1959,7 +2000,22 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(cca_findcard2);
 
-void __exit zcrypt_ccamisc_exit(void)
+int __init zcrypt_ccamisc_init(void)
+{
+	/* Pre-allocate a small memory pool for cca cprbs. */
+	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_mempool_threshold,
+						   CPRB_MEMPOOL_ITEM_SIZE);
+	if (!cprb_mempool) {
+		ZCRYPT_DBF_WARN("%s mempool_create(%d,%d) failed: %ld\n",
+				__func__, zcrypt_mempool_threshold,
+				CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
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

