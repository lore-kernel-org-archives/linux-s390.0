Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A4430CC0
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131074; cv=none; b=SJsb6HzG95fzmn6JQmsPrncAt46sJjnxCp4E6EfCQqFepCpEA3xapMPK/6Umvu7PjiQqTOJANuHyAQO+gzhqk2dpGLzR4m2r9D2fGxl77w0Gg9K5RmcUQWlK0ix665FWGMbzhJvETLc4reZboEVZ2orHyGpcEaqzPnn6b6wQGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131074; c=relaxed/simple;
	bh=YFCFvCTxoyOwRFf5wF0ZbkzXZmeTjsvlk36esctrRN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3IwqUF/HkG+lbuVFIVc5JyDljjG9Qql/ZDAW+10LP4gfFao9aRE6o1f/HK7PNGYtjpU3eway+2Io4rmmhjToBT8GqgetMochmMQNMoydzjbWEQU5y2iJ8irqETFIqbDY3TarE3mYR7AA9c341xtxTxoPJ413JvtfkhHYS3a8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E1o4ItLz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E1o4ItLz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WLlM2558493
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4MCGMFg/OYRHCkwZD
	2ghXM1rl4YbdajQqcrK9D6ufMI=; b=E1o4ItLz9AzF8qjK2zZQCDdHbV2xTY1TB
	QAb0aRlnh6SwrVmxTFqk/wEgbSZOcdf0l54m3jeKMv6xdQ6amBO6Y/EvbYpkTprY
	4OgOdb+XuyO4Y8QvHdwh8zhaffXeaZZq4lNA2jsgDgMjF3iCFKRZei03w4dfrchK
	CJ/CvKdOH7xbWWjzQxltkxJ2eKRRkK0rOf4EGh21zo1d/iRukdApdcrBFl9qTgPo
	fbA9vZN5MsT3gTRvt+Pw3sFCylyJniyD37VJZDQ/WRsKmCLaP4wYJrnwlq/x8yX/
	c5WbucDzJ0KUxmrDvxNHFeJ2mhaJ0prhcQi2ZjQ/FnfMSaFgJ3UPA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu42pjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BKoZ001553
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yfuxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9Hahd30540272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 526FA20043;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 339082004F;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 7/7] s390/crypto: Fix wrong return code to engine in asynch callbacks
Date: Wed, 19 Aug 2026 11:17:34 +0200
Message-ID: <20260819091734.7331-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819091734.7331-1-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX2vkE44F4E/Uo
 /34rowxL0tvwo8EFoEd1mvMtBKpwZzppTtZrDDGRvKnnpSyxHGuIAsSauHmLQ2epran5ZvTX64h
 16v/L6xRKLzoGHC3Tb2wZ2f6lVxbmqU=
X-Proofpoint-GUID: a0URXXV2uPifXuOiDloRsTrBDk3EnKMW
X-Proofpoint-ORIG-GUID: a0URXXV2uPifXuOiDloRsTrBDk3EnKMW
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a8574b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=1dj2bPP-jMAkdeiF44cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX0N/oI/fkMFe5
 pAymD5zQd9UPpmiQAlCVGi2GRhIpPokIDXqYponwiC2cZFkhREWHynoArCQtA7w7biLgEiTocga
 1OyNEgThr8fUCc78ks+YCnD0i7cX934wfxYqSqCPW/bttVudIHNFCdwWH9ZRLknjt6+IJpnrnMa
 mqojIDghk2pyxeq4YHrLfqQgNBWx/l+8BGGPkl9JBlDc3OS52+4+LO8XQWcI1TcnOH10sq5zyDl
 GXRuMJAluABW2bwk4UXC0V0lMW/PotGHEW2VNWLovEWJN3ge52exhfreVG202Zsoz53TcuLFuLU
 JkZvtN/XoULuMElOnERblPli66omRGYsmRjf7n/KMPeFWoncGtIkayIyalNn2BuhH0eBFjV/96z
 ps1P+asH39taCZEdi/E30JVnvILAnsnoc40lD5TkVoigjC/hGeLG7y3fanGQAcNDEBiHI0NwOdN
 1ELXsW4GHsQocaKup5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

When crypto_finalize_hash_request() or
crypto_finalize_skcipher_request() explicitly completes a request, the
do_one_request callback must return 0 to indicate successful
handling. Returning a negative error code causes the crypto engine to
assume the driver failed to take ownership and triggers a second
completion via crypto_request_complete(), resulting in a double
completion. This pattern occurs in paes_s390.c 4 times and once in
phmac_s390.c.

Fixed in phmac_do_one_request() and all four paes do_one_request
callbacks (ecb, cbc, ctr, xts) by returning 0 after explicit
finalization instead of propagating the error code.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 arch/s390/crypto/paes_s390.c  | 8 ++++----
 arch/s390/crypto/phmac_s390.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 2048327c1ffe..0bc360c7ef15 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -574,7 +574,7 @@ static int ecb_paes_do_one_request(struct crypto_engine *engine, void *areq)
 	atomic_dec(&ctx->via_engine_ctr);
 	crypto_finalize_skcipher_request(engine, req, rc);
 	local_bh_enable();
-	return rc;
+	return 0;
 }
 
 static struct skcipher_engine_alg ecb_paes_alg = {
@@ -846,7 +846,7 @@ static int cbc_paes_do_one_request(struct crypto_engine *engine, void *areq)
 	atomic_dec(&ctx->via_engine_ctr);
 	crypto_finalize_skcipher_request(engine, req, rc);
 	local_bh_enable();
-	return rc;
+	return 0;
 }
 
 static struct skcipher_engine_alg cbc_paes_alg = {
@@ -1165,7 +1165,7 @@ static int ctr_paes_do_one_request(struct crypto_engine *engine, void *areq)
 	atomic_dec(&ctx->via_engine_ctr);
 	crypto_finalize_skcipher_request(engine, req, rc);
 	local_bh_enable();
-	return rc;
+	return 0;
 }
 
 static struct skcipher_engine_alg ctr_paes_alg = {
@@ -1618,7 +1618,7 @@ static int xts_paes_do_one_request(struct crypto_engine *engine, void *areq)
 	atomic_dec(&ctx->via_engine_ctr);
 	crypto_finalize_skcipher_request(engine, req, rc);
 	local_bh_enable();
-	return rc;
+	return 0;
 }
 
 static struct skcipher_engine_alg xts_paes_alg = {
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
index 30c8a59af1a4..89c5fa3dced2 100644
--- a/arch/s390/crypto/phmac_s390.c
+++ b/arch/s390/crypto/phmac_s390.c
@@ -945,7 +945,7 @@ static int phmac_do_one_request(struct crypto_engine *engine, void *areq)
 	atomic_dec(&tfm_ctx->via_engine_ctr);
 	crypto_finalize_hash_request(engine, req, rc);
 	local_bh_enable();
-	return rc;
+	return 0;
 }
 
 #define S390_ASYNC_PHMAC_ALG(x)						\
-- 
2.43.0

