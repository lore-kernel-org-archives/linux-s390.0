Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE72432BD2
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131066; cv=none; b=a2P0bGe9Gi8WEHcTWBz7D1xtBbQ8oM5ZMs6NHYIi6IhNOnRxDYm/dUTATqqWDEvkmPDk8g1CeHuZ6H6AuMVt+oWsZ0HifpPazyabwKkC3E7EJQ+3Rmb0NJ7qNkotjn2pDWkFfZ4kv599jH16kJykbjlDe3fSX0K+Mmigxj0qFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131066; c=relaxed/simple;
	bh=KuyvPuH0+A3W0Qez7wwjWcHzpPdfTORkyvhRsgMb/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sks4IM+AmoIxSb+J9uDfvwmjvH3RrbG47PyJlibVdcGnlU4nnj8Vr5h/94HU7MWD1tjZSNmNV6WBTKsYDtZrPwRgnACXfPcal2io4b5B7KtT1uWnLhGU1/5MjJSu+ffYRC5wNkHBlqlo4g4z3VTCOv5+6glkYxcyEoAJiTXLCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cGZY+PsX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cGZY+PsX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6Vxie2667025
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o+PXTs98ZGvSQCBRF
	5++SaL8y9RjGrUNYrXbnwgTjIQ=; b=cGZY+PsX3tltGF4kJE1EpkyM3SSXI74Gp
	If+vd8PXFay6QcTpjwQUz0i5thDRhV1mxYY0y7YNxBelihZwuZZCMjc067q/PJWH
	9YBUYHxmtZ+AYlJzPf43v8f5tkrYcRvyNviTzLddYDByRtuLncvar3zIE6W9dgac
	5kluyTpPFodfxcXV5UFvgwUMyW+NYyoN/WumMy12Dvd9RqGQasfm2Bcbe0z8aU/f
	96xXzJn1tMo9sACGl8187vxUIQZyD6tRVGOSbKoZ63HLP7KMEoHxREiwBf7bmLhj
	2NtTVzlzuskiJORxfQ1g93PR7uEd4Q+xa/jAUO7O0C9WRQCROs8vg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ar8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BPwm001847
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw87xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9HZnu28312002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D569620043;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B56182004F;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 4/7] s390/crypto: Fix missing cra_flags in paes_s390
Date: Wed, 19 Aug 2026 11:17:31 +0200
Message-ID: <20260819091734.7331-5-freude@linux.ibm.com>
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
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=LGQ5mng98TkiZO--HCkA:9
X-Proofpoint-ORIG-GUID: IPQzgNnu1AVUSR_inNVM7842IEVLD-R1
X-Proofpoint-GUID: IPQzgNnu1AVUSR_inNVM7842IEVLD-R1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfXxHOI85vC7gjy
 S2ybVWn9Gsk8B8dpRMVXJoYtizIv0Re2c7MxSoK1IF9l7iIiaZBIW/94G9GxIIXFwYOMf3JI0Pm
 lhHQVwo1PxfMp1Pz9f1BrntQEEqTBfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX62WEKFRe/D7L
 u7yNCXJonhcIL5Eum2+K4+Axl5nrj0F0nqHwdcOnqT01wN1AmUyM4lsINq4F2bXsEBERTEguj9T
 RN2iSI4xI95rqx4l1j+jnJcSCXZ80h6f+SXaQwJWvisQCIGJHQXzOajaNAqsS9kfqDBXtLbdcc/
 CEzLJDeFvM4V11SgjHHQwanx095hG3iF/5Xmvy1XQSDX0D+pJLi7UBuLhsoLq/PJLWBBtjNWFfI
 pd4qOagj7XCQP9p6DS+Ow6WbKo9uYcNux53hx3vyxBw6ivLYMVsUQPzSJNNkI4uVfyJZbZ3VZeW
 M2NoVhY1fSLPYuiSiXNgUYcDVcjV2qq2PAKTT8Q5r+keEG2uN6TZOqKLWn+cfJaLUkYYpQrTzWW
 AxpJH5Jp1bI3egduTmxAmNb645VzS3xB4+85ve0dRBS3LhWm4ymQ2j06Eaxwdjz7KfRMvg8X+TY
 PsscrZCC69R9fiRMzDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

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

