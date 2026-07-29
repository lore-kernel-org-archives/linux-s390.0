Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFB381B07
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318807; cv=none; b=dL1D9jac5cAyr2FiDn8pSYmfQ+fa81eBAPFcaHcJIadHB13YokwjlMDrClZatgojIDgUjJKFvNAUsDygtS7kuiFjWJaYLWfYV3faDtM2vwHEkIGcuyOyRY61ynt51mcsmRorRWWkpZPDah6K/v3OrdWuwqUPAs7YX+OcGNvlV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318807; c=relaxed/simple;
	bh=+PscsMzSr3xE78ffiKPA2/OKs4NFGXGjroWJ0vMV7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rksw0No//TzCQeHUzRNY+Fkr8Jryww4N6pDLjX/D0GjOtbZBWE588cBjl0GYzUnlqR3AJZhuLfoApusq2E0tvwePmWvxS2B+U9zLSCTpK9EhH+/MYXfPguMzZvYHtsNPAc0nbrJjgARQ4e0MVi8GIiWt8JebhJh5LxADcgaFvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YJ+xUVCr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YJ+xUVCr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7mSe13507718
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=btcVHMDOXTC3bXESn
	lkNa7AzkYRexXTNtWaGfnJD8uM=; b=YJ+xUVCryJPGbMaYeSw3edAugxAw5pK5F
	ZsbCESacWVS+Y3iUXrrPWFZCqAlAbNzpOL66LUev/4PJ3AqMTd7yAxU8UQF6UJxS
	OQMzUusZZoIz/PteCupdzR1aYxZWIvF3Z8vFohgnL3EOHUfu3RsMLgAbyrK4wjKl
	V40Bkj6W2D2LsDMWEB63yLQp8jCcZHrPReRKUo6wuhtoL7eRl+hjG1fIMYW+XrK/
	fN61m78B6emO3uBZY42SLdz57Wt2Xt481oA2jrzZH28CWQIGDuO6bJT3OPcI/bvQ
	hOZjLxZnuZ3TBRyhGAChmT66IxEg+0ACdUFp9h+Up/AOEqE0rotmw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj98a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9fG5d017310
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgdxnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9rJQx29426056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:53:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE1A72004B;
	Wed, 29 Jul 2026 09:53:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C8952004E;
	Wed, 29 Jul 2026 09:53:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:53:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v7 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
Date: Wed, 29 Jul 2026 11:53:14 +0200
Message-ID: <20260729095318.184141-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729095318.184141-1-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX2ppFrskNm0Rn
 hYY+oksc6pZfk0JzTY7d2P1AsZ3gywfjKbQLSG0lXoCql5FmzG5SFImnJIWX65ALePel+MIYu3w
 +wglmY2VPT9Da8eGfzdXUlApesFnGqg=
X-Proofpoint-GUID: zXeWDof6lIN-LC6rCIEnRIrOVaYWXCL2
X-Proofpoint-ORIG-GUID: zXeWDof6lIN-LC6rCIEnRIrOVaYWXCL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX4cyeeeMiuImd
 qqEysOGIUc39hbToFW3yJ+its/Rbwv6uhjyHT43I/8WFoIYw1hCdpII0ZABuuJo/NBuziei+Coj
 Wikmo3S31K6i3azNlenojYyBJ5PWx1R6QLdSO+N7Q9L2qJJFaPZP6Z1/oKCMLR+qwl6sEkZjyB3
 7YvCN4pbyGcl54AlXJ7Eawc99m6zu1u3COAGFBq9sNkec8+V0XFrObZduhiL8r5QZDaw98L6zaG
 0ZR2yDcBbFYaGNTwefHlEZgTyVrfVZnDPUqeWGD0B4VqUyfPHeM1gFQXRe7DNPQ8lrCzZEFxNWt
 Ak0soBqmS8s8mVnXWXH2HCdTmHfbrH53EzBcCSsQTaeUQsAxsT0lukG1SB1ZGKh1kRru8qKABkK
 Q43KIepPL4XNys6aEuCTLJifMt5uBBqzxmnlSLYSG2CmaPvJ5uodY+SYYtl3m+p9YYsJeG5500U
 oQoBM4GDYapYsvrn2Pw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69cd94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwzV5RmOnu_Tvrgo3V0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290080

Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
did not round up the memory allocation to a multiple of 4 bytes as it
is needed by the zcrypt layer to process the CPRBs.

Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
guarantee that the base CPRB struct and a possible parameter block are
aligned to a 4-byte boundary and the backing memory allocation is
rounded up to the next multiple of 4 byte.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c  | 16 +++++++++++-----
 drivers/s390/crypto/zcrypt_ep11misc.c | 12 ++++++++----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 84936a795b95..0aa72593ae2b 100644
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

