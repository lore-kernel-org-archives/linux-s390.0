Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625A4756A7
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235609; cv=none; b=Zj72oKg34wZ+eEPGQPmfVaTd1S6cSJl0SM15eG988ZspVWKGrCBVxm7LRjgqY5L4q6jNwJDD7MokyKorOipK8LZzmwauaVLe8zGEW42l2kbS+SIcO4OgWUeOrU+N2PB/l2FgT0ty71NfwW+WifjtAHgk27mcwCM3aFABasrZ53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235609; c=relaxed/simple;
	bh=eMgN7utmSr2Yth0TCaFNqggt/v6VwmAEBGd3BY4mYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6RDqFrzSOLIWxX1LSyw8s/JCT/kR+7ZB2a8GchXn7aBjNSRL4gmKaBwKEAw4KWAoHViV5BH0vT4gt8vupER3Cas1vQa3Yk0sOXG17HU9rObKdc5xHzZzPRnFTYmvg5//pNMlJKHlvy1FOgemVmFX6U+gtgs828j+OHiiCnjCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m96KiInC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m96KiInC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K905gk471173
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EiCfP8wCNb0ztlGi2
	Q87zHCQILiS/Z/nxQ6Z3xTrNX0=; b=m96KiInCs8xPzHkAax2kdgMpQq3omw1F6
	mMya5vrnXMJqt/GS43IBsRqtTDnq1FoHWqUyLQTDAskWLBj9ZH49sG5Xl6a+4kAy
	8UBRRVVscfi7YeAym768yf/Xbf89rMhAdmeZf2aeGVmW3PpnlYOqEOwlakAvmoo7
	EbMuRlZmQt6OdeZoiLqOagDY3uf271UKLh1dj+8e7P4B2j8EKlhluFUPc0CNNMjz
	JjlKa49f8IxROpJM4iJQCPS79Pq/oW7KX+fnUM90Yzzglh8q+8Tg7hNXSNTlrbFT
	ixT9pC2NF0+3F6xAJpTsG0f03Pl723g+DQ++zHNjWH1TnvkeE2A+Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0jwt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEBnEj015234
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqf5v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJwwE13959556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59EDE20040;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 391542004D;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 5/8] s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto engine
Date: Thu, 20 Aug 2026 16:19:54 +0200
Message-ID: <20260820141957.19091-6-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a870d13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=-JHTZFwV513spj01isoA:9
X-Proofpoint-ORIG-GUID: nf90uEU_oUYXxCphnvk7j52ime1_P-zW
X-Proofpoint-GUID: nf90uEU_oUYXxCphnvk7j52ime1_P-zW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX72i0317xwIAy
 69txOYcIjKncM/u5bOkZXQleLZoU5ohgtkyUTNPouGYMN1rItFSM2JavTByvb6+B3Lvp/AfyEyO
 So9904R96ZBZt5f6Shp1rOe/I4+te3U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX0RKKF2tCyjp2
 oyt11x0uQNwOXcurixP0fGrGknrnLN6fVMj14YHBAaKFiv/ZNAj1Linr2jviF1Oxxzmzj4vTtRy
 dplkU61dtayh1SbvXF7DcCA5fXh8hh4wOjCZQ6A6eS9nw6pT/IGU2Txb2Uq8nEALASub7BTdIBD
 5hW3lwTK1yUBIRZv8A7rU4G4gWSxfHr7NF9kkvJz8zwHqzq9Z0H8J1do8XPsoT9L1tqr/A3NVzH
 4JPmX/+5ARdb1uk35YJ/dI9b4ySN6NewOAg2KAvUFFOfxeCw7zcyulRvcwOLBGLluz6ZA6qHGga
 Z5zJBSvyDSkEL7Jc9L7CSD5YKDaNp4291N3FGAa41s2YLD/vZnLAymVb0Db9ZjcEZRhZ0ml+AIR
 lHOCbYGw3HB6x3+ftijWHpoP1degTOkLf+hd3S/tt1PyzTXVvdZl1YZwONF8DkaFwAOWx2jePLj
 CoIMmucpW43WSDvtCAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

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

