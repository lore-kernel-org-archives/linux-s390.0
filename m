Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40944756D8
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235607; cv=none; b=X1YgohRAtZSJOtuYFFnRDNoAJB1PcqKa5aeDFtMuQecNiTUkgOc5cLtZ/Lm9lc/ol2aP2ZhhZV+5x3xmdWxfsCU6iJo7/8gjaghnX3d9vMRvo6Ayl/khjw0xiY0ZSELvHe0+s1QJaqBNFRmkpYV4dktme4Sy8lSX2m2wsi47cwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235607; c=relaxed/simple;
	bh=P1pl90Cp34rBGlNk4iF7Q05CcYa5D+ROT5Pwj5P3BhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXTjrBur7WvPAb9zePAdv4vj0vF1BH5aV5AckLjVng1SXD/W/bQiceWhHWI1oG7kIT1urSjpVNfC1Xb+OTOFi5lAvjtFd5ygdveX6qIhdgb0NUwxWwOQXLAx0XDSaOHt2r9OPOYiwWfln+oUSzX1kDA3dVDYJ8d3Up12GPNN5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QsIDt9dp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QsIDt9dp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8fa9M471744
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=71rhcCDRuYtv2ByAk
	wSvdSeBGOMX5IYb5VNot5NvDCw=; b=QsIDt9dpa4FOZRBzQlyyLUltWd6V5crG2
	FImiA+7oIK/BDw6eNoiyZwAGxQbk0f3WK5jp8cqlS6PXVbvfNK14c9Wucxou8UJR
	xH4zb6MA+X2WmlZoHSaY5Mouo7lJuI9pmF4FH1uK9a77QTRKnoWVvwt4mXV6+slu
	gpvn6eAJ7POPucPC6L8Tnl/INi2254tqHGD+ZuwUaIFqiArRERGZ5vfix/P0J+Q1
	JYqf/Swz0q0PCP3lBvPU7/pEIDXCAE+BkARzM3rgF2MhBgVnukcYBUNnL6/SW+8A
	eGQo6zYOm8f4/YDlQ9nhjkZ+h9T8JQkwdczz27MBM+YAoKMDNGaxQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0jwt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuJM1014888
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngpskd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJwNq13959560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A59A320040;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84DCD2004D;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 7/8] s390/crypto: Fix wrong return code to engine in asynch callbacks
Date: Thu, 20 Aug 2026 16:19:56 +0200
Message-ID: <20260820141957.19091-8-freude@linux.ibm.com>
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
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=1dj2bPP-jMAkdeiF44cA:9
X-Proofpoint-ORIG-GUID: 05NPUpzMESRUoOCBTAmlyrO7LUuyDbaM
X-Proofpoint-GUID: 05NPUpzMESRUoOCBTAmlyrO7LUuyDbaM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX0DQLj3VCGXfP
 PwpAKyiDEhSPER1TFGxgWepnuVRmQ5SPWDzAS1LYvDaZneu+fOB8HoxqZXuk2iNKGOLV4a/YE0T
 9pjvcKSH/6R9p+qD+6+ALQOSMKL+m0w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX1TZS9N5iAigM
 /nAvmLqupLfLWOpht/dY5R+YUfOMevOSxO0WpC8rB8fw4X9szvpicQmisb3+LbTQQ/0Ft31V5Va
 NcaM35UdSI7OrK/HqMytF8tPxXVZwApzUsP9qCYRw47UhNNlmGD35tZGe6o/O8f8hRqN0UIvvlP
 imYgjfE6F085Se8a0jrBgbVv/PYp83pr8h+xlGWp1yQ2bkNdCCpQyCHoyEN0VQ5v8+Q/nd+9gcp
 k1ezj7ClfjwIlcnKUbC0ImKxD0KYGg72WDDmTT7aJxGsJ27wNqwqQC/XMDDiyonc2vOtNgLxOFW
 D7O29gNMyB+6V+00fLCnKFocwyp1uCOEsyfMt4l1d7sd829nH5DriGdjHJEx4IC8YOFE86CUfhP
 gPemAs1y73IGeg/7QTzMH4f9GZWwga0nCx4C5T/urtXefBWTmB+39bh9hrEkpvhkJA778+/M4IP
 tyXhYQyNBxwW0duhSTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

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
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
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

