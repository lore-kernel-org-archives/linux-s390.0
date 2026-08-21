Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F335C694
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302016; cv=none; b=OC3K5heZnnzSuYQLKni86xbCjFGUTL9DjJgh5ZYUIXxgGjvok0gieMLP3Xt7wDp5RCA441YUhKsdWTgu64pGOBcOe/BFKAsDqHl15hVgIG779I8hVsRGFu7r1LySlbBF2KP0SoFAm09vkb2fNDkXIZSqtdFlj9dVdqgZ6CNG9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302016; c=relaxed/simple;
	bh=eMgN7utmSr2Yth0TCaFNqggt/v6VwmAEBGd3BY4mYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWmrBhn/uy4uM4ZPmVWXt/08xJ+peKnPEP+Y3ci9i7Iw+95btDPcd0w9C4+QmZWhwA3jid9duianHYkwc4dV8OTls23Lg4LQYxeADFFBEPZLWRltRGBy+d2+aRLpgyYUgrzMGMN8kpKeQwci39kgjNWhzu2P75wJFCTwQCylqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aO+SNiZH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aO+SNiZH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WaTh3300025
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EiCfP8wCNb0ztlGi2
	Q87zHCQILiS/Z/nxQ6Z3xTrNX0=; b=aO+SNiZHzUhk0CYj4ZGiu8cZbF7YARcc/
	ISwsCSzoKY5LYDNejno7/JC+TnOeCaFz767fAKJv8NTOHdWH7ebJ0qe2zh9hFDZx
	90ZWw5kHWbvhv/MCOHgUOwD1R6ZE7QxKfyg+Bhs9bW4AjXN9FQhNz1t9UCwvr8ZG
	V+5NAH4x16S0XVHXbM+m7QZKI3GAxiuGiSnM23FljjEuaJmDLTWCh8God/RqgVib
	yqeNngfMUgX5AW00U5T/Eqr1QA3o4ZzjyJX+scKC71KNvy6Eh+1VeVcCiJ1OtP8g
	LYbWGSHWkTxFwBb8K86K1yyMDsEpNO3UB93We5Q4GxhiyeHYTVeow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0g7yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fbrQ001655
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqkrsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kni051052952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 168D92004B;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC55B20043;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 5/9] s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto engine
Date: Fri, 21 Aug 2026 10:46:44 +0200
Message-ID: <20260821084648.23222-6-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: fuUO-ENN4DKz2VPMEwh_Ct1S12Fl0iFi
X-Proofpoint-GUID: fuUO-ENN4DKz2VPMEwh_Ct1S12Fl0iFi
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88107d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=-JHTZFwV513spj01isoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX6wkdpmKt5DpV
 Kg56e50Ka3F4Hjq2fc45WJgKjyRRoXruFwfznskoy2klv3Xc+cdRAiqYlclSFWyx9Ah+X42ZqYk
 dalNgCKECE3CnxEtZl4v30HfYS55gEI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXwAbWkmZbOqvr
 A+NM5byv2K7sQjJrMxBaRy71F3l46yiJQmYYcScre0SmMtfuX5tRzHkBtSG+4QTLQpnZIqBAQUA
 VGHARiW/G+glB09zyN6rcsUMRLhTXianvNJRmnGyqcnFZgJfBk9GuIOOF8RWRk0nTqeKO3xGsI6
 dwjJ0MKyfPGi7MzQ0Cq5UpDuA7S9IpH7ip415emO6Yd62aYv2oS2t9cNE+AShldLVgsc1Qnu7Ur
 tmHziNLZ0cdqfqtqusPXPBjFrsPYw4cs87AjE6rddXifnYtQNGvIjMs4zFm1blkBeLKqiAkwKe9
 CxrFEm/PQdBTfYbNsO+vmHmo5E7JJUIe/8pWP+z0IXG9ZMWwacJrVPKWFSIFDVULKsh/hUHH8co
 oavZGy/ERAs0G6//WMaMXHho6da1U92Z+pLurmX+K0dsXKCz2gwdotFSJjnG5QIIWwK8gaTxTxN
 6CNeqDq2jRXyAxteFaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

When a request is transferred to the engine via
crypto_transfer_skcipher_request_to_engine() there are two return
codes signaling a successful transfer: EINPROGRESS and EBUSY. However
the correct handling of EBUSY was missing and has been added as a
return code indicating a successful transfer to the crypto engine.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 arch/s390/crypto/paes_s390.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 03446bfac37f..2048327c1ffe 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -463,6 +463,7 @@ static int ecb_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -494,15 +495,17 @@ static int ecb_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -732,6 +735,7 @@ static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -763,15 +767,17 @@ static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -1059,6 +1065,7 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -1089,15 +1096,17 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -1498,6 +1507,7 @@ static inline int xts_paes_crypt(struct skcipher_request *req, unsigned long mod
 	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -1529,15 +1539,17 @@ static inline int xts_paes_crypt(struct skcipher_request *req, unsigned long mod
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
-- 
2.43.0

