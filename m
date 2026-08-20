Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2D472F7A
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235607; cv=none; b=eBvdpfngTPkhtCxzKeO+MLIrrb2CD+Zk8hkhvxRzs20Djyq/TuvUDoMgqPE2p8jtDmNAVR+dBy+b1oCP7crBs7+k0/Tn7N6FOMicd6XzbofPDlXlowcOvnwNHsohH4DgJhQHdqqrrrWfuIjjajbeSLgFxQrWq23F6l+xgV3vgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235607; c=relaxed/simple;
	bh=+33gNGwKE5Vfb81qF+s7VXNrNvdpmT3xAHiULICe3Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNeZD7xITQZbTWDyBxb6mPUcD3ENkmL0QqjnJlRHenUQsYTOWmtYsDmPiY33nhbCHHxqklxrjdTxqamu6+r1cK6te0oA48XpLHnYqXANB1DX4cxTl1CZpB2Swz4VaK10ww2nZcROeOhgYHF/+45MBeEBJj8iZ4S6swVPRtZJFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LozLP4ni; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LozLP4ni"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8OSiv424041
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o5aIIUYGN2Mc3/giK
	weSf0ePjWc+0yivRpqtaNNi1Rs=; b=LozLP4niuY1YYc+BaJbB0MQWAIITtihfp
	M/ZSWtYyAgpsNl+boLcdzqOwmzhzojX6Pb98Y9p6KuoJ2IUm5IDrEf20Fxg/xs2y
	WYhEdBG4Vz6EfILnT2nny1tiojMAte0CKMTd+Gw1/WgBxghlerUDAESgBexyj0fb
	xAObJuwOjjKjCAXDZ6Iznf7+LrNWcMFyIlOYG2ImiOzSmviBETSpzNlEWKUM3vXH
	dvfHm+44Z+PX5MO+x3e8TQCEfAtwXER+GUNyYx/Xz1iYwS3QGorAo+UJLMY2WEac
	LdOF/qSnKmoGzOqwIi9xoouC5XGNpJhn6wP/V+H/bFvPJIlq5FRPA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1ju7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEBg9o002542
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypqk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJwuw31392384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2622004B;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F17920043;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 6/8] s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto engine
Date: Thu, 20 Aug 2026 16:19:55 +0200
Message-ID: <20260820141957.19091-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820141957.19091-1-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a870d13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=qxvTYN98PGHahdRChkcA:9
X-Proofpoint-GUID: anptYP5Ek8x_NWcoFOtPDvaGdsDOGQKb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX7ZmQ/LtabPgl
 WYZZOaGl9fnju0I2X0tBcZKjOvZbCfjpfATLZHhaL02TDJW4+zn2BeeFP+ghEqWDYL3DAqOP1Qw
 mCbDhr00m19eTOJYy2ippjYekF+3DmU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXwFneTad4doJQ
 TdhZUfk6OuFypYM1uVKsHrMvz2POZkN6vdAIhtUlCex/bWX4VIXYhleabQ16SvVI6OlywUGxA5m
 kPYvCEOaelMp6VZb/m+9H4RUceADxe+vpTMWx0OPsUUe+xAsuGZsa+i5d73AI869nYmCzCRwH8F
 tICB/8YAou9wOTMcvz9WmX3zJ8sa8401EOOO424MFLZ7kCWnfF1rPxKJF3PIfK3kwXLzoV4pk9A
 nV3RoCbXRsb/I+bhKMfXpYqg/+Fi/CK/4yQ614/+FfUU08bN8psImtRciTAS59fpegz5V9n7qOj
 ujpkCxlM1X0r+rvAtmt30V0/jSvy6+HZWN7xIhxAGkoBRt6Q8g8ZroRsnf40ZJCdcV8dAJ9VxJY
 p2579BHIX9mWgafiO1aSdFmRB4B+AH9QN9grldr/54JsBrjHPjMMszk8KkOVOkPyBksV7fE/3Vb
 ZnJA73rnGfcXiVThZUQ==
X-Proofpoint-ORIG-GUID: anptYP5Ek8x_NWcoFOtPDvaGdsDOGQKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

When a request is transferred to the engine via
crypto_transfer_hash_request_to_engine() there are two return codes
signaling a successful transfer: EINPROGRESS and EBUSY. However the
correct handling of EBUSY was missing and has been added as a return
code indicating a successful transfer to the crypto engine.

Fixes: cbbc675506cc ("crypto: s390 - New s390 specific protected key hash phmac")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
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

