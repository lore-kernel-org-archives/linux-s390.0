Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C443BFAC8
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302017; cv=none; b=fI0HaPrqJobAtkRXi1CNevHVK3ug2kppdELe+WGkiB3R1mJ4+PWCVSWxyVQm9MnlPuxEBmkqzeilHjgCNtg0hi9b2yFaWYVa7wSSwde5BCaOMFMpqiRF+3YpDpdo7/kaxu7OxuSoDbj62D2UEyi1QJIoc+qmuHLsxVe+0WItyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302017; c=relaxed/simple;
	bh=W9hKRuc/egymqglm+qxMc0yjUAzeKERDrLVWVvJ/fH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5EDapHX3H58Mat7DBYbK4zQRzJWGQwA/GF7fT5BZ+s54YQGLpsJwh6+QPWkJCxKmvwI40swHGkxF7myOMHgC1JuwSVM24Cawrq9bPqFELZMgXuXVa+ZTvbCcZTFe9O6Vr3dg5rnWMyALV6KZzaZgSpcTKp/SdPJxhygoPokLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y+xYINYz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y+xYINYz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8Vufq3298709
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NfaEThVIstSsf1BfS
	z4+zwUF11WZV1amVyJ2rWqJHc4=; b=Y+xYINYzPKljP2iPygkXw8kZFdXpUgigV
	CmUCViJ4J8tV1a6u+3DT57DEy/kDD6Hu67+0hf2YvJoBKsuIungEkVAKlZT9CuWZ
	doqDPDy87eV5q1kv/rKLhJ6QsaPKsiYjrUwhSgzIz7m4U1GjK3vpDlqJsudy/lPN
	ZgJbg2RX0PHQmMMCwA/SjHQ2uyZnZ5jaa7r4JEUTMbfE8toM6kNA/VYMjtrpcX45
	jZL4yLnElpMG4haTbzPwX4gpDus04JyIjeOJlzC+6wscvXNYDDXZOoHdlgXUmjYE
	90tqn3BQO5CvHjT98UgUbamaH+AXKaJMndW9kpsRQlb5LlcCqIR0g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0g7yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fd6e005975
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twknx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8knV048890190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79DCB20043;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F7E72004E;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 8/9] s390/crypto: Map EBUSY to EIO when key conversion fails repeatedly
Date: Fri, 21 Aug 2026 10:46:47 +0200
Message-ID: <20260821084648.23222-9-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZZl8q9tFrTyhxDXQ88vBoYvkS-YJ_k4f
X-Proofpoint-GUID: ZZl8q9tFrTyhxDXQ88vBoYvkS-YJ_k4f
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88107e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Fr3jCehX831DqKRPnFkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXytbyuCRxBMDy
 1Xk6ov0m/EeqJjbd8qSJY8A5MhsUjOix8RPkj+pmqIY/2AXfyIoXjwCtGocmrcg54i8LEeNcTnU
 Ii0cN9wFxzf97HtNEcuxY8KdHNTIu9M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX7UsFtdElEK8j
 XSP287elFB9ImwnM5g6jYb5koV4txcIjCm8BnY2b+ZQzHqhkn4ZAyQbXcEZW3J566FH7gilbPfY
 qD365uZZUZx+h7lQ2Pg/U9XARCQOFoxtnywCdFp+rwbCtKppkxQ5dD0R/fIN4NrAcaoJpr+bkht
 lIoRzi49pQxGldOf+i5ZfmZ3MTe421Br5aUUSJeekr0Q2pPl2adOsyEyFS4eOVEhLT9m9TGFGNV
 f30NNRFXrOU3g4QN1/c+rv3+vW1zOPrHqmEDzDQzKivesEy1sZ/iFcA9HUdqunbpbro65GG9CaT
 QcCyJJvewHeiKIcHU9GkCrDevTnD6I2vPtUNjnjT6ekmcpXhxbt/7zonU1JooPjw8ZgmOfcZFXm
 l4qOaShHEozFcwSkm5ZycRb6YOt5JV9URxfp1VPqwNCd14qanCaBUBjrxgdsC+sTk9ZdPF+cEDm
 7aUzH5LQ/3lzd2Z7FOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

When hardware persistently returns -EBUSY after exhausting retries,
the error propagates to crypto_finalize_*_request(). The crypto API's
completion wrapper treats -EBUSY as a queueing status and swallows it,
preventing the completion callback from firing. This causes callers
using crypto_wait_req() to block indefinitely.

Translate persistent -EBUSY to -EIO after retry exhaustion to ensure
proper error propagation and callback invocation.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 arch/s390/crypto/paes_s390.c  | 4 ++++
 arch/s390/crypto/phmac_s390.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 0bc360c7ef15..17ef788e3053 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -220,6 +220,10 @@ static inline int convert_key(const u8 *key, unsigned int keylen,
 				      xflags);
 	}
 
+	/* But finally map -EBUSY to -EIO to indicate an IO failure */
+	if (rc == -EBUSY)
+		rc = -EIO;
+
 out:
 	pr_debug("rc=%d\n", rc);
 	return rc;
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
index 89c5fa3dced2..44817c3d25cf 100644
--- a/arch/s390/crypto/phmac_s390.c
+++ b/arch/s390/crypto/phmac_s390.c
@@ -341,6 +341,10 @@ static inline int convert_key(const u8 *key, unsigned int keylen,
 				      xflags);
 	}
 
+	/* But finally map -EBUSY to -EIO to indicate an IO failure */
+	if (rc == -EBUSY)
+		rc = -EIO;
+
 out:
 	pr_debug("rc=%d\n", rc);
 	return rc;
-- 
2.43.0

