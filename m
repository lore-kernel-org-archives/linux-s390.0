Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DA3AE6F5
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302016; cv=none; b=mCh5tdSxhpF6pV6DOUzsD17plnmUc/FrszA+f/FMQZnfRUXbv9ssN6+w7nVPWNKfH2JqkZVhhlYCkPLv4jgfb8wdKy65PPL2aOGumRJpz24t9LVV+UN+oD476IiqtIUlRpuBpNNGMew9U0gWXobf8rRASEwGyQY8Uhnc/UYtbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302016; c=relaxed/simple;
	bh=KuyvPuH0+A3W0Qez7wwjWcHzpPdfTORkyvhRsgMb/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEyXAxupYPEXu6vQNj16sXGedBQpkqer3CN1RSlcpvLC0OkTwfLUOq+ZCWf8dv7Tqdj/Ru0J2us35ak+mnn4F05Va5dMUaNR8WkELtKycdG4tODTXKmw6HCNYkvH7Re6jmsWJr400UUNWnvQK9YcLPmgP/5sb9D2zvNs+mHg+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bJhklEIx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bJhklEIx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WrkY4042685
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o+PXTs98ZGvSQCBRF
	5++SaL8y9RjGrUNYrXbnwgTjIQ=; b=bJhklEIxQW4lm0IH66gaQ9kVQdfmfzgut
	kFVI6ylDr+tjL6PVey8u0ClQe2WBUlWTDCJuj9avoRZMkZ6U6u9/mKZjTej0mr9/
	YpUz8WKmlc3WGJ1IVyAdws0xAYd5U2iQBj0SS5JUZmispE66YdRV5VT94qY7XqxO
	l+0l8OP4ucM45s92eo/sqOm2EX0TlWjo/dAfxQkKlHW7iO9jP69NaSfV0ClIf8wl
	F+0CFWPi2nmi5yzUXGa4qjwOEzzYHES6eWqCyAayHdfYbZXYVMbTgZXF04InHOdL
	253o7J0ZPGG1kVIXzcUAKDOpcLoaafT6rbGrcB/bH3fPJ4TLtfgCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2g356-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fdjp005987
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twknwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kn2t36307350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E703020040;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BD52004B;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 4/9] s390/crypto: Fix missing cra_flags in paes_s390
Date: Fri, 21 Aug 2026 10:46:43 +0200
Message-ID: <20260821084648.23222-5-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88107d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=LGQ5mng98TkiZO--HCkA:9
X-Proofpoint-GUID: WY31zmdWcz0F7oJm-JvbSbdqv2X56Hmr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXw8yKckOBt8Vg
 rokUPbjVbWIV9YLfovlTwi3D4OQ7VNBZUQoMqFdWglNL1qpNY4K3+5lHx/s1ElG+zgznbaoduOP
 CwQIlt7TcP/m8nVlHb23mi5jT71vc8uzyrDA6bqy87W5TyeHN/yIFQKsD/moAuKCVhVaCFV2tVL
 WvsBW9NOx3a6VFCEz18DWlAcqbAw5bGclMVLgTKoLkJnKbPx2zeYH5Ao2JBftMmHPUcT+I8+1+b
 S+55TT81adNdpcgaqaJUg8bMVdncKZTo9J8wvDDp5G5sjJNC62ccATVgUSLXbtbN/qjVKBpWE0H
 B9JiFn1HPRGFk4Qpb/Rux95L7O4Th4awmjZkwqXCPhlE7qKjHhjf7UNx0JpM1B+6vn6EXPr8JQn
 rxz3duuQfWiXXTiywXB4N4m3+QMzyF8cpDDyD/FHbsmBj0N71FulZjWSjPJY7p5aRuS6cjmNMei
 SaQEudstEJgb3HLbccQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXz60BT8/IYe6W
 AQy2yTD1SKc3cc725130c486KjR0nFmqa6kxDoo1x1v1AQTJFMFPnz+6c8Du10i55Wm2MOGwL6C
 5JaDFsR0LEcUiJIIO/ph3dlkETKQe9o=
X-Proofpoint-ORIG-GUID: WY31zmdWcz0F7oJm-JvbSbdqv2X56Hmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210061

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

