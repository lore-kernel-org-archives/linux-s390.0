Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1A3BCD33
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302017; cv=none; b=eVvFM5okYx3ETMl5NUuje1JUvFh4yBxFNmp7TY44QMkaHC7orSvpbUTLtGNPCAhu8YhQfjbtnulH7D3ZMkEVXuEsx27iSzlieWoV6ia7a9aljWhzL+V17UsspSFcUtB8g4+s58fxn8D+AAMXEsEbqlQiNyfyxr2f3dQbmM+B/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302017; c=relaxed/simple;
	bh=+33gNGwKE5Vfb81qF+s7VXNrNvdpmT3xAHiULICe3Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuxsAkkjaAdyh7BT8MqOn2YqhhRwMhytgWP8QsBvCA0MYLMZI3/V9lXYpR/DeOBa8e2784kWdYF/CKIhBj/xztpNNe3zR1Q1dcXmop2eGYevPEM8UiD86T9JxOq7SG47mTDQ+IHmMRVcT+kW0ZRQGTKXPUPMaMohypKm33CI92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l4xNQ9HX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l4xNQ9HX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8Vumk923102
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o5aIIUYGN2Mc3/giK
	weSf0ePjWc+0yivRpqtaNNi1Rs=; b=l4xNQ9HX1OoF+V52cwfUPVyONzHiMqWP8
	49+cSE3a53Rc/qvM/UzVE/EsPofAbc9v3ZuFdVPFg/Z0rPthqkQNGKibMYVuVZiZ
	wNbwgV2RDLgxZl2wInDVkPiK1LhPAnDsiCghQE7wxUf84V8R1eSKyfJFT4PuR/+R
	kaM+dmzpWd9m2Gejqy6x9knaEH/N2+1bTFsWnmHr+XvadWEv3uMQV5YIuDFJvGBb
	sP5XqM6xTZx35kA5wdBnbIt1NqpjeYPa99UL/1N3pU91DOa3SmRDUhIGiuNNTZu4
	bvyLD0s08lXLP8h6bM/m1ttmEqnY4pzv0KE0ZDTgpMCXmfokclJTA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1r6ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fk58002922
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekkk4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kneB51052954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30F9D20043;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BB322004E;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 6/9] s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto engine
Date: Fri, 21 Aug 2026 10:46:45 +0200
Message-ID: <20260821084648.23222-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821084648.23222-1-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a88107e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=qxvTYN98PGHahdRChkcA:9
X-Proofpoint-GUID: mD0ktuOPX1zu01oG0wjvbZzUdU8Wuprm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX3+FV/ztgJuMX
 Jcs8LVlC+9D0uUAFPtgABeFL7U1CTbmAK5ofkEGcriafLmCA80+O+6OpCaIhmjcZ+GlwdosKJnz
 kE8XVHCY1ld0ECiXkiZ7INs1YYWdzr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX8dr5q6iEr3VJ
 PvXhFD6l6G2TxiHnpt7PhH8gIKOeLLXeym0pF+oIfHiXr4lYAfPGfm/LUe1RbN0iguapSmypIZ3
 1TDQyPsiSS7a+lCuQhNX+ehhLvShBYYJyBWLSNSCejLIm7O5p23MWmKhRH58ZIshAnHF/D4iNf3
 bH/xbldyaWGzNNErrkzx7JKdASY3u0OmPLLOA7LmNRGqqsxWvUpip+veBQw9Rd4BjemNXQ9vJAQ
 PhELOGnFCtYIrRan+1PAdKf2CeE70P887xnP0LGfWyVLf7zj9JzDBJ3Ylh1gOz0td+a1qgwyWw/
 quB8qciJR6g67prfnfopvomvtOwWW1zSa6gcT5WFJaLxg3vmYmxTLpgLvM0HKLwLKQsHARfGDwl
 FnNJwWC2WCPhurEPsii1G9vAqTPdvDUT2KTYniqPrhtjmUXXwhVe7dQT4BXeKjp3P7xgE8yjwrS
 bgp+cP6Ih+oGRIU4E1g==
X-Proofpoint-ORIG-GUID: mD0ktuOPX1zu01oG0wjvbZzUdU8Wuprm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

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

