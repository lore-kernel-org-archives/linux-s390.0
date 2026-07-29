Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94A39795F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335976; cv=none; b=ayjXsubvfEj/HTcM9agRLB/yno0ZVm6vS/H+09sbnEsQjH9rFo0KAWceCn1UQDxr0yXfjVFwH0e2ngcMqg5RUrbvo0UV2ZJLZLsUbxmJJKskgOfrLsjyswaW+Zuv0ArfGfQyMaD6hdAkJ5+x+lcPO5HgHIbgCz2DxyBLq6yb+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335976; c=relaxed/simple;
	bh=VN0+PHKrWKkMwHvL4FxbP8Z8AiKVdwMWQfYVwxrkHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvVQwHOTtQOz377PX/MkKphIxxovNn3/bOztEOJG92a1Y6SNWRrVnBYpyNRsz91IZrQsApr21AY1nikReyK+6c164EkKNuwmDFeU5dRHZUrjQvSNwJaKCewsG80IrRbf1lNXKQRZFNZXnf9UqT+w5rXDncohW5zkRXfQakF92E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sSW5/pcN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sSW5/pcN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHwnU021638
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zzBAD8HpQGDi6VLVT
	uYULTwxjD8yFV/9FQS5ntHmlfI=; b=sSW5/pcNo4fTIljEDDZcCrl9rHYOJ1OxY
	r7YXPi3pOdlbE8Ce+L69uPgMlcQx94egOLVoYcmZDs4m6gylL4F3s4C1rkAhPsA+
	x348HPvYxREe996PlezzY2XMPqzQ9f63mTVHUGi0krcmuGOPoyHZScZKy5iN+rb3
	VHljcx0OaOj2nYSYh2juRs2x+bJdpsELN6WMN5JjAJL8CPfILfx7GYXkLSytbadi
	ZIktUlSLKcMh8/8QB/kwLwuXEPb9Ey86h4N5M/tP6ZbIo3h7htYTjYwH8jw+ncLA
	kNlr3Q3mF3HVtqm6TrSksL72PI4leUvxYam/t2gc4zxe4nAeeukRg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntchg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEQdlj028652
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqf9dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEdTIg33685952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:39:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E8E820040;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB5462004B;
	Wed, 29 Jul 2026 14:39:28 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:39:28 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v8 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
Date: Wed, 29 Jul 2026 16:39:24 +0200
Message-ID: <20260729143928.191969-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729143928.191969-1-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX0kcwiXlfH6cm
 1m8FEVNAK2R+kKqRjenUnA8S9OB58U0YQFYdnNBwfmTam//rnxWGLqt7JfIap2u5NAG/rbEKK6I
 DAJu7DjZRtv9h3Y1CQACd/j5t62Bymk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX+5NbtbLdQ8nr
 jCYBgKC2nNxYjXik8iX75be9a2cvXfcnurCTuVRvZwc0cL3kvJYebledMMK6iB0UQC0SRa4w27R
 lTN3GCk4GEphxVhSmtbatv7QB6vqIJ5AFQoULmZJ84jDpPVuB2R7QyyHByuVoyzEeA3MJvJ8CCE
 67RW2pIQd1jUNJe34QUoPtINODGNzhk469PCI7LZnaN8N3cfhgg5cin+lvtXdiPNv0iVy/KC78E
 LNiPAwKUgZlYejUkL+JfvlY5gcjOAM+HRtompVovKA1CAZp5nvRD3nCLRlyTMQvKXDJuG9xpGGo
 J6SjokZp/ubQgFLz3kzwKAsVry+olJeAozdlYOqjw8fCapUUgEUH1z+vFAuprm6wGG301aYCIon
 6WXAaEtmg6UX5l3FhTdsA2hfkz49MxM2j/AQscqejb/BF6cU3slYJLPaa8qk1tZIx+owh/E+gY1
 OruoYL+fUNHeXHZk2xA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a10a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=8qAYiVTNipp6oTadkGwA:9
X-Proofpoint-GUID: gnqhZSXs6hVxwYbejpvyRJ0UgBONg95k
X-Proofpoint-ORIG-GUID: gnqhZSXs6hVxwYbejpvyRJ0UgBONg95k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290117

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
 drivers/s390/crypto/zcrypt_ep11misc.c | 12 ++++++++----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 84936a795b95..6819acd67c49 100644
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
index 3dda9589f2b9..e604c100ccce 100644
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
-- 
2.43.0

