Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3644334AE
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131081; cv=none; b=YSxYRi1pBh0vV/Sgm5mZP+havs98yd6vBfJnft6ZEbJgptVvqvsYgwNPoHQTHNHG8/Zxxlb/ZtNrNXKAGEZIvOvwQVGLS7nAO/fycIEZDPuGL0Emxls4RJ2q/BtvXyOpqNbVClTzgRjLov7wecaYtr8glRMpY318rskxXDgRRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131081; c=relaxed/simple;
	bh=wB6wo1RvlUkrH8GRvtR985R/r7zjPis9B7FzipyUru4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+D/EvAWBIwNTQ78HMVI1KY9Y+/i1j3U3OYa4Leby0gK6Rv6bNRasL/vtpEdTidmegmsY9nf3nPj7cm0pVVasSx1gl7ohFxrftXcdGP2mzAtXfklwkOjs4s51K8QfS+rAvoq/FYID1h4EXzCKBzVl/ov8xqgGTkuISv0VDr8ZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mn9Cs6DS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mn9Cs6DS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VrJO2666938
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QALlL4qViwL70xEBo
	i7josYGnciZHVZb4rGQPohkuvo=; b=Mn9Cs6DS/7f5jNGPaPGmlPc54B+KVmIPd
	GEP14nsNZW2WZ3f5630BSQ3hg3dV5rWhHsW0MdI518iZx2cBvqjEx5EE6RMdQmo4
	dXSBEi/kjrKSyGAXPhyXtR4GPOeU1lufedILFweI9pQkp2LAzdVYDRCOjA/fpqTk
	YYLtDhhz3ksNgL3VVvynP21XTjLapSsvmOp0T/CMMcLG99c+mUa+9OAukvwmljcJ
	KXF742YMTx8/2vzJziOTtS8qjUktDbesC+MOt+XqbQXepLHxAiLcPnmJ4O/H3kje
	mpOpyElNzKPcfcWLsm7ge0mb57DTwy1xV0wvfj0VoqBTqoMjrEGFA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ar8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BJV0032659
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngfwtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9Haaa44892640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB392004D;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA5B20043;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 6/7] s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto engine
Date: Wed, 19 Aug 2026 11:17:33 +0200
Message-ID: <20260819091734.7331-7-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a8574b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=qxvTYN98PGHahdRChkcA:9
X-Proofpoint-ORIG-GUID: 8K1h_JgPOniaHjrYB83YN9pAD7GP4pI2
X-Proofpoint-GUID: 8K1h_JgPOniaHjrYB83YN9pAD7GP4pI2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX/txVvTvlU5Jd
 hutYohf9mjlA5ChOAgqB+hD+4Arfs+eev+LZiafp6+FpIMf56Oh8AZM3QYRfOIv7ytqB5iuDQb7
 XjMb7cSi97gE6HVZtuAb9SQFu6VyHoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX5kKlPifLTJb3
 lwWiM5gES0IeMsR/0BRatmn8mqNNTXCfF+bf+7bSe65FXEl2oClzTCXuLKkcgmmZJnWDYZMIu2b
 mxyKdFn5JgQrg0An7HBHS3ilXIhVVv2kH/kwTnHaefOVQv9SyhpsdcT+/++qlQw+kgSDPDWBgei
 zTXyCiYn01YfONopkZlK4hpi3ldRWYDjOMZtRmWk8BeUN45CbdEiV2RsHPw9YNvSDy2Ea+xTHRX
 l97XWsu3uJtzs0J0WZMWi4plUjqiq9cUQLCRRxoNgv+X0eC4BOILlUx1tQcNtFSW3q+byDZoXRq
 tLUOHLcpmmmV+/+jSI19ZWrGNiv83do8ni0ehnTLfYwEGhKpiie7RT4YRwjYaCPduuj+9Oo77g0
 V3FpY9Dp0SZZD18uWsicgiCdLcEW7V1WztkcAKUk1f6OeBjd+wJFBSQK9JTrU9fh97pbUBTlLRE
 gWRnVlCBPrK/Coh1W3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

When a request is transferred to the engine via
crypto_transfer_hash_request_to_engine() there are two return codes
signaling a successful transfer: EINPROGRESS and EBUSY. However the
correct handling of EBUSY was missing and has been added as a return
code indicating a successful transfer to the crypto engine.

Fixes: cbbc675506cc ("crypto: s390 - New s390 specific protected key hash phmac")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.17+
---
 arch/s390/crypto/phmac_s390.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
index 03ca33ffe6cc..30c8a59af1a4 100644
--- a/arch/s390/crypto/phmac_s390.c
+++ b/arch/s390/crypto/phmac_s390.c
@@ -62,8 +62,10 @@ static inline int hwh_prepare(struct ahash_request *req,
  */
 static inline int hwh_advance(struct hash_walk_helper *hwh, int n)
 {
-	if (n < 0)
+	if (n < 0) {
+		hwh->walkbytes = n;
 		return crypto_hash_walk_done(&hwh->walk, n);
+	}
 
 	hwh->walkbytes -= n;
 	hwh->walkaddr += n;
@@ -606,6 +608,7 @@ static int phmac_update(struct ahash_request *req)
 	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
 	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
 	struct hash_walk_helper *hwh = &req_ctx->hwh;
+	bool cleanup = true;
 	int rc;
 
 	/* prep the walk in the request context */
@@ -629,12 +632,15 @@ static int phmac_update(struct ahash_request *req)
 		req_ctx->async_op = OP_UPDATE;
 		atomic_inc(&tfm_ctx->via_engine_ctr);
 		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&tfm_ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS) {
-		hwh_advance(hwh, rc);
+	if (cleanup) {
+		if (hwh->walkbytes > 0)
+			hwh_advance(hwh, rc);
 		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
 	}
 
@@ -649,6 +655,7 @@ static int phmac_final(struct ahash_request *req)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
 	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
+	bool cleanup = true;
 	int rc = 0;
 
 	/* Try synchronous operation if no active engine usage */
@@ -667,12 +674,14 @@ static int phmac_final(struct ahash_request *req)
 		req_ctx->async_op = OP_FINAL;
 		atomic_inc(&tfm_ctx->via_engine_ctr);
 		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&tfm_ctx->via_engine_ctr);
 	}
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -685,6 +694,7 @@ static int phmac_finup(struct ahash_request *req)
 	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
 	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
 	struct hash_walk_helper *hwh = &req_ctx->hwh;
+	bool cleanup = true;
 	int rc;
 
 	/* prep the walk in the request context */
@@ -716,15 +726,17 @@ static int phmac_finup(struct ahash_request *req)
 		/* req->async_op has been set to either OP_FINUP or OP_FINAL */
 		atomic_inc(&tfm_ctx->via_engine_ctr);
 		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&tfm_ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS)
+	if (cleanup && hwh->walkbytes > 0)
 		hwh_advance(hwh, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
 	pr_debug("rc=%d\n", rc);
 	return rc;
-- 
2.43.0

