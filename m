Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C3D3AAF4D
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339907; cv=none; b=dlkG9X+uNILk7R9m/aV0ws4qF3iyjVkEuIOhCm1jKfcbz3k0X4m2MxsBWbcUK7eBGnsv1JT1KhY+6OVDOICj5sN3DDd/gpmR+SSh3i3oa/n4Dk3vzgM+Mn9q8jRCc3HABtVlWmyH4BRR+SGc0LtnYycGUOVDw2TaCTpV6ROVr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339907; c=relaxed/simple;
	bh=DndJezGze8U83zhp4eSB5t69jzOAnydTCwNEl2v0Wv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzrpWtdFXsZydJ4giIJeMN84qBCaxVqf1u7eJDVOjO0xE4VDKytMrjggXDN+0VOpYLx8RM5sYr36QTxT6L5JgXlo59zry12YZOFLoWGBASap3jPXOZHSer0O/VdeIhoMzDf7jPXqlqRUUbCwZkSRKYpiex/sDqHr9jsOVYOoNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bagSvArE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bagSvArE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHbSm388620
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LIbLWU9nuSKFmil4X
	2uGwLBO0oo9LqSZO1O50Pp3Aj0=; b=bagSvArEEHKM4GOy/CpJNzO0aiu/djePl
	1ltNsvnnO/ZjlKJBA9NA+5as0+5NEYdUdagI+AfD/LCCy1zJBW0G+w04gTdih9sd
	6EG5I58eaaXH3cvsBBv1LGwXJe1br0YNK8WEDwzckFU0vvn/yFptwLcZL38CB5G0
	RduYQzCRduQJBhW5gzMogqBvEdewCvQS3UKpC1ZephzXROCsI7J9PeWGApxfMhkJ
	z6L/ij5ydSZB2dfXUPx4W2DE3Zblsf4Jnkx75o+yjLBRjYGWWZLSEjJsBGlJ//NI
	7tWMM+31x5fvdOIzTkfTKkNJCgcpPj2h3HFRL+/PfO1Nl6rpolB6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xugbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfNEV013452
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw7f0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFj0ti27591022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:45:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F215B20040;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBDFD2004D;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v9 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
Date: Wed, 29 Jul 2026 17:44:54 +0200
Message-ID: <20260729154458.195135-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729154458.195135-1-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KbUoCiOdNmDxYcu1zXRZCWn3hMgjZf0f
X-Proofpoint-ORIG-GUID: KbUoCiOdNmDxYcu1zXRZCWn3hMgjZf0f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX6hobGmn3tzP8
 tra5VK5L6uM/RjDBhF+P+lizQEkUETbOy3r/wl4fu1tL1LjgxFZqLqJkP/NHBI7/mibm7GkfPxl
 FTjRmyrAg7cZ/UGcL5f3S3DbdRNHEns=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a2001 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8qAYiVTNipp6oTadkGwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX2It++gd8MA2p
 GkWC+6jq2cst+OrOiqmXUGfyicOVyV/JMCxmBTmFqlMrjMFzyQI8Lh8xFrrd+2vu4FB9o0I5Ngn
 RVkaDCBn2KiK+7XrFjGS6K3p7yOp1Y2UIp7se8mWJYSpAgTkPWUApb2Zou6+vUkzxRjif2dSshG
 TMFiju696QxtrLG+0GRFGD+ZLIXwlIobjPca4GgKFDui1qt4xbuyKnAuaOD0gpY3k5zwQMHDYYZ
 V6ianr97pn0/sSF609G6d9LM8bPBhCN7wfLi6IUEgtyMiQx/cqma4wk9exXnl4JQr73LdoqT2W5
 uywRtHoXX0iavXXs2VPY+wCD0NRcRujEQ1mjE+9KUPKAp1NxoRqSlFZsQeTbvSc7V+12AFlDQkD
 +aN3YQ6a8PrY6Z5a/9OJSU6vBgm9h2GUutGl9vbQ9/MTsF25e4lcFMcaX2Kysa4Cp8SCJ+Eye0Y
 9FEEdThWaznQJRqZUig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
did not round up the memory allocation to a multiple of 4 bytes as it
is needed by the zcrypt layer to process the CPRBs.

Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
guarantee that the base CPRB struct and a possible parameter block are
aligned to a 4-byte boundary and the backing memory allocation is
rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
updated and scrubs the rounded up amount of memory.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c  | 20 ++++++++++++++------
 drivers/s390/crypto/zcrypt_ep11misc.c | 16 +++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 322677a8d320..16be61e92ce3 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/align.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 
@@ -231,6 +232,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
  * block, reply CPRB and reply param block and fill in values
  * for the common fields. Returns 0 on success or errno value
  * on failure.
+ * It is guaranteed that request and a possible param block
+ * are aligned to a 4 byte boundary. Furthermore if a param
+ * block is used, the memory allocated for this is rounded up to
+ * the next multiple of 4 bytes.
  */
 static int alloc_and_prep_cprbmem(size_t paramblen,
 				  u8 **p_cprb_mem,
@@ -239,7 +244,8 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 				  u32 xflags)
 {
 	u8 *cprbmem = NULL;
-	size_t cprbplusparamblen = sizeof(struct CPRBX) + paramblen;
+	size_t cprbplusparamblen =
+		ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);
 	size_t len = 2 * cprbplusparamblen;
 	struct CPRBX *preqcblk, *prepcblk;
 
@@ -266,10 +272,10 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 	memcpy(preqcblk->func_id, "T2", 2);
 	preqcblk->rpl_msgbl = cprbplusparamblen;
 	if (paramblen) {
-		preqcblk->req_parmb =
-			((u8 __user *)preqcblk) + sizeof(struct CPRBX);
-		preqcblk->rpl_parmb =
-			((u8 __user *)prepcblk) + sizeof(struct CPRBX);
+		preqcblk->req_parmb = ((u8 __user *)preqcblk) +
+			ALIGN(sizeof(struct CPRBX), 4);
+		preqcblk->rpl_parmb = ((u8 __user *)prepcblk) +
+			ALIGN(sizeof(struct CPRBX), 4);
 	}
 
 	*p_cprb_mem = cprbmem;
@@ -287,8 +293,10 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
  */
 static void free_cprbmem(void *mem, size_t paramblen, bool scrub, u32 xflags)
 {
+	size_t cprblen = ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);
+
 	if (mem && scrub)
-		memzero_explicit(mem, 2 * (sizeof(struct CPRBX) + paramblen));
+		memzero_explicit(mem, 2 * cprblen);
 
 	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
 		mempool_free(mem, cprb_mempool);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 3dda9589f2b9..2d900ffc5068 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/align.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 #include <crypto/aes.h>
@@ -355,21 +356,24 @@ EXPORT_SYMBOL(ep11_check_aes_key);
 
 /*
  * Allocate and prepare ep11 cprb plus additional payload.
+ * It is guaranteed that the memory is aligned to a 4 byte boundary.
+ * Furthermore the memory allocation is rounded up to the next
+ * multiple of 4 bytes (with taking the payload_len into account).
  */
 static void *alloc_cprbmem(size_t payload_len, u32 xflags)
 {
-	size_t len = sizeof(struct ep11_cprb) + payload_len;
+	size_t memlen = ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);
 	struct ep11_cprb *cprb = NULL;
 
 	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
-		if (len <= CPRB_MEMPOOL_ITEM_SIZE)
+		if (memlen <= CPRB_MEMPOOL_ITEM_SIZE)
 			cprb = mempool_alloc_preallocated(cprb_mempool);
 	} else {
-		cprb = kmalloc(len, GFP_KERNEL);
+		cprb = kmalloc(memlen, GFP_KERNEL);
 	}
 	if (!cprb)
 		return NULL;
-	memset(cprb, 0, len);
+	memset(cprb, 0, memlen);
 
 	cprb->cprb_len = sizeof(struct ep11_cprb);
 	cprb->cprb_ver_id = 0x04;
@@ -385,8 +389,10 @@ static void *alloc_cprbmem(size_t payload_len, u32 xflags)
  */
 static void free_cprbmem(void *mem, size_t payload_len, bool scrub, u32 xflags)
 {
+	size_t memlen = ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);
+
 	if (mem && scrub)
-		memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);
+		memzero_explicit(mem, memlen);
 
 	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
 		mempool_free(mem, cprb_mempool);
-- 
2.43.0

