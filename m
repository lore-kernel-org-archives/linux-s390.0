Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3C43E07D
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420915; cv=none; b=FVtKajnce6DKlkQVh+Zuu6cYZvOlfEduc41/HPujOBnCptvJsnxg03WlVta6Pf1FNV5/WVJwFhyjxYFQG5xuQ5H+i74gDn8i0HI0cNUSwCRyGTgFjymuvWl4TPty/7TiZzUD6WCfA4C602Ip89dwLtwZ+L8eF/t0ioR/IbdLe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420915; c=relaxed/simple;
	bh=wmSAc4BXY5/+i+g/SoWQ56H8Bz8NSjVka9lzWUxFSKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNMheASnbd5RuXmDUq3B68WrgQRoipUKmFUF6ZY4O7SNJSBa+HC5lBlTfGhbUt4c9GGwFyGDtp62t1kqYcutyGl3VgoRnrb+C4eLVxYiAdx2G97+/b2q3MklodHTR18GWolUCI8KPArLT6wl5Sk8VJja01t++IRd3jfBICYWNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JFbpn1YR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JFbpn1YR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHdWm3091357
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kpAhugzC4+irO8tbP
	ulNqmF8uNubkoGkvpTFTBE+nRE=; b=JFbpn1YR/z0OJpqELG3ZfRhJnk5QLbQrw
	kPHD3grLfTrQq3Cg3m2IbdxR3u/AdZSdI7gLZeYcECZem7q5K7oO+jTgEc5O4JMt
	CzomCfYQshnZMohoUZpluBK4Xt45MmmdrO2rqJCZ9ZSRWz8K1GiRK7daBiS4JGX1
	R6GtVCyybo8ty2SxORVv7x23BCsvOKDIYylqHt88/gS9oRW67g8ab+4bZni4lEnV
	L4GX8CivorwWlg9lMTWECZOkeewzPUibKqQJEoZ/FWwKiOVF7qehJ4LdN7b5eIcz
	yY6TidgWXb364G84Z6UXiJvbTBDszerWGTvaGm/2/gh1wPkUtFVyw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7r5k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDuUGY030480
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqkv9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEF89M17433064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:15:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F2522004D;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E9C12004B;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v10 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
Date: Thu, 30 Jul 2026 16:15:05 +0200
Message-ID: <20260730141509.205970-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730141509.205970-1-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r4AKexUCUxhAk4l6M2_t4cKG7W2HD4Dc
X-Proofpoint-ORIG-GUID: r4AKexUCUxhAk4l6M2_t4cKG7W2HD4Dc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfXy/ibQ4IZP9QU
 XWesKdJS2QUhtXZIQfB4OQKwjxF53f0YF0Zk2Y5ihXWzw4mV1RA4mW/cGntouyRvabGVaXhcCsF
 hz1gqIgJ+IsJ9olb0IEs6XH8MmlbcDXmN0PLWMmhHGtHqL9wykCM/rKLmysJjYTuoTJKB99jZyS
 asir13NSGb1k9qTxHm8AtJcF854zHUHAigWspXHkvYVplpgSFmSJOI0XRh6CPyY1nQyNbcl9Cqp
 8ytxbqZLxyBNuq5KZuloi5jYJ4izVSrWPxCfTv/Sd1oJyx6XYT3YEMxt4raOgxhFS0vItv9yaw4
 vJPFcNgTLmMiDGG+ErktZ8PAEmUJ3ay/muYm3Vco52C605fHR00J7b8IFsBtQysUrbdwSx+COGB
 BQ+sHegi2w+lia/9Yk0t4AHO2vgzo7RX/L6HO6FDCbqeFLTsDxZ1AgrMQaBqYzSgzLFT5YCjM3G
 KIuUZOiARHCrckajOiQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b5c71 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=O4jZ9uyBpPWV-DBWKG8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX4Vdo8c82YzUQ
 sRwy0+9WLXSVVUeppZzs9DTuXd0Y9/kpS0RsCRUOsFE2c07du+vmjtbEm8r2fiAuYYblBKmYjjh
 ro9K761hrwIG9cVSFNXqhOrSNJM+AmM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300105

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
Cc: stable@vger.kernel.org # 6.16+
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

