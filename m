Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB363845C4
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224438; cv=none; b=LO9XShR+r28rxQ5H0TsK46IQvIdgtz3u1RJPJn1L6HTXjKBINTi9POWsxjIsnzjbixW8/BYy69W+/zsYS7+VxQ6sJNik9dwhZPZIHQddp4Z066sfCAb521cdI1MybqSPl92MOS6/ccu/+u2uvnH3oBSS5ktE6VVN/D6njGrruTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224438; c=relaxed/simple;
	bh=MmmWdhlBZYvvs+BE9t9wnH7Y/YitA+QhvZW8QhsUlmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG+Tnv6e8zUDJlFQ7PnspSuMDKmdV8AxZYZ8W+DUFHuAr9oOMJyoHqbebCz5sqpTSGLbQvoQBl9PPzdxNWmAxLkFldKI1o6v+APeh/yvZX78zT0scBqup5LrdF71XsJDd1H7mtNB/iTrpQx6/KjVrV6qSOHOx+dwXd/i+dZzYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fMBG8VXS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fMBG8VXS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmXaF1826578
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9oSiC4ciL+GgKwPbn
	l9gNEzxYkspY+khoz1yH50WM5Y=; b=fMBG8VXSCGgdbO4MrJeROzs6r6hVTB418
	Oeo/wkYU1tulRWrDKhYCFB3U4r+9roMjM55QoRCmiJpO6643b5dBh88PerDJTBGW
	2hT7DiVXwZhzEziGQ3+rTEbv0m68sWqmRWBfnv1+qIUQMTEIFkIRKX0sgmTZ6/9F
	Iq+o2aT1LosTiQ0EkH2uhjD++pw16xNwaJDa4Z5fzUtzve5rRazMuXXFSfUNOd1y
	ZMATjy9Ia2WpUuK+oCG86YKbeYBlHJIzMKnb7qCp7+KUKa9f0bsLW2PMhatrq+i1
	5mHtIF9Q8h03FJHv2GaJNy38YMGTy3lD8GC+0OCiSWoBe91YhiK3Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgspubd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NE4kBr015699
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbk8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEKW2i23724320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F052220040;
	Tue, 23 Jun 2026 14:20:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4F2C2004B;
	Tue, 23 Jun 2026 14:20:31 +0000 (GMT)
Received: from ibm.com (unknown [9.111.10.197])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:31 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 1/1] pkey: Move keytype check from pkey api to handler
Date: Tue, 23 Jun 2026 16:20:31 +0200
Message-ID: <20260623142031.4053768-2-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623142031.4053768-1-dengler@linux.ibm.com>
References: <20260623142031.4053768-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX5b29+VBDz6FF
 GmZw/wFj0v2CinP5CiQ0qjcfJpARrbNOwAEpL5wL+mPEjOmXqbcJ+H8E9Jgyz71+DXguMl3nSlh
 Aq9Jpr9936uuh55vUAqDhQl2nONA+JbJxUsvDAcIRlfMraqdatnR9lY9MzogwNK7zDFBuOod0iv
 etPnee+TLWTx/tPO7oSoWJNDqNHNvGp2LNSXgCYebupSnCVXrcOCyK5cBPlw0SvIefapX8VvgFa
 uy9M2/N6i+M6zKfKJdad4Mu6mR4+73nojJ5cmK4MxXgwLB6tLQK9xN5wOptbjMIt5un1hkYrH+J
 8gvxQQjBorbA/fsFnFw7Tz6aM9fgbkYzkcGOcrfVoCfarBVVqurzKX/poy+1cetNITpL63Rg3k5
 OXdkSOS6TR6RaLh0CnV8MuCCRtBogTZEuuWlC4DXSi7JWjIX+AlSwPwv+9G5uK9kpXbIVrL4+wR
 jnGR+vWLq82md0GaR1A==
X-Proofpoint-GUID: 67prmgfaVOTaTZsAyQZ-yHtQIkQuoF7f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXzhH+5AgbEwqp
 Z2Y7KDPM2WY0VbgxovSuglcZYQTCR5AY4rWcTR9yiZlwF7fLjhKfMZCVpKOOHaEMQ77gN4FcZZW
 e6giom7zRAHSwhNh55zcoCoAXntwh9A=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a9634 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=BsMriLjAb_E9CgLYo98A:9
X-Proofpoint-ORIG-GUID: 67prmgfaVOTaTZsAyQZ-yHtQIkQuoF7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

The PKEY_VERIFYPROTK ioctl takes data from user-space and verifies the
contained protected key. While checking the integrity of the ioctl
request structure is the responsibility of the generic pkey_api code,
the verification of the contained protected key is the responsibility
of the pkey handler.

The keytype verification (based on the calculated bitsize of the key)
is part of the protected key verification and therefore the
responsibility of the pkey handler (which already verifies
it). Therefore the keytype verification is removed from the generic
pkey_api code.

As the calculation of the key bitsize is currently wrong, the removal
of the keytype check in pkey_api also removes this wrong
calculation. For this reason, the commit is flagged with the Fixes:
tag.

Cc: stable@kernel.org # 6.12+
Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_api.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 28e1007005f2..5d8f63f390a8 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -327,7 +327,6 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 {
 	struct pkey_verifyprotk kvp;
 	struct protaeskeytoken *t;
-	u32 keytype;
 	u8 *tmpbuf;
 	int rc;
 
@@ -341,14 +340,6 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 		return -EINVAL;
 	}
 
-	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
-	if (!keytype) {
-		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
-			     __func__, kvp.protkey.len);
-		memzero_explicit(&kvp, sizeof(kvp));
-		return -EINVAL;
-	}
-
 	/* build a 'protected key token' from the raw protected key */
 	tmpbuf = kzalloc(sizeof(*t), GFP_KERNEL);
 	if (!tmpbuf) {
@@ -358,7 +349,7 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 	t = (struct protaeskeytoken *)tmpbuf;
 	t->type = TOKTYPE_NON_CCA;
 	t->version = TOKVER_PROTECTED_KEY;
-	t->keytype = keytype;
+	t->keytype = kvp.protkey.type;
 	t->len = kvp.protkey.len;
 	memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);
 
-- 
2.54.0

