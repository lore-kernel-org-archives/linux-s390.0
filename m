Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285B33711D
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746020; cv=none; b=RmIQcCbyFTSTkMAVOev7OhS4jMbnr1Ang3a/K6rHNIK5X85VtBEeTRGFJ/zUFFrS5fTkyrHCHNYu+o4teYgonuKEHDLRpsuNx4Blvg/+NDvLMMMOpgrRFXXQgyMXSamTMYJ4X+wUx3p1WRlVxgQuV91X/Tcu/Yj6uKGEGgLCMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746020; c=relaxed/simple;
	bh=O43A++24HWBuHgb8MgIpK4pHov/RE41l+A/MH5H6z94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+4enunQ5IZrFJd2C/ATUo6vIacxIA/Hmkrhu4DDIiJ/PzKCntgtUny1SkHdTAiS3TzNcfu4CdyhBC+YPFpJ594rxjzjHIKqbiG65u49GOmgWgyw/01u8kZYyUcLsJzbQ58q3Gb8SufhxcG2VkoBfluXFlzQZA1MWejQHGHXiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WK/em7J5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WK/em7J5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm9Xa168336
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vD5/RC0Rv/xhzv3Qi
	MDdAO74h1TvWd2H2jWR7uQeSu4=; b=WK/em7J5FqOYVeXRXlVSwg+T4gXDk03VP
	UNneTPNmsvkt4PFAFWlnJv15RLchPIYeSLQDXt9umvtaROb9rSiZSAMOOkUTOz45
	6wpf0inRHOWe3Kf169I/Vw5NtJk59OoEkfQTBn7/SfzOfFAyT5VDPqYHPWQQSAo9
	xtB0+lONCz6AIFEA1dyig807lkiAn7GDvqk9vBWom8xBJOYouGbqrJ//QCmVwHIV
	QAHM/YFPAUnUD3ehQGNuc64oU5+ElKArnfWj4ab7Rq4vAduyoqXWvCx1hKJIbreM
	PJbJFr7lCQOFdLLD/HB2eq0VaP7o+2UdxCobpxIsL3ROGJA9VPtWQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fyk60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:33:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738QI1W000556
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:33:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jvgkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:33:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6738XXjw41550290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:33:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31C12004E;
	Mon,  3 Aug 2026 08:33:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E06D20067;
	Mon,  3 Aug 2026 08:33:33 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:33:33 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v11 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
Date: Mon,  3 Aug 2026 10:33:34 +0200
Message-ID: <20260803083339.212885-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803083339.212885-1-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3MiBTYWx0ZWRfX1jieJYJeecHY
 jUzgqx6BYu7gRB6fjCIufJG7BdQyAyJosNbSjGquWOgF5yoArxVYLKG8b+NJ341MH2Kqn83+vuk
 EV2Yf3IkMLDYSzEuy843KqQL2JFOMr22aFqBVkJNwPSmXDhZ2UTAME6hhttq26n3fdNkoQ9d/m0
 FORxpktN+XFfJaitf9ujVLBmz6BXNQyp4qjukP6Cepa8R0HN3Ma8DxGg9mZEjjZewfI89KeGUKz
 T4UZ2Iiwwr/sb1c6uM6XV7Yo3itrU9fjrPT7/L9VzHAtx9eVHeJYJwe48wgDUaIrY5UIGXqTNDT
 RndgbUCV7/hGFcmziwjssK58S6ITPl2dnA7uQKiJiarZKbk1i1vZG2MXSwsI87AcJp/GS+A5H2Z
 9qQzsRVl299jO4Kg1htj49G6gafr1QWBtV9W5WyGTXdfgVKds6/tc5yZNPoGQ8abM+qgVgVez+p
 vmAgmfbc+H2ZZXFmkgw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a705262 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=uY6hddB1wUZoGjyr-5sA:9
X-Proofpoint-GUID: HuLiWDnIN48FGjuNHrGLwFkCHxDR0O6n
X-Proofpoint-ORIG-GUID: HuLiWDnIN48FGjuNHrGLwFkCHxDR0O6n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3MiBTYWx0ZWRfXyBPdf7HpRD9+
 gHMUYTE71WeQO94TgHK/DnRygeg26BJb3Il+3zf75fsTeLVjl4+3j1PBqFIFtxymRik02gK2stS
 Oanwhz1pmJ0TqJMVQnR+c+wEsDEuP08=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030072

Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
did not round up the memory allocation to a multiple of 4 bytes as it
is needed by the zcrypt layer to process the CPRBs.

Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
guarantee that the base CPRB struct and a possible parameter block are
aligned to a 4-byte boundary and the backing memory allocation is
rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
updated and scrubs the rounded up amount of memory.

Fixes: 9bdb5f7e8369 ("s390/zcrypt: Introduce cprb mempool for cca misc functions")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 drivers/s390/crypto/zcrypt_ccamisc.c  | 20 ++++++++++++++------
 drivers/s390/crypto/zcrypt_ep11misc.c | 16 +++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 86d2ee78c9f4..d4ce6352b5b2 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/align.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 
@@ -267,6 +268,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
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
@@ -275,7 +280,8 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 				  u32 xflags)
 {
 	u8 *cprbmem = NULL;
-	size_t cprbplusparamblen = sizeof(struct CPRBX) + paramblen;
+	size_t cprbplusparamblen =
+		ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);
 	size_t len = 2 * cprbplusparamblen;
 	struct CPRBX *preqcblk, *prepcblk;
 
@@ -302,10 +308,10 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
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
@@ -323,8 +329,10 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
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

