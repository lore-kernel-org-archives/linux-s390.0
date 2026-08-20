Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7647604C
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235609; cv=none; b=jhy4lLVYp6axiRzvLQKHTg2L3y4trDyw41ldPBPYOPAi7Lj1XD/+67h9OTqLAXG44pX3bHzkZkC2nUa8h35KnpsUdIGsvVWkjF9EnDK6vYXPnJfDlvtKMJXI6rSjfZHDIr/d0S6UTDasl5eNDOuo5kmP+SQQL3s7AN7mcVpmgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235609; c=relaxed/simple;
	bh=KuyvPuH0+A3W0Qez7wwjWcHzpPdfTORkyvhRsgMb/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA5XHNpSOCe0dT2f1I3gfa23ddRQ5fDfZTxF3x3EVYGxq8mrI2j/+2Zd5CGWmm+7fIxvZs+qU3xTVp5zib/zLVgUC/PpVH7OiCqAAW74aRdn44ONfYoejgeV0M9X6rlVKcTcXd7WxNZuT4/F43SI9prZUU4Jy/n9xaXp7JAeLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GLTC1OCJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GLTC1OCJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K9HLms2794846
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o+PXTs98ZGvSQCBRF
	5++SaL8y9RjGrUNYrXbnwgTjIQ=; b=GLTC1OCJFp7WcI8qPfhCZjkm+StYHHVS3
	kA4+Fvd3Sro5D/fNOzAxGHeF/N1MqKaXdYATN7xzu2PrpwXDRANihqyo8BYWThnr
	FTAqahqs/WC9vBUYra/TqHlDj8wmzYwOdhqhgVGo0H1qGE/oaaTa4ceXMfhutmET
	PiNdM8hQQ3c732Dyu8oPU02nIPLkjrbI25sbeju0ri9GwF5EV3JXA/vilevCfqDc
	76oC4J3znbrbikPpiWNfPEvm1R+CEL+PbLRVO89zOrH1g9AJPc6zmoA6GxOoQlVW
	mq9+WjmAcHN/+0g6ZyEhra8fdFyCh7f9iy33Ff3bdOS1fAloT2pUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0auy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEBmD1009702
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xheyq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJw8d13959554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338DD2004B;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1315A20043;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 4/8] s390/crypto: Fix missing cra_flags in paes_s390
Date: Thu, 20 Aug 2026 16:19:53 +0200
Message-ID: <20260820141957.19091-5-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: aVVwUgnue039N0gzwcslcfAe8MeNBo5Y
X-Proofpoint-GUID: aVVwUgnue039N0gzwcslcfAe8MeNBo5Y
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a870d13 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=LGQ5mng98TkiZO--HCkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX+Oj4+gejdNnD
 JvxDVPQjrsOkJ0n40aikKGrrDSHn9y29FVJgn80C3wP9Y59O+ySoVCm1DPJjZC6yofg51u6sspv
 jVD4pDLyCR2GRvEp/nWOswPtjynzfpw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX/Qn3Sk31m66q
 GyM87d21e2664z+tANgCKPtlY2G1mxycploldv35rGJOi/zKY6SrM8VDzPp0bWXCrNTxJelwPvB
 rcnWsBQKANI1A5Y8l5VwPxfv+BNmfgDEp/e7ltC9Xn7SPzZVg6hOYXxxAuipXqDURrNItscivFn
 DKlMbdWb4lrEkkNlKi0/Fx2h2a9oSWzdADhx966w2YJifrVmvkpNG4XNSDeFX2XDER5gcV0ZLgS
 +mdLg40nvY9LaVZvkAl/2nvi1Dj/976kL8xErNHC2+Q95Poc9Hk8v0hUoiyc6fu0P5ZAXyVNfdt
 E50kw4P3BV+0OTkSxyjviB/3kO+2UYKDe2XCSMeVLPBLHoONDL2CJpU57r5dS4M6Wf59pB9oDcO
 27vd99W00ykBE6an0DLEHpwGKS4pSxiucCa12Xj4WOHvGpLhAGiGVJF2v9c79GhG18Y7nxaVLLU
 CePHnJerZqHXHR4SJDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

The 4 algorithms implemented in paes_s390 never had any cra_flags
set. So add code which sets the cra_flag to CRYPTO_ALG_ASYNC and
CRYPTO_ALG_NO_FALLBACK.

Fixes: 4ccd065a69df ("crypto: ahash - Add support for drivers with no fallback")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.17+
---
 arch/s390/crypto/paes_s390.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index e8bbfc376ebb..03446bfac37f 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -579,6 +579,7 @@ static struct skcipher_engine_alg ecb_paes_alg = {
 		.base.cra_name	      = "ecb(paes)",
 		.base.cra_driver_name = "ecb-paes-s390",
 		.base.cra_priority    = 401,	/* combo: aes + ecb + 1 */
+		.base.cra_flags	      = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NO_FALLBACK,
 		.base.cra_blocksize   = AES_BLOCK_SIZE,
 		.base.cra_ctxsize     = sizeof(struct s390_paes_ctx),
 		.base.cra_module      = THIS_MODULE,
@@ -847,6 +848,7 @@ static struct skcipher_engine_alg cbc_paes_alg = {
 		.base.cra_name	      = "cbc(paes)",
 		.base.cra_driver_name = "cbc-paes-s390",
 		.base.cra_priority    = 402,	/* cbc-paes-s390 + 1 */
+		.base.cra_flags	      = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NO_FALLBACK,
 		.base.cra_blocksize   = AES_BLOCK_SIZE,
 		.base.cra_ctxsize     = sizeof(struct s390_paes_ctx),
 		.base.cra_module      = THIS_MODULE,
@@ -1162,6 +1164,7 @@ static struct skcipher_engine_alg ctr_paes_alg = {
 		.base.cra_name	      =	"ctr(paes)",
 		.base.cra_driver_name =	"ctr-paes-s390",
 		.base.cra_priority    =	402,	/* ecb-paes-s390 + 1 */
+		.base.cra_flags	      = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NO_FALLBACK,
 		.base.cra_blocksize   =	1,
 		.base.cra_ctxsize     =	sizeof(struct s390_paes_ctx),
 		.base.cra_module      =	THIS_MODULE,
@@ -1611,6 +1614,7 @@ static struct skcipher_engine_alg xts_paes_alg = {
 		.base.cra_name	      =	"xts(paes)",
 		.base.cra_driver_name =	"xts-paes-s390",
 		.base.cra_priority    =	402,	/* ecb-paes-s390 + 1 */
+		.base.cra_flags	      = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NO_FALLBACK,
 		.base.cra_blocksize   =	AES_BLOCK_SIZE,
 		.base.cra_ctxsize     =	sizeof(struct s390_pxts_ctx),
 		.base.cra_module      =	THIS_MODULE,
-- 
2.43.0

