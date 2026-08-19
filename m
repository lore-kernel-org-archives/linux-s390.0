Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3E43553C
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131075; cv=none; b=l1wxjNHt3oTHm4o9R+74dTCPYa50YQkbIh1rz2dTee259Bko2y0fIBfIRhqvPoumoRCI+ha44KABmb5QAO2O1JCzfwB5Z/D65k1+z+Ro44EU1V2I2hdCAQ+2DXaMuAHxMgDvbygngVf5OQjyFFxvXiod5dcywcmGF65fGfVa4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131075; c=relaxed/simple;
	bh=7vDo38YzZmaw/bER21o4zLjnyRDUaxbTmV7UrwrZrKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRN1FO0iXmuh25YGw/C6nM+5Abmdo5ysjlulvMrhc/YA8vR+vQjMZXhFIRg2hCeC10HYkpUij+kS6UCgTps54hY8n8o34f6/V3BLVDZ3UkoD8WFyBkYw1yFwhWyKsXpDWUFPz+jC94dOJTDC9BmPCDkBzKEmwg6n6kZsE1ochRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qR3yTO0H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qR3yTO0H"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WGtm2558322
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hz3oFCY98gYiJ1i3E
	s/OYCG4wopTWSyQEOzy3UMk6LE=; b=qR3yTO0HbLxWZYF+EhNK59xPaKxgW3hY2
	7pCb1UCZBouq+nQD1nwmT2laQ/avz2RldR678gOXQh/MNuJKNmjnMYYKgFtMh7ZH
	s9JAaIJwSOkBHLo7G4mSUG5fwE0wAsSP+d/aQT/GFWyBzhrZdKEaI4LMamMHIWv9
	6K+tV6Xee1365jyb9U6Vmni6EyyYZ2d3YYebuBBp+vth6YH5KkUWZcyq1ZA4ckMO
	N3UQ8jETCBW6cHdQa1qwsW+ulcgRjxaT6UcLnZFJxlCl7pyc9QNLNNB8OvI02mwH
	FuiljLR7E4yrdiMoIm78YBfApq0gNNznSZthyXGGenGvQhgQSPqIg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu42pjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8uKkM026659
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq89cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9HaAA44892638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 086612004E;
	Wed, 19 Aug 2026 09:17:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F9A2004D;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 5/7] s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto engine
Date: Wed, 19 Aug 2026 11:17:32 +0200
Message-ID: <20260819091734.7331-6-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX31FwuyGN9USz
 3ohVhZ5jxvxpbCNybk8gvKi/9DbkmDn2mpCkP9s16IINPHhJIRe9hOVF/GqluoKEx9brZDn2Oxw
 3wJCMiZYs03xjl4aUVnDbE0bmMGdPZA=
X-Proofpoint-GUID: knsG7KeIauXC6udH7RYdWBHL0d7EoCvb
X-Proofpoint-ORIG-GUID: knsG7KeIauXC6udH7RYdWBHL0d7EoCvb
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a8574b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=-JHTZFwV513spj01isoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX08YCaTmCZ4gs
 ANKo5ent2PoM1EVpk/ZB7RhRF2x3W8m+PtL+xwI0KCK71xkOtYOQ/EUfom2yozjVNvMxx5gakWB
 KUmGIvxAh/1vfrdDrX8bo5kAb4Zabct0RiJLy/YTa4qlQDiaFUJeWgZYTlQzvFB4GhpnvkyL8N1
 sMY8sgY33F64J2VB+9U1wqlMXG2VY6eBAp1YiWNqh9rZ/MLgWaVqFzNrGW9cYdffKpE3xrUmYTO
 Tv2AnYrFsTOASHd7w9HR7IkueMAoa/yWKGn7YSB9Y0iBj9fiAP5BzLtfxWFiiQ3gmVWIaajFNDa
 1pl9wsDttbiao/jgxapVGnO0chbecb1LuTMyhVsCopNYNYVg+RRW+sqYmzwiVrR8Hv6CjXbMVdC
 tVJz8m7hFMsvaA3GgLWQRJNe6rTUQelO/WRXzYKGMGYcFAajwmt9mBbsOoTsu1gpNlnIzsDwReG
 g7z96ymEQx966sqBrzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

When a request is transferred to the engine via
crypto_transfer_skcipher_request_to_engine() there are two return
codes signaling a successful transfer: EINPROGRESS and EBUSY. However
the correct handling of EBUSY was missing and has been added as a
return code indicating a successful transfer to the crypto engine.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
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

