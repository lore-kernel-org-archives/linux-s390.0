Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988712EC0A7
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302017; cv=none; b=J+k3z8AS53qTVoDm7WkV/NNefxJM9k1DymgVxBn7DoO7huu2jibpzc24K3APZgcOsLdSk8LVRIWHqL677kySw90z0YXF6+2O26yx2sCznNiTMzMYVUA2zBuvqbEFtktkeuzRo/YcIG7G3U1PEm81FHAVSLiS60ulRZTnONypE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302017; c=relaxed/simple;
	bh=P1pl90Cp34rBGlNk4iF7Q05CcYa5D+ROT5Pwj5P3BhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6WwPF8QtFe8X2utRMMqoA2ZNW2Ybo4gL3RGgJ/mXAUvlbxzG49Xquf1eIGzZsVcYeAllLHf40DlfcPbLvHDEpclcBviRyNoYG2AtSBTjs0kH/F+DfjHD+UaAVR1SFVkUer7YW9MKN7uVggFRb8+idDX+164ocP4j+pz840Yugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hwYGvmbX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hwYGvmbX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8Vu983298693
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=71rhcCDRuYtv2ByAk
	wSvdSeBGOMX5IYb5VNot5NvDCw=; b=hwYGvmbXmFxq03MPx+hTH3ghB2+KRdwOz
	gr+yoP0CPdH05yFVHF6LZeLwvahhKZ9F3xztfOJLS9ic+EJ6QXH8hrPDmOvbo8rX
	cswhCvmrUYwFxke5JTfEKs4RNU55YdMBZr6hvWVSlz0aKiydPDl/1TLMfSDgk5gV
	CPp9crP7mHxQFf2/4MYzRGWEZhH/nAGWq8h7svqOIGkvrKB5KtH6WlYL9hY6b7Pt
	Rrr4jlho2vZhIK+LbNlmwGTsIeVdaylCXIh+cgHU1NE2jo7rsMdjvLFNxADJ7Y7b
	OyRx9q2EZ1sD9Mk3wh65yevOPVyCF/Jg3u+siKURiLdTrBEB7zKsA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0g7yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fjpM030896
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhkjw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kn7950725270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF682004B;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FBD52004D;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 7/9] s390/crypto: Fix wrong return code to engine in asynch callbacks
Date: Fri, 21 Aug 2026 10:46:46 +0200
Message-ID: <20260821084648.23222-8-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IpuxWja7fDU8Le_dDJ0Qwh_VXiTdcjqs
X-Proofpoint-GUID: IpuxWja7fDU8Le_dDJ0Qwh_VXiTdcjqs
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88107e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=1dj2bPP-jMAkdeiF44cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX6EHHQmDEM2/6
 U8sTTg1shs0vdb/8M4D1jPr3EjuoTUdmC6ueBHiatijiY/K7Z6VQeo/ZZVKFZWqVMgTqO5PQAEy
 n1bHYHtbJnRBaMsDnuWMHOsfaf90QaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX1fUp5tUx018C
 ykwARSU8JVp+z4fiEa19MHwIX9VPoZfJH/tcOPXcI/7sYcv0inNpDskFbTztTxpFvKl8S0w0x/X
 MnixU2AhW9BBr8C98SL0/4iUlQX45zwqB0NtQ8zumaIc+fUikWMZox0NyEpf9Y+4yeiUTHl0AJS
 /j4PH6NvEXGJW2N8cV1l8wMbDc78DwEVtCXFype9oZ+N3c29tuTWlNRYMQVI+nad6rAAvbRbTZr
 v76G2agWv8LQwy6pF6XhSozRP/T1WtAqfnB5vuUjLsddk0rWx7HFL/DTkgAMjswVYtm60pGPxHs
 Xy9Eu4K6LPljZYUWiIRV0uMqd7HGjuNuVuRgZzR1oBDeXIVU879MAKrE9aFMbYpl43g1DIUvtHE
 RQSooWoBOMMhvEiMh6yYEucYiWsasN9FAjHiragWmNTAPxo+KJs5rYS1iYIt7FVvl8G2pO0HaTO
 7azxeOHuh9avqLm3/eA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

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

