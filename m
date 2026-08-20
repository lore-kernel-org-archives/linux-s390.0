Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C54398911
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235607; cv=none; b=RuOYNZhpx36zHX0F2bdW4DAw3tU5OVHXrnLMrrnw/jnaJrfdRHsXvR9ey2SopnLsWxKOpZytm+dvLLLLCy2uESQGv+x0aQD5O5xCD+VL63S4tWqfWSVnNFAztvJr/avggCY+rzhjhulWHpOVuxv71yOmALHgXRKNXJscTwn7eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235607; c=relaxed/simple;
	bh=LUFJcedcUarmZ/aWuqtUQw1wgDu44yRqq5Df7k1kJh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxr4C+t2rH9nlx/ze+hmRbRdYqpV0WL8188RWXJnUdrZs77AQpaAIlUp9HxvkablMQJ9J2eOE35FWZ7DZq//3JaOXCQW8YTHkFY+9WcOj+s6vXp9Z3E1/MMdvM3yJo3NQAwoE/MDlAGpMfPmNQrAW0zjuhgvYdu+yaPGHriAht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ml21kLyB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ml21kLyB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8vokb471312
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=71sbkMOMz+2dfj4fp
	ebeowJL8APGigbmWCPvl5qD1tc=; b=Ml21kLyBLcowOmr3uLuiecciLmxUXBhV9
	2vOQmENLlJT9oIhuntjykTh8VktDZjtA0NBR2N62CrC0H92aDip4M2et+mIOtH2u
	P8xz12BC8LibU4obAZVYpj36RxB9NPjbf0OF7RCqTRnYMUewtV0Aw4ph3yrYNVB0
	KdtNgckYSu8Xbq5viT99IYLE9iDVtCKWw8OVbDQZRpYK1E/FWuSedgRVsFLwqJzy
	48kGZPhZ+RuSF5y2zgXSozKd5hmjVaAoq38EtgcdAqvpOnuLBlmwTMy3kqYBe0GJ
	2IYjkZXmasooB7izO+TUhcPw0VY/V0GVdJaBOdY7L2ny5qersf5vw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0jwt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEBwRm020343
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twf311-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJvL941550136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCF22004B;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9BBC20043;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 2/8] s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
Date: Thu, 20 Aug 2026 16:19:51 +0200
Message-ID: <20260820141957.19091-3-freude@linux.ibm.com>
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
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xgcJR-P8mceqExzzGMoA:9
X-Proofpoint-ORIG-GUID: qeNTJ9ubkpnuo5d29W4fO6WGuQlBrQ-T
X-Proofpoint-GUID: qeNTJ9ubkpnuo5d29W4fO6WGuQlBrQ-T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX2Yyyxlbn/Y+J
 QN39qL91ZKGuLSVyckULdgcCspRQXIPwabc52mPuAK+T8DvKPsDUAC6jx9tYgiOezm1TWUND+U/
 L+uNoccf77zcRu9+8oRU5OlkWDkPd70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXx2uOQhwZ1QTk
 JW4XNERV28MqdSo+PGUkXohtSRNCA/VcUVbx1pYKv0PW3y6zGqYL+ZzKaLK0SCmarRfXaAxeraz
 G24+907N7We/PyrzwzU6ZOD1M7B5KG/AVrFgjtb5hXsmXNrEtJh7MWliLCoQ05LodFcao7eUYDe
 cFiyLp49KmS/ToPWnpa1uc5O3if32n7sgf40C99Sdmpi5xOzauPV2lbBJAfA8pvnSitgSNnqGON
 tixz9Olb04mJLP59km9Qh7o80L5ctgkPEw1OKdteLf9OnfulWjB1QnIcPfiNW5NDIsH/xc56Uv7
 YX3XhmbwY5zNgUYEeCs5xh5aAG3a3jq0yU1fyIiu30PB+voddec39swI1BoqR4bg+vUrFiV5zxn
 ZWKh3c1iXTAv6E71088biY07l9xKxBbSdtu1kzTzfkkaFeV4hxISsTk19nqEiw5BU6qFkcN97zd
 j4vajGyGFcjHvMnuhOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

In function ctr_paes_do_crypt() there is a buffer used to process
remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
thus could lead to expose of unwanted data. Rework the code to
explicitly scrub the buffer at the end of the function to avoid
exposure of maybe sensitive data.

In function __xts_2keys_prep_param() change the existing scrub to
clean the whole param block instead of just the key field.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 arch/s390/crypto/paes_s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index ccc7da106c3a..d075b0241f1f 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -1044,6 +1044,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 	}
 
 out:
+	memzero_explicit(buf, sizeof(buf));
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -1377,7 +1378,7 @@ static inline int __xts_2keys_prep_param(struct s390_pxts_ctx *ctx,
 		memcpy(param->init, pcc_param.xts, 16);
 	}
 
-	memzero_explicit(pcc_param.key, sizeof(pcc_param.key));
+	memzero_explicit(&pcc_param, sizeof(pcc_param));
 	return rc;
 }
 
-- 
2.43.0

